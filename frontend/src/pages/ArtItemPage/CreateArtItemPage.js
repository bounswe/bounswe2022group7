import React, { useReducer } from "react";
import {useNavigate} from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";

import {Button, TextField, Typography, Stack} from "@mui/material";
import ContentLayout from "../../layouts/ContentLayout";
import ImageUploader from '../../components/ImageUploader';
import LoadingButton from '../../components/LoadingButton';
import MapSelectComponent from "../../components/MapSelectComponent"

function CreateArtItemForm(props) {

    const [formInput, setFormInput] = useReducer(
      (state, newState) => ({ ...state, ...newState }),
      {
        name: "",
        description: "",
        category: "",
        labels: ""
      }
    );
    const [selectedImage, setSelectedImage] = React.useState(null);
  
    const formatFormInput = (imageId) => {
      return {
        artItemInfo: {
          name: formInput.name,
          description: formInput.description,
          category: formInput.category,
          labels: formInput.labels,
          imageId: imageId
        },
        lastPrice: 0
      }
    }
  
    const { postRequestWithImage } = useAuth()
  
    const handleSubmit = event => {
      event.preventDefault();
      
      postRequestWithImage(
        "/api/art_item",
        selectedImage,
        formatFormInput,
        (data) => "/artitem/"+data.id
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
          New Art Item
        </Typography>
  
        <form onSubmit={handleSubmit}>
          <Stack sx={{padding: 2}}>
            <TextField
              required
              id="outlined-required"
              label="Art Item Name"
              name="name"
              defaultValue={formInput.name}
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
              label="Labels"
              name="labels"
              defaultValue={formInput.labels}
              onChange={handleInput}
              sx = {{marginY: 1}}
            />
  
            <ImageUploader 
              label="Select Art Item"
              value={selectedImage}
              onChange={setSelectedImage}
              width="100%"
            />
  
            <LoadingButton
              loading={false}
              label="Create Art Item"
              loadingText="Creating Art Item"
              type="submit"
              variant="contained"
              color="primary"
            />
  
          </Stack>
        </form>
      </>
    );
  }

function CreateArtItemPage() {
  return (
    <ContentLayout>
      <div sx={{marginX: 50}}>
        <CreateArtItemForm/>
      </div>
    </ContentLayout>
  )
}

export default CreateArtItemPage