'use strict';

const os = require('os');
const path = require('path');

const {
  EZM_SERVER,
  EZM_ID,
  EZM_SECRET,
} = process.env;

module.exports = appInfo => {
  const config = {};

  config.mysql = {
    app: true,
    agent: false,
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
  };

  config.redis = {
    client: {
      sentinels: null,
      port: 6379,
      host: '127.0.0.1',
      password: '',
      db: 0,
    },
  };

  config.forceHttp = true;

  config.xprofilerConsole = 'http://127.0.0.1:8443';

  config.xtransitManager = 'http://127.0.0.1:8543';

  config.xtransit = {
    server: EZM_SERVER || 'ws://127.0.0.1:9090',
    appId: EZM_ID || '',
    appSecret: EZM_SECRET || '',
    logDir: path.join(__dirname, '../logs', appInfo.scope),
    customAgent() {
      return `${os.hostname()}@${appInfo.scope}`;
    },
  };

  return config;
};
