import UIKit
import Photos
import Flutter

struct Album {
    let id: String
    let name: String
    let count: Int
    let thumbnailPath: String? // Optional, since not all albums may have a thumbnail
    
    // Function to convert Album instance to a dictionary
    // This is useful for passing album data back to Flutter
    func toJson() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "numberOfPhotos": count,
            "thumbnailPath": thumbnailPath ?? "" // Provide an empty string if nil
        ]
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.blz.gallery/access",
                                           binaryMessenger: controller.binaryMessenger,
                                           codec: FlutterStandardMethodCodec.sharedInstance()
        )
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getAlbums":
                self.fetchAlbums(result: result)
            case "getPhotosFromAlbum":
                if let args = call.arguments as? [String: Any], let albumId = args["albumId"] as? String {
                    self.fetchPhotosFromAlbum(albumId: albumId, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments for getPhotosFromAlbum", details: nil))
                }
            default:
                result(FlutterMethodNotImplemented)
            }
            
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    private func fetchAlbums(result: @escaping FlutterResult) {
        var albums: [Album] = []
        var processedIdentifiers = Set<String>() // To avoid duplicates
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard status == .authorized else {
                DispatchQueue.main.async {
                    result(FlutterError(code: "PERMISSION_DENIED", message: "Photo library access denied", details: nil))
                }
                return
            }
            
            let fetchOptions = PHFetchOptions()
            // Fetch user albums
            let userAlbumResults = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            // Fetch smart albums
            let smartAlbumResults = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: fetchOptions)
            
            let manager = PHImageManager.default()
            
            let totalAlbums = userAlbumResults.count + smartAlbumResults.count
            var processedAlbums = 0
            
            // Function to handle album processing
            func processAlbumCollection(collection: PHAssetCollection) {
                let albumId = collection.localIdentifier
                
                // Check for duplicate
                guard !processedIdentifiers.contains(albumId) else {
                    processedAlbums += 1
                    self?.checkAndReturnResults(albums: albums, result: result, processedAlbums: processedAlbums, totalAlbums: totalAlbums)
                    return
                }
                processedIdentifiers.insert(albumId)
                
                let albumName = collection.localizedTitle ?? ""
                let assets = PHAsset.fetchAssets(in: collection, options: fetchOptions)
                let count = assets.count
                
                // Skip albums with a count of 0
                if count == 0 {
                    processedAlbums += 1
                    self?.checkAndReturnResults(albums: albums, result: result, processedAlbums: processedAlbums, totalAlbums: totalAlbums)
                    return
                }
                
                guard let firstAsset = assets.lastObject else {
                    // This line is now essentially redundant since count == 0 cases are already skipped
                    processedAlbums += 1
                    self?.checkAndReturnResults(albums: albums, result: result, processedAlbums: processedAlbums, totalAlbums: totalAlbums)
                    return
                }
                
                let targetSize = CGSize(width: 200, height: 200)
                let requestOptions = PHImageRequestOptions()
                requestOptions.isSynchronous = false
                requestOptions.deliveryMode = .highQualityFormat
                
                manager.requestImage(for: firstAsset, targetSize: targetSize, contentMode: .aspectFill, options: requestOptions) { image, _ in
                    var thumbnailPath: String? = nil
                    if let image = image, let data = image.pngData() {
                        let fileName = NSUUID().uuidString + ".png"
                        let filePath = NSTemporaryDirectory() + fileName
                        if FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil) {
                            thumbnailPath = filePath
                        }
                    }
                    
                    let album = Album(id: albumId, name: albumName, count: count, thumbnailPath: thumbnailPath)
                    albums.append(album)
                    processedAlbums += 1
                    self?.checkAndReturnResults(albums: albums, result: result, processedAlbums: processedAlbums, totalAlbums: totalAlbums)
                }
            }
            
            // Process each user album
            userAlbumResults.enumerateObjects { collection, _, _ in
                processAlbumCollection(collection: collection)
            }
            
            // Process each smart album
            smartAlbumResults.enumerateObjects { collection, _, _ in
                processAlbumCollection(collection: collection)
            }
        }
    }
    
    func checkAndReturnResults(albums: [Album], result: @escaping FlutterResult, processedAlbums: Int, totalAlbums: Int) {
        if processedAlbums >= totalAlbums {
            result(albums.map { $0.toJson() })
        }
    }
    
    
    
    
    private func fetchPhotosFromAlbum(albumId: String, result: @escaping FlutterResult) {
        var photos: [String] = []
        
        // Ensure authorization
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                DispatchQueue.main.async {
                    result(FlutterError(code: "PERMISSION_DENIED", message: "Photo library access denied", details: nil))
                }
                return
            }
            
            // Fetch the specific album
            let fetchOptions = PHFetchOptions()
            let collections = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [albumId], options: fetchOptions)
            
            guard let album = collections.firstObject else {
                DispatchQueue.main.async {
                    result(FlutterError(code: "ALBUM_NOT_FOUND", message: "Could not find album", details: nil))
                }
                return
            }
            
            // Fetch assets in the album
            let assets = PHAsset.fetchAssets(in: album, options: nil)
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true // You may want to fetch asynchronously in a production app
            requestOptions.deliveryMode = .highQualityFormat
            
            assets.enumerateObjects { (asset, index, stop) in
                // Request image for each asset
                imageManager.requestImageData(for: asset, options: requestOptions) { (data, _, _, _) in
                    if let data = data {
                        // Create temporary file for image data
                        let fileName = UUID().uuidString + ".jpg"
                        let filePath = NSTemporaryDirectory() + fileName
                        if FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil) {
                            photos.append(filePath)
                        }
                    }
                    
                    // Once all photos have been processed, return the paths
                    if index == assets.count - 1 {
                        result(photos)
                    }
                }
            }
            
            // Handle case where there are no assets in the album
            if assets.count == 0 {
                result(photos)
            }
        }
    }
}
