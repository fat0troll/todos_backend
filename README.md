# ToDo app backend

Fires up as usual Rails app, uses Rspec as testing framework.

## Timeline of development

* 0h00m: Development started
* 0h15m: Initial app configuration, test framework setuo
* 0h30m: Added models and database structure of the app
* 1h00m: Added todos and tasks API endpoints. For that moment they were open
* 2h35m: Added authorization with JSON Web Tokens
* 4h05m: Todos and tasks hidden behind authorization and assigned to users.
* 4h10m: Added todos serialization for less API calls from frontend.
* 4h15m: Fixed a mess with database column naming (``public`` in ``todos`` become ``is_public``)
* 4h20m: Wrote down this README file

## Routes

/login                  POST
/signup                 POST
/todos                  GET, POST
/todos/:id/             GET, PATCH, PUT, DELETE
/todos/:id/tasks        GET, POST
/todos/:id/tasks/:id    GET, PATCH, PUT, DELETE

All specifications are under ``spec/requests`` folder, tests are self-descriptive.

## Firing up in production

There are no special requirements to run this app in production, so use your preferred method to start Rails API applications as usual.