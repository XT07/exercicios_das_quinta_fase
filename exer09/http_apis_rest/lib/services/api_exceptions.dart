/// Exceptions customizadas do app.
///
/// A camada de serviço (ApiService) captura as exceptions "brutas"
/// (TimeoutException, SocketException, status code != 200) e as
/// traduz para estas classes, já com uma mensagem amigável para o usuário.
/// Assim a UI não precisa conhecer detalhes de dart:io ou dart:async,
/// apenas tratar um ApiException e exibir a mensagem.
abstract class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

/// Requisição excedeu o tempo limite (10s).
class TimeoutApiException extends ApiException {
  TimeoutApiException()
      : super('A requisição demorou muito para responder. Tente novamente.');
}

/// Dispositivo sem conexão com a internet (modo avião, sem sinal, etc).
class NoConnectionException extends ApiException {
  NoConnectionException()
      : super('Sem conexão com a internet. Verifique sua rede e tente novamente.');
}

/// A API respondeu, mas com um status HTTP de erro (ex: 500, 503).
class ServerException extends ApiException {
  final int statusCode;
  ServerException(this.statusCode)
      : super('Erro no servidor (código $statusCode). Tente novamente mais tarde.');
}

/// Recurso não encontrado (CEP inexistente, Pokémon inexistente, HTTP 404).
class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message);
}

/// Qualquer outro erro inesperado (parsing, etc).
class UnknownApiException extends ApiException {
  UnknownApiException() : super('Ocorreu um erro inesperado. Tente novamente.');
}
