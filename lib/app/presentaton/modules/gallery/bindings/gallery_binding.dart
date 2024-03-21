import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentaton/modules/gallery/controllers/gallery_controller.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

class GalleryBinding extends Binding {
  @override
  bool get isSingleInstance => false;

  @override
  Future<void> addDependencies() async {
    DependencyProvider().provideScreenController<GalleryController>(
      () => GalleryController(),
      isSingleInstance: isSingleInstance,
    );
  }

  @override
  Future<void> removeDependencies() async {
    DependencyProvider().removeController<GalleryController>();
  }
}
