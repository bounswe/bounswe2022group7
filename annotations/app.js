import mongo from 'koa-mongo'
import Koa from 'koa'
import Router from '@koa/router'
import { koaBody } from 'koa-body'
import bodyParser from 'koa-bodyparser'

const app = new Koa()
const router = new Router()

app.use(mongo({
    host: 'mongo',
    user: 'root',
    pass: 'abcd1234',
    db: 'admin',
    acquireTimeoutMillis: 10000
}))
app.use(bodyParser({
    extendTypes: {
        json: ['application/ld+json']
    }
}))
router.post('/annotations', koaBody(), async ctx => {
    const result = await ctx.db.collection('annotations').insertOne(ctx.request.body)

    ctx.body = { id: ctx.request.body.id }
    
    ctx.set('Content-Type', 'application/ld+json; charset=utf-8; profile=http://www.w3.org/ns/anno.jsonld')
    ctx.set('ETag', `W/${result.ops[0]._id}`)
})
    .get('/annotations', async ctx => {
        ctx.body = await ctx.db.collection('annotations').find().toArray()
    })

app.use(router.routes())

app.listen(3001)
