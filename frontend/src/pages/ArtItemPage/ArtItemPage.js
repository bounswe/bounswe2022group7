import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"
import ImageDisplay from "../../components/ImageDisplay"
import IconWithText from "../../components/IconWithText"
import AnnotatableText from "../../components/AnnotatableText"
import GenericCardLayout from "../../layouts/GenericCardLayout";
import AuctionDisplay from "./AuctionDisplay"
import {ArtItemLike} from '../../components/ArtItemPreview';
import LoadingButton from "../../components/LoadingButton"

import BrushIcon from '@mui/icons-material/Brush';
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
  const { token, userData } = useAuth()
  
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

  const artLikeStatus = (id) => {
    if (userData === null) {
        return false;
    }
    return userData.likedArtItemIds.includes(id);
  };

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
      <ArtItemLike content={{
        liked: artLikeStatus(artitem.id),
        likeCount: artitem?.likedByUsernames?.length,
        id: artitem.id,
        commentCount: artitem?.commentList?.length,
      }}/>

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
        </ Grid>
      </ Grid>
      <AuctionDisplay
        max_bid = {artitem.maxBid}
        art_item_id = {artitem.id}
        user_id = {userData?.id}
        owner_id = {artitem.ownerId}
        on_auction = {artitem.onAuction}
      />
      <CommentSection
        contentId={id}
        commentList={artitem.commentList}
      />
      {artitem.ownerId == userData?.id &&
        <div>
          <br/>
          As the owner user:
          <br/>
          <LoadingButton
            label="Delete Art Item"
            onClick={() => {
              fetch("/api/art_item/" + artitem.id, {
                method: "DELETE",
                headers: {Authorization: "Bearer " + token}
              }).then((response) => {window.location.href = "/"})
            }}
            type="submit"
            variant="contained"
            color="primary"
          />
        </div>
      }
    </GenericCardLayout>
  )}
}


export default ArtItemPage