import 'package:freezed_annotation/freezed_annotation.dart';
import '../../abstracts/abstracts.dart';
import '../../code_systems/code_systems.dart';
import '../../base_types/base_types.dart';

//THIS FILE IS AUTO GENERATED! DO NOT EDIT! 

part 'insurance_item.freezed.dart';
part 'insurance_item.g.dart';

@freezed
class InsuranceItem extends Element with _$InsuranceItem {
  factory InsuranceItem({
    String? id, 
 		List<Extension>? extension, 
 		CodeableConcept? category, 
 		String? name, 
 		String? description, 
 		CodeableConcept? productOrService, 
 		Boolean? excluded, 
 		List<BackboneElement>? benefit
  }) = _InsuranceItem;

  factory InsuranceItem.fromJson(Map<String, dynamic> json) =>
      _$InsuranceItemFromJson(json);
}
