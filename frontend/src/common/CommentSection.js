import React from 'react';

import {Stack, Typography, Paper} from '@mui/material';

import UserCard from './UserCard'
import NewComment from './NewComment'

function CommentSection(props) {
  
  let commentComponents = props.commentList.map(comment => <UserCard data={comment} key={comment.id}></UserCard>)
  
  return (
    <Paper style={{
      width: '98%',
      marginTop: 5,
      marginLeft: "1%"
    }}>
      <Typography variant="h6">
        Comment Section
      </Typography>

      <Stack spacing={2}>
        {commentComponents}
        <NewComment contentId={props.contentId}/>
        
      </Stack>
    </Paper>
  );
}

export default CommentSection