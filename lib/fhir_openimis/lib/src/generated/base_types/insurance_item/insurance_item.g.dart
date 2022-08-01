// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InsuranceItem _$$_InsuranceItemFromJson(Map<String, dynamic> json) =>
    _$_InsuranceItem(
      id: json['id'] as String?,
      extension: (json['extension'] as List<dynamic>?)
          ?.map((e) => Extension.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] == null
          ? null
          : CodeableConcept<dynamic>.fromJson(
              json['category'] as Map<String, dynamic>, (value) => value),
      name: json['name'] as String?,
      description: json['description'] as String?,
      productOrService: json['productOrService'] == null
          ? null
          : CodeableConcept<dynamic>.fromJson(
              json['productOrService'] as Map<String, dynamic>,
              (value) => value),
      excluded:
          json['excluded'] == null ? null : Boolean.fromJson(json['excluded']),
      benefit: (json['benefit'] as List<dynamic>?)
          ?.map((e) => BackboneElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_InsuranceItemToJson(_$_InsuranceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'extension': instance.extension,
      'category': instance.category,
      'name': instance.name,
      'description': instance.description,
      'productOrService': instance.productOrService,
      'excluded': instance.excluded,
      'benefit': instance.benefit,
    };
