import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"

import { Typography, Grid } from '@mui/material';

function ArtItemPage() {
  
  let { id } = useParams();

  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    artitem: [] 
  })

  const { token } = useAuth()
  
  useEffect(() => {

    const fetchArgs = {
      method: "GET",  
    }

    if (token) fetchArgs.headers = {Authorization: "Bearer " + token}
    fetch('/api/art_item/' + id, fetchArgs)
      .then((response) => response.json())
      .then((data) => {
        console.log(data)
        setState({error: null, isLoaded: true, artitem: data})
      },
        error => {
          setState({error: error})
        }
      )
  }, [id, token])

  const {error, isLoaded, artitem} = state

  if (error) {
    return <div>Error: {error.message}</div>
  } else if (!isLoaded) {
    return <div>Loading...</div>
  } else {
  return (
    <div>
      <Typography variant="h4" sx={{padding:2}}>
        {artitem.artItemInfo.name}
      </Typography>
    
      <Grid container>
        <Grid item xs={6} sx={{padding:2}}>
          <img src={artitem.artItemInfo.imageUrl} alt="Art Item" style={{width:'100%'}}/>
        </ Grid>
        <Grid item xs={6} sx={{padding:2}}>
          <Typography variant="h5">Owner:</Typography>
          <UserCard author={artitem.owner}/>
          
          <Typography variant="h5">Description:</Typography>
          <Typography variant="body1">{artitem.artItemInfo.description}</Typography>

          {artitem.onAuction && // if auction_id exists, render block below
          // TODO render auction properly
            <div>
              <Typography variant="h5">Auction Price:</Typography>
              Auction at id={artitem.lastPrice}
            </div>
          }


        </ Grid>
        <CommentSection
          id={id}
          commentList={artitem.commentList.filter(x => !!x.author)}
        />
      </ Grid>  
    </div>
    
  )}
}


export default ArtItemPage