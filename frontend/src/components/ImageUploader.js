import Grid from "@mui/material/Grid";
import Button from "@mui/material/Button";

import PropTypes from 'prop-types';

export default function ImageUploader(props) {

    const convertBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file)
            fileReader.onload = () => {
                resolve(fileReader.result);
            }
            fileReader.onerror = (error) => {
                reject(error);
            }
        })
    }

    const handleImageSelection = async (event) => {
        const file = event.target.files[0]
        const base64 = await convertBase64(file)
        props.onChange(base64)
    }

    return (
        <Grid container spacing={0} direction="column" alignItems="center" justifyContent="center">
            <Grid item xs={12}>
                {props.imgComponent || <img width={props.width} height={props.height} src={props.value} style={{ border: 1, borderColor: 'grey' }} />}
            </Grid>
            <Grid item xs={12}>
                <input
                    accept="image/*"
                    style={{ display: 'none' }}
                    id="text-button-file"
                    multiple={props.multiple}
                    type="file"
                    onChange={e => handleImageSelection(e)}
                    hidden
                />
                <label htmlFor="text-button-file">
                    <Button variant="text" component="span" color="primary">
                        {props.label}
                    </Button>
                </label>
            </Grid>
        </Grid>
    );
}

ImageUploader.propTypes = {
    label: PropTypes.string.isRequired,
    value: PropTypes.string,
    onChange: PropTypes.func.isRequired,
    multiple: PropTypes.bool,
    imgComponent: PropTypes.element,
    width: PropTypes.number,
    height: PropTypes.number,
}