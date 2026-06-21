class AppUser {
  final String id;
  String name;
  String email;
  String? avatarUrl;
  String? bio;
  DateTime createdAt;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'bio': bio,
        'createdAt': createdAt.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        bio: json['bio'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  AppUser copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
  }) =>
      AppUser(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        bio: bio ?? this.bio,
        createdAt: createdAt,
      );
}
