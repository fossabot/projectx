import * as debug from 'debug'
import * as http from 'http'

import Server from './server'

debug('koa:server')

const port: number = 3000

const server = http.createServer(Server.callback())

console.log(`Server listening on port ${port}`)
server.listen(port)
