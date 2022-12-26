import React, { useEffect, useState } from 'react'
import { useParams } from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import AnnotatableText from "../../components/AnnotatableText"
import AuctionDisplay from "./AuctionDisplay"
import CommentSection from "../../common/CommentSection"
import CopyrightReporter from '../../common/CopyrightReporter';
import CustomizableDropdownMenu from '../../components/CustomizableDropdownMenu';
import GenericCardLayout from "../../layouts/GenericCardLayout";
import IconWithText from "../../components/IconWithText"
import ImageDisplay from "../../components/ImageDisplay"
import UserCard from "../../common/UserCard"
import {ArtItemLike} from '../../components/ArtItemPreview';
import LoadingButton from "../../components/LoadingButton"

import BookmarkIcon from '@mui/icons-material/Bookmark';
import BookmarkBorderOutlinedIcon from '@mui/icons-material/BookmarkBorderOutlined';
import BrushIcon from '@mui/icons-material/Brush';
import LabelIcon from '@mui/icons-material/Label';
import CategoryIcon from '@mui/icons-material/Category';
import ShareIcon from '@mui/icons-material/Share';
import WarningIcon from '@mui/icons-material/Warning';

import Grid from '@mui/material/Grid';
import IconButton from '@mui/material/IconButton';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import { useTheme } from '@mui/material';



function ArtItemPage(props) {

  let { id } = useParams();

  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    artitem: []
  })

  const theme = useTheme();
  const { token, userData } = useAuth()

  const [reportOpen, setReportOpen] = useState(false);
  const [bookmarked, setBookmarked] = React.useState(false);


  // Report and bookmark functionality addition
  const menuContent = [
    {
      label: "Share",
      icon: <ShareIcon />,
      action: () => {
        navigator.clipboard.writeText(window.location.href);
        props.onResponse("success", "Link copied to clipboard");
      }
    },
  ]

  // Adds if the users is signed in
  if (token !== null) {
    menuContent.push(
      {
        label: "Report",
        icon: <WarningIcon />,
        action: () => { setReportOpen(true); }
      }
    );
  }

  // Handles bookmark click
  function handleBookmark() {

    fetch('/api/art_item/bookmark/' + id,
      {
        method: "POST", headers: {
          'Authorization': 'Bearer ' + token,
        }
      })
      .then(response => {
        if (response.ok) {
          setBookmarked(!bookmarked);
        } else {
          props.onResponse("error", "Couldn't complete bookmark request");
        }
      })
      .catch(error => props.onResponse("error", error));
  }

  useEffect(() => {

    const fetchArgs = {
      method: "GET",
    }

    if (token) fetchArgs.headers = { Authorization: "Bearer " + token }
    fetch('/api/art_item/' + id, fetchArgs)
      .then((response) => response.json())
      .then((data) => {
        setState({ error: null, isLoaded: true, artitem: data })

        // Check bookmark status
        if (userData) {
          data.bookmarkedByUsernames.includes(userData.accountInfo.username) ? setBookmarked(true) : setBookmarked(false);
        }
      },
        error => {
          setState({ error: error })
        }
      )
  }, [id, token])

  const { error, isLoaded, artitem } = state
  const artLikeStatus = (id) => {
    if (userData === null) {
        return false;
    }
    return userData.likedArtItemIds.includes(id);
  };



  if (error) {
    return <div>Error: {error.message}</div>
  } else if (!isLoaded) {
    return <div>Loading...</div>
  } else {
  return (
    <GenericCardLayout maxWidth={1000}>
      <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center">

        <Stack spacing={2} direction="column" justifyContent="start" alignItems="start">
          <Typography
            variant="h5"
            color={theme.palette.primary.main}
          >
            Art Item:
          </Typography>
          <Typography variant="h4">
            {artitem.name}
          </Typography>
        </Stack>

        <Stack spacing={2} direction="row" justifyContent="end" alignItems="center">
          {(token) && <IconButton data-testid="bookmarkButton" onClick={handleBookmark} color="secondary"> {bookmarked ? <BookmarkIcon data-testid="bookmarked" /> : <BookmarkBorderOutlinedIcon data-testid="notBookmarked" />}</IconButton>}
          <CustomizableDropdownMenu data-testid="menuButton" color="secondary" tooltip="More Actions" menuContent={menuContent} />
        </Stack>
      </Stack>

      <ImageDisplay imageId={artitem.imageId} />
      
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
          <AnnotatableText text={artitem.description} />
        </ Grid>
        <Grid item xs={12} sm={4}>

          <IconWithText
            icon={<BrushIcon />}
            text="Creator:"
            variant="h5"
          />
          <UserCard data={artitem.creatorAccountInfo} />

          <IconWithText
            icon={<LabelIcon />}
            text="Labels:"
            variant="h5"
          />
          {artitem.labels.join(", ")}

          <IconWithText
            icon={<CategoryIcon />}
            text="Categories:"
            variant="h5"
          />
          {artitem.category.join(", ")}
        </ Grid>
      </ Grid>
      <AuctionDisplay
        max_bid={artitem.maxBid}
        art_item_id={artitem.id}
        user_id={userData?.id}
        owner_id={artitem.ownerId}
        on_auction={artitem.onAuction}
      />
      <CommentSection
        contentId={id}
        commentList={artitem.commentList}
      />
      {reportOpen && <CopyrightReporter
        id={id}
        onResponse={() => {
          props.onResponse("success", "Report submitted");
          setReportOpen(false);
        }} />}
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