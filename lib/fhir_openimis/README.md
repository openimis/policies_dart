# FHIR OpenIMIS

A package serving special FHIR types and authentication client to work with an OpenIMIS backend. 

## FHIR Generator

The packages uses the [fhir generator](https://github.com/Lightningstream/fhir_generator) package for creating special fhir data types in dart. All dart classes are already generated for this project. If you need to regenerated them because of changes in the `json` or `abstracts` folder, run `dart .\runner.dart ./json ./generated`. Please look at the [openimis-generation](https://github.com/Lightningstream/fhir_generator/tree/openimis-generation) branch for more information about how to use the generator.

Syntax: `dart ./runner.dart [json path] [generation path]`.

The `./json` folder contains all base types, code systems, extensions, resources and value sets for openIMIS. All of the files except fhir base code systems and the base types can be directly downloaded from the [openIMIS fhir](http://fhir.openimis.org/).

## Authentication

The `Authenticator` automatically sets the `Authorization` header for each request made by the client.

The recommended authenticator is the `BearerAuhenticator`, which uses username and password to retrieve a bearer token, keeping the token up-to-date under the hood.

The `initialize`-factory verifies the validity of the credentials on authenticator creation. The `offline`-factory skips the initial verification, taking the risk of possibly invalid credentials in exchange for immediate availability.

## Testing
To test the package you have to run `flutter test`.  
