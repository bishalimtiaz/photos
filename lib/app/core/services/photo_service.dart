import 'package:flutter/services.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/data/model/response/album_response.dart';
import 'package:photos/app/data/model/response/photo_response.dart';

class PhotoService {
  static const MethodChannel _channel = MethodChannel('com.blz.gallery/access');

  // Method to fetch albums from the native platform
  Future<AlbumResponse?> fetchAlbums() async {
    try {
      final dynamic albums = await _channel.invokeMethod('getAlbums');
      Log.debug(albums);
      return AlbumResponse.fromJson(albums);
    } on PlatformException catch (e) {
      Log.error("Failed to fetch albums: '${e.message}'.");
      return null;
    }
  }

  // Method to fetch photos from a specific album
  Future<PhotoResponse?> fetchPhotosFromAlbum(String albumId) async {
    try {
      final dynamic photos = await _channel.invokeMethod(
          'getPhotosFromAlbum', <String, String>{'albumId': albumId});
      Log.debug(photos);
      return PhotoResponse.fromJson(photos);
    } on PlatformException catch (e) {
      Log.error("Failed to fetch photos: '${e.message}'.");
      return null;
    }
  }
}
