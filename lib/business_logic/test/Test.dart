import 'package:business_logic/src/business_logic.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  printMe(Map<String, dynamic> a) async {
    String prettyprint = JsonEncoder.withIndent('  ').convert(a);
    print("\n"+prettyprint+"\n-------------------\n");
  }

  group("Bearer authentication unit tests", () {
    late BusinessLogic bl;

    setUp(() async {
      final ResourceServer server =
          ResourceServer("demo.openimis.org", "/api/api_fhir_r4");
      final authenticator =
          await BearerAuthenticator.initialize(server, "admin", "admin123");
      bl = BusinessLogic.create(
          FhirClient(server, authenticator), "OpenImis Insurer");
    });

    test('Test', () async {

      //printMe(await bl.getPerson("36F7D9AE-782F-4665-9B47-09F8050DCEEF"));
      //printMe(await bl.getFamily("180000002"));
      //printMe(await bl.getPatients(10));
      //printMe(await bl.searchPatient(""));

    });
  });
}
