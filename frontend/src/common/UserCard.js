import React, { useState } from "react";
import {useNavigate} from 'react-router-dom';
import { useAuth } from "../auth/useAuth";

import { CardHeader, CardContent, Card, Avatar, IconButton, Typography, MenuItem, Menu } from '@mui/material';
import MoreVertIcon from '@mui/icons-material/MoreVert';

import CardActions from '@mui/material/CardActions';
import StarIcon from '@mui/icons-material/Star';
import StarOutlineIcon from '@mui/icons-material/StarOutline';

function UserCard(props) {

  let { userData, body, date } = props

  const { token } = useAuth()

  // HANDLING FOLLOW/LIKE FUNCTIONALITIES

  const [starState, setStarState] = useState({
      stared: false, // TOOD: fetch the initial state of the comment from the api
    });

  const handleCommentLike = event => {
    setStarState({stared: ! starState.stared})
    // TODO: send an api request saving the like/dislike
  }

  const handleUserFollow = event => {
    console.log(starState)
    setStarState({stared: ! starState.stared})
    // TODO: send an api request saving the follow/unfollow
  }

  // HANDLING MENU FUNCTIONALITY

  const [anchorElUser, setAnchorElUser] = React.useState(null);
  const handleOpenUserMenu = (event) => {setAnchorElUser(event.currentTarget)};
  const handleCloseUserMenu = () => {setAnchorElUser(null)};

  const navigate = useNavigate()

  // RENDER

  return (
    <div>
      <Card sx={{
        width: '%90',
        padding: 2
      }}>
        <CardHeader 
          avatar = {
            <Avatar sx={{ bgcolor: 'secondary.main' }} aria-label="user">
              {userData.level}
            </Avatar>
          }
          title={userData.name}
          subheader={date}
          action={
            <IconButton onClick={handleOpenUserMenu} aria-label="settings">
              <MoreVertIcon />
            </IconButton>
          }
        />

        <Menu
          sx={{ mt: '45px' }}
          id="menu-appbar"
          anchorEl={anchorElUser}
          anchorOrigin={{
            vertical: 'top',
            horizontal: 'right',
          }}
          keepMounted
          transformOrigin={{
            vertical: 'top',
            horizontal: 'right',
          }}
          open={Boolean(anchorElUser)}
          onClose={handleCloseUserMenu}
        >
          <MenuItem key='See Profile' onClick={() => {navigate("/user/" + userData.user_id)}}>
            <Typography textAlign="center">See Profile</Typography>
          </MenuItem>          
        </Menu>

        {body && // if commentData is provided as parameter, render it.
          <CardContent>
            <Typography variant="body2" color="text.secondary">
              {body}
            </Typography>
          </CardContent>
        }

        {token && // if logged_in_user, render below 
          <CardActions disableSpacing>
            <IconButton onClick={body ? handleCommentLike : handleUserFollow} aria-label="add to favorites">
              {starState.stared ? <StarIcon /> : <StarOutlineIcon />}
            </IconButton>
            {body ? "Like Comment" : "Follow User"}
          </CardActions>
        }
      </Card>
    </div>
  )
}

export default UserCard