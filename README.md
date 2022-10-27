# Playground

## Installation

```bash
$ docker-compose up -d
$ mix deps.get
$ mix ecto.migrate
```

## Run

```bash
$ mix run --no-halt
```

It will start your application with a web server running at localhost:4001.

## Checks

```bash
$ docker-compose up -d
$ mix format --check-formatted
$ mix test
$ mix dialyzer
```

## User stories

- [X] As a Customer I want to place an order
- [X] As a Customer I want to view the details of one order
- [X] As a Customer I want to view the list of my orders