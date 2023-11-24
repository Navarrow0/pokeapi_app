

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/application/usecases/list_pokemon/get_pokemon_list_usecase.dart';
import 'package:pokeapi_app/core/application/usecases/list_pokemon/get_pokemon_list_usecase_impl.dart';
import 'package:pokeapi_app/core/data/providers/pokemon_providers.dart';
import 'package:pokeapi_app/core/data/repositories/pokemon_repository_impl.dart';

final getPokemonListUseCaseProvider = Provider<GetPokemonListUseCase>(
      (ref) => GetPokemonListUseCaseImpl(
    PokemonRepositoryImpl(
      remoteDataSource: ref.read(pokemonRemoteDataSourceProvider),
    ),
  ),
);