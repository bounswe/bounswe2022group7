import React, { useEffect, useState, useRef } from 'react'
import PropTypes from 'prop-types';
import { Annotorious } from '@recogito/annotorious';
import '@recogito/annotorious/dist/annotorious.min.css';

function ImageComponent({ imageId }) {
  const imgEl = useRef(null)

  const [state, setState] = useState({
    base64String: null
  })


  useEffect(() => {
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


  }, [imageId])

  return (
    <>
      {
        state.base64String
          ?
          <img ref={imgEl} src={state.base64String} alt="image" style={{ width: '100%' }} />
          :
          <div style={{ textAlign: "center" }}>
            <img src="https://www.ign.gob.ar/geodesiaapp/ntrip-registro/img/loader.gif" alt="loading" style={{ width: '25%' }} />
          </div>

      }
    </>
  )
}

export default ImageComponent


ImageComponent.propTypes = {
  imageId: PropTypes.number
}

ImageComponent.defaultProps = {
  imageId: 0
}