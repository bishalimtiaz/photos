import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/utils/log.dart';

class PhotoAccessController extends ScreenController {
  @override
  void onInit() {
    Log.debug('onInit: PhotoAccessController');
    super.onInit();
  }

  @override
  void onDispose() {
    Log.debug('onDispose: PhotoAccessController');
    super.onDispose();
  }
}
