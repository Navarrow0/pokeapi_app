import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pokeapi_app/core/data/data_sources/pokemon_remote_data_source.dart';

void main() {
  group('PokemonRemoteDataSource', () {
    late PokemonRemoteDataSource dataSource;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/',
        ),
      );
      dioAdapter = DioAdapter(dio: dio);
      dataSource = PokemonRemoteDataSource(dio);
    });

    test('getPokemonList should return a list of Pokemon', () async {
      // Mock the response
      final mockResponse = {
        'results': [
          {'name': 'Pikachu', 'url': 'https://pokeapi.com/api/v2/pokemon/25'},
          {'name': 'Bulbasaur', 'url': 'https://pokeapi.com/api/v2/pokemon/1'},
        ],
      };

      dioAdapter.onGet(
        'pokemon?offset=0&limit=10',
            (request) => request.reply(200, mockResponse),
      );

      final result = await dataSource.getPokemonList(offset: 0, limit: 10);

      // Verify that the result matches the expected data
      expect(result, [
        {'name': 'Pikachu', 'url': 'https://pokeapi.com/api/v2/pokemon/25'},
        {'name': 'Bulbasaur', 'url': 'https://pokeapi.com/api/v2/pokemon/1'},
      ]);
    });
  });
}
