import mongo from 'koa-mongo'
import Koa from 'koa'
import Router from '@koa/router'
import { koaBody } from 'koa-body'
import bodyParser from 'koa-bodyparser'
import { ObjectId } from 'mongodb'

import * as dotenv from 'dotenv' // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
dotenv.config()

const app = new Koa()
const router = new Router()

if (process.env.NODE_ENV === 'production') {
    app.use(mongo({
        uri: `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASS}@${process.env.MONGO_HOST}/${process.env.MONGO_DB}`,
        retryWrites: true,
        w: 'majority',
        ssl: true,
    }))
} else {

    app.use(mongo({
        host: process.env.MONGO_HOST,
        user: process.env.MONGO_USER,
        pass: process.env.MONGO_PASS,
        db: process.env.MONGO_DB,
        port: process.env.MONGO_PORT,
        acquireTimeoutMillis: 10000
    }))
}

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
            id: { $regex: `^${ctx.params.imageId}` }
        }).toArray()
    })



app.use(router.routes())

app.listen(3001)
