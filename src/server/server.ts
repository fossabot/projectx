import * as Koa from 'koa'
import * as Router from 'koa-router'
import * as body from 'koa-body'
import * as assets from 'koa-static'

import ViewRouter from './routes/ViewRouter'

class Server {
  public app: Koa
  public router: Router
  constructor () {
    this.app = new Koa()
    this.router = new Router()
    this.config()
    this.routes()
  }

  private config (): void {
    // SQL Connection

    // Response Time
    this.app.use(async (ctx, next) => {
      const t1 = Date.now();
      await next();
      const t2 = Date.now();
      ctx.set('X-Response-Time', Math.ceil(t2-t1)+'ms');
    });

    this.app.use(async (ctx, next) => {
      console.log('Url: ', ctx.url);
      await next();
    });

    // Body Parser
    this.app.use(body({multipart:true}));

    this.app.use(this.router.routes())
    .use(this.router.allowedMethods());

    this.app.use(assets(__dirname + '../client/'));

  }

  private routes (): void {
    this.router.use('/', ViewRouter)
  }
}

export default new Server().app
