import mongo from 'koa-mongo'
import Koa from 'koa'
import Router from '@koa/router'
import { koaBody } from 'koa-body'
import bodyParser from 'koa-bodyparser'
import { ObjectId } from 'mongodb'

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
    ctx.set('ETag', `W/${result.insertedId}`)
})
    .get('/annotations', async ctx => {
        ctx.body = await ctx.db.collection('annotations').find().toArray()
    })
    .put('/annotations', koaBody(), async ctx => {
        const result = await ctx.db.collection('annotations').updateOne({
            _id: ObjectId(ctx.request.body._id)
        }, {
            $set: {
                body: ctx.request.body.body
            }
        })
        ctx.body = result.modifiedCount
    })
    .del('/annotations', async ctx => {
        const result = await ctx.db.collection('annotations').deleteOne({
            _id: ObjectId(ctx.request.body._id)
        })

        ctx.body = result.deletedCount
    })
    .get('/annotations/:imageId', async ctx => {
        ctx.body = await ctx.db.collection('annotations').find({
            $where: `this.id.startsWith(${ctx.params.imageId})`
        }).toArray()
    })

app.use(router.routes())

app.listen(3001)
