import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/core/utils/permission_manager.dart';

class SplashController extends ScreenController {
  @override
  void onInit() {
    Log.debug("onInit SplashController");

    super.onInit();
  }

  void listenForPhotoAccessPermission(
    Function(bool isPermissionGranted) callback,
  ) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo =
          await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        bool res =
            await PermissionManager().isPermissionGranted(Permission.storage);
        callback.call(res);
      } else {
        bool res =
            await PermissionManager().isPermissionGranted(Permission.photos);
        callback.call(res);
      }
    } else {
      bool res =
          await PermissionManager().isPermissionGranted(Permission.photos);
      callback.call(res);
    }
  }

  @override
  void onDispose() {
    Log.debug("onDispose SplashController");
  }
}
