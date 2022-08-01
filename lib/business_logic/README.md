# Buisness Logic

Middleware between UI and Model

## Authentication

As the business logic requires a `FhirClient`, which in turn requires an `Authenticator`, we cannot create an instance of it before the user is logged in.

This problem was solved by splitting the business logic into two parts: The `AuthLogic` handles all relevant logic concerning credential management, login/logout and `Authenticator` creation.

The `Authenticator` associated with the current credentials is provided as a stream, updating on all changes to the login state.

On a successful login, the credentials used are stored in the shared preferences or their equivalent. Stored credentials are considered valid for 24h.