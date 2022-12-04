import React, {useEffect, useState} from 'react'
import { Typography, useTheme } from "@mui/material";
import {useParams} from "react-router-dom";
import UserCard from "../../common/UserCard"
import GenericCardLayout from '../../layouts/GenericCardLayout';
import CommentSection from '../../common/CommentSection';

function DiscussionPostPage() {

  let { id } = useParams();
  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    discussionPost: [] 
  })

  const theme = useTheme()

  useEffect(() => {

    fetch('/api/discussionPost/' + id, {
      method: "GET",  
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data)
        setState({error: null, isLoaded: true, discussionPost: data})
      },
        error => {
          setState({error: error})
        }
      )
  }, [id])

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
          Discussion Post:
        </Typography>
        <Typography variant="h4">
          {state.discussionPost.title}
        </Typography>
        <br/>

        <Typography variant="body1">
          {state.discussionPost.textBody}
        </Typography>

        <br/>

        <UserCard data={state.discussionPost} />

        <CommentSection
          contentId={id}
          commentList={state.discussionPost.commentList}
        />


      </GenericCardLayout>
    )
  }
}




export default DiscussionPostPage