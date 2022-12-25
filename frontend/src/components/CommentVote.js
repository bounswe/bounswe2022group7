import React from "react";
import { useAuth } from "../auth/useAuth";
import InteractiveIcon from  "./InteractiveIcon"

import ThumbUpIcon from '@mui/icons-material/ThumbUp';
import ThumbUpOutlinedIcon from '@mui/icons-material/ThumbUpOutlined';
import ThumbDownIcon from '@mui/icons-material/ThumbDown';
import ThumbDownOutlinedIcon from '@mui/icons-material/ThumbDownOutlined';

function CommentVote(props) {
  const {upVotedUsernames, downVotedUsernames, commentId} = props;
  let upVoteCount = upVotedUsernames.length
  let downVoteCount = downVotedUsernames.length

  const {userData, token} = useAuth();
  const username = userData?.accountInfo.username

  // set state
  let initialState = 0
  if (upVotedUsernames.includes(username)) {
    initialState = 1
  } else if (downVotedUsernames.includes(username)) {
    initialState = -1
  }
  const [state, setState] = React.useState(null) // TODO decide on start state according to user status
  React.useEffect(() => { setState({
    voteStatus: initialState,
    upVoteCount: upVotedUsernames.length,
    downVoteCount: downVotedUsernames.length
  })}, [initialState] )
  console.log(initialState, state, upVoteCount, downVoteCount)
  

  const upVoteStateIconMap = (state) => {
    if (state == 1) {      
      return <ThumbUpIcon/>
    }
    return <ThumbUpOutlinedIcon/>
  }

  const downVoteStateIconMap = (state) => {
    if (state == -1) {
      return <ThumbDownIcon/>  
    }
    return <ThumbDownOutlinedIcon/>
  }

  /*
  On click functions
  */

  const makeVoteRequest = (vote) => {
    fetch("/api/comment/vote", {
      method: "POST",
      body: JSON.stringify({id: commentId, vote: vote}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
    })
  }

  const onUpVoteClick = (e) => {
    if (state == 1) {
      upVoteCount -= 1
      makeVoteRequest(1)
      setState(0)
    } else {
      upVoteCount += 1
      makeVoteRequest(1)
      setState(1)
    }
  }

  const onDownVoteClick = (e) => {
    if (state == -1) {
      downVoteCount -= 1
      makeVoteRequest(1)
      setState(0)
    } else {
      downVoteCount += 1
      makeVoteRequest(-1)
      setState(-1)
    }

  }

  return (
    <div>
      <InteractiveIcon
        state = {state}
        onClick = {onUpVoteClick}
        stateToIconMap = {upVoteStateIconMap}
        text = {"Number of upvotes: " + upVoteCount}
        clickDisabled = {userData == null}
      />
      <InteractiveIcon
        state = {state}
        onClick = {onDownVoteClick}
        stateToIconMap = {downVoteStateIconMap}
        text = {"Number of downvotes:" + downVoteCount}
        clickDisabled = {userData == null}
      />
    </div>
  )
}

export default CommentVote;