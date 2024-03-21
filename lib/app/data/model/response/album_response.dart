import 'package:equatable/equatable.dart';

class AlbumResponse extends Equatable {
  final List<Album> albums;

  const AlbumResponse({
    required this.albums,
  });

  factory AlbumResponse.fromJson(List<dynamic> json) {
    return AlbumResponse(
      albums: json.map((dynamic album) => Album.fromJson(album)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'albums': albums.map((album) => album.toJson()).toList(),
      };

  @override
  List<Object?> get props => <Object?>[
        albums,
      ];
}

class Album extends Equatable {
  final String? albumId;
  final String? albumName;
  final String? thumbnailPath;
  final int? numberOfPhotos;

  const Album({
    required this.albumId,
    required this.albumName,
    required this.thumbnailPath,
    required this.numberOfPhotos,
  });

  factory Album.fromJson(dynamic json) => Album(
        albumId: json['id'],
        albumName: json['name'],
        thumbnailPath: json['thumbnailPath'],
        numberOfPhotos: json['numberOfPhotos'],
      );

  Map<String, dynamic> toJson() => {
        'id': albumId,
        'name': albumName,
        'thumbnailPath': thumbnailPath,
        'numberOfPhotos': numberOfPhotos,
      };

  @override
  List<Object?> get props => <Object?>[
        albumId,
        albumName,
        thumbnailPath,
        numberOfPhotos,
      ];
}
