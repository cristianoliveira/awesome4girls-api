# awesome4girls-api
The api for the https://github.com/cristianoliveira/awesome4girls project.

## Motivation
Since the beginning of the awesome4girls project I wondered that it will become
a site where you can know more about the projects collected.
This api is the first step to construct the site.

## Main Routes
| Data      | Route                                | Methods             | Restricted             |
|-----------|--------------------------------------|---------------------|------------------------|
|users      | `/users`                             | GET/POST/DELETE     | admin: ALL             |
|sections   | `/sections`                          | GET/POST/DELETE     | user: POST/DELETE      |
|subsections| `/section/:sectionid/subsections`    | GET/POST/DELETE     | user: POST/DELETE      |
|projects   | `/projects?section=id&subsection=id` | GET/POST/PUT/DELETE | user: POST/PUT/ DELETE |

## Working in progress
  - [ ] Docker
  - [ ] Api documentation
  - [ ] Heroku deploy
  - [ ] Ruby client lib
  - [ ] Parser Markdown for updating data
  - [ ] Job for updating data
