import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import { Typography, Grid } from '@mui/material';
import CommentSection from "../../common/CommentSection"
import ImageComponent from "../../common/ImageComponent"
import ContentLayout from "../../layouts/ContentLayout";
import MapComponent from "../../components/MapComponent"

function EventPage() {
  
  let { id } = useParams();

  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    event: [] 
  })

  const { token } = useAuth()
  
  useEffect(() => {

    const fetchArgs = {
      method: "GET",  
    }

    if (token) fetchArgs.headers = {Authorization: "Bearer " + token}
    fetch('/api/event/' + id, fetchArgs)
      .then((response) => response.json())
      .then((data) => {
        setState({error: null, isLoaded: true, event: data})
      },
        error => {
          setState({error: error})
        }
      )
  }, [id, token])

  const {error, isLoaded, event} = state

  if (error) {
    return <div>Error: {error.message}</div>
  } else if (!isLoaded) {
    return <div>Loading...</div>
  } else {
  return (
    <ContentLayout>
      <Typography variant="h4" sx={{padding:2}}>
        {event.eventInfo.title}
      </Typography>
    
      <Grid container spacing={2}>
        <Grid item xs={12} sm={8}>
          <ImageComponent imageId={event.eventInfo.posterId}/>          
        </ Grid>
        <Grid item xs={12} sm={4}>          
          <Typography variant="h5">Description:</Typography>
          <Typography variant="body1">{event.eventInfo.description}</Typography>

          <Typography variant="h5">Start Date:</Typography>
          <Typography variant="body1">{event.eventInfo.startingDate}</Typography>

          <Typography variant="h5">End Date:</Typography>
          <Typography variant="body1">{event.eventInfo.endingDate}</Typography>

          <Typography variant="h5">Location:</Typography>
          <Typography variant="body1">{event.location.address}</Typography>
        </ Grid>

        <MapComponent
          position={{
            lat:event.location.latitude, 
            lng:event.location.longitude
          }}
          eventTitle={event.eventInfo.title}
        />
      </ Grid>  
      <CommentSection
        id={id}
        commentList={event.commentList.filter(x => !!x.author)}
      />
    </ContentLayout>
    
  )}
}


export default EventPage