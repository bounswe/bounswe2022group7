import React from "react";
import { useAuth } from "../auth/useAuth";
import InteractiveIcon from  "./InteractiveIcon"

import ThumbUpIcon from '@mui/icons-material/ThumbUp';
import ThumbUpOutlinedIcon from '@mui/icons-material/ThumbUpOutlined';
import ThumbDownIcon from '@mui/icons-material/ThumbDown';
import ThumbDownOutlinedIcon from '@mui/icons-material/ThumbDownOutlined';

function CommentVote(props) {
  const {upVotedUsernames, downVotedUsernames, commentId} = props;

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
  console.log(initialState, state)
  

  const upVoteStateIconMap = (state) => {
    if (state.voteStatus == 1) {      
      return <ThumbUpIcon/>
    }
    return <ThumbUpOutlinedIcon/>
  }

  const downVoteStateIconMap = (state) => {
    if (state.voteStatus == -1) {
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

  // could have written on upvote and on downvote
  // functions as one function. Not doing it for
  // the sake of readability.
  const onUpVoteClick = (e) => {
    makeVoteRequest(1)
    if (state.voteStatus == -1) {
      setState({
        voteStatus:1,
        upVoteCount:state.upVoteCount+1,
        downVoteCount:state.downVoteCount-1,
      })
    } else if (state.voteStatus == 0) {
      setState({
        voteStatus:1,
        upVoteCount:state.upVoteCount+1,
        downVoteCount:state.downVoteCount,
      })
    } else { // status == 1
      setState({
        voteStatus:0,
        upVoteCount:state.upVoteCount-1,
        downVoteCount:state.downVoteCount,
      })
    }
  }

  const onDownVoteClick = (e) => {
    makeVoteRequest(-1)
    if (state.voteStatus == -1) {
      setState({
        voteStatus:0,
        upVoteCount:state.upVoteCount,
        downVoteCount:state.downVoteCount-1,
      })
    } else if (state.voteStatus == 0) {
      setState({
        voteStatus:-1,
        upVoteCount:state.upVoteCount,
        downVoteCount:state.downVoteCount+1,
      })
    } else { // status == 1
      setState({
        voteStatus:-1,
        upVoteCount:state.upVoteCount-1,
        downVoteCount:state.downVoteCount+1,
      })
    }

  }

  return (
    <div>
      <InteractiveIcon
        state = {state}
        onClick = {onUpVoteClick}
        stateToIconMap = {upVoteStateIconMap}
        text = {state?.upVoteCount}
        clickDisabled = {userData == null}
      />
      <InteractiveIcon
        state = {state}
        onClick = {onDownVoteClick}
        stateToIconMap = {downVoteStateIconMap}
        text = {state?.downVoteCount}
        clickDisabled = {userData == null}
      />
    </div>
  )
}

export default CommentVote;