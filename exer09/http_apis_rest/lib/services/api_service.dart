import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/endereco.dart';
import '../models/pokemon.dart';
import 'api_exceptions.dart';

/// Centraliza as requisições HTTP do app.
///
/// Todas as chamadas usam timeout de 10 segundos e capturam:
/// - TimeoutException  -> sem resposta dentro do prazo
/// - SocketException   -> sem conexão com a internet
/// - status code != 200 -> resposta de erro do servidor
class ApiService {
  static const Duration _timeout = Duration(seconds: 10);

  /// Valida se o CEP tem exatamente 8 dígitos numéricos.
  static bool cepValido(String cep) {
    return RegExp(r'^\d{8}$').hasMatch(cep);
  }

  Future<Endereco> buscarCep(String cep) async {
    final uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode != 200) {
        throw ServerException(response.statusCode);
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      // ViaCEP devolve HTTP 200 com {"erro": true} quando o CEP não existe.
      if (data['erro'] == true) {
        throw NotFoundException('CEP não encontrado. Verifique o número digitado.');
      }

      return Endereco.fromJson(data);
    } on TimeoutException {
      throw TimeoutApiException();
    } on SocketException {
      throw NoConnectionException();
    } on ApiException {
      rethrow;
    } catch (_) {
      throw UnknownApiException();
    }
  }

  Future<Pokemon> buscarPokemon(String nome) async {
    final nomeNormalizado = nome.trim().toLowerCase();
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nomeNormalizado');

    try {
      final response = await http.get(uri).timeout(_timeout);

      if (response.statusCode == 404) {
        throw NotFoundException('Pokémon não encontrado. Verifique o nome digitado.');
      }
      if (response.statusCode != 200) {
        throw ServerException(response.statusCode);
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } on TimeoutException {
      throw TimeoutApiException();
    } on SocketException {
      throw NoConnectionException();
    } on ApiException {
      rethrow;
    } catch (_) {
      throw UnknownApiException();
    }
  }
}
