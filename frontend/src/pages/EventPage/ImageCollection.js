// ImagePreview for showing the images under an online event.
import ImageDisplay from "../../components/ImageDisplay";
import { Grid } from '@mui/material';
import IconWithText from "../../components/IconWithText"
import { Link } from "react-router-dom";

function ImageCollection(props) {
  const {artItemList} = props
  return (
    <div>
      <IconWithText
        text={"Art Item Collection (" + artItemList.length + ")"}
        variant="h5"
      />
      <br/>
      <Grid container spacing={2}>
        {artItemList.map(artItem => 
          <Grid item xs={12} sm={4}>
            <Link to={"/artitem/" + artItem.id} style={{ textDecoration: 'none', color: "black" }}>
              <ImageDisplay imageId={artItem.imageId}/>
              <div style={{"text-align":"center"}}>{artItem.name}</div>
            </Link>
          </Grid>
        )}
      </Grid> 
    </div>
  )
}

export default ImageCollection