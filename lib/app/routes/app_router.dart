import 'package:go_router/go_router.dart';

abstract class _Path {
  static const String splash = '/splash';
  static const String album = '/album';
  static const String gallery = '/gallery';
  static const String photo = '/photo';
  static const String photoAccess = '/photo-access';
}

final GoRouter appRouter = GoRouter(
  initialLocation: _Path.splash,
  routes: <RouteBase>[],
);
