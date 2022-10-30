import React, { useEffect } from 'react'
import {useParams} from "react-router-dom";

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"
import { useAuth } from "../../auth/useAuth"

import { Typography, Grid } from '@mui/material';

function ArtItemPage() {
  let { id } = useParams();

  const [error, setError] = React.useState(null)
  const [isLoaded, setLoaded] = React.useState(false)
  const [artData, setData] = React.useState([])

  const { token } = useAuth()
  const fetchHeaders = {
      Authorization: 'Bearer ' + token
  }

  useEffect(() => {
    const promise = fetch('/art_item/' + id, {
        headers: fetchHeaders,
        method: 'GET',
    })
        .then((response) => response.json())
        .then((data) => {
            setLoaded(true)
            console.log(data)
            console.log(artData)
            setData(data)
            console.log(artData)
        },
            error => {
                console.log(error)
                setLoaded(true)
                setError(error)
            })

    return () => {
        promise.cancel()
    }
  }, [])

  if (error) {
    return <div>Error: {error.message}</div>
  } else if (!isLoaded) {
    return <div>Loading...</div>
  } else {
    console.log(artData)
    return (
      <div>
        <Typography variant="h4" sx={{padding:2}}>
          {artData.artItemInfo.name}
        </Typography>
      
        <Grid container>
          <Grid item xs={6} sx={{padding:2}}>
            <img src={artData.artItemInfo.imageUrl} style={{width:'100%'}}/>
          </ Grid>
          <Grid item xs={6} sx={{padding:2}}>
            <Typography variant="h5">Artist:</Typography>
            <UserCard userData={{level: 1, name: "not_provided", user_id: artData.creator.id}}/>

            {/*
              artData.collaborators && // if collaborators exists, render block below
              <div>
                <Typography variant="h5">Collaborators:</Typography>
                {artData.collaborators.map(collaboratorData => <UserCard userData={collaboratorData} />)            }
              </div>
              */
            }
            
            <Typography variant="h5">Description:</Typography>
            <Typography variant="body1">{artData.description}</Typography>

            {/* artData.related_events && // if related_events is provided in data, render the block below
            // TODO: render event properly.
              <div>
                <Typography variant="h5">Related Events:</Typography>
                {artData.related_events.map(eventData => eventData.title + ", ")}
              </div>
            */}

            {/* artData.auction_id && // if auction_id exists, render block below
            // TODO render auction properly
              <div>
                <Typography variant="h5">Auction:</Typography>
                Auction at id={artData.auction_id}
              </div>
            */}


          </ Grid>
          {/*
          <CommentSection
            id={id}
            comments={artData.comments}
          />*/}
        </ Grid>  
      </div>
      
    )
  }
}


export default ArtItemPage