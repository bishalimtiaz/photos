import 'package:flutter/material.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/core/constants/app_assets.dart';
import 'package:photos/app/core/constants/app_values.dart';
import 'package:photos/app/presentaton/modules/photo_access/controllers/photo_access_controller.dart';
import 'package:photos/app/presentaton/widgets/asset_image_view.dart';
import 'package:photos/app/presentaton/widgets/primary_button.dart';
import 'package:photos/app/routes/app_router.dart';
import 'package:photos/app/routes/app_routes.dart';

class PhotoAccessScreen extends StatefulWidget {
  const PhotoAccessScreen({super.key});

  @override
  State<PhotoAccessScreen> createState() => _PhotoAccessScreenState();
}

class _PhotoAccessScreenState
    extends ScreenState<PhotoAccessScreen, PhotoAccessController> {
  @override
  String? get routeName => AppRoutes.photoAccess;

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.dimen_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const AssetImageView(
            fileName: AppAssets.icPhotos,
            fit: BoxFit.contain,
            height: AppValues.dimen_149,
            width: AppValues.dimen_123,
          ),
          const SizedBox(height: AppValues.dimen_8),
          const Text(
            "Require Permission",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.dimen_8),
          const Text(
            "To show your black and white photos/n we just need your folder permission.\nWe promise, we don’t take your photos.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppValues.dimen_42),
          PrimaryButton(
            onTap: _onTapRequestPermission,
            child: const Text(
              "Grant Access",
            ),
          )
        ],
      ),
    );
  }

  void _onTapRequestPermission() async {
    controller.requestPhotoAccess().then((bool value) {
      if (value) {
        appRouter.goNamed(AppRoutes.album);
      }
    });
  }
}
