import 'package:photos/app/core/base/observable_list.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/services/app_service.dart';
import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/data/model/response/photo_response.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';

class GalleryController extends ScreenController {
  final ObservableList<PhotoEntity> photos =
      ObservableList<PhotoEntity>.empty(growable: true);

  AlbumEntity? selectedAlbum;

  @override
  void onInit() {
    Log.debug("onInit GalleryController");
    selectedAlbum = AppService().argument as AlbumEntity?;
    _fetchPhotos();
    super.onInit();
  }

  @override
  void onDispose() {
    Log.debug("onDispose GalleryController");
    super.onDispose();
  }

  void _fetchPhotos() async {
    Log.debug("route_debug: arg: ${AppService().argument}");
    if (selectedAlbum != null) {
      PhotoServiceService().fetchPhotosFromAlbum(selectedAlbum!.albumId).then(
        (PhotoResponse? value) {
          Log.debug("gallery_debug: ${value.toString()}");
          if (value != null) {
            PhotosEntity photosEntity = PhotosEntity.fromPhotoResponse(value);
            photos.value = photosEntity.photos;
          }
        },
      );
    }
  }
}
