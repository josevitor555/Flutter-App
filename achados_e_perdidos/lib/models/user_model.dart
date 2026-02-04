class User {
  final int id;
  final String username; // No seu models.py é 'username', não 'name'

  User({required this.id, required this.username});

  // Serialização: Recebendo dados do Python
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username:
          json['username'] as String, // Ajustado para bater com o back-end
    );
  }

  // De-serialização: Enviando para o Python (ex: no cadastro)
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username};
  }
}
