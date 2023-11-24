import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/presentation/providers/pokemon_team_provider.dart';
import 'package:pokeapi_app/core/presentation/widgets/card_pokemon.dart';


void showPokemonTeamDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const PokemonTeamDialog();
    },
  );
}

class PokemonTeamDialog extends ConsumerWidget {
  const PokemonTeamDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final teamNotifier = ref.read(pokemonTeamProvider.notifier);
    final team = ref.watch(pokemonTeamProvider);

    return AlertDialog(
      title: const Text('Pokémon en tu equipo'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: team.length,
                separatorBuilder: (_, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (BuildContext ctx, index) {
                  return CardPokemon(
                    pokemon: team[index],
                    isDelete: true,
                    onPressed: () {
                      teamNotifier.removeFromTeam(team[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
