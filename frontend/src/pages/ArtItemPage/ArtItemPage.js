import React from 'react'
import {useParams} from "react-router-dom";

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"

import { Typography, Grid } from '@mui/material';

function fetchArtItemData(id) {
  // we will replace the mock data below with
  // and api call once the api endpoint is
  // ready in the backend.

  const data = {
    "art_item_title": "Super Art Item",
    "description": "Super Description",
    "auction_id": 2,
    "image": "https://picsum.photos/200/300",
    "artist": {
      "level": 6,
      "name": "Mehmet",
      "user_id": 1
    },
    "collaborators": [
      {
        "level": 7,
        "name": "Husnu",
        "user_id": 2
      },
      {
        "level": 4,
        "name": "Hasan",
        "user_id": 3
      },
    ],
    "related_events": [
      {
        "title": "Super Event",
        "id": 2
      }
    ],
    "comments": [
      {
        "userData": {
          "level": 6,
          "name": "Picasso",
          "user_id": 4,
        },
        "body": "Super Comment",
        "date": "Super date"
      },
      {
        "userData": {
          "level": 4,
          "name": "Da Vinci",
          "user_id": 6,
        },
        "body": "Super Comment 2",
        "date": "Super date 2"
      }
    ],
    "labels": "?"
  }
  return data
}

function ArtItemPage() {
    
  let { id } = useParams();

  const data = fetchArtItemData(id)

  return (
    <div>
      <Typography variant="h4" sx={{padding:2}}>
        {data.art_item_title}
      </Typography>
    
      <Grid container>
        <Grid item xs={6} sx={{padding:2}}>
          <img src={data.image} style={{width:'100%'}}/>
        </ Grid>
        <Grid item xs={6} sx={{padding:2}}>
          <Typography variant="h5">Artist:</Typography>
          <UserCard userData={data.artist}/>

          {data.collaborators && // if collaborators exists, render block below
            <div>
              <Typography variant="h5">Collaborators:</Typography>
              {data.collaborators.map(collaboratorData => <UserCard userData={collaboratorData} />)            }
            </div>
          }
          
          <Typography variant="h5">Description:</Typography>
          <Typography variant="body1">{data.description}</Typography>

          { data.related_events && // if related_events is provided in data, render the block below
          // TODO: render event properly.
            <div>
              <Typography variant="h5">Related Events:</Typography>
              {data.related_events.map(eventData => eventData.title + ", ")}
            </div>
          }

          { data.auction_id && // if auction_id exists, render block below
          // TODO render auction properly
            <div>
              <Typography variant="h5">Auction:</Typography>
              Auction at id={data.auction_id}
            </div>
          }


        </ Grid>
        <CommentSection
          id={id}
          comments={data.comments}
        />
      </ Grid>  
    </div>
    
  )
}


export default ArtItemPage