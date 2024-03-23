import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/presentation/modules/album/controllers/album_controller.dart';
import 'package:photos/app/domain/repository/album_repository.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'album_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlbumRepository>()])
void main() {
  MockAlbumRepository mockAlbumRepository = MockAlbumRepository();

  setUp(() {
    locator.registerFactory<AlbumRepository>(
      () => mockAlbumRepository,
    );
  });

  tearDown(() {
    locator.reset();
  });

  test('AlbumController fetches albums successfully', () async {
    when(mockAlbumRepository.getAlbums()).thenAnswer(
      (_) => Future<AlbumsEntity>.value(
        const AlbumsEntity(
          albums: <AlbumEntity>[
            AlbumEntity(
              albumId: '1',
              albumName: 'Album 1',
              thumbnailPath: 'assets/images/gallery.png',
              numberOfPhotos: 3,
            ),
            AlbumEntity(
              albumId: '2',
              albumName: 'Album 2',
              thumbnailPath: 'assets/images/gallery.png',
              numberOfPhotos: 3,
            ),
          ],
        ),
      ),
    );
    final AlbumController controller = AlbumController();

    await Future<void>.delayed(const Duration(seconds: 2));

    // Verify state is updated with fetched albums
    expect(controller.albums.value.length, 2);
  });
}
