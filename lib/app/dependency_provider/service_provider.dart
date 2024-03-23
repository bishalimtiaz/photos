import 'package:get_it/get_it.dart';
import 'package:photos/app/core/services/photo_service.dart';
import 'package:photos/app/dependency_provider/provider.dart';

class ServiceProvider implements Provider {
  @override
  Future<void> provide(GetIt locator) async {
    locator.registerLazySingleton<PhotoService>(() => PhotoService());
  }
}
