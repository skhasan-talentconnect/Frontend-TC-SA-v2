import 'package:flutter/material.dart';
import 'package:tc_sa/common/models/photo.dart';

class PhotosView extends StatefulWidget {
  final List<Photo> photos;

  const PhotosView({
    super.key,
    required this.photos,
  });

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  final List<String> _validUrls = [];

  @override
  void initState() {
    super.initState();    
    _filterValidPhotos();
  }

  Future<void> _filterValidPhotos() async {
    _validUrls.clear();
    for (final photo in widget.photos) {
      if (photo.url != null && photo.url!.isNotEmpty) {
        _validUrls.add(photo.url!);
      }
    }
    setState(() {});
  }

  Future<void> _onRefresh() async {
    await _filterValidPhotos();
  }

  @override
  Widget build(BuildContext context) {
    if (_validUrls.isEmpty) {
      return const Center(
        child: Text(
          'No photos available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: Colors.amber,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _validUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // you can change to 1 or 3 depending on layout
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final url = _validUrls[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                // Skip broken images entirely by returning SizedBox.shrink
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _validUrls.remove(url));
                });
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

