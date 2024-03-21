import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  // Singleton instance
  static final PermissionManager _instance = PermissionManager._internal();

  factory PermissionManager() {
    return _instance;
  }

  PermissionManager._internal();

  // Request permission for a specific Permission
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return permission.request();
  }

  // Check if a permission is granted
  Future<bool> isPermissionGranted(Permission permission) async {
    return permission.status.isGranted;
  }

  // Request multiple permissions at once
  Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permissions,
  ) async {
    return permissions.request();
  }

  void openAppSettings() {
    openAppSettings(); // Calls platform-specific method to open settings
  }
}
