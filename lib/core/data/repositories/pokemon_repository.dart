import 'package:dartz/dartz.dart';
import 'package:pokeapi_app/core/domain/entities/api_result.dart';
import 'package:pokeapi_app/core/domain/entities/pokemon_entitie.dart';

abstract class PokemonRepository {
  Future<Either<String, ApiResult<List<PokemonEntity>>>> getPokemonList();
}