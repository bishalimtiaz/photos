import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentation/modules/album/controllers/album_controller.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

class AlbumBinding extends Binding {
  @override
  bool get isSingleInstance => false;

  @override
  Future<void> addDependencies() async {
    DependencyProvider().provideScreenController<AlbumController>(
      () => AlbumController(),
      isSingleInstance: isSingleInstance,
    );
  }

  @override
  Future<void> removeDependencies() async {
    DependencyProvider().removeController<AlbumController>();
  }
}
