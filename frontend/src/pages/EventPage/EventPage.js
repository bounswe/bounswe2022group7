import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import { Typography, Grid } from '@mui/material';
import CommentSection from "../../common/CommentSection"
import ContentLayout from "../../layouts/ContentLayout";

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
    
      <Grid container>
        <Grid item xs={6} sx={{padding:2}}>
          <img src={event.eventInfo.posterUrl} alt="Event" style={{width:'100%'}}/>
        </ Grid>
        <Grid item xs={6} sx={{padding:2}}>          
          <Typography variant="h5">Description:</Typography>
          <Typography variant="body1">{event.eventInfo.description}</Typography>

          <Typography variant="h5">Start Date:</Typography>
          <Typography variant="body1">{event.eventInfo.startingDate}</Typography>

          <Typography variant="h5">End Date:</Typography>
          <Typography variant="body1">{event.eventInfo.endingDate}</Typography>

          <Typography variant="h5">Location:</Typography>
          <Typography variant="body1">{event.location.address}</Typography>
        </ Grid>
        <CommentSection
          id={id}
          commentList={event.commentList.filter(x => !!x.author)}
        />
      </ Grid>  
    </ContentLayout>
    
  )}
}


export default EventPage