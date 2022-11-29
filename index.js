'use strict';

const path = require('path');

const startCluster = require('egg').startCluster;

const base = {
  workers: 1,
  baseDir: __dirname,
  env: process.env.EZM_ENV ? process.env.EZM_ENV : 'prod',
}

const options = Object.assign({}, base, {
  port: 8443,
  serverScope: 'console',
  framework: path.dirname(require.resolve('@xprofiler/console')),
});

startCluster(options, () => console.log('ezmconsole started'));
