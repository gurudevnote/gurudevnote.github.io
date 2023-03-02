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

# References:
- [https://github.com/laravel/framework](https://github.com/laravel/framework)