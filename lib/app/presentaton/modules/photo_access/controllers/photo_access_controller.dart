import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/core/utils/permission_manager.dart';

class PhotoAccessController extends ScreenController {
  @override
  void onInit() {
    Log.debug('onInit: PhotoAccessController');
    super.onInit();
  }

  Future<bool> requestPhotoAccess() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo =
          await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        PermissionStatus status =
            await PermissionManager().requestPermission(Permission.storage);
        return _isGranted(status);
      } else {
        PermissionStatus status =
            await PermissionManager().requestPermission(Permission.photos);
        return _isGranted(status);
      }
    } else {
      PermissionStatus status =
          await PermissionManager().requestPermission(Permission.photos);
      return _isGranted(status);
    }
  }

  bool _isGranted(PermissionStatus status) {
    return status.isGranted ? true : false;
  }

  @override
  void onDispose() {
    Log.debug('onDispose: PhotoAccessController');
    super.onDispose();
  }
}
