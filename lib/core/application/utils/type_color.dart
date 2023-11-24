import 'package:flutter/material.dart';
import 'package:pokeapi_app/core/config/app_colors.dart';
import 'package:pokeapi_app/core/data/models/pokemon_model.dart';

Color colorGeneratorFromTypeDetail(TypeDetail typeDetail) {
  switch (typeDetail.name) {
    case 'grass':
    case 'bug':
      return AppColors.lightTeal;

    case 'fire':
      return AppColors.lightRed;

    case 'water':
      return AppColors.lightBlue;

    case 'normal':
    case 'flying':
      return AppColors.semiGrey;

    case 'fighting':
      return AppColors.brown;

    case 'electric':
    case 'psychic':
      return AppColors.lightYellow;

    case 'poison':
    case 'ghost':
      return AppColors.lightPurple;

    case 'ground':
    case 'rock':
      return AppColors.lightBrown;

    case 'dark':
      return AppColors.black;

    case 'fairy':
      return AppColors.lightPink;

    default:
      return AppColors.lightBlue;
  }
}