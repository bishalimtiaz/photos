import 'package:photos/app/presentaton/modules/photo_access/bindings/photo_access_binding.dart';
import 'package:photos/app/presentaton/modules/splash/bindings/splash_binding.dart';
import 'package:photos/app/routes/app_routes.dart';
import 'package:photos/app/routes/route_bindings/binding.dart';

typedef Binder = Binding Function();

final Map<String, Binder> routeBindings = <String, Binder>{
  AppRoutes.splash: () => SplashBinding(),
  AppRoutes.photoAccess: () => PhotoAccessBinding(),
};
