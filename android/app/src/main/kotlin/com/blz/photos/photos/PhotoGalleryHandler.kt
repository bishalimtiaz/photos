package com.blz.photos.photos

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

// Data model for albums (replace with your actual data structure)
data class Album(val id: String, val name: String, var count: Int = 0, val coverUri: Uri?)

class PhotoGalleryHandler(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL_NAME = "com.blz.gallery/access"
    }

    // Check storage permission before accessing photos (Optional - You might handle it on Flutter side)
    private val contentResolver by lazy {
        context.contentResolver
    }


    private fun hasStoragePermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.READ_MEDIA_IMAGES
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.READ_EXTERNAL_STORAGE
            ) == PackageManager.PERMISSION_GRANTED
        }
    }


    private fun fetchAlbums(result: MethodChannel.Result) {
        if (!hasStoragePermission()) {
            result.error("PERMISSION_DENIED", "Storage permission not granted", null)
            return
        }


        val collection =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                MediaStore.Images.Media.getContentUri(
                    MediaStore.VOLUME_EXTERNAL
                )
            } else {
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI
            }

        val projections = arrayOf(
            MediaStore.Images.Media.BUCKET_ID,
            MediaStore.Images.Media.BUCKET_DISPLAY_NAME,
            MediaStore.Images.Media.DATA,
        )
        val orderBy = "${MediaStore.Images.Media.DATE_TAKEN} DESC"
        val findAlbums = HashMap<String, Album>()

        try {
            contentResolver.query(collection, projections, null, null, orderBy)
                ?.use { cursor ->
                    val bucketIdIndex =
                        cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_ID)
                    val bucketNameIndex =
                        cursor.getColumnIndexOrThrow(MediaStore.Images.Media.BUCKET_DISPLAY_NAME)

                    while (cursor.moveToNext()) {
                        val bucketId = cursor.getString(bucketIdIndex)
                        val albumName = cursor.getString(bucketNameIndex)
                        if (albumName.contains("mipmap") || albumName.contains("drawable")) continue
                        val imageUriIndex =
                            cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                        val imageUri = Uri.parse(cursor.getString(imageUriIndex))

                        findAlbums.getOrPut(bucketId) {
                            Album(id = bucketId, name = albumName, coverUri = imageUri)
                        }.count++
                    }
                }

            Handler(Looper.getMainLooper()).post {
                result.success(findAlbums.values.toList().map { it.toJson() })
            }
        } catch (e: Exception) {
            result.error("QUERY_FAILED", "Failed to fetch albums: ${e.message}", null)
        }
    }


    // Function to fetch photos from a specific album
    private fun fetchPhotosFromAlbum(albumId: String, result: MethodChannel.Result) {
        if (!hasStoragePermission()) {
            result.error("PERMISSION_DENIED", "Storage permission not granted", null)
            return
        }

        val collection =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                MediaStore.Images.Media.getContentUri(
                    MediaStore.VOLUME_EXTERNAL
                )
            } else {
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI
            }
        val projections = arrayOf(MediaStore.Images.Media.DATA)
        val selection = MediaStore.Images.Media.BUCKET_ID + " = ?"
        val selectionArgs = arrayOf(albumId)
        val orderBy = MediaStore.Images.Media.DATE_TAKEN + " DESC"

        val photos = mutableListOf<String>()
        try {
            context.contentResolver.query(
                collection,
                projections,
                selection,
                selectionArgs,
                orderBy
            )?.use { cursor ->
                val imageUriIndex = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                while (cursor.moveToNext()) {
                    val imagePath = cursor.getString(imageUriIndex)
                    photos.add(imagePath)
                }
            }
            Handler(Looper.getMainLooper()).post {
                result.success(photos)
            }
        } catch (e: Exception) {
            result.error("QUERY_FAILED", "Failed to fetch photos from album: " + e.message, null)
        }
    }


    // Helper method to convert an Album object to a JSON-serializable Map
    private fun Album.toJson(): Map<String, Any?> {
        return mapOf(
            "id" to id,
            "name" to name,
            "thumbnailPath" to coverUri.toString(),
            "numberOfPhotos" to count
        )
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getAlbums" -> {
                try {
                    fetchAlbums(result)
                } catch (e: Exception) {
                    result.error("getAlbumsError", "Failed to fetch albums", null)
                }
            }

            "getPhotosFromAlbum" -> {
                val albumId = call.argument<String>("albumId")
                if (albumId == null) {
                    result.error("invalidArgument", "Missing albumId argument", null)
                    return
                }

                try {
                    fetchPhotosFromAlbum(albumId, result)
                } catch (e: Exception) {
                    result.error("getPhotosError", "Failed to fetch photos", null)
                }
            }

            else -> result.notImplemented()
        }
    }
}

