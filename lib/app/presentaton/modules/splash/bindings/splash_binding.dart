import 'package:photos/app/dependency_provider/dependency_provider.dart';
import 'package:photos/app/presentaton/modules/splash/controllers/splash_controller.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

class SplashBinding extends Binding {
  @override
  Future<void> addDependencies() async {
    DependencyProvider().provideScreenController<SplashController>(
      () => SplashController(),
      isSingleInstance: isSingleInstance,
    );
  }

  @override
  Future<void> removeDependencies() async {
    DependencyProvider().removeController<SplashController>();
  }
}
