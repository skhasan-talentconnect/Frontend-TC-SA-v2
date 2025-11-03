import 'package:flutter/material.dart';
import 'package:tc_sa/common/models/photo.dart';

class PhotosView extends StatelessWidget {
  final List<Photo> photos;

  const PhotosView({
    super.key,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const Center(
        child: Text(
          'No photos available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
      
        return;
      },
      color: Colors.amber,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final photo = photos[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              photo.url ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




























