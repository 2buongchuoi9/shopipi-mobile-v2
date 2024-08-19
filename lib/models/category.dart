class Category {
  final String id;
  final String slug;
  final String name;
  final List<String> parentIds;
  final String thumb;
  late String? key;
  late String? label;
  late dynamic value; // `dynamic` để xử lý cả `String` và `number`
  late List<Category>? children;

  Category({
    required this.id,
    required this.slug,
    required this.name,
    required this.parentIds,
    required this.thumb,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      parentIds: List<String>.from(json['parentIds'] as List),
      thumb: json['thumb'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'parentIds': parentIds,
      'thumb': thumb,
    };
  }
}
