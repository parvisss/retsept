// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComentModel _$ComentModelFromJson(Map<String, dynamic> json) => ComentModel(
      title: json['title'] as String,
      date: json['date'] as String,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$ComentModelToJson(ComentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'sender': instance.sender,
    };
