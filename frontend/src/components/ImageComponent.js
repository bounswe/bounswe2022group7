import React, {useEffect, useState} from 'react'

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
      {state.base64String && <img src={state.base64String} alt="image" style={{width: '100%'}}/>}
    </>
  )
}

export default ImageComponent