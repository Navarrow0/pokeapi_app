// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      name: json['name'] as String,
      url: json['url'] as String,
      frontDefaultImage: json['frontDefaultImage'] as String,
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => PokemonType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'frontDefaultImage': instance.frontDefaultImage,
      'name': instance.name,
      'url': instance.url,
      'types': instance.types,
    };

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) => PokemonType(
      slot: json['slot'] as int,
      type: TypeDetail.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

TypeDetail _$TypeDetailFromJson(Map<String, dynamic> json) => TypeDetail(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$TypeDetailToJson(TypeDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
