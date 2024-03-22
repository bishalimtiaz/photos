import 'package:photos/app/domain/entities/photo_entity.dart';

abstract class GalleryRepository {
  Future<PhotosEntity> getPhotos({required String albumId});
}
