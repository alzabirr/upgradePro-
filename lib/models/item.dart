class AppItem {
  final String id;
  String title;
  String description;
  String? imageUrl;
  String category;
  bool isFavorite;
  DateTime createdAt;
  DateTime updatedAt;

  AppItem({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.category = 'General',
    this.isFavorite = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'category': category,
        'isFavorite': isFavorite,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory AppItem.fromJson(Map<String, dynamic> json) => AppItem(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        imageUrl: json['imageUrl'] as String?,
        category: json['category'] as String? ?? 'General',
        isFavorite: json['isFavorite'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  AppItem copyWith({
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    bool? isFavorite,
  }) =>
      AppItem(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
        isFavorite: isFavorite ?? this.isFavorite,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );
}
