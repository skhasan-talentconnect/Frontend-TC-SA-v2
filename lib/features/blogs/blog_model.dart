class BlogModel {
  String? title;
  String? highlight;
  String? description;
  List<String>? contributor;
  int? likes;

  BlogModel({
    this.title,
    this.highlight,
    this.description,
    this.contributor,
    this.likes,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    highlight = json['highlight'];
    description = json['description'];
    contributor = json['contributor'].cast<String>();
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['highlight'] = this.highlight;
    data['description'] = this.description;
    data['contributor'] = this.contributor;
    data['likes'] = this.likes;
    return data;
  }
}