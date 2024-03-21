import 'package:equatable/equatable.dart';

class PhotoResponse extends Equatable {
  final List<Photo> photos;

  const PhotoResponse({
    required this.photos,
  });

  @override
  List<Object?> get props => [photos];

  // Convert PhotoResponse to a JSON-serializable Map
  Map<String, dynamic> toJson() => {
        "photos": photos.map((photo) => photo.toJson()).toList(),
      };

  // Factory constructor to create PhotoResponse from a JSON Map
  factory PhotoResponse.fromJson(List<dynamic> json) => PhotoResponse(
        photos: json.map((photoJson) => Photo.fromJson(photoJson)).toList(),
      );
}

class Photo extends Equatable {
  final String path;

  const Photo({
    required this.path,
  });

  @override
  List<Object?> get props => [path];

  // Convert Photo to a JSON-serializable Map
  Map<String, dynamic> toJson() => {
        "path": path,
      };

  // Factory constructor to create Photo from a JSON Map
  factory Photo.fromJson(dynamic path) => Photo(
        path: path,
      );
}
