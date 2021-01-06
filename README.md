tgagor/owasp-dependency-check
=============================

If you need more information about this tool, please check here:
https://owasp.org/www-project-dependency-check/

This image contains application and runtime environment that allows to run tests in CI/CD pipeline or standalone in your project.

How to run
----------

Let say your code is in current directory in `code` dir and you want to place report in `result` directory, then execution will look like below:

```bash
docker run -ti --rm \
    -v $(pwd)/code:/code:ro \
    -v $(pwd)/result:/report \
    tgagor/owasp-dependency-check \
    --format HTML --project dummy --scan /code --out /report
```

As example parameters above are set by default in `CMD`, it's simplest way to call it is:

```bash
docker run -ti --rm \
    -v $(pwd)/code:/code:ro \
    -v $(pwd)/result:/report \
    tgagor/owasp-dependency-check
```

TODO
----

* run it as unprivileged allowing to change UID/GID
