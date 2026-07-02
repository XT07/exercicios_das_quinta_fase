/// Modelo que representa o endereço retornado pela API ViaCEP.
class Endereco {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;
  final String uf;

  Endereco({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  /// A API ViaCEP retorna HTTP 200 mesmo quando o CEP não existe,
  /// devolvendo um JSON no formato { "erro": true }.
  /// Por isso a checagem de "CEP não encontrado" é feita no service,
  /// antes de chamar este fromJson.
  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? '',
      bairro: json['bairro'] ?? '',
      localidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
    );
  }
}
