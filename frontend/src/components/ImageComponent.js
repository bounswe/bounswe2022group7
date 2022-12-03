import React, {useEffect, useState} from 'react'
import PropTypes from 'prop-types';

function ImageComponent({imageId, imageStyle}) {

  const [state, setState] = useState({
    base64String: null
  })

  useEffect(() => {
    fetch('/api/image/' + imageId, {method:"GET"})
      .then((response) => response.json())
      .then((json) => setState({base64String: json.base64String}))
  }, [imageId])

  return (
    <img src={
      state.base64String ||
      "https://www.ign.gob.ar/geodesiaapp/ntrip-registro/img/loader.gif"
    } alt="image" style={imageStyle}/>
  )
}

export default ImageComponent


ImageComponent.propTypes = {
  imageId: PropTypes.number
}

ImageComponent.defaultProps = {
  imageId: 0
}