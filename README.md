# devpoll

devpoll - small web application for making polls written in Crystal lang.

## Development

- `bin/deps` to install dependencies
- `bin/test` to run specs
- `bin/build` to build `bin/app`
- `bin/migrate up` to run migrations
- `bin/devserver` to run development server (build & run)
- `bin/app` to run compiled app
- `bin/bench` to run benchmark against deployed app

## Deployment (heroku)

You will need to set these variables:

```
BUILDPACK_URL:   https://github.com/zamith/heroku-buildpack-crystal.git
CRYSTAL_ENV:     production

CLEARDB_DATABASE_URL or DATABASE_URL:   <get it from heroku addons or on aws, anywhere>
```

## Contributing

1. Fork it ( https://github.com/waterlink/devpoll/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
