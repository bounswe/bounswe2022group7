import React, { useReducer } from "react";
import { useAuth } from "../../auth/useAuth";

import {TextField, Typography, Stack, Grid, OutlinedInput} from "@mui/material";
import MenuItem from '@mui/material/MenuItem';
import Select from '@mui/material/Select';

import GenericCardLayout from "../../layouts/GenericCardLayout";
import ImageUploader from '../../components/ImageUploader';
import LoadingButton from '../../components/LoadingButton';
import MapSelectComponent from "../../components/MapSelectComponent"
import postRequestWithImage from "../../common/postRequestWithImage"

function CreatePhysicalEventForm() {

  const [formInput, setFormInput] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      title: "",
      description: "",
      category: [],
      eventPrice: 0,
      labels: [],
      startTime: null,
      endTime: null,
      collaborators: "",
      artItemIds: []
    }
  );
  const [selectedImage, setSelectedImage] = React.useState(null);
  const [isLoading, setIsLoading] = React.useState(false);

  const formatFormInput = (posterId) => {
    return {
      eventInfo: {
        title: formInput.title,
        startingDate: formInput.startTime,
        endingDate: formInput.endTime,
        description: formInput.description,
        category: [formInput.category],
        eventPrice: formInput.eventPrice,
        labels: [formInput.labels],
        posterId: posterId
      },
      artItemIds: formInput.artItemIds,
      collaboratorUsernames: formInput.collaborators.split(",")
    }
  }

  const { token, userData } = useAuth()

  const handleSubmit = event => {
    event.preventDefault();
    setIsLoading(true)
    
    postRequestWithImage(
      "/api/event/online",
      selectedImage,
      formatFormInput,
      (data) => "/event/"+data.id,
      token
    )
  };
  
  const handleInput = event => {
    const name = event.target.name;
    const newValue = event.target.value;
    setFormInput({ [name]: newValue });
  };

  return (
    <>
      <Typography variant="h5" component="h3">
        New Online Event
      </Typography>

      <form onSubmit={handleSubmit}>
        <Stack>
          <TextField
            required
            id="outlined-required"
            label="Event Title"
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
            label="Description"
            name="description"
            defaultValue={formInput.description}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            id="outlined"
            label="Collaborators"
            name="collaborators"
            defaultValue={formInput.collaborators}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            required
            id="outlined-required"
            label="Category"
            name="category"
            defaultValue={formInput.category}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            required
            id="outlined-required"
            label="Labels"
            name="labels"
            defaultValue={formInput.labels}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            type="number"
            id="outlined"
            label="Event Price"
            name="eventPrice"
            defaultValue={formInput.eventPrice}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />

          <br/>

          <Typography variant="h6" component="h3">
            Start & End Time
          </Typography>

          <Grid container spacing={2} alignItems="center" justifyContent="center" sx={{ width: "100%" }}>

            <Grid item xs={12} sm={6}>
              Start Time
              <OutlinedInput
                required
                label="Start Time"
                type="datetime-local"
                name="startTime"
                onChange={handleInput}
                renderInput={(params) => <TextField {...params} />}
                style={{width: "100%"}}
              />
            </Grid>

            <Grid item xs={12} sm={6}>
              End Time
              <OutlinedInput
                required
                label="End Time"
                type="datetime-local"
                name="endTime"
                onChange={handleInput}
                renderInput={(params) => <TextField {...params} />}
                style={{width: "100%"}}
              />
            </Grid>

          </Grid>

          <br/>

          <Typography variant="h6" component="h3">
            Art Items
          </Typography>

          <Select
            multiple
            label="Art Items"
            name="artItemIds"
            value={formInput.artItemIds}
            onChange={handleInput} 
          >
            {userData?.artItems.map((artItem) =>
              <MenuItem
                key={artItem.id}
                value={artItem.id}
              >
                {artItem.name}
              </MenuItem>
            )

            }
          </Select>

          <br/>

          <Typography variant="h6" component="h3">
            Poster
          </Typography>

          <ImageUploader 
            label="Select Event Poster"
            value={selectedImage}
            onChange={setSelectedImage}
            width="100%"
          />

          <br/>

          <LoadingButton
            loading={isLoading}
            label="Create Event"
            loadingText="Creating Event"
            type="submit"
            variant="contained"
            color="primary"
            disabled={selectedImage == null}
          />

        </Stack>
      </form>
    </>
  );
}

function CreatePhysicalEventPage() {
  return (
    <GenericCardLayout maxWidth={750}>
      <div sx={{marginX: 50}}>
        <CreatePhysicalEventForm/>
      </div>
    </GenericCardLayout>
  )
}

export default CreatePhysicalEventPage