# run the app
`docker compose up`

- The app uses MongoDB as the database and listens on the port 3001.

- Send the annotation objects to /annotations endpoint.
- GET /annotations returns the list of annotations.

Example annotation:
```
{
  "@context": "http://www.w3.org/ns/anno.jsonld",
  "id": "http://example.org/anno21",
  "type": "Annotation",
  "body": "http://example.org/note2",
  "target": {
    "source": "http://example.org/page1.html",
    "selector": {
      "type": "CssSelector",
      "value": "#elemid > .elemclass + p"
    }
  }
}
```

More info: [WADM](https://www.w3.org/TR/annotation-model/)