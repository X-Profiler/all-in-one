'use strict';

const fs = require('fs')
const path = require('path');

module.exports = function () {
  const logDir = path.join(__dirname, '../logs/xprofiler');
  if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir, { recursive: true });
  }
  require('xprofiler').start({ log_dir: logDir, log_level: 2 });
};