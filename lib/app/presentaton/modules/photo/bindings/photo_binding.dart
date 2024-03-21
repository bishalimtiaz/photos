import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentaton/modules/photo/controllers/photo_controller.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

class PhotoBinding extends Binding {
  @override
  bool get isSingleInstance => false;

  @override
  Future<void> addDependencies() async {
    DependencyProvider().provideScreenController<PhotoController>(
      () => PhotoController(),
      isSingleInstance: isSingleInstance,
    );
  }

  @override
  Future<void> removeDependencies() async {
    DependencyProvider().removeController<PhotoController>();
  }
}
