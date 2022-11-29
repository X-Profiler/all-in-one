'use strict';

const path = require('path');
const startCluster = require('egg').startCluster;

let projectNum = 0;

const base = {
  workers: 1,
  baseDir: path.join(__dirname, '..'),
  env: process.env.EZM_ENV ? process.env.EZM_ENV : 'prod',
}

function start(name, options, cb) {
  ++projectNum;
  options = Object.assign({ serverScope: name }, base, options);
  startCluster(options, () => {
    console.log(`=========> [${process.pid}] ${name} started on ${options.port}.`);
    if (--projectNum === 0) {
      cb();
    }
  });
}

module.exports = function (cb) {
  // ezmconsole
  start('console', {
    port: 8443,
    framework: path.dirname(require.resolve('@xprofiler/console')),
  }, cb);

  // ezmmanager
  start('manager', {
    port: 8543,
    framework: path.dirname(require.resolve('@xprofiler/manager')),
  }, cb);

  // ezmwsserver
  start('wsserver', {
    port: 9090,
    framework: path.dirname(require.resolve('@xprofiler/wsserver')),
  }, cb);
}
