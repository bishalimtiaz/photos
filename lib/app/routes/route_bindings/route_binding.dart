import 'package:photos/app/routes/route_bindings/binding.dart';

typedef Binder = Binding Function();

final Map<String, Binder> routeBindings = <String, Binder>{};
