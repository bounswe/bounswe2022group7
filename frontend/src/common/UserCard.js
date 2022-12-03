import React from "react";
import {Link} from 'react-router-dom';

import { Grid, Avatar } from '@mui/material';
import UserAvatar from "../components/UserAvatar";

function UserCard(props) {

  let { authorAccountInfo, creatorAccountInfo, text, creationDate } = props.data
  if (!authorAccountInfo & !creatorAccountInfo) { //this is not a comment. It's a user card
    authorAccountInfo = props.data
  }
  else if (!authorAccountInfo) {
    authorAccountInfo = creatorAccountInfo
  }

  // HANDLING FOLLOW/LIKE FUNCTIONALITIES
  // NOT POSSIBLE TO HANDLE WITH THE CURRENT ENDPOINTS

  /*
   * Possible state values and meanings:
   * - dontShow: DEFAULT user not logged in. Don't show anything
   * - show: user logged in but hasn't clicked anything
   * - liked: user has liked
   * - disliked: user has disliked
  const [likeState, setLikeState] = useState("dontShow");


  const handleCommentLike = event => {
    setStarState({stared: ! starState.stared})
    // TODO: send an api request saving the like/dislike
  }
  */

  if (creationDate) {
    creationDate = new Date(creationDate)
    creationDate = creationDate.toLocaleString()
  }

  // RENDER

  return (
    <Grid container wrap="nowrap" spacing={2}>
      <Grid item>
        {/* <Avatar alt="User Profile" src={authorAccountInfo.profilePictureId} /> */}
        <UserAvatar id={authorAccountInfo.profilePictureId} />
      </Grid>
      <Grid justifyContent="left" item xs zeroMinWidth>
        <h4 style={{ margin: 0, textAlign: "left" }}>
          <Link  
            to={"/profile/" + authorAccountInfo.username}
            style={{ color: 'inherit', textDecoration: 'inherit'}}
          >
            {authorAccountInfo.username}
          </Link >
        </h4>
        <p style={{ textAlign: "left" }}>
          {text}
        </p>
        <p style={{ textAlign: "left", color: "gray" }}>
          {creationDate}
        </p>

      </Grid>
    </Grid>
  )
}

export default UserCard