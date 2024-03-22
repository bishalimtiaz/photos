import 'package:photos/app/domain/entities/album_entity.dart';

abstract class AlbumRepository {
  Future<AlbumsEntity> getAlbums();
}
