import 'package:equatable/equatable.dart';
import 'package:photos/app/data/model/response/photo_response.dart';

class PhotosEntity extends Equatable {
  final List<PhotoEntity> photos;

  const PhotosEntity({
    required this.photos,
  });

  factory PhotosEntity.fromPhotoResponse(PhotoResponse? response) {
    final List<PhotoEntity> photos = response?.photos
            .map((Photo photo) => PhotoEntity.fromPhoto(photo))
            .toList() ??
        const <PhotoEntity>[];
    return PhotosEntity(
      photos: photos,
    );
  }

  @override
  List<Object?> get props => <Object?>[photos];
}

class PhotoEntity extends Equatable {
  final String path;

  const PhotoEntity({
    required this.path,
  });

  factory PhotoEntity.fromPhoto(Photo photo) {
    return PhotoEntity(
      path: photo.path,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        path,
      ];
}
