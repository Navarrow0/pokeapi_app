import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/data/data_sources/pokemon_remote_data_source.dart';
import 'package:pokeapi_app/core/data/providers/dio_provider.dart';
import 'package:pokeapi_app/core/data/repositories/pokemon_repository_impl.dart';

final pokemonRepositoryProvider = Provider.family<PokemonRepositoryImpl, int>((ref, offset) {
  return PokemonRepositoryImpl(
    remoteDataSource: ref.read(pokemonRemoteDataSourceProvider),
  );
});

final pokemonListLimitProvider = StateProvider<int>((ref) => 20);
final pokemonListOffsetProvider = StateProvider<int>((ref) => 10);

final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((ref) {
  return PokemonRemoteDataSource(ref.read(dioProvider));
});
