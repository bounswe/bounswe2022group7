import React from 'react';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';

import UserCard from './UserCard'
import NewComment from './NewComment'

import {useAuth} from "../auth/useAuth"

function CommentSection(props) {
  
  let commentComponents = props.commentList.map(commentData => UserCard(commentData))
  const {token} = useAuth() 
  return (
    <Box sx={{
      width: '90%',
      paddingX: 1,
      paddingY: 2,
      borderRadius: 1,
      boxShadow: 2,
    }}>
      <Typography variant="h6">
        Comment Section of id={props.id}
      </Typography>

      <Stack spacing={2}>
        {commentComponents}
        {token && <NewComment />}
        
      </Stack>
    </Box>
  );
}

export default CommentSection