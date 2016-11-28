# awesome4girls-api
The api for the https://github.com/cristianoliveira/awesome4girls project.

## Motivation
Since the beginning of the awesome4girls project I wondered that it will become
a site where you can know more about the projects collected.
This api is the first step to construct the site.

## Main Routes
| Data      | Route                                | Methods             | Restricted                   |
|-----------|--------------------------------------|---------------------|------------------------------|
|home       | `/`                                  | GET                 | No                           |
|version    | `/version`                           | GET                 | No                           |
|users      | `/users`                             | GET/POST/DELETE     | Only admin                   |
|sections   | `/sections`                          | GET/POST/DELETE     | admin/user: POST/DELETE      |
|subsections| `/section/:sectionid/subsections`    | GET/POST/DELETE     | admin/user: POST/DELETE      |
|projects   | `/projects?section=id&subsection=id` | GET/POST/PUT/DELETE | admin/user: POST/PUT/ DELETE |

## Endpoints examples
It uses Basic Authentication so in order to manipulate some data you need
to provide user and password.

Default users:
 - Admin: `admin:admin`
 - Regular: `user:user`

### Users
Users are divided in roles: ADMIN(1), USER(2) and GUEST(3)

Listing:
```bash
curl https://awesome4girl-api.herokuapp.com/users -u admin:admin
```

Get one:
```bash
curl https://awesome4girl-api.herokuapp.com/users/1 -u admin:admin
```

Creating:
```bash
curl -XPOST https://awesome4girl-api.herokuapp.com/users -u admin:admin -d'name=john&password=bla&role=1'
```

Deleting:
```bash
curl -XDELETE https://awesome4girl-api.herokuapp.com/users/:id -u admin:admin
```

### Sections
Sections are the top categories. Like 'Meetups', 'Summits', 'Conferences'

Listing is open and is not required an user
```bash
curl https://awesome4girl-api.herokuapp.com/sections
```

Get one:
```bash
curl https://awesome4girl-api.herokuapp.com/sections/1
```

Creating:
```bash
curl -XPOST https://awesome4girl-api.herokuapp.com/sections -u user:user -d'title=john&description=foo'
```

Deleting:
```bash
curl -XDELETE https://awesome4girl-api.herokuapp.com/sections/:id -u user:user
```

### Subsections
Subsections are related to sections.

Listing is open and is not required an user
```bash
curl https://awesome4girl-api.herokuapp.com/section/1/susections
```

Get one:
```bash
curl https://awesome4girl-api.herokuapp.com/section/1/subsections/1
```

Creating:
```bash
curl -XPOST https://awesome4girl-api.herokuapp.com/section/1/subsections -u user:user -d'title=john&description=foo'
```

Deleting:
```bash
curl -XDELETE https://awesome4girl-api.herokuapp.com/section/1/subsections/1 -u user:user
```

### Projects
Projects are the main data. It is under Section>Subsection>Projects.

Listing is open and is not required an user
```bash
curl https://awesome4girl-api.herokuapp.com/projects
```

Get one:
```bash
curl https://awesome4girl-api.herokuapp.com/projects/1
```

Creating:
```bash
curl -XPOST https://awesome4girl-api.herokuapp.com/projects -u user:user -d'title=john&description=foo&language=pt'
```

Deleting:
```bash
curl -XDELETE https://awesome4girl-api.herokuapp.com/projects/1 -u user:user
```

## Working in progress
  - [x] Docker
  - [x] Api documentation
  - [x] Heroku deploy
  - [ ] Better query on projects data
  - [ ] Ruby client lib
  - [ ] Parser Markdown for updating data
  - [ ] Job for updating data

## Contributing

You can contribute following this simple steps:
   - Fork it!
   - Create your feature branch: `git checkout -b my-new-feature`
   - Commit your changes: `git commit -am 'Add some feature'`
   - Push to the branch: `git push origin my-new-feature`
   - Make sure the tests are passing. `make test`
   - Submit a pull request

Pull Requests are really welcome! Others support also.

** Pull Request should have unit tests **

## License

This project was made under MIT License.
