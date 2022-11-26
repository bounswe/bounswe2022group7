import React from 'react';

import {Stack, Typography, Paper} from '@mui/material';

import UserCard from './UserCard'
import NewComment from './NewComment'

import {useAuth} from "../auth/useAuth"

function CommentSection(props) {
  
  let commentComponents = props.commentList.map(commentData => UserCard(commentData))
  const {token} = useAuth() 
  return (
    <Paper style={{
      width: '98%',
      marginTop: 5,
      marginLeft: "1%"
    }}>
      <Typography variant="h6">
        Comment Section of id={props.id}
      </Typography>

      <Stack spacing={2}>
        {commentComponents}
        {token && <NewComment />}
        
      </Stack>
    </Paper>
  );
}

export default CommentSection