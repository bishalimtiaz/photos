import 'package:photos/app/core/base/screen_controller.dart';
import 'package:photos/app/core/services/app_service.dart';
import 'package:photos/app/core/utils/log.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';

class PhotoController extends ScreenController {
  PhotoEntity? selectedPhoto;

  @override
  void onInit() {
    Log.debug("onInit PhotoController");
    selectedPhoto = AppService().argument as PhotoEntity?;
    super.onInit();
  }

  @override
  void onDispose() {
    Log.debug("onDispose PhotoController");
    super.onDispose();
  }
}
