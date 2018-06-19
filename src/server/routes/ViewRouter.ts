import * as Koa from 'koa'
import * as Router from 'koa-router'

export class ViewRouter {
  router: Router
  constructor () {
    this.router = new Router()
    this.routes()
  }

  private async main (ctx, next): Promise<void> {
    await ctx.render('./index.html',{
      info: 'test'
    })
  }

  private routes (): void {
    this.router.get('/', this.main)
  }
}
const viewRouter: ViewRouter = new ViewRouter()

export default viewRouter.router.routes()
