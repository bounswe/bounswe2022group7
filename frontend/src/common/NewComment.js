import React from 'react';

import Card from '@mui/material/Card';
import { CardContent } from '@mui/material';
import TextField from '@mui/material/TextField';

import {useAuth} from "../auth/useAuth"
import LoadingButton from '../components/LoadingButton';

function NewComment(props) {

  const {token} = useAuth()
  const [newCommentState, setNewCommentState] = React.useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      isLoading: false,
      text: ""
    }
  );

  if (!token) {
    return
  } else {
    const handleSubmit = (event) => {
      event.preventDefault();
      setNewCommentState({isLoading: true})
      const {contentId} = props

      fetch("/api/comment", {
        method: "POST",
        body: JSON.stringify({
          text: newCommentState.text,
          commentedObjectId: contentId 
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        }
      })
        .then(response => window.location.reload())
    }

    const handleInput = event => {
      const name = event.target.name;
      const newValue = event.target.value;
      setNewCommentState({ [name]: newValue });
    };

    return (
      <Card sx={{
        width: '%90',
        padding: 2
      }}>
        <CardContent>
          <form onSubmit={handleSubmit}>
            <TextField
              fullWidth
              id="outlined-multiline-static"
              multiline
              name="text"
              defaultValue={newCommentState.text}
              onChange={handleInput}
              rows={4}
              label="Enter Your Comment Here"
            />
            <LoadingButton
              loading={newCommentState.isLoading}
              label="Add Comment"
              loadingText="Adding Comment"
              type="submit"
              variant="contained"
              color="primary"
            />
          </form>
        </CardContent>  
      </Card>
    )
  }
}

export default NewComment