// lib/features/blogs/data/entities/blog_model.dart
class BlogModel {
  String? id;            // maps _id (if present)
  String? title;
  String? highlight;
  String? description;
  List<String>? contributor;
  int? likes;
  String? createdAt;
  String? updatedAt;

  BlogModel({
    this.id,
    this.title,
    this.highlight,
    this.description,
    this.contributor,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] ?? json['id']) as String?;
    title = json['title'] as String?;
    highlight = json['highlight'] as String?;
    description = json['description'] as String?;
    contributor = (json['contributor'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        const [];
    likes = (json['likes'] is num)
        ? (json['likes'] as num).toInt()
        : int.tryParse('${json['likes'] ?? ''}');
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['highlight'] = highlight;
    data['description'] = description;
    data['contributor'] = contributor ?? const [];
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
