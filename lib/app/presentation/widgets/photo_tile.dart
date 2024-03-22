import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photos/app/core/constants/app_values.dart';
import 'package:photos/app/domain/entities/photo_entity.dart';

class PhotoTile extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoTile({
    required this.photo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.dimen_5),
      child: Image.file(
        File(photo.path),
        fit: BoxFit.cover,
      ),
    );
  }
}
