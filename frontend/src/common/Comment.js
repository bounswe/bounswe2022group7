import React from 'react';

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import { CardContent, CardHeader } from '@mui/material';
import Typography from '@mui/material/Typography';

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
        />
        <CardContent>
          <Typography variant="body2" color="text.secondary">
            {commentBody}
          </Typography>
        </CardContent>
  
      </Card>
    )
  }

export default Comment