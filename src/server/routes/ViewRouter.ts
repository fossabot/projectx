import * as Koa from 'koa'
import * as Router from 'koa-router'

export class ViewRouter {
  public router: Router
  constructor () {
    this.router = new Router()
    this.routes()
  }

  private async main (ctx: Koa.Context, next): Promise<void> {
    await ctx.render('./index.html',{
      info: 'test'
    })
  }

  private routes (): void {
    this.router.get('', this.main)
  }
}
const viewRouter: ViewRouter = new ViewRouter()

export default viewRouter.router.routes()
