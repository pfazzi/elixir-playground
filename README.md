# Playground

## Installation

```bash
$ docker-compose up -d
$ mix deps.get
$ mix ecto.migrate
```

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