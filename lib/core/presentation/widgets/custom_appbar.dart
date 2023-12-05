part of 'widgets.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, ref) {
    final team = ref.watch(pokemonTeamProvider);

    return AppBar(
      title: const Text(
        'Pokedex',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: InkWell(
            onTap: () {
              showPokemonTeamDialog(context);
            },
            child: badges.Badge(
              badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColors.indigo
              ),
              badgeContent: Text(
                '${team.length}',
                style: const TextStyle(color: AppColors.whiteGrey),
              ),
              child: Image.asset(
                'assets/pokebola.png',
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}