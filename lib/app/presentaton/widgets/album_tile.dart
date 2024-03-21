import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photos/app/core/constants/app_values.dart';
import 'package:photos/app/domain/entities/album_entity.dart';

class AlbumTile extends StatelessWidget {
  final AlbumEntity album;

  const AlbumTile({
    required this.album,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.dimen_8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.dimen_10),
        child: Stack(
          children: <Widget>[
            Image.file(
              File(album.thumbnailPath),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.luminosity,
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) {
                return const Center(child: Icon(Icons.error));
              },
            ),
            // Overlay album name (optional)
            Positioned(
              bottom: AppValues.dimen_8,
              left: AppValues.dimen_8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    album.albumName,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppValues.dimen_3),
                  Text(
                    "${album.numberOfPhotos} Photos",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
