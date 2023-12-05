part of 'widgets.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({super.key, required this.pokemon, this.onPressed, this.isDelete = false});

  final PokemonModel pokemon;
  final void Function()? onPressed;
  final bool isDelete;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: pokemon.color, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pokemon.name.capitalizeFirstLetter(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          return Container(
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              pokemon.types[index].type.name
                                  .capitalizeFirstLetter(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                            height: 5), // Espacio entre elementos
                        itemCount: pokemon.types.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                      ),
                    )
                  ],
                ),
                Image.network(
                  pokemon.frontDefaultImage,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  width: 140,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: isDelete ? Colors.red : Colors.black26,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
              child: Text('${isDelete ? 'Eliminar de mi' : 'Agregar a mi'} equipo'),
            ),
          )
        ],
      ),
    );
  }
}

