# Project 🐳
My project

## Introduction

Build a simple laravel development environment with docker-compose.

## Usage

```bash
git clone this repository.
cd this project
docker-compose up -d
docker-compose exec app composer install
```

## Container structure

```bash
├── app
├── web
└── db
```

### app container

- [php:fpm-alpine](https://hub.docker.com/_/php)

### web container

- [nginx:alpine](https://hub.docker.com/_/nginx)

### db container

- [mariadb](https://hub.docker.com/_/mariadb)

#### Persistent MySQL Storage

By default, the [named volume](https://docs.docker.com/compose/compose-file/#volumes) is mounted, so MySQL data remains even if the container is destroyed.
If you want to delete MySQL data intentionally, execute the following command.

```bash
docker-compose down -v && docker-compose up
```
## License
MIT