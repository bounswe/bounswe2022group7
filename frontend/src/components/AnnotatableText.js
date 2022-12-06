import React, {useRef} from 'react';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

function AnnotatableText(props) {
  /*
  const textEl = useRef(null)

  if (textEl.current) {
    const r = new Recogito({ content: textEl.current });
  }
  
  return (
    <div ref={textEl}>{props.text}</div>
  );
  */
 
  /*
  const textElement = document.getElementById('annnotatedText')

  if (textElement) {
    const r = new Recogito({ content: "annnotatedText" });
  }

  return (
    <div id="annnotatedText">{props.text}</div>
  );
  */

  return (<>{props.text}</>)
}

export default AnnotatableText