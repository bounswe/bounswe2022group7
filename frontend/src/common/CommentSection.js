import React from 'react';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';

import Comment from './Comment'
import NewComment from './NewComment'

function CommentSection() {
  
  // Mock data
  const comments = [
    "Comment 1 resides here",
    "Comment 2 resides here",
    "Comment 3 resides here"
  ]
  let commentComponents = comments.map(commentStr => Comment("Comment Title", "September 18, 2022", commentStr))

  return (
    <Box sx={{
      width: '90%',
      paddingX: 1,
      paddingY: 2,
      borderRadius: 1,
      boxShadow: 2,
    }}>
      <Typography variant="h6">
        Comment Section
      </Typography>

      <Stack spacing={2}>
        {commentComponents}
        <NewComment />
      </Stack>
    </Box>
  );
}

export default CommentSection