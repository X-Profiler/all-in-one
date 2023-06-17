class AppBoot {
  constructor(app) {
    this.app = app;
  }

  didReady() {
    const app = this.app;
    const {
      options: { serverScope },
      config: { basicAuthHooks, ignoreRouter, customStorage },
      router,
    } = app;

    // custom console
    if (serverScope === 'console') {
      // auth hooks
      if (basicAuthHooks) {
        let index = 0;
        const middlewares = app.middleware;
        for (const length = middlewares.length; index < length; index++) {
          const { _name } = middlewares[index];
          if (_name && _name.includes('basicAuth')) {
            break;
          }
        }

        if (basicAuthHooks.before) {
          middlewares.splice(index, 0, basicAuthHooks.before);
        }

        if (basicAuthHooks.after) {
          middlewares.splice(index + 1, 0, basicAuthHooks.after);
        }
      }

      // ignore routes
      if (ignoreRouter.length) {
        const layers = router.stack;
        for (const layer of layers) {
          if (ignoreRouter.every(router => (typeof router === 'string'
            ? router !== layer.path
            : router.path !== layer.path || !layer.methods.includes(router.method.toUpperCase())))) {
            continue;
          }

          this.app.logger.info('[devtoolx-console] ignore router: %s, methods: %s', layer.path, layer.methods.join(','));
          layer.stack.pop();
        }
      }

      // app extension
      if (customStorage) {
        const originStorage = app.storage;
        Object.defineProperty(app, 'storage', {
          get() {
            return customStorage.call(app, originStorage);
          },
        });
      }
    }
  }
}

module.exports = AppBoot;
