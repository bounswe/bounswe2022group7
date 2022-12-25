import mongo from 'koa-mongo'
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

var uri = `mongodb://${process.env.MONGO_USER}:${process.env.MONGO_PASS}@${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/`;
let db_name = process.env.MONGO_DB;

if (process.env.NODE_ENV === "production") {
    uri = `mongodb+srv://${process.env.MONGO_USER}:${process.env.MONGO_PASS}@${process.env.MONGO_HOST}/?retryWrites=true&w=majority`;
} 

const client = new MongoClient(uri, {maxPoolSize:10, minPoolSize: 2, useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });


async function connectDB() {
    try {
        // Connect the client to the server (optional starting in v4.7)
        await client.connect();
        // Establish and verify connection
        await client.db(db_name).command({ ping: 1 });
    } catch (e) {
        console.error(e);
    }
}

connectDB();

app.use(bodyParser({
    extendTypes: {
        json: ['application/ld+json']
    }
}))


async function findOperations(query = null) {
    try {
        const database = client.db(db_name);
        const annotations = database.collection("annotations");

        return await annotations.find(query).toArray();

    } catch (e) {
        console.error(e);
    }
}

router.post('/annotations', koaBody(), async ctx => {
    try {
        const database = client.db(db_name);
        const annotations = database.collection("annotations");
        const result = await annotations.insertOne(ctx.request.body);

        ctx.body = { id: ctx.request.body.id }

        ctx.set('Content-Type', 'application/ld+json; charset=utf-8; profile=http://www.w3.org/ns/anno.jsonld')
        ctx.set('ETag', `W/${result.insertedId}`)

    } catch (e) {
        console.error(e);
    }
})
    .get('/annotations', async ctx => {
        ctx.body = await findOperations();
    })
    .put('/annotations', koaBody(), async ctx => {

        try {
            const database = client.db(db_name);
            const annotations = database.collection("annotations");
            const result = await annotations.updateOne(
                { _id: ObjectId(ctx.request.body._id)}, {
                    $set: {
                        body: ctx.request.body.body
                    }
                });
    
            ctx.body = result.modifiedCount
    
        } catch (e) {
            console.error(e);
        }
    })
    .del('/annotations', async ctx => {

        try {
            const database = client.db(db_name);
            const annotations = database.collection("annotations");
            const result = await annotations.deleteOne({ _id: ObjectId(ctx.request.body._id)});
    
            ctx.body = result.deletedCount
    
        } catch (e) {
            console.error(e);
        }


    })
    .get('/annotations/:imageId', async ctx => {

        ctx.body = await findOperations({ id: { $regex: `^${ctx.params.imageId}` } });

    })



app.use(router.routes())
app.listen(3001)
