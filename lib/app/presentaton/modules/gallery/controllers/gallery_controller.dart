import 'package:photos/app/core/base/observable_list.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/services/app_service.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';
import 'package:photos/app/domain/repository/gallery_repository.dart';

class GalleryController extends ScreenController {
  final ObservableList<PhotoEntity> photos =
      ObservableList<PhotoEntity>.empty(growable: true);

  AlbumEntity? selectedAlbum;
  late final GalleryRepository _galleryRepository;

  @override
  void onInit() {
    Log.debug("onInit GalleryController");
    selectedAlbum = AppService().argument as AlbumEntity?;
    _galleryRepository = locator.get<GalleryRepository>();
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
      _galleryRepository
          .getPhotos(albumId: selectedAlbum!.albumId)
          .then((PhotosEntity entity) {
        photos.value = entity.photos;
      }).catchError((dynamic error, StackTrace stackTrace) {
        Log.error("gallery_debug: error $error");
      });
    }
  }
}
