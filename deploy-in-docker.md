# 通过 Docker 部署

## 构建镜像

```bash
docker build -t fengmk2/ezmall .
```

## 使用 `config.prod.js` 覆盖

直接覆盖 `/usr/src/app/config/config.prod.js` 文件也可以实现生产配置自定义。

```js
module.exports = {
  mysql: {
    clients: {
      xprofiler_console: {
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: '',
        database: 'xprofiler_console',
      },
      xprofiler_logs: {
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: '',
        database: 'xprofiler_logs',
      },
    },
  },

  redis: {
    client: {
      sentinels: null,
      port: 6379,
      host: '127.0.0.1',
      password: '',
      db: 0,
    },
  },

  xprofilerConsole: 'http://127.0.0.1:8443',
  xtransitManager: 'http://127.0.0.1:8543',
};
```

通过 docker volumes 设置配置文件

```bash
docker run -p 8443:8443 -p 8543:8543 -p 9190:9190 -it --rm \
  -v /path-to/config.prod.js:/usr/src/app/config/config.prod.js \
  --name ezmall ezmall
```

## 演示地址

### ezmconsole

https://ezm.fengmk2.com

体验账号：`demo@test.com/12345678`

### ezmmanager

http://ezm.fengmk2.com:8543

### ezmwsserver

http://ezm.fengmk2.com:9190

## fengmk2/ezmall 镜像

https://hub.docker.com/r/fengmk2/ezmall

```bash
docker pull fengmk2/ezmall
```

阿里云镜像

```bash
docker pull registry.cn-shanghai.aliyuncs.com/fengmk2/ezmall:latest
```
