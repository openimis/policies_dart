import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:fhir_openimis/src/generated/code_systems/coverage_status/coverage_status_code.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_activitiy_definition/openimis_activitiy_definition.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_coverage/openimis_coverage.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_group/openimis_group.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_insurance_plan/openimis_insurance_plan.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_location/openimis_location.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_medication/openimis_medication.dart';
import 'package:fhir_openimis/src/generated/resources/openimis_patient/openimis_patient.dart';
import 'package:fhir_openimis/src/resource_server.dart';
import 'package:test/test.dart';

void main() {
  group("Bearer authentication unit tests", () {
    final ResourceServer server =
        ResourceServer("release.openimis.org", "/api/api_fhir_r4");

    test('Login successfully', () async {
      expect(await BearerAuthenticator.initialize(server, "admin", "admin123"),
          isA<BearerAuthenticator>());
    });

    test('Login fails', () async {
      expect(
          () async =>
              await BearerAuthenticator.initialize(server, "admin", "wrong"),
          throwsA(isA<LoginException>()));
    });
  });

  group("Get Ressources", () {
    final ResourceServer server =
        ResourceServer("release.openimis.org", "/api/api_fhir_r4");
    late FhirClient client;

    setUp(() async {
      final authenticator =
          await BearerAuthenticator.initialize(server, "admin", "admin123");
      client = FhirClient(server, authenticator);
    });

    test('Get patients', () async {
      var bundle = await client.getPatients();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisPatient, true);
    });

    test('Get a patient', () async {
      var patient =
          await client.getPatient("2F777238-DD44-4A6B-AB4E-21AF0349A98E");
      expect(patient.id, "2F777238-DD44-4A6B-AB4E-21AF0349A98E");
    });

    test('Get a patient by insurance number', () async {
      var patient = await client.getPatientByInsuranceNumber("172000001");
      expect(patient.id, "172000001");
    });

    test('Get families', () async {
      var bundle = await client.getFamilies();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisGroup, true);
      expect(bundle.entry?[0].resource?.member[0].entity?.reference?.isNotEmpty,
          true);
    });

    test('Get a family', () async {
      var family =
          await client.getFamily("0A22C764-A3D2-49C0-9D87-311E84BCA8A8");
      expect(family.id, "0A22C764-A3D2-49C0-9D87-311E84BCA8A8");
    });

    test('Get policies', () async {
      var bundle = await client.getPolicies();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisCoverage, true);
    });

    test('Get a policy', () async {
      var policy =
          await client.getPolicy("53979956-3A00-498C-B12E-B0007162AD81");
      expect(policy.status, CoverageStatusCode.value_active);
    });

    test('Get medical services', () async {
      var bundle = await client.getMedicalServices();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisActivitiyDefinition, true);
    });

    test('Get medications', () async {
      var bundle = await client.getMedications();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisMedication, true);
    });

    test('Get locations', () async {
      var bundle = await client.getLocations();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisLocation, true);
    });

    test('Get products', () async {
      var bundle = await client.getProducts();
      expect(bundle.entry?.isNotEmpty, true);
      expect(bundle.entry?[0].resource is OpenimisInsurancePlan, true);
    });

    test('Get more 20 bundle entries', () async {
      // This does not work on openIMIS side
      // var bundle = await client.getFamilies(amount: 20);
      // expect(bundle.entry?.isNotEmpty, true);
      // expect(bundle.total!.value, 20);
    });

    test('Get page offset', () async {
      var bundle = await client.getFamilies(pageOffset: 2);
      expect(bundle.link!.length, 3);
      expect(bundle.link![2].relation, "previous");
    });

    test('Get Coverage eligibilty', () async {
      var eligbility = await client.getCoverageEligibilityOfItem(
          insureeId: "100000001",
          insurer: "openIMIS-Implementation",
          eligibilityCode: "eligibility-code",
          isService: false);
      expect(
          eligbility.insurer.reference, "Organization/openIMIS-Implementation");
    });
  });

  group("Basic authentication unit tests", () {
    final ResourceServer server =
        ResourceServer("release.openimis.org", "/api/api_fhir_r4");

    test('Login successfully', () async {
      expect(await Authenticator.initialize(server, "admin", "admin123"),
          isA<Authenticator>());
    });

    test('Login fails', () async {
      expect(
          () async => await Authenticator.initialize(server, "admin", "wrong"),
          throwsA(isA<LoginException>()));
    });
  });
}
