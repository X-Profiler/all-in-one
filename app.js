'use strict';

class AppBoot {
  constructor(app) {
    this.app = app;
  }

  didReady() {
    const { options: { serverScope }, config: { ignoreRouter, basicAuthHooks }, router } = this.app;

    // handle console router
    if (serverScope === 'console') {
      // custom auth
      if (basicAuthHooks) {
        let index = 0;
        const middlewares = this.app.middleware;
        for (const length = middlewares.length; index < length; index++) {
          const { _name } = middlewares[index];
          if (_name.includes('basicAuth')) {
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
          if (ignoreRouter.every(router => typeof router === 'string'
            ? router !== layer.path
            : router.path !== layer.path || !layer.methods.includes(router.method.toUpperCase()))) {
            continue;
          }

          this.app.logger.info(`[devtoolx-console] ignore router: %s, methods: %s`, layer.path, layer.methods.join(','));
          layer.stack.pop();
        }
      }
    }
  }
}

module.exports = AppBoot;