import 'package:flutter/material.dart';
import 'package:photos/app/core/base/observer.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/core/utils/context_ext.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';
import 'package:photos/app/presentaton/modules/gallery/controllers/gallery_controller.dart';
import 'package:photos/app/presentaton/widgets/photo_tile.dart';
import 'package:photos/app/routes/app_router.dart';
import 'package:photos/app/routes/app_routes.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState
    extends ScreenState<GalleryScreen, GalleryController> {
  @override
  String? get routeName => AppRoutes.gallery;

  @override
  PreferredSizeWidget? appbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        controller.selectedAlbum?.albumName ?? " ",
        style: context.textTheme.displayMedium,
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Observer<List<PhotoEntity>>(
      observable: controller.photos,
      childBuilder: (BuildContext context, List<PhotoEntity> list, _) {
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: list.length,
          // Replace with your list of albums
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () async {
              _onTapAlbum(list[index]);
            },
            child: PhotoTile(
              photo: list[index],
            ),
          ),
        );
      },
    );
  }

  void _onTapAlbum(PhotoEntity entity) async {
    appRouter.pushNamed(
      AppRoutes.photo,
      extra: entity,
    );
  }
}
