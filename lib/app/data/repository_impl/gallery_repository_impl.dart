import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';
import 'package:photos/app/domain/repository/gallery_repository.dart';
import 'package:photos/app/data/model/response/photo_response.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  @override
  Future<PhotosEntity> getPhotos({required String albumId}) {
    return PhotoServiceService().fetchPhotosFromAlbum(albumId).then(
      (PhotoResponse? value) {
        return PhotosEntity.fromPhotoResponse(value);
      },
    );
  }
}
