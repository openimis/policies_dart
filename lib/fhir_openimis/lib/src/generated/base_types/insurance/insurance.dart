import 'package:freezed_annotation/freezed_annotation.dart';
import '../../abstracts/abstracts.dart';
import '../../code_systems/code_systems.dart';
import '../../base_types/base_types.dart';

//THIS FILE IS AUTO GENERATED! DO NOT EDIT! 

part 'insurance.freezed.dart';
part 'insurance.g.dart';

@freezed
class Insurance extends Element with _$Insurance {
  factory Insurance({
    String? id, 
 		List<Extension>? extension, 
 		Reference? coverage, 
 		Period? benefitPeriod, 
 		List<InsuranceItem>? item
  }) = _Insurance;

  factory Insurance.fromJson(Map<String, dynamic> json) =>
      _$InsuranceFromJson(json);
}
