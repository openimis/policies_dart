import 'dart:convert';
import 'dart:math';

import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:fhir_openimis/src/generated/abstracts/abstracts.dart';
import 'package:fhir_openimis/src/generated/base_types/base_types.dart';
import 'package:fhir_openimis/src/generated/code_systems/code_systems.dart';

main() async {
  final ResourceServer server =
      ResourceServer("release.openimis.org", "/api/api_fhir_r4");
  Authenticator auth = await BearerAuthenticator.initialize(server, "admin", "admin123");
  FhirClient client = FhirClient(server, auth);
  /**
   * Example for creating a patient and group.
   */
  String randomId = "PNew${Random().nextInt(1000).toString()}";
  var patientToBeCreated = client.createValidPatientResource(
      insuranceId: randomId,
      familyName: "Mustermann123",
      givenName: "MaxiSchmaxi 2",
      gender: AdministrativeGenderCode.value_male,
      birthDate: Date("2020-08-01"),
      addressLocationId: "23CC9D7E-CE56-45A1-B150-EFC0513957C4");
  print(jsonEncode(patientToBeCreated.toJson()));
  var createdPatient = await client.createPatient(patientToBeCreated);
  print(createdPatient);
  var familyToBeCreated = client.createValidGroupResource(
      '23CC9D7E-CE56-45A1-B150-EFC0513957C4', 'Meine Familie' + randomId, [
    OpenImisGroupMember(
        entity: Reference(
            reference: "Patient/" + createdPatient.id!,
            type: FhirUri("Patient")))
  ]);
  print(jsonEncode(familyToBeCreated.toJson()));
  var createdFamily = await client.createFamily(familyToBeCreated);
  print(createdFamily);
}
