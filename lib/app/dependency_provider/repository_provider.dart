import 'package:get_it/get_it.dart';
import 'package:photos/app/data/repository_impl/album_repository_impl.dart';
import 'package:photos/app/data/repository_impl/gallery_repository_impl.dart';
import 'package:photos/app/dependency_provider/provider.dart';
import 'package:photos/app/domain/repository/album_repository.dart';
import 'package:photos/app/domain/repository/gallery_repository.dart';

class RepositoryProvider implements Provider {
  @override
  Future<void> provide(GetIt locator) async {
    locator.registerFactory<AlbumRepository>(() => AlbumRepositoryImpl());
    locator.registerFactory<GalleryRepository>(() => GalleryRepositoryImpl());
  }
}
