/// Modelo que representa os dados de um Pokémon retornados pela PokeAPI.
class Pokemon {
  final int id;
  final String nome;
  final int alturaDecimetros;
  final int pesoHectogramas;
  final List<String> tipos;
  final String imagemUrl;

  Pokemon({
    required this.id,
    required this.nome,
    required this.alturaDecimetros,
    required this.pesoHectogramas,
    required this.tipos,
    required this.imagemUrl,
  });

  double get alturaMetros => alturaDecimetros / 10;
  double get pesoQuilos => pesoHectogramas / 10;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final tiposJson = json['types'] as List<dynamic>? ?? [];
    final tipos = tiposJson
        .map((t) => (t['type']?['name'] ?? '').toString())
        .where((s) => s.isNotEmpty)
        .toList();

    return Pokemon(
      id: json['id'] ?? 0,
      nome: json['name'] ?? '',
      alturaDecimetros: json['height'] ?? 0,
      pesoHectogramas: json['weight'] ?? 0,
      tipos: tipos,
      imagemUrl: json['sprites']?['front_default'] ?? '',
    );
  }
}
