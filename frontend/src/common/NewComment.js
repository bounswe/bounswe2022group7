import React from 'react';

import Card from '@mui/material/Card';
import { CardContent } from '@mui/material';
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
          defaultValue="Enter Comment Here"
        />
      </CardContent>  
    </Card>
  )
}

export default NewComment