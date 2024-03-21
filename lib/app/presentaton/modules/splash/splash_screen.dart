import 'package:flutter/material.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/core/constants/app_assets.dart';
import 'package:photos/app/core/constants/app_values.dart';
import 'package:photos/app/presentaton/modules/splash/controllers/splash_controller.dart';
import 'package:photos/app/presentaton/widgets/asset_image_view.dart';
import 'package:photos/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ScreenState<SplashScreen, SplashController> {
  @override
  String? get routeName => AppRoutes.splash;

  @override
  Widget buildScreen(BuildContext context) {
    return const Center(
      child: AssetImageView(
        fileName: AppAssets.gallery,
        fit: BoxFit.contain,
        height: AppValues.dimen_130,
        width: AppValues.dimen_130,
      ),
    );
  }
}
