import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fhir_openimis/src/api_error.dart';
import 'package:fhir_openimis/src/generated/abstracts/abstracts.dart';
import 'package:fhir_openimis/src/generated/base_types/base_types.dart';
import 'package:fhir_openimis/src/generated/code_systems/code_systems.dart';
import 'package:fhir_openimis/src/generated/extensions/extensions.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';
import 'package:fhir_openimis/src/http.dart';
import 'package:fhir_openimis/src/resource_server.dart';
import 'package:http/http.dart';
import 'authentication/authenticator.dart';
import 'http_method.dart';
import 'generated/base_types/base_types.dart';

class FhirClient {
  final ResourceServer _server;
  final Authenticator _authenticator;
  late HTTPCache _cache;

  FhirClient(this._server, this._authenticator) {
    _cache = HTTPCache();
  }

  // Resources

  OpenimisGroup createValidGroupResource(
      String locationId, String name, List<OpenImisGroupMember> member) {
    return OpenimisGroup(
        active: Boolean(true),
        identifier: [],
        type: GroupTypeCode.value_person,
        actual: Boolean(true),
        name: name,
        quantity: UnsignedInt(member.length),
        member: member,
        extension: [
          GroupAddress(
              valueAddress: createValidPatientAddressResource(
                  locationId: locationId,
                  addressUse: AddressUseCode.value_home))
        ]);
  }

  Address createValidPatientAddressResource(
      {required String locationId, required AddressUseCode addressUse}) {
    return Address(
        extension: [
          AddressMunicipality(valueString: "Does not Matter"),
          AddressLocationReference(
              valueReference: Reference(
                  reference: "Location/$locationId",
                  type: FhirUri("Location"),
                  identifier: Identifier(
                      type: CodeableConcept(coding: [
                        OpenimisIdentifiersCoding(
                            code: OpenimisIdentifiersCode.value_uuid)
                      ]),
                      value: locationId)))
        ],
        use: addressUse,
        type: AddressTypeCode.value_physical,
        text: "it",
        city: "does",
        district: "not",
        state: "matter");
  }

  OpenimisPatient createValidPatientResource(
      {required String insuranceId,
      required String familyName,
      required String givenName,
      required AdministrativeGenderCode gender,
      required Date birthDate,
      required String addressLocationId,
      String? groupId,
      bool? isHead}) {
    var group = groupId != null
        ? PatientGroupReference(
            valueReference: Reference(
                reference: "Group/$groupId",
                type: FhirUri("Group"),
                identifier: Identifier(
                    type: CodeableConcept(coding: [
                  OpenimisIdentifiersCoding(
                      code: OpenimisIdentifiersCode.value_uuid)
                ]))))
        : null;
    List<Extension> extension = [PatientIsHead(valueBoolean: Boolean(isHead))];
    if (group != null) {
      extension.add(group);
    }
    return OpenimisPatient(
        extension: extension,
        identifier: [
          Identifier(
              type: CodeableConcept(coding: [
                OpenimisIdentifiersCoding(
                    code: OpenimisIdentifiersCode.value_code)
              ]),
              value: insuranceId)
        ],
        name: [
          HumanName(
              use: NameUseCode.value_usual,
              family: familyName,
              given: [givenName])
        ],
        gender: gender,
        birthDate: birthDate,
        address: [
          createValidPatientAddressResource(
              locationId: addressLocationId,
              addressUse: groupId != null
                  ? AddressUseCode.value_home
                  : AddressUseCode.value_temp)
        ]);
  }

  // Api calls

  Future<Bundle<OpenimisPatient>> getPatients(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request = await _createResourceRequest(
        "Patient", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> bundleJson = jsonDecode(response.body);
    Bundle<OpenimisPatient> patientBundle =
        Bundle.fromJson(bundleJson, (entry) {
      return OpenimisPatient.fromJson(entry as dynamic);
    });
    return patientBundle;
  }

  Future<OpenimisPatient> getPatientByInsuranceNumber(String id) async {
    Map<String, dynamic> queryParameters = {
      "identifier": id,
    };
    Request request = await _createResourceRequest(
        "Patient", HttpMethod.get, queryParameters);

    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisPatient patient = OpenimisPatient.fromJson(responseJson);
    return patient;
  }

  Future<OpenimisPatient> getPatient(String id) async {
    Request request =
        await _createResourceRequest("Patient/$id", HttpMethod.get);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisPatient patient = OpenimisPatient.fromJson(responseJson);
    return patient;
  }

  Future<OpenimisPatient> createPatient(OpenimisPatient patient) async {
    Request request = await _createResourceRequest("Patient/", HttpMethod.post)
      ..body = jsonEncode(patient.toJson());
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisPatient responsePatient = OpenimisPatient.fromJson(responseJson);
    return responsePatient;
  }

  Future<OpenimisPatient> updatePatient(
      String id, OpenimisPatient patient) async {
    Request request =
        await _createResourceRequest("Patient/$id/", HttpMethod.put)
          ..body = jsonEncode(patient.toJson());
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisPatient responsePatient = OpenimisPatient.fromJson(responseJson);
    return responsePatient;
  }

  Future<Bundle<OpenimisGroup>> getFamilies(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request =
        await _createResourceRequest("Group", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> bundleJson = jsonDecode(response.body);
    Bundle<OpenimisGroup> groupBundle = Bundle.fromJson(bundleJson, (entry) {
      return OpenimisGroup.fromJson(entry as dynamic);
    });
    return groupBundle;
  }

  Future<OpenimisGroup> getFamily(String id) async {
    Request request = await _createResourceRequest("Group/$id", HttpMethod.get);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisGroup family = OpenimisGroup.fromJson(responseJson);
    return family;
  }

  Future<OpenimisGroup> createFamily(OpenimisGroup family) async {
    Request request = await _createResourceRequest("Group/", HttpMethod.post)
      ..body = jsonEncode(family.toJson());
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisGroup responseFamily = OpenimisGroup.fromJson(responseJson);
    return responseFamily;
  }

  Future<Bundle<OpenimisCoverage>> getPolicies(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };

    Request request = await _createResourceRequest(
        "Coverage", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    Bundle<OpenimisCoverage> policies = Bundle.fromJson(responseJson, (entry) {
      return OpenimisCoverage.fromJson(entry as dynamic);
    });
    return policies;
  }

  Future<OpenimisCoverage> getPolicy(String id) async {
    Request request =
        await _createResourceRequest("Coverage/$id", HttpMethod.get);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisCoverage policy = OpenimisCoverage.fromJson(responseJson);
    return policy;
  }

  Future<Bundle<OpenimisActivitiyDefinition>> getMedicalServices(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request = await _createResourceRequest(
        "ActivityDefinition", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    Bundle<OpenimisActivitiyDefinition> medicalServices =
        Bundle.fromJson(responseJson, (entry) {
      return OpenimisActivitiyDefinition.fromJson(entry as dynamic);
    });
    return medicalServices;
  }

  Future<Bundle<OpenimisMedication>> getMedications(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request = await _createResourceRequest(
        "Medication", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    Bundle<OpenimisMedication> medication =
        Bundle.fromJson(responseJson, (entry) {
      return OpenimisMedication.fromJson(entry as dynamic);
    });
    return medication;
  }

  Future<Bundle<OpenimisLocation>> getLocations(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request = await _createResourceRequest(
        "Location", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    Bundle<OpenimisLocation> locations = Bundle.fromJson(responseJson, (entry) {
      return OpenimisLocation.fromJson(entry as dynamic);
    });
    return locations;
  }

  Future<Bundle<OpenimisInsurancePlan>> getProducts(
      {int amount = 10, int pageOffset = 1}) async {
    Map<String, dynamic> queryParameters = {
      "_count": amount.toString(),
      "page-offset": pageOffset.toString()
    };
    Request request = await _createResourceRequest(
        "InsurancePlan", HttpMethod.get, queryParameters);
    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    Bundle<OpenimisInsurancePlan> products =
        Bundle.fromJson(responseJson, (entry) {
      return OpenimisInsurancePlan.fromJson(entry as dynamic);
    });
    return products;
  }

  Future<OpenimisCoverageEligibilityResponse> getCoverageEligibilityOfBenefits(
      {required String insureeId, required String insurer}) async {
    OpenimisCoverageEligibilityRequest coverageEligibilityRequest =
        OpenimisCoverageEligibilityRequest(
      identifier: [],
      status: FmStatusCode.value_active,
      created: DateTime.now(),
      purpose: [EligibilityrequestPurposeCode.value_benefits],
      patient: Reference(reference: "Patient/$insureeId"),
      insurer: Reference(reference: "Organization/$insurer"),
    );
    print(coverageEligibilityRequest.toJson());
    Request request = await _createResourceRequest(
        "CoverageEligibilityRequest/", HttpMethod.post)
      ..body = jsonEncode(coverageEligibilityRequest.toJson());

    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisCoverageEligibilityResponse coverageEligibilityResponse =
        OpenimisCoverageEligibilityResponse.fromJson(responseJson);
    return coverageEligibilityResponse;
  }

  Future<OpenimisCoverageEligibilityResponse> getCoverageEligibilityOfItem(
      {required String insureeId,
      required String insurer,
      required String eligibilityCode,
      required bool isService}) async {
    BackboneElement item = BackboneElement.fromJson({
      "productOrService": {"text": eligibilityCode},
      "category": CoverageItemCategoryCoding(
              code: isService
                  ? CoverageItemCategoryCode.value_item
                  : CoverageItemCategoryCode.value_service)
          .toJson(),
    });

    OpenimisCoverageEligibilityRequest coverageEligibilityRequest =
        OpenimisCoverageEligibilityRequest(
            identifier: [],
            status: FmStatusCode.value_active,
            created: DateTime.now(),
            purpose: [EligibilityrequestPurposeCode.value_validation],
            patient: Reference(reference: "Patient/$insureeId"),
            insurer: Reference(reference: "Organization/$insurer"),
            item: [item]);
    print(coverageEligibilityRequest.toJson());
    Request request = await _createResourceRequest(
        "CoverageEligibilityRequest/", HttpMethod.post)
      ..body = jsonEncode(coverageEligibilityRequest.toJson());

    Response response = await _sendRequest(request);
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    OpenimisCoverageEligibilityResponse coverageEligibilityResponse =
        OpenimisCoverageEligibilityResponse.fromJson(responseJson);
    return coverageEligibilityResponse;
  }

  String getServerName() => _server.server;

  // Helper methods

  Future<Response> _sendRequest(Request request) async {
    try {
      Response response = await _cache.send(request);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiError(response.statusCode, response.body);
      }
      return response;
    } on TimeoutException catch (e) {
      throw NoConnectionException(e.toString());
    } on SocketException catch (e) {
      throw NoConnectionException(e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<Request> _createResourceRequest(String resource, HttpMethod method,
          [Map<String, dynamic>? queryParameters]) =>
      _authenticator.authenticate(Request(
          method.name, _server.getResourceUri(resource, queryParameters))
        ..headers.addAll({"Content-Type": "application/json"}));
}
