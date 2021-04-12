# TaskApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Run in deployment
    https://dual-ornery-tahr.gigalixirapp.com/api/#{module}

## API 

API endpoints to the application:

### User

User endpoints

#### Registers user

##### Request
`POST /users/register`
    curl --location --request POST 'https://dual-ornery-tahr.gigalixirapp.com/api/users/register' \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "username": "sample_username",
      "email": "sample_email@sample.com",
      "password": "sample_password"
    }'

##### Response
    {
      "email":"sample_email@sample.com",
      "id":10,
      "token":"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw",
      "username":"sample_username"
    }

#### Login user

##### Request
`POST /users/login`
    curl --location --request POST 'https://dual-ornery-tahr.gigalixirapp.com/api/users/login' \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "username": "sample_username",
      "password": "sample_password"
    }'

##### Response
    {
      "email":"sample_email@sample.com",
      "id":10,
      "token":"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw",
      "username":"sample_username"
    }

### Task

Task endpoints

#### Creates a task

##### Request
`POST /tasks/create`
    curl --location --request POST 'https://dual-ornery-tahr.gigalixirapp.com/api/tasks/create' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw' \ 
    --data-raw '{
      "name": "task_name",
      "status": "todo",
      "description": "task_desc",
      "reporter": "current_user",
      "owner": "any_user"
    }'

##### Response
    {"data":
      { "description": "task_desc",
        "id": 7,
        "name": "task_name",
        "owner": "asd",
        "status": "todo",
        "reporter":"current_user"
      }
    }

#### Updates a task

##### Request
`PUT /tasks/:id/update`
    curl --location --request PUT 'https://dual-ornery-tahr.gigalixirapp.com/api/tasks/:id/update' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw' \ 
    --data-raw '{
      "name": "task_name",
      "status": "in_progress",
      "description": "task_desc",
      "reporter": "current_user",
      "owner": "any_user"
    }'

##### Response
    {"data":
      { "description": "task_desc",
        "id": 7,
        "name": "task_name",
        "owner": "asd",
        "status": "in_progress",
        "reporter":"current_user"
      }
    }

#### Deletes a task

##### Request
`DELETE /tasks/:id`
    curl --location --request DELETE 'https://dual-ornery-tahr.gigalixirapp.com/api/tasks/:id' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw'

#### Views a task

##### Request
`GET /tasks/:id`
    curl --location --request PUT 'https://dual-ornery-tahr.gigalixirapp.com/api/tasks/:id' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw'

##### Response
    {"data":
      { "description": "task_desc",
        "id": 7,
        "name": "task_name",
        "owner": "asd",
        "status": "in_progress",
        "reporter":"current_user"
      }
    }

#### Lists all tasks

##### Request
`GET /tasks`
    curl --location --request PUT 'https://dual-ornery-tahr.gigalixirapp.com/api/tasks' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0YXNrX2FwaSIsImV4cCI6MTYyMDQ4MzY0NywiaWF0IjoxNjE4MDY0NDQ3LCJpc3MiOiJ0YXNrX2FwaSIsImp0aSI6ImI4YzZhOGFhLTM0MzAtNDA2Ny05MWQ3LTY0MGFiZjBiNWY0NyIsIm5iZiI6MTYxODA2NDQ0Niwic3ViIjoiMTAiLCJ0eXAiOiJhY2Nlc3MifQ.lklCvPSsJcFEu5PbFgB6RhEITImOTFR6dR70drXqbdOOb4777-QXzwgyBcQmCHdOuA6ICPfFmCkUCr2xe3ZGxw'

##### Response
    {
      "data":[
        {
          "description":"Test Task 1",
          "id":1,
          "name":"Task 1",
          "owner":null,
          "reporter":null,
          "status":"todo"
        }
      ]
    }


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
