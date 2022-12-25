import Koa from 'koa'
import Router from '@koa/router'
import { koaBody } from 'koa-body'
import bodyParser from 'koa-bodyparser'
import { ObjectId } from 'mongodb'
import { MongoClient, ServerApiVersion } from 'mongodb';

import * as dotenv from 'dotenv' // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
dotenv.config()

const app = new Koa()
const router = new Router()

let uri = `mongodb://${process.env.MONGO_USER}:${process.env.MONGO_PASS}@${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/`
if (process.env.NODE_ENV === "production") {
    uri = `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASS}@${process.env.MONGO_HOST}/?retryWrites=true&w=majority`
}

const client = new MongoClient(
    uri,
    {
        maxPoolSize: 10,
        minPoolSize: 2,
        useNewUrlParser: true,
        useUnifiedTopology: true,
        serverApi: ServerApiVersion.v1
    }
)

const annotations = client.db(process.env.MONGO_DB).collection('annotations')

app.use(bodyParser({
    extendTypes: {
        json: ['application/ld+json']
    }
}))

const findOperations = async (query = null) =>
    annotations.find(query).toArray()

router.post('/annotations', koaBody(), async ctx => {
    const result = await annotations.insertOne(ctx.request.body)
        .catch(err => console.error(err.message))

    ctx.body = { id: ctx.request.body.id }
    ctx.set(
        'Content-Type',
        'application/ld+json; charset=utf-8; profile=http://www.w3.org/ns/anno.jsonld'
    )
    ctx.set('ETag', `W/${result.insertedId}`)

})
    .get('/annotations', async ctx => {
        ctx.body = await findOperations()
    })
    .put('/annotations', koaBody(), async ctx => {
        const result = await annotations.updateOne(
            { $where: `this.id.startsWith('${ctx.params.id}')` },
            {
                $set: {
                    body: ctx.request.body.body
                }
            })
            .catch(err => console.error(err.message))

        ctx.body = result.modifiedCount

    })
    .del('/annotations', async ctx => {
        const result = await annotations.deleteOne({ $where: `this.id.startsWith('${ctx.params.id}')` })
            .catch(err => console.error(err.message))

        ctx.body = result.deletedCount
    })
    .get('/annotations/:id', async ctx => {
        ctx.body = await findOperations({ $where: `this.id.startsWith('${ctx.params.id}')` })
    })

app.use(router.routes())

app.listen(3001)
