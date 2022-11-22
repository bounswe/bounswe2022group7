import React from "react";
import { useNavigate } from 'react-router-dom';
import { useFormik } from 'formik';
import * as yup from 'yup';

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Avatar from '@mui/material/Avatar';
import Button from "@mui/material/Button";
import InputLabel from "@mui/material/InputLabel";
import TextField from "@mui/material/TextField";
import Typography from "@mui/material/Typography";
import Grid from "@mui/material/Grid";
import Stack from '@mui/material/Stack';

import ImageUploader from './ImageUploader';
import CustomOutlinedInput from './CustomOutlinedInput';
import CountrySelect from './CountrySelect';
import LoadingButton from "./LoadingButton";

const validationSchema = yup.object({
    name: yup
        .string('Enter your name')
        .matches(/^[a-zA-Z]+$/, 'Must be only letters'),

    surname: yup
        .string('Enter your surname')
        .matches(/^[a-zA-Z]+$/, 'Must be only letters'),
});


export default function EditUserInfo(props) {
    const [isLoading, setLoading] = React.useState(false);
    const [error, setError] = React.useState(null);
    const [selectedImage, setSelectedImage] = React.useState(null);
    const [selectedCountry, setSelectedCountry] = React.useState(null);
    const [selecteddateOfBirth, setSelecteddateOfBirth] = React.useState(null);

    const navigate = useNavigate();

    if (props.existingUser) {
        //TODO: Fetch user info from backend
    }

    // Validation
    const formik = useFormik({
        initialValues: {
            name: '',
            surname: '',
        },
        validationSchema: validationSchema,
        validateOnChange: true,
        onSubmit: (values) => {

            const data = {
                name: values.name,
                surname: values.surname,
                country: selectedCountry,
                dateOfBirth: selecteddateOfBirth,
                image: selectedImage,
            }

            setLoading(true);

            // Endpoint is not implemented yet
            console.log(data);


            // setError("message");
        },
    });

    return (
        <div>
            <form onSubmit={formik.handleSubmit}>
                <Grid container spacing={2} alignItems="center" justifyContent="center" sx={{ width: "100%" }}>

                    <Grid item xs={12}>
                        <Typography variant="h5" component="h3">
                            {props.formName}
                        </Typography>
                        <Typography component="p">{props.formDescription}</Typography>
                    </Grid>

                    <Grid item xs={12}>
                        {error && <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error updating user info</AlertTitle>{error}</Alert>}
                    </Grid>

                    <Grid item xs={12}>
                        <ImageUploader label="Upload profile photo" imgComponent={<Avatar sx={{ width: 96, height: 96 }} src={selectedImage} alt="username" />} value={selectedImage} onChange={setSelectedImage} />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <InputLabel>Name</InputLabel>
                        <TextField
                            id="outlined-required"
                            name="name"
                            placeholder='Name'
                            value={formik.values.name}
                            onChange={formik.handleChange}
                            error={formik.touched.name && Boolean(formik.errors.name)}
                            helperText={formik.touched.name && formik.errors.name}
                            fullWidth
                        />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <InputLabel>Surname</InputLabel>
                        <TextField
                            id="outlined-required"
                            placeholder="Surname"
                            name="surname"
                            value={formik.values.surname}
                            onChange={formik.handleChange}
                            error={formik.touched.surname && Boolean(formik.errors.surname)}
                            helperText={formik.touched.surname && formik.errors.surname}
                            fullWidth
                        />
                    </Grid>
                    <Grid item xs={12}>
                        <InputLabel>Country</InputLabel>
                        <CountrySelect name="country" width="100%" onChange={setSelectedCountry} />
                    </Grid>
                    <Grid item xs={12}>
                        <CustomOutlinedInput placeholder="BirthDate" type="date" fullWidth name="dateOfBirth" label="Birth Date" value={selecteddateOfBirth} onChange={setSelecteddateOfBirth} />
                    </Grid>
                    <Grid item xs={12}>
                        <Stack direction="row" justifyContent="end">
                            { !(isLoading || props.existingUser) ? <Button disabled={isLoading} size="large" variant="text" sx={{ color: 'black' }} onClick={() => { navigate('/') }}>Skip</Button> : null }
                            <LoadingButton loading={isLoading} type="submit" size="large" variant="text" sx={{ ml: 2 }} label="continue" loadingText="saving" />
                        </Stack>

                    </Grid>

                </Grid>
            </form>
        </div >
    );
}


