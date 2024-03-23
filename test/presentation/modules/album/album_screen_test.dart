import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photos/app/core/base/observable_list.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/presentation/modules/album/album_screen.dart';
import 'package:photos/app/presentation/modules/album/controllers/album_controller.dart';
import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentation/widgets/album_tile.dart';

import 'album_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlbumController>()])
void main() {
  MockAlbumController mockAlbumController = MockAlbumController();

  setUp(() {
    locator.registerFactory<AlbumController>(
      () => mockAlbumController,
    );
  });

  tearDown(() {
    locator.reset();
  });
  testWidgets('AlbumScreen displays a list of albums and responds to tap',
      (WidgetTester tester) async {
    // Set up mocked method responses
    when(mockAlbumController.albums).thenReturn(
      ObservableList<AlbumEntity>.from(
        <AlbumEntity>[
          const AlbumEntity(
              albumId: '1',
              albumName: 'Album 1',
              thumbnailPath: '',
              numberOfPhotos: 10),
          const AlbumEntity(
              albumId: '2',
              albumName: 'Album 2',
              thumbnailPath: '',
              numberOfPhotos: 20),
        ],
      ),
    );

    await tester.pumpWidget(const MaterialApp(home: AlbumScreen()));

    // Verify that the list of albums is displayed
    expect(find.byType(AlbumTile), findsNWidgets(2));
  });
}
