import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';
import 'package:photos/app/domain/repository/gallery_repository.dart';
import 'package:photos/app/data/model/response/photo_response.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  late final PhotoService _photoService;

  GalleryRepositoryImpl() {
    _photoService = locator.get<PhotoService>();
  }

  @override
  Future<PhotosEntity> getPhotos({required String albumId}) {
    return _photoService.fetchPhotosFromAlbum(albumId).then(
      (PhotoResponse? value) {
        return PhotosEntity.fromPhotoResponse(value);
      },
    );
  }
}
