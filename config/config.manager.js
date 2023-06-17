module.exports = () => {
  const config = {};

  config.mailer = {
    host: '',
    port: 25,
    secure: false,
    auth: {
      user: '',
      pass: '',
    },
  };

  return config;
};
