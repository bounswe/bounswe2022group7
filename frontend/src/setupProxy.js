const { createProxyMiddleware } = require('http-proxy-middleware')

module.exports = function (app) {
    app.use(
        '/annotations',
        createProxyMiddleware({
            target: 'http://annotation-service:3001/annotations',
            changeOrigin: true,
            prependPath: false
        })
    )

    app.use(
        '/api',
        createProxyMiddleware({
            target: 'http://backend:8080',
            changeOrigin: true
        })
    )
}