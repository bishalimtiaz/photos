import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/data/model/response/album_response.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/domain/repository/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  @override
  Future<AlbumsEntity> getAlbums(){
    return PhotoServiceService().fetchAlbums().then((AlbumResponse? value) {
      return AlbumsEntity.fromAlbumResponse(value);
    });
  }
}
