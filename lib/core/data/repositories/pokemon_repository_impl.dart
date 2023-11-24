
import 'package:dartz/dartz.dart';
import 'package:pokeapi_app/core/data/data_sources/pokemon_remote_data_source.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';
import 'package:pokeapi_app/core/domain/entities/api_result.dart';
import 'package:pokeapi_app/core/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<String, ApiResult<List<PokemonModel>>>> getPokemonList({required int offset, required int limit}) async {
    try {
      final apiPokemonList = await remoteDataSource.getPokemonList(offset: offset, limit: limit);
      final List<PokemonModel> pokemonList = [];

      for (final pokemonData in apiPokemonList) {
        final details = await remoteDataSource.getPokemonDetails(pokemonData['url']);

        final pokemonModel = PokemonModel.fromJson({
          'name': pokemonData['name'],
          'url': pokemonData['url'],
          'frontDefaultImage': details['sprites']['front_default'],
          'types': details['types'],
        });
        pokemonList.add(pokemonModel);
      }

      return Right(ApiResult(data: pokemonList));
    } catch (e) {
      return Left('$e');
    }
  }
}