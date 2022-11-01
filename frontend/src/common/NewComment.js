import React from 'react';

import Card from '@mui/material/Card';
import { CardContent } from '@mui/material';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';

function NewComment() {
  return (
    <Card sx={{
      width: '%90',
      padding: 2
    }}>
      <CardContent>
        <TextField
          fullWidth
          id="outlined-multiline-static"
          multiline
          rows={4}
          label="Enter Your Comment Here"
        />
        <Button variant="contained">Send Comment</Button>
      </CardContent>  
    </Card>
  )
}

export default NewComment