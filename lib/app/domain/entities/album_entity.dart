import 'package:equatable/equatable.dart';
import 'package:photos/app/data/model/response/album_response.dart';

class AlbumsEntity extends Equatable {
  final List<AlbumEntity> albums;

  const AlbumsEntity({
    required this.albums,
  });

  factory AlbumsEntity.fromAlbumResponse(AlbumResponse? response) {
    final List<AlbumEntity> albums = response?.albums
            .map((Album album) => AlbumEntity.fromAlbum(album))
            .toList() ??
        const <AlbumEntity>[];
    return AlbumsEntity(albums: albums);
  }

  @override
  List<Object?> get props => <Object?>[
        albums,
      ];
}

class AlbumEntity extends Equatable {
  final String albumId;
  final String albumName;
  final String thumbnailPath;
  final int numberOfPhotos;

  const AlbumEntity({
    required this.albumId,
    required this.albumName,
    required this.thumbnailPath,
    required this.numberOfPhotos,
  });

  factory AlbumEntity.fromAlbum(Album album) {
    return AlbumEntity(
      albumId: album.albumId ?? "",
      albumName: album.albumName ?? "",
      thumbnailPath: album.thumbnailPath ?? "",
      numberOfPhotos: album.numberOfPhotos ?? 0,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        albumId,
        albumName,
        thumbnailPath,
        numberOfPhotos,
      ];
}
