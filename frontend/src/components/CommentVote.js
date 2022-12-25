import React from "react";
import { useAuth } from "../auth/useAuth";
import InteractiveIcon from  "./InteractiveIcon"

import ThumbUpIcon from '@mui/icons-material/ThumbUp';
import ThumbUpOutlinedIcon from '@mui/icons-material/ThumbUpOutlined';
import ThumbDownIcon from '@mui/icons-material/ThumbDown';
import ThumbDownOutlinedIcon from '@mui/icons-material/ThumbDownOutlined';

function CommentVote(props) {
  const {upVotedUsernames, downVotedUsernames} = props;
  let upVoteCount = upVotedUsernames.length
  let downVoteCount = downVotedUsernames.length

  const {userData} = useAuth();
  const username = userData?.accountInfo.username

  // set state
  const [state, setState] = React.useState(0) // TODO decide on start state according to user status
  if (upVotedUsernames.includes(username)) {
    setState(1)
  } else if (downVotedUsernames.includes(username)) {
    setState(-1)
  }

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

  // const makeVoteRequest

  const onUpVoteClick = (e) => {
    console.log("clicked")
    if (state == 1) {
      upVoteCount -= 1
      setState(0)
    } else {
      upVoteCount += 1
      setState(1)
    }
  }

  const onDownVoteClick = (e) => {
    if (state == -1) {
      downVoteCount -= 1
      setState(0)
    } else {
      downVoteCount += 1
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