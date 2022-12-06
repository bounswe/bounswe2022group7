/*
An image component. Container of the image has the following properties
- has a maximum height
- centers objects

Image in the center fills the whole space
- image has max width
*/

import React from 'react'
import Paper from '@mui/material/Paper';

import ImageComponent from "./ImageComponent"

function ImageDisplay({imageId}) {
  return (
    <Paper elevation={0} style={{display: 'flex', width: "100%"}}>
      <div style={{
        textAlign: "center",
        backgroundColor: '#fafafa',
        width: "100%"
      }}>
        <ImageComponent
          imageId={imageId}
          imageStyle={{
            maxWidth: "80%",
            margin: "auto"}}
        />
      </div>  
    </Paper>
  )
}


export default ImageDisplay