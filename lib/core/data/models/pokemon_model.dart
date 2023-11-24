import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokeapi_app/core/application/utils/type_color.dart';
import 'package:pokeapi_app/core/domain/entities/pokemon_entitie.dart';

part 'pokemon_model.g.dart';
@JsonSerializable()
class PokemonModel extends PokemonEntity {
  final String frontDefaultImage;
  @override
  final String name;
  @override
  final String url;

  final List<PokemonType> types;

  final Color color;

  PokemonModel({
    required this.name,
    required this.url,
    required this.frontDefaultImage,
    this.types = const [],
  })  : color = _calculateColor(types),
        super(name: name, url: url);

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);

  static List<PokemonModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => PokemonModel.fromJson(map)).toList();
  }

  static Color _calculateColor(List<PokemonType> types) {
    final typeName = types.first.type.name;
    return colorGeneratorFromTypeDetail(TypeDetail(name: typeName, url: ""));
  }
}

@JsonSerializable()
class PokemonType {
  final int slot;
  final TypeDetail type;

  PokemonType({
    required this.slot,
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeToJson(this);
}

@JsonSerializable()
class TypeDetail {
  final String name;
  final String url;

  TypeDetail({
    required this.name,
    required this.url,
  });

  factory TypeDetail.fromJson(Map<String, dynamic> json) =>
      _$TypeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDetailToJson(this);
}
