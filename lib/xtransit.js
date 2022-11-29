'use strict';

const path = require('path');
const xtransit = require('xtransit');

module.exports = function () {
  const logDir = path.join(__dirname, '../logs/xprofiler');

  const options = {
    server: process.env.APP_SERVER,
    appId: process.env.APP_ID,
    appSecret: process.env.APP_SECRET,
    logDir,
    reconnectBaseTime: 10,
  };

  if (!options.server || !options.appId || !options.appSecret) {
    return;
  }

  xtransit.start(options);
};