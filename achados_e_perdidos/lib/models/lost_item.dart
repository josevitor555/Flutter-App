class LostItem {
  final int id; // No Python o ID é Integer
  final String title;
  final String? imageUrl; // No Python é nullable=True
  final bool isFound;
  final String? description;
  final String? location;
  final String? category;
  final int usuarioId; // Importante para saber de quem é o item

  const LostItem({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.isFound,
    this.description,
    this.location,
    this.category,
    required this.usuarioId,
  });

  // Ajuste aqui: Mapeando os nomes em português do Python para o seu código
  factory LostItem.fromJson(Map<String, dynamic> json) => LostItem(
    id: json['id'] as int,
    title: json['titulo'] as String, // 'titulo' vem do Python
    imageUrl: json['imagem_url'] as String?, // 'imagem_url' vem do Python
    isFound: json['status'] == 'found', // Converte String "found" para booleano
    description: json['descricao'] as String?,
    location: json['local'] as String?,
    category: json['categoria'] as String?,
    usuarioId: json['usuario_id'] as int,
  );

  Map<String, dynamic> toJson() => {
    'titulo': title,
    'descricao': description,
    'categoria': category,
    'local': location,
    'status': isFound ? 'found' : 'lost', // Devolve como String para o Python
    'imagem_url': imageUrl,
  };

  String get statusLabel => isFound ? 'Encontrado' : 'Perdido';

  LostItem copyWith({
    int? id,
    String? title,
    String? imageUrl,
    bool? isFound,
    String? description,
    String? location,
    String? category,
    int? usuarioId,
  }) {
    return LostItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      isFound: isFound ?? this.isFound,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }
}
