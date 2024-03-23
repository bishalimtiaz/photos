import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/data/model/response/album_response.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/domain/repository/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  late final PhotoService _photoService;

  AlbumRepositoryImpl() {
    _photoService = locator.get<PhotoService>();
  }

  @override
  Future<AlbumsEntity> getAlbums() {
    return _photoService.fetchAlbums().then((AlbumResponse? value) {
      return AlbumsEntity.fromAlbumResponse(value);
    });
  }
}
