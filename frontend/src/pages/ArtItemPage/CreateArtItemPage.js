import React, { useReducer } from "react";
import { useAuth } from "../../auth/useAuth";

import { TextField, Typography, Stack} from "@mui/material";
import GenericCardLayout from "../../layouts/GenericCardLayout";
import ImageUploader from '../../components/ImageUploader';
import LoadingButton from '../../components/LoadingButton';

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
    const [isLoading, setIsLoading] = React.useState(false);
  
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
      setIsLoading(true)
      
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
          <Stack>
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
  
            <br/>

            <LoadingButton
              loading={isLoading}
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
    <GenericCardLayout maxWidth={750}>
      <div sx={{marginX: 50}}>
        <CreateArtItemForm/>
      </div>
    </GenericCardLayout>
  )
}

export default CreateArtItemPage