# all-in-one

startup of all projects with one script

## Quick Start

### prod config

Create `config/config.prod.js`:

```js
module.exports = () => {
  const config = {};

  // mysql
  config.mysql = {
    app: true,
    agent: false,
    clients: {
      xprofiler_console: {
        host: '127.0.0.1',
        port: 3306,
        user: '******',
        password: '******',
        database: 'xprofiler_console',
      },
      xprofiler_logs: {
        host: '127.0.0.1',
        port: 3306,
        user: '******',
        password: '******',
        database: 'xprofiler_logs',
      },
    },
  };

  // redis
  config.redis = {
    client: {
      sentinels: null,
      port: 6379,
      host: '127.0.0.1',
      password: '',
      db: 0,
    },
  };

  return config;
};
```

### run console & manager & wsserver

```bash
// start
npm start

// stop
npm stop
```

### run console

```bash
// start
npm run start:console

// stop
npm run stop:console
```

### run manager

```bash
// start
npm run start:manager

// stop
npm run stop:manager
```

### run wsserver

```bash
// strart
npm run start:wsserver

// stop
npm run stop::wsserver
```

## Development

### local config

Create `config/config.local.js`:

```js
module.exports = () => {
  const config = {};

  // mysql
  config.mysql = {
    app: true,
    agent: false,
    clients: {
      xprofiler_console: {
        host: '127.0.0.1',
        port: 3306,
        user: '******',
        password: '******',
        database: 'xprofiler_console',
      },
      xprofiler_logs: {
        host: '127.0.0.1',
        port: 3306,
        user: '******',
        password: '******',
        database: 'xprofiler_logs',
      },
    },
  };

  // redis
  config.redis = {
    client: {
      sentinels: null,
      port: 6379,
      host: '127.0.0.1',
      password: '',
      db: 0,
    },
  };

  return config;
};
```

### run console & manager & wsserver

```bash
npm run dev
```

### run console

```bash
npm run dev:console
```

### run manager

```bash
npm run dev:manager
```

### run wsserver

```bash
npm run dev:wsserver
```

## Custom authentication

Create `config/config.console_prod.js` for production or `config/config.console_local.js` for development:

```js
module.exports = () => {
  const config = {};

  config.basicAuthHooks = {
    async before(ctx, next) {
      if (ctx.path === '/xapi/upload_from_xtransit') {
        return await next();
      }

      // getUserInfo() is your custom logic such as get from isso
      // identity is mostly like the unique workId
      const { nick, identity, mail } = await getUserInfo();
      if(!nick || !identity || !mail) {
        return (ctx.body = 'access denied');
      }
    
      const user = await mysql.getUserByIdentity(identity);
      if (!user) {
        const res = await mysql.saveUser(nick, identity, mail);
        ctx.user = {
          userId: res.insertId,
          nick, mail,
        };
        return await next();
      }
    
      ctx.user = {
        userId: user.id,
        nick: user.nick,
        mail: user.mail,
      };
      await next();
    };
  }

  return config;
};
```

## Custom storage

Create `config/config.console_prod.js` for production or `config/config.console_local.js` for development, example `aliyun-oss`:

```js
const OSS = require('ali-oss');

module.exports = () => {
  const config = {};

  config.oss = {
    client: {
      accessKeyId: 'xxxx',
      accessKeySecret: 'xxxx',
      bucket: 'xxxx',
      endpoint: 'xxxx'
    }
  }

  config.customStorage = function ossStorage(originStorage) {
    const { config, logger } = this;
    if (!config.oss) {
      return originStorage;
    }

    const client = new OSS(config.oss.client)
    return {
      async saveFile(fileName, stream) {
        try {
          if (stream instanceof Buffer) {
            await client.put(fileName, stream);
            return;
          }

          await client.putStream(fileName, stream);
        } catch (err) {
          logger.error(`save file failed: ${err}`);
        }
      },

      async deleteFile(fileName) {
        try {
          await client.delete(fileName);
        } catch (err) {
          logger.error(`delete file failed: ${err}`);
        }
      },

      downloadFile(fileName) {
        return client.getStream(fileName).then(res => res.stream);
      },
    };
  };

  return config;
};
```

## Deploy in Docker

See [deploy-in-docker.md](deploy-in-docker.md)
