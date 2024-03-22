import 'package:flutter/material.dart';
import 'package:photos/app/core/base/observer.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/core/constants/app_values.dart';
import 'package:photos/app/core/utils/context_ext.dart';
import 'package:photos/app/domain/entities/album_entity.dart';
import 'package:photos/app/presentation/modules/album/controllers/album_controller.dart';
import 'package:photos/app/presentation/widgets/album_tile.dart';
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
  PreferredSizeWidget? appbar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        "Albums",
        style: context.textTheme.displayLarge,
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Observer<List<AlbumEntity>>(
      observable: controller.albums,
      childBuilder: (BuildContext context, List<AlbumEntity> list, _) {
        return GridView.builder(
          padding: const EdgeInsets.all(AppValues.dimen_8),
          itemCount: list.length, // Replace with your list of albums
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust for desired number of columns
            crossAxisSpacing: AppValues.dimen_4,
            mainAxisSpacing: AppValues.dimen_6,
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
