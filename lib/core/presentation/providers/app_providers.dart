
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';
import 'package:pokeapi_app/core/data/providers/pokemon_providers.dart';
import 'package:pokeapi_app/core/presentation/providers/usecase_providers.dart';

class PokemonListState {
  List<PokemonModel> pokemonList;
  String? errorMessage;

  PokemonListState({required this.pokemonList, this.errorMessage});
}

class PokemonListNotifier extends StateNotifier<PokemonListState> {
  PokemonListNotifier(this.ref)
      : _offset = ref.read(pokemonListOffsetProvider),
        super(PokemonListState(pokemonList: []));

  final Ref ref;
  int _offset;

  Future<void> loadMore() async {
    final limit = ref.read(pokemonListLimitProvider);
    final useCase = ref.read(getPokemonListUseCaseProvider);

    final either = await useCase.execute(offset: _offset, limit: limit);

    either.fold(
          (error) {
        // Manejo del error
        state = PokemonListState(pokemonList: state.pokemonList, errorMessage: error);
      },
          (result) {
            state = PokemonListState(pokemonList: [...state.pokemonList, ...result.data ?? []]);
            _offset += limit;
          },
    );
  }
}

final pokemonListNotifierProvider = StateNotifierProvider<PokemonListNotifier, PokemonListState>((ref) {
  return PokemonListNotifier(ref);
});
