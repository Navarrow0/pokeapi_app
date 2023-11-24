import 'package:dartz/dartz.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';
import 'package:pokeapi_app/core/domain/entities/api_result.dart';

abstract class PokemonRepository {
  Future<Either<String, ApiResult<List<PokemonModel>>>> getPokemonList({required int offset, required int limit});
}
