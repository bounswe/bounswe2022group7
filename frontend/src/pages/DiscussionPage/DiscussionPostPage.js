import React, {useEffect, useState} from 'react'
import { Typography, useTheme } from "@mui/material";
import {useParams} from "react-router-dom";
import UserCard from "../../common/UserCard"
import AnnotatableText from "../../components/AnnotatableText"
import GenericCardLayout from '../../layouts/GenericCardLayout';
import CommentSection from '../../common/CommentSection';
import {DiscussionPostVote} from '../../components/DiscussionPostPreview';
import { useAuth } from "../../auth/useAuth"

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

  const { userData } = useAuth();

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
          <AnnotatableText id={id} contentType={'d'}>{state.discussionPost.textBody}</AnnotatableText>
        </Typography>
        <DiscussionPostVote content= {{
          id: state.discussionPost.id,
          voteStatus: userData && (state.discussionPost.upVotedUsernames.includes(userData.accountInfo.username) ? 1 : state.discussionPost.downVotedUsernames.includes(userData.accountInfo.username) ? -1 : 0),
          voteCount: state.discussionPost.upVotedUsernames.length - state.discussionPost.downVotedUsernames.length,
          commentCount: state.discussionPost.commentList.length,
        }}/>
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