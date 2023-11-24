import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';

final pokemonTeamProvider = StateNotifierProvider<PokemonTeamNotifier, List<PokemonModel>>((ref) {
  return PokemonTeamNotifier();
});


class PokemonTeamNotifier extends StateNotifier<List<PokemonModel>> {
  PokemonTeamNotifier() : super([]);

  List<PokemonModel> getTeam() {
    return state;
  }

  void addToTeam(PokemonModel pokemon) {
    if (state.length < 5) {
      state = [...state, pokemon];
    }
  }

  void removeFromTeam(PokemonModel pokemon) {
    state = state.where((p) => p != pokemon).toList();
  }
}
