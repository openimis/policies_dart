// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_type_coding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupTypeCoding _$$_GroupTypeCodingFromJson(Map<String, dynamic> json) =>
    _$_GroupTypeCoding(
      system: json['system'] == null
          ? const FhirUri.asConst("http://hl7.org/fhir/group-type",
              ConstUri("http://hl7.org/fhir/group-type"), true)
          : FhirUri.fromJson(json['system']),
      code: $enumDecode(_$GroupTypeCodeEnumMap, json['code']),
    );

Map<String, dynamic> _$$_GroupTypeCodingToJson(_$_GroupTypeCoding instance) =>
    <String, dynamic>{
      'system': instance.system,
      'code': _$GroupTypeCodeEnumMap[instance.code],
    };

const _$GroupTypeCodeEnumMap = {
  GroupTypeCode.value_person: 'Person',
  GroupTypeCode.value_animal: 'Animal',
  GroupTypeCode.value_practitioner: 'Practitioner',
  GroupTypeCode.value_device: 'Device',
  GroupTypeCode.value_medication: 'Medication',
  GroupTypeCode.value_substance: 'Substance',
};
