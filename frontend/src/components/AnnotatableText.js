import React, { useRef, useEffect } from 'react';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

function AnnotatableText(props) {
  const textEl = useRef(null)
  

  useEffect(() => {
    let recogito
    
    if (textEl.current) {
      recogito = new Recogito({
        content: textEl.current,
        widgets: [
          'COMMENT'
        ]
      })

      recogito.loadAnnotations(`/annotations/${props.contentType}${props.id}`)

      recogito.on('createAnnotation', annotation => {
        annotation.id = props.contentType + props.id + '-' + annotation.id
        console.log(annotation)
        fetch('/annotations/',
          {
            method: 'POST',
            body: JSON.stringify(annotation),
            headers: {
              'Content-Type': 'application/ld+json'
            }
          })
      })

      recogito.on('updateAnnotation', annotation => {
        console.log(annotation)
        fetch('/annotations/',
          {
            method: 'PUT',
            body: JSON.stringify(annotation),
            headers: {
              'Content-Type': 'application/ld+json'
            }
          })
      })

      recogito.on('deleteAnnotation', annotation => {
        fetch('/annotations/',
          {
            method: 'DELETE',
            body: JSON.stringify(annotation),
            headers: {
              'Content-Type': 'application/ld+json'
            }
          })
      })
    }
  }, [])

  return (
    <p ref={textEl}>
      {props.children}
    </p>
  )
}


export default AnnotatableText