---
layout: post
title: Run unit test on laravel framework source code
tags: ["laravel", "phpunit", "docker", "composer"]
---

# Clone laravel framework source code
```bash
git clone git@github.com:laravel/framework.git
git checkout 10.x
```

# Run composer install
```bash
docker run -w /data -v ${PWD}:/data:delegated \
   --rm registry.gitlab.com/grahamcampbell/php:8.1-base composer install --ignore-platform-req=ext-gmp
```

# Run phpunit with code coverage option

```bash
docker run -w /data -v ${PWD}:/data:delegated \
   --rm --env XDEBUG_MODE=coverage registry.gitlab.com/grahamcampbell/php:8.1 ./vendor/bin/phpunit --coverage-filter ./src --coverage-html ./html --testdox-html=./result.html
```

# Run phpunit test with xdebug

- create xdebug server like

![config server for xdebug on phpstorm](/assets/config_server_for_xdebug_on_phpstorm.png)

- run php with xdebug

```bash
docker run -w /data -v ${PWD}:/data:delegated  \
    --rm --env XDEBUG_MODE=debug \
    --env XDEBUG_CONFIG="client_host=$(ifconfig | sed -n '/wlp/,+1p' | grep inet | awk '{print $2}')" \
    --env PHP_IDE_CONFIG="serverName=0.0.0.0" \
    --env XDEBUG_SESSION=1 \
    registry.gitlab.com/grahamcampbell/php:8.1 \
    ./vendor/bin/phpunit  -- ./tests/Container/ContainerTest.php
```

# References:
- [https://github.com/laravel/framework](https://github.com/laravel/framework)