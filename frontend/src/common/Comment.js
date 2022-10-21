import React from 'react';

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import { CardContent, CardHeader } from '@mui/material';
import Typography from '@mui/material/Typography';

import IconButton from '@mui/material/IconButton';
import MoreVertIcon from '@mui/icons-material/MoreVert';

import CardActions from '@mui/material/CardActions';
import FavoriteIcon from '@mui/icons-material/Favorite';

function Comment(title, subheader, commentBody) {
    return (
      <Card sx={{
        width: '%90',
        padding: 2
      }}>
        
        <CardHeader 
          avatar={
            <Avatar sx={{ bgcolor: 'secondary.main' }} aria-label="user">
              G
            </Avatar>
          }
          title={title}
          subheader={subheader}
          action={
            <IconButton aria-label="settings">
              <MoreVertIcon />
            </IconButton>
          }
        />

        <CardContent>
          <Typography variant="body2" color="text.secondary">
            {commentBody}
          </Typography>
        </CardContent>

        <CardActions disableSpacing>
          <IconButton aria-label="add to favorites">
            <FavoriteIcon />
          </IconButton>
        </CardActions>

      </Card>
    )
  }

export default Comment