import mongo from 'koa-mongo'
import Koa from 'koa'
import Router from '@koa/router'
import { koaBody } from 'koa-body'

const app = new Koa()
const router = new Router()

app.use(mongo({
    host: 'mongo',
    user: 'root',
    pass: 'abcd1234',
    db: 'admin',
    acquireTimeoutMillis: 10000
}))

router.post('/annotations', koaBody(), async ctx => {
    const result = await ctx.db.collection('annotations').insertOne(ctx.request.body)
    ctx.type = 'application/json'
    ctx.body = { _id: result.ops[0]._id }
})
    .get('/annotations', async ctx => {
        ctx.body = await ctx.db.collection('annotations').find().toArray()
    })

app.use(router.routes())

app.listen(3000)
