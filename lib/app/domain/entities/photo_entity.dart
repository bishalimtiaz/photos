import 'package:equatable/equatable.dart';
import 'package:photos/app/data/model/response/photo_response.dart';

class PhotosEntity extends Equatable {
  final List<PhotoEntity> photos;

  const PhotosEntity({
    required this.photos,
  });

  factory PhotosEntity.fromPhotoResponse(PhotoResponse response) {
    return PhotosEntity(
      photos:
          response.photos.map((photo) => PhotoEntity.fromPhoto(photo)).toList(),
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
