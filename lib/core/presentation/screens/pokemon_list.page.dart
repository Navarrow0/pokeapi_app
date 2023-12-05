import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi_app/core/presentation/providers/app_providers.dart';
import 'package:pokeapi_app/core/presentation/providers/pokemon_team_provider.dart';
import 'package:pokeapi_app/core/presentation/widgets/widgets.dart';


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

  void _showAlreadyInTeamNotification(BuildContext context) {
    ElegantNotification.info(
      title: const Text("Información"),
      description: const Text("Este Pokémon ya está en tu equipo."),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListState = ref.watch(pokemonListNotifierProvider);
    final teamNotifier = ref.watch(pokemonTeamProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(),
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
                separatorBuilder: (_, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (BuildContext ctx, index) {
                  if (index < pokemonListState.pokemonList.length) {
                    final pokemon = pokemonListState.pokemonList[index];

                    return CardPokemon(
                      pokemon: pokemon,
                      onPressed: () {
                        final wasAdded = teamNotifier.addToTeam(pokemon);
                        if (wasAdded) {
                          _showSuccessNotification(context);
                        } else if (teamNotifier.getTeam().length >= 5) {
                          _showErrorNotification(context);
                        } else {
                          _showAlreadyInTeamNotification(context);
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
