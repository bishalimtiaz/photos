import 'package:flutter/material.dart';
import 'package:photos/app/core/base/observer.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/presentaton/modules/album/controllers/album_controller.dart';
import 'package:photos/app/presentaton/widgets/album_tile.dart';
import 'package:photos/app/routes/app_router.dart';
import 'package:photos/app/routes/app_routes.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends ScreenState<AlbumScreen, AlbumController> {
  @override
  String? get routeName => AppRoutes.album;

  @override
  PreferredSizeWidget? get appbar => AppBar(
        centerTitle: false,
        title: const Text("Albums"),
      );

  @override
  Widget buildScreen(BuildContext context) {
    return Observer<List<AlbumEntity>>(
      observable: controller.albums,
      childBuilder: (BuildContext context, List<AlbumEntity> list, _) {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: list.length, // Replace with your list of albums
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust for desired number of columns
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 6.0,
          ),
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () async {
              _onTapAlbum(list[index]);
            },
            child: AlbumTile(
              album: list[index],
            ),
          ),
        );
      },
    );
  }

  void _onTapAlbum(AlbumEntity entity) async {
    appRouter.pushNamed(
      AppRoutes.gallery,
      extra: entity,
    );
  }
}
