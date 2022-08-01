// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Insurance _$$_InsuranceFromJson(Map<String, dynamic> json) => _$_Insurance(
      id: json['id'] as String?,
      extension: (json['extension'] as List<dynamic>?)
          ?.map((e) => Extension.fromJson(e as Map<String, dynamic>))
          .toList(),
      coverage: json['coverage'] == null
          ? null
          : Reference.fromJson(json['coverage'] as Map<String, dynamic>),
      benefitPeriod: json['benefitPeriod'] == null
          ? null
          : Period.fromJson(json['benefitPeriod'] as Map<String, dynamic>),
      item: (json['item'] as List<dynamic>?)
          ?.map((e) => InsuranceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_InsuranceToJson(_$_Insurance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'extension': instance.extension,
      'coverage': instance.coverage,
      'benefitPeriod': instance.benefitPeriod,
      'item': instance.item,
    };
