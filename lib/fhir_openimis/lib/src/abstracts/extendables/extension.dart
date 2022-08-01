import 'package:freezed_annotation/freezed_annotation.dart';
import 'element.dart';
import '../primitive_types/fhir_uri.dart';

class Extension extends Element {
  final FhirUri url;
  const Extension._(this.url);
  factory Extension.fromJson(Map<String, dynamic> json) =>
      Extension._(FhirUri(json['url']));

  /**
   * Hotfix for sub extension
  factory Extension.fromJson(Map<String, dynamic> json) {
    final String url = json['url'].toString();
    if (url.contains("patient-is-head")) {
      return PatientIsHead.fromJson(json);
    } else if (url.contains("patient-education-level")) {
      return PatientEducationLevel.fromJson(json);
    } else if (url.contains("patient-profession")) {
      return PatientProfession.fromJson(json);
    } else if (url.contains("patient-identification")) {
      return PatientIdentification.fromJson(json);
    } else if (url.contains("patient-card-issued")) {
      return PatientCardIssued.fromJson(json);
    } else if (url.contains("group-reference")) {
      return PatientGroupReference.fromJson(json);
    } else if (url.contains("vulnerability-status")) {
      return PatientVulnerabilityStatus.fromJson(json);
    } else if (url.contains("address-municipality")) {
      return AddressMunicipality.fromJson(json);
    } else if (url.contains("address-location-reference")) {
      return AddressLocationReference.fromJson(json);
    } else {
      return Extension._(FhirUri(json['url']));
    }
  }
   */

  Map<String, dynamic> toJson() => {...super.toJson(), "uri": this.url};
}
