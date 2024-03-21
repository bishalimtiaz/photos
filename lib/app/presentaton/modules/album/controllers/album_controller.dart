import 'package:photos/app/core/base/observable_list.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/data/model/response/album_response.dart';
import 'package:photos/app/domain/entities/album_entity.dart';

class AlbumController extends ScreenController {
  final ObservableList<AlbumEntity> albums =
      ObservableList<AlbumEntity>.empty(growable: true);

  @override
  void onInit() {
    Log.debug('onInit AlbumController');
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
    PhotoServiceService().fetchAlbums().then((AlbumResponse? value) {
      Log.debug("album_debug: then calling");

      if (value != null) {
        AlbumsEntity entity = AlbumsEntity.fromAlbumResponse(value);
        albums.value = entity.albums;
      }
    }).catchError((dynamic error, StackTrace stackTrace) {
      Log.error("album_debug: error $error");
    });
  }
}
