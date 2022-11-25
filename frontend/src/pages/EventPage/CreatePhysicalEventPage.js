import React, { useReducer } from "react";
import { useAuth } from "../../auth/useAuth";

import {TextField, Typography, Stack} from "@mui/material";
import ContentLayout from "../../layouts/ContentLayout";
import ImageUploader from '../../components/ImageUploader';
import LoadingButton from '../../components/LoadingButton';
import MapSelectComponent from "../../components/MapSelectComponent"

function CreatePhysicalEventForm() {

  const [formInput, setFormInput] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      title: "",
      description: "",
      category: "",
      eventPrice: "",
      labels: "",
      rules: "",
      address: ""
    }
  );
  const [selectedImage, setSelectedImage] = React.useState(null);
  const [position, setPosition] = React.useState({lat: 41, lng: 29});

  const formatFormInput = (posterId) => {
    return {
      eventInfo: {
        title: formInput.title,
        description: formInput.description,
        category: formInput.category,
        eventPrice: formInput.eventPrice,
        labels: formInput.labels,
        posterId: posterId
      },
      location: {
        latitude: position.lat,
        longitude: position.lng,
        address: formInput.address
      },
      rules: formInput.rules
    }
  }

  const { postRequestWithImage } = useAuth()

  const handleSubmit = event => {
    event.preventDefault();
    
    postRequestWithImage(
      "/api/event/physical",
      selectedImage,
      formatFormInput,
      (data) => "/event/"+data.id
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
        New Physical Event
      </Typography>

      <form onSubmit={handleSubmit}>
        <Stack sx={{padding: 2}}>
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
            id="outlined-required"
            label="Description"
            name="description"
            defaultValue={formInput.description}
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
            label="Event Price"
            name="eventPrice"
            defaultValue={formInput.eventPrice}
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
            required
            id="outlined-required"
            label="Rules"
            name="rules"
            defaultValue={formInput.rules}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />
          <TextField
            required
            id="outlined-required"
            label="Address"
            name="address"
            defaultValue={formInput.address}
            onChange={handleInput}
            sx = {{marginY: 1}}
          />

          <MapSelectComponent
            position = {position}
            setPosition = {setPosition}
          />

          <ImageUploader 
            label="Select Event Poster"
            value={selectedImage}
            onChange={setSelectedImage}
            width="100%"
          />

          <LoadingButton
            loading={false}
            label="Create Event"
            loadingText="Creating Event"
            type="submit"
            variant="contained"
            color="primary"
          />

        </Stack>
      </form>
    </>
  );
}

function CreatePhysicalEventPage() {
  return (
    <ContentLayout>
      <div sx={{marginX: 50}}>
        <CreatePhysicalEventForm/>
      </div>
    </ContentLayout>
  )
}

export default CreatePhysicalEventPage