# [FASTAPI](https://fastapi.tiangolo.com)

[Install FastAPI](https://fastapi.tiangolo.com/tutorial/#install-fastapi) part by part, extensible for each of the optional dependencies:

```console
pip install fastapi

pip install "uvicorn[standard]"

# pip install dependency
```

Alternative deployment of [FastAPI in Containers - Docker](https://fastapi.tiangolo.com/deployment/docker/#fastapi-in-containers-docker) ready for production is also possible.

## SETUP

```console
docker build -t fastapi .
docker run -d --name restapi -p 80:80 fastapi
```

Interactive API docs are automatically available at [http://127.0.0.1/docs](http://127.0.0.1/docs) or the equivalent Docker host.