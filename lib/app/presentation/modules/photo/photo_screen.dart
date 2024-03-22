import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photos/app/core/base/screen_state.dart';
import 'package:photos/app/presentation/modules/photo/controllers/photo_controller.dart';
import 'package:photos/app/routes/app_routes.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ScreenState<PhotoScreen, PhotoController> {
  @override
  String? get routeName => AppRoutes.photo;

  @override
  PreferredSizeWidget? appbar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, // Change this to your desired color
      ),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Color? get backgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Image.file(
            File(controller.selectedPhoto?.path ?? ""),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
