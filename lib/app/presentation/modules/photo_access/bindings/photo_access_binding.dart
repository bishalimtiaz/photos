import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentation/modules/photo_access/controllers/photo_access_controller.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

class PhotoAccessBinding extends Binding {
  @override
  bool get isSingleInstance => false;

  @override
  Future<void> addDependencies() async {
    DependencyProvider().provideScreenController<PhotoAccessController>(
      () => PhotoAccessController(),
      isSingleInstance: isSingleInstance,
    );
  }

  @override
  Future<void> removeDependencies() async {
    DependencyProvider().removeController<PhotoAccessController>();
  }
}
