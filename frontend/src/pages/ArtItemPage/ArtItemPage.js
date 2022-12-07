import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"
import ImageDisplay from "../../components/ImageDisplay"
import IconWithText from "../../components/IconWithText"
import AnnotatableText from "../../components/AnnotatableText"
import GenericCardLayout from "../../layouts/GenericCardLayout";

import BrushIcon from '@mui/icons-material/Brush';
import SellIcon from '@mui/icons-material/Sell';
import LabelIcon from '@mui/icons-material/Label';
import CategoryIcon from '@mui/icons-material/Category';

import { Typography, Grid, useTheme } from '@mui/material';

function ArtItemPage() {
  
  let { id } = useParams();

  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    artitem: [] 
  })

  const theme = useTheme();
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
      <Typography
        variant="h5"
        color={theme.palette.primary.main}
      >
        Art Item:
      </Typography>
      <Typography variant="h4">
        {artitem.name}
      </Typography>

      <ImageDisplay imageId={artitem.imageId}/>

      <Grid container>
        <Grid item xs={12} sm={8}>
          <IconWithText
            text="Description "
            variant="h5"
          />
          <AnnotatableText text={artitem.description}/>
        </ Grid>
        <Grid item xs={12} sm={4}>

          <IconWithText
            icon = {<BrushIcon/>}
            text="Creator:"
            variant="h5"
          />
          <UserCard data={artitem.creatorAccountInfo}/>

          <IconWithText
            icon = {<LabelIcon/>}
            text="Labels:"
            variant="h5"
          />
          {artitem.labels.join(", ")}

          <IconWithText
            icon = {<CategoryIcon/>}
            text="Categories:"
            variant="h5"
          />
          {artitem.category.join(", ")}

          <IconWithText
            icon = {<SellIcon/>}
            text = "Auction Status"
            variant = "h5"
          />

          {artitem.onAuction
          ? 
          // if auction_id exists, render block below
          // TODO render auction properly
          <div>
            <Typography variant="h5">Auction Price:</Typography>
            Auction at id={artitem.lastPrice}
          </div>
          :
          <div>
            Not currently on auction.
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