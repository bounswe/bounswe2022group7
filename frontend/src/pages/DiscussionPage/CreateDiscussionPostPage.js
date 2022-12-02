
import React from 'react'
import {useNavigate} from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";
import { TextField, Typography, Stack } from "@mui/material";
import GenericCardLayout from "../../layouts/GenericCardLayout";
import LoadingButton from '../../components/LoadingButton';

function CreateDiscussionPostForm(props) {
  const [formInput, setFormInput] = React.useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      title: "",
      textBody: "",
    }
  );
  const handleInput = event => {
    const name = event.target.name;
    const newValue = event.target.value;
    setFormInput({ [name]: newValue });
  };
  const [isLoading, setIsLoading] = React.useState(false);

  const navigate = useNavigate()
  const { token } = useAuth()
  const handleSubmit = event => {
    event.preventDefault();
    setIsLoading(true)
    
    fetch("/api/discussionPost", {
      method: "POST",
      body: JSON.stringify(formInput),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
    })
      .then(response => response.json())
      .then(data => navigate("/discussionPost/" + data.id))
  };
  
  return (
    <>
      <Typography variant="h5" component="h3">
        New Discussion Post
      </Typography>

      <form onSubmit={handleSubmit}>
        <Stack>
          <TextField
            required
            id="outlined-required"
            label="Post Title"
            name="title"
            defaultValue={formInput.title}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            required
            multiline
            minRows={2}
            maxRows={6}
            id="outlined-required"
            label="Your Post"
            name="textBody"
            defaultValue={formInput.textBody}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />

          <br/>

          <LoadingButton
            loading={isLoading}
            label="Create Discussion Post"
            loadingText="Creating Discussion Post"
            type="submit"
            variant="contained"
            color="primary"
          />
        </Stack>
      </form>
    </>
  )
}

function CreateDiscussionPostPage() {
  return (
    <GenericCardLayout maxWidth={1000}>
      <div sx={{marginX: 50}}>
        <CreateDiscussionPostForm/>
      </div>
    </GenericCardLayout>
  )
}
  
export default CreateDiscussionPostPage