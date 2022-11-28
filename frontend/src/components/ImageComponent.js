import React, {useEffect, useState} from 'react'
import PropTypes from 'prop-types';

function ImageComponent({imageId}) {

  const [state, setState] = useState({
    base64String: null
  })

  useEffect(() => {
    fetch('/api/image/' + imageId, {method:"GET"})
      .then((response) => response.json())
      .then((json) => setState({base64String: json.base64String}))
  }, [imageId])

  return (
    <>
      {
      state.base64String
      ?
      <img src={state.base64String} alt="image" style={{width: '100%'}}/>
      :
      <div style={{textAlign: "center"}}>
        <img src="https://www.ign.gob.ar/geodesiaapp/ntrip-registro/img/loader.gif" alt="loading" style={{width: '25%'}}/>
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