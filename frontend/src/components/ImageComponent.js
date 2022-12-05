import React, { useEffect, useState, useRef } from 'react'
import PropTypes from 'prop-types';
import { Annotorious } from '@recogito/annotorious';
import '@recogito/annotorious/dist/annotorious.min.css';


function ImageComponent({ imageId, imageStyle }) {
  const imgEl = useRef(null)

  const [state, setState] = useState({
    base64String: null
  })


  useEffect(() => {
    if (imageId) {

      fetch('/api/image/' + imageId, { method: "GET" })
        .then((response) => response.json())
        .then((json) => {
          setState({ base64String: json.base64String })

          let annotorious = null;

          if (imgEl.current) {
            annotorious = new Annotorious({
              image: imgEl.current
            })

            annotorious.loadAnnotations(`/annotations/${imageId}`)

            annotorious.on('createAnnotation', annotation => {
              annotation.id = imageId + '-' + annotation.id
              fetch('/annotations',
                {
                  method: 'POST',
                  body: JSON.stringify(annotation),
                  headers: {
                    'Content-Type': 'application/ld+json'
                  }
                })
            })

            annotorious.on('updateAnnotation', (annotation) => {
              fetch('/annotations',
                {
                  method: 'PUT',
                  body: JSON.stringify(annotation),
                  headers: {
                    'Content-Type': 'application/ld+json'
                  }
                })
            })

            annotorious.on('deleteAnnotation', annotation => {
              fetch('/annotations',
                {
                  method: 'DELETE',
                  body: JSON.stringify(annotation),
                  headers: {
                    'Content-Type': 'application/ld+json'
                  }
                })
            })
          }
        })
    }

  }, [imageId])

  return (

    <img ref={imgEl} src={
      state.base64String ||
      "https://www.ign.gob.ar/geodesiaapp/ntrip-registro/img/loader.gif"
    } alt="image" style={imageStyle} />
  )
}

export default ImageComponent


ImageComponent.propTypes = {
  imageId: PropTypes.number
}

ImageComponent.defaultProps = {
  imageId: 0
}