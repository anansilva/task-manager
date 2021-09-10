# Task manager

RESTful API to manage tasks.

Built with ruby on rails.

## To run the application locally:

`docker-compose up`

## To see background jobs' logs separately:

`docker-compose up sidekiq`

## To run the test suit locally:

`docker-compose -f docker-compose.tdd.yml run tdd rspec spec`

## API documentation:

### Sign up

Creates and authenticates user.

#### Endpoint

```
POST /api/v1/signup
```

User is created and authenticated.

#### Reques body schema:

- email (required): string
- password (required): string
- role: integer
   - valid values:
      - 0 for managers
      - 1 for technicians

#### Request body sample:

```
{
  "email": "your@email.com",
  "password": "super strong password",
  "role": 0
}
```

#### Response sample

`201 Created`

```
{
  "message": "Manager account created successfully",
  "auth_token: 'aBcD123"
}
```

### Authentication

Authenticates user.

#### Endpoint

```
POST /api/v1/authenticate
```

#### Request body schema:

- email (required): string
- password (required): string

#### Request body sample:

```
{
  "email": "your@email.com",
  "password": "super strong password"
}
```

#### Response sample:

```
200 OK
```

```
{
  "auth_token": "yasdas12J"
}
```

### Authorization

The `auth_token` key returned in the `authentication` or `signup` endpoints
should be passed in the "Authentication" HTTP header. For example:

```
Authorization: 401f7ac837da42b97f613d789819ff93537bee6a
```

### List tasks

#### Endpoint

```
GET /api/v1/tasks
```

A manager will see all tasks from all technicians.
A technician will see all his/her own tasks.

#### Response sample:

`200 OK`

```
[
  {
    "id": 1,
    "summary": "task summary",
    "performed_at": "2021-09-09T19:43:31.000Z",
    "created_at": "2021-09-09T18:48:38.334Z",
    "updated_at": "2021-09-09T19:43:32.023Z",
    "user_id": 3,
    "name": "task name"
  }
]
```

### Show a task

A manager can see a single task from a any technician.
A technician can see his/her own specific task.

#### Endpoint

```
GET /api/v1/tasks/{id}
```

#### Response sample:

`200 OK`

```
{
  "id": 1,
  "summary": "task summary",
  "performed_at": "2021-09-09T19:43:31.000Z",
  "created_at": "2021-09-09T18:48:38.334Z",
  "updated_at": "2021-09-09T19:43:32.023Z",
  "user_id": 3,
  "name": "task name"
}
```

### Create a task

A manager cannot create tasks.
A technician can create his/her own tasks.

#### Endpoint

```
POST /api/v1/tasks
```

#### Request body sample

```
  {
    "task":
    {
      "name": "task name",
      "summary": "task summary"
    }
  }
```

#### Response sample:

`200 OK`

```
{
  "id": 1,
  "summary": "task summary",
  "performed_at": null,
  "created_at": "2021-09-09T18:48:38.334Z",
  "updated_at": "2021-09-09T19:43:32.023Z",
  "user_id": 3,
  "name": "task name"
}
```

### Delete a task

A manager can delete tasks.
A technician cannot delete tasks.

#### Enpoint

```
DELETE /api/v1/tasks/{id}
```

#### Response sample:

`204 No Content`

### Perform a task

A manager cannot perform tasks.
A technician can perform tasks.

#### Enpoint

```
PUT /api/v1/tasks/{id}/perform
```

#### Response sample:

`200 OK`

```
{
  "id": 1,
  "summary": "task summary",
  "performed_at": "2021-09-09T19:43:31.000Z",
  "created_at": "2021-09-09T18:48:38.334Z",
  "updated_at": "2021-09-09T19:43:32.023Z",
  "user_id": 3,
  "name": "task name"
}
```

### List notifications

A manager can see notifications.
A technician cannot see notifications.

#### Enpoint

```
GET /api/v1/notificiations
```

#### Response sample

`200 OK `

```
[
  {
    "id": 1,
      "message": "The technician ana@technician.com performed the task 'task name' on 2021-09-09 19:25:33 UTC.",
      "status": 1,
      "created_at": "2021-09-09T19:25:40.161Z",
      "updated_at": "2021-09-09T19:25:40.161Z"
  }
]
```

### Mark notification as read

A manager can mark a notification as read.
A technician cannot mark a notification as read.

#### Enpoint

```
PUT /api/v1/notificiations/{id}/read
```

#### Response sample

`200 OK`

```
{
  "id": 1,
  "message": "The technician ana@technician.com performed the task name on 2021-09-09 19:25:33 UTC",
  "status": 1,
  "created_at": "2021-09-09T19:25:40.161Z",
  "updated_at": "2021-09-10T09:59:06.852Z"
}
```

### Mark notification as unread

A manager can mark a notification as unread.
A technician cannot mark a notification as unread.

#### Enpoint

```
PUT /api/v1/notificiations/{id}/unread
```

#### Response sample

`200 OK`

```
{
  "id": 1,
  "message": "The technician ana@technician.com performed the task name on 2021-09-09 19:25:33 UTC",
  "status": 0,
  "created_at": "2021-09-09T19:25:40.161Z",
  "updated_at": "2021-09-10T09:59:06.852Z"
}
```
