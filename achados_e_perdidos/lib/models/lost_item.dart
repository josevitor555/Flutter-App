/// Modelo de item perdido ou encontrado.
/// Status: apenas Perdido ou Encontrado.
class LostItem {
  final String id;
  final String title;
  final String imageUrl;
  final bool isFound; // true = Encontrado, false = Perdido
  final String? description;
  final String? location;
  final String? category;

  const LostItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isFound,
    this.description,
    this.location,
    this.category,
  });

  String get statusLabel => isFound ? 'Encontrado' : 'Perdido';

  LostItem copyWith({
    String? id,
    String? title,
    String? imageUrl,
    bool? isFound,
    String? description,
    String? location,
    String? category,
  }) {
    return LostItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isFound: isFound ?? this.isFound,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'isFound': isFound,
        'description': description,
        'location': location,
        'category': category,
      };

  factory LostItem.fromJson(Map<String, dynamic> json) => LostItem(
        id: json['id'] as String,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String,
        isFound: json['isFound'] as bool,
        description: json['description'] as String?,
        location: json['location'] as String?,
        category: json['category'] as String?,
      );
}
