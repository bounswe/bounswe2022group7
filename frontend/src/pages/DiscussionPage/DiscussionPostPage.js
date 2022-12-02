import React, {useEffect, useState} from 'react'
import { Typography, Stack } from "@mui/material";
import { useAuth } from "../../auth/useAuth"
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

  // TODO: remove token
  const { token } = useAuth()
  useEffect(() => {

    const fetchArgs = {
      method: "GET",  
    }

    if (token) fetchArgs.headers = {Authorization: "Bearer " + token}
    fetch('/api/discussionPost/' + id, fetchArgs)
      .then((response) => response.json())
      .then((data) => {
        console.log(data)
        setState({error: null, isLoaded: true, discussionPost: data})
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

        <Stack>
          <Typography variant="h4" sx={{padding:2}}>
            {state.discussionPost.title}
          </Typography>
          <br/>

          <Typography variant="body1">
            {state.discussionPost.textBody}
          </Typography>

          <UserCard data={state.discussionPost.creatorAccountInfo} />

          <CommentSection
            contentId={id}
            commentList={state.discussionPost.commentList}
          />

        </Stack>

      </GenericCardLayout>
    )
  }
}




export default DiscussionPostPage