import * as Koa from 'koa'
import * as Router from 'koa-router'

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
  }

  private routes (): void {
    this.router.use('/', ViewRouter)
  }
}

export default new Server().app
