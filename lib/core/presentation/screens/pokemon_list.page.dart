import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/presentation/providers/app_providers.dart';
import 'package:pokeapi_app/core/presentation/providers/pokemon_team_provider.dart';
import 'package:pokeapi_app/core/presentation/widgets/card_pokemon.dart';
import 'package:pokeapi_app/core/presentation/widgets/pokemon_dialog.dart';
import 'package:pokeapi_app/core/presentation/widgets/skeleton.dart';


class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonListNotifierProvider.notifier).loadMore();
    });
  }


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isEndOfList()) {
      ref.read(pokemonListNotifierProvider.notifier).loadMore();
    }
  }

  bool _isEndOfList() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    return currentScroll >= maxScroll;
  }

  void _showSuccessNotification(BuildContext context) {
    ElegantNotification.success(
      title: const Text("Éxito"),
      description: const Text("¡Pokemon añadido al equipo!"),
    ).show(context);
  }

  void _showErrorNotification(BuildContext context) {
    ElegantNotification.error(
      title: const Text("Error"),
      description: const Text("No puedes tener más de 5 Pokémon en tu equipo"),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListState = ref.watch(pokemonListNotifierProvider);
    final teamNotifier = ref.watch(pokemonTeamProvider.notifier);


    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Pokedex',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  showPokemonTeamDialog(context);
                },
                child: Image.asset(
                  'assets/pokebola.png',
                  width: 30,
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            if (pokemonListState.errorMessage != null)
              Center(
                child: Text(
                  'Error: ${pokemonListState.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (pokemonListState.pokemonList.isEmpty)
              const ListSkeleton()
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pokemonListState.pokemonList.length + 1,
                separatorBuilder: (_,index)=> const SizedBox(height: 10,),
                itemBuilder: (BuildContext ctx, index) {
                  if (index < pokemonListState.pokemonList.length) {
                    final pokemon = pokemonListState.pokemonList[index];

                    return CardPokemon(
                      pokemon: pokemon,
                      onPressed: () {
                        if (teamNotifier.getTeam().length < 5) {
                          teamNotifier.addToTeam(pokemon);
                          _showSuccessNotification(context);
                        } else {
                          _showErrorNotification(context);
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )

          ],
        ),
      ),
    );
  }
}

