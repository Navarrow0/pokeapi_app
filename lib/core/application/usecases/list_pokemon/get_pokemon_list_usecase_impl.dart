
import 'package:dartz/dartz.dart';
import 'package:pokeapi_app/core/application/usecases/list_pokemon/get_pokemon_list_usecase.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';
import 'package:pokeapi_app/core/domain/entities/api_result.dart';
import 'package:pokeapi_app/core/domain/repositories/pokemon_repository.dart';

class GetPokemonListUseCaseImpl implements GetPokemonListUseCase {
  final PokemonRepository _repository;

  GetPokemonListUseCaseImpl(this._repository);

  @override
  Future<Either<String, ApiResult<List<PokemonModel>>>> execute({required int offset, required int limit}) async {
    return await _repository.getPokemonList(offset: offset, limit: limit);
  }
}
