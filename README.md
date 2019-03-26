# docker-compose-fluentd

> fluentd in docker compose

## Usage

You can modify config in [./fluentd](./fluentd), or mount config by docker compose.

### fluent + elasticsearch + kibana (efk)

```sh
$ export COMPOSE_FILE=docker-compose.efk.yml
$ docker-compose up

# send log by docker or other
$ docker run --rm --log-driver=fluentd --log-opt fluentd-address=${YOUR_LOCAL_IP}:24224 alpine echo "Hello world"
# go to kibana panel view the log
```

### fluent + mongo

```sh
$ export COMPOSE_FILE=docker-compose.mongo.yml
$ docker-compose up

# send log by docker or other
$ docker run --rm --log-driver=fluentd --log-opt fluentd-address=${YOUR_LOCAL_IP}:24224 alpine echo "Hello world"
# go to mongodb panel view the log
# default database name is fluentd, and default collection is logs
```

### fluent + loki + grafana (not works well now)

```sh
$ export COMPOSE_FILE=docker-compose.loki.yml
$ docker-compose up

# send log by docker or other
$ docker run --rm --log-driver=fluentd --log-opt fluentd-address=${YOUR_LOCAL_IP}:24224 alpine echo "Hello world"
# go to grafana panel view the log
```

## License

MIT &copy; zcong1993
