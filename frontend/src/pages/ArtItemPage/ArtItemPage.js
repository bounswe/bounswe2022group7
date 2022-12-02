import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"
import ImageComponent from "../../components/ImageComponent"
import GenericCardLayout from "../../layouts/GenericCardLayout";

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
    <GenericCardLayout maxWidth={1000}>
      <Typography variant="h4" sx={{padding:2}}>
        {artitem.name}
      </Typography>
    
      <Grid container spacing={2}>
        <Grid item xs={12} sm={8}>
          <ImageComponent imageId={artitem.imageId}/>          
        </ Grid>
        <Grid item xs={12} sm={4}>
          <Typography variant="h5">Owner:</Typography>
          <UserCard data={artitem.creatorAccountInfo}/>
          
          <Typography variant="h5">Description:</Typography>
          <Typography variant="body1">{artitem.description}</Typography>

          {artitem.onAuction && // if auction_id exists, render block below
          // TODO render auction properly
            <div>
              <Typography variant="h5">Auction Price:</Typography>
              Auction at id={artitem.lastPrice}
            </div>
          }


        </ Grid>
      </ Grid>  
      <CommentSection
        contentId={id}
        commentList={artitem.commentList}
      />
    </GenericCardLayout>
    
  )}
}


export default ArtItemPage