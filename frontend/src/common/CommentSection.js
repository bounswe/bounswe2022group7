import React from 'react';

import {Divider, Typography, Paper} from '@mui/material';

import UserCard from './UserCard'
import NewComment from './NewComment'

function CommentSection(props) {
  
  let commentComponents = props.commentList.map(
    comment => (
    <>
      <UserCard
        data={comment}
        key={comment.id}
      />
      <Divider variant="fullWidth" style={{ margin: "30px 0" }} />
    </>))
  
  return (
    <Paper style={{ padding: "10px 20px", marginTop: 10 }}>
      <Typography variant="h6" style={{marginBottom: 20}}>
        Comment Section ({commentComponents.length})
      </Typography>

      {commentComponents}
      <NewComment contentId={props.contentId}/>        
    </Paper>
  );
}

export default CommentSection