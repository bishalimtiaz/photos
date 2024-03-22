import 'package:photos/app/core/base/observable_list.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/domain/repository/album_repository.dart';

class AlbumController extends ScreenController {
  final ObservableList<AlbumEntity> albums =
      ObservableList<AlbumEntity>.empty(growable: true);

  late final AlbumRepository _albumRepository;

  @override
  void onInit() {
    Log.debug('onInit AlbumController');
    _albumRepository = locator.get<AlbumRepository>();
    _fetchAlbums();
    super.onInit();
  }

  @override
  void onDispose() {
    Log.debug('onDispose AlbumController');
    albums.dispose();
    super.onDispose();
  }

  void _fetchAlbums() async {
    _albumRepository.getAlbums().then((AlbumsEntity entity) {
      albums.value = entity.albums;
    }).catchError((dynamic error, StackTrace stackTrace) {
      Log.error("album_debug: error $error");
    });
  }
}
