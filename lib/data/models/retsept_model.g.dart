// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retsept_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetseptModel _$RetseptModelFromJson(Map<String, dynamic> json) => RetseptModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preparation: (json['preparation'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      coments: (json['coments'] as List<dynamic>)
          .map((e) => ComentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: (json['likes'] as num).toInt(),
      image: json['image'] as String,
      video: json['video'] as String,
    );

Map<String, dynamic> _$RetseptModelToJson(RetseptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'ingredients': instance.ingredients,
      'preparation': instance.preparation,
      'coments': instance.coments.map((e) => e.toJson()).toList(),
      'likes': instance.likes,
      'image': instance.image,
      'video': instance.video,
    };
