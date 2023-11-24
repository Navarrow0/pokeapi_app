import 'package:dio/dio.dart';

class PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource(this.dio);

  Future<List<Map<String, dynamic>>> getPokemonList({required int offset, required int limit}) async {
    final response = await dio.get('pokemon?offset=$offset&limit=$limit');
    return List<Map<String, dynamic>>.from(response.data['results']);
  }

  Future<Map<String, dynamic>> getPokemonDetails(String url) async {
    final response = await dio.get(url);
    return Map<String, dynamic>.from(response.data);
  }
}
