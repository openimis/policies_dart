# App

The actual flutter app.

## Authentication

All pages using the business logic should be created as a child of a `LoginProtected` widget, which creates the `BusinessLogic` and injects it into the actual widget.

The `LoginProtected` displays a `LoginScreen` instead of the widget intended for a route, until the login was successful.

If saved credentials are found during application startup, they are used for `Authenticator` creation, allowing to immediately access the app, while checking their validity in the background. If this background check fails, the user is logged out.
