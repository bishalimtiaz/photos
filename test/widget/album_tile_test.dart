import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/presentation/widgets/album_tile.dart';

void main() {
  group('AlbumTile Tests', () {
    testWidgets('Displays album information correctly',
        (WidgetTester tester) async {
      const AlbumEntity album = AlbumEntity(
        albumId: '1',
        albumName: 'Vacation',
        numberOfPhotos: 5,
        thumbnailPath: 'assets/images/gallery.png',
      );

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: AlbumTile(album: album),
        ),
      ));

      expect(find.text('Vacation'), findsOneWidget);
      expect(find.text('5 Photos'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
