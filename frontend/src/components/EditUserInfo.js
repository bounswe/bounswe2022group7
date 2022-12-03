import React from "react";
import { useNavigate } from 'react-router-dom';
import { useFormik } from 'formik';
import { useAuth } from "../auth/useAuth";
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


export default function EditUserInfo({ existingUser, name, surname, dateOfBirth, country, image, buttonLabel, formDescription, formName }) {

    const [isLoading, setLoading] = React.useState(false);
    const [error, setError] = React.useState(null);
    const [selectedImage, setSelectedImage] = React.useState(image);
    const [selectedCountry, setSelectedCountry] = React.useState(country);
    const [selectedDateOfBirth, setSelecteddateOfBirth] = React.useState(dateOfBirth);

    const navigate = useNavigate();

    const { token } = useAuth();

    React.useEffect(() => {
        setSelecteddateOfBirth(dateOfBirth);
    }, [dateOfBirth])

    React.useEffect(() => {
        setSelectedImage(image);
    }, [image])

    React.useEffect(() => {
        setSelectedCountry(country);
    }, [country])

    // Validation
    const formik = useFormik({
        initialValues: {
            name: name,
            surname: surname,
        },
        validationSchema: validationSchema,
        validateOnChange: true,
        onSubmit: (values) => {

            headerTemplate = {
                'Authorization': 'Bearer ' + token,
                "Content-Type": "application/json",
            }

            setLoading(true);
            setError(null);


            fetch("/api/image",
                {
                    method: "POST",
                    body: JSON.stringify({ base64String: selectedImage }),
                    headers: headerTemplate,
                })
                .then((response) => response.json())
                .then((data) => {
                    if (json.error) {
                        setError(data.message);
                    }
                    else {
                        const requestBody = {
                            name: values.name,
                            surname: values.surname,
                            country: selectedCountry,
                            dateOfBirth: selectedDateOfBirth,
                            profilePictureId: data.id,
                        }

                        fetch('/api/profile/settings', {
                            method: 'POST',
                            headers: headerTemplate,
                            body: JSON.stringify(requestBody),
                        })
                            .then((response) => response.json())
                            .then((json) => {
                                setLoading(false);
                                if (json.error) {
                                    setError(data.message);
                                }
                                else {
                                    if (existingUser) {
                                        navigate('/profile');
                                    } else {
                                        navigate('/');
                                    }
                                }
                            })
                            .catch((error) => {
                                setLoading(false);
                                setError(error);
                            });
                    }
                })
                .catch((error) => {
                    setLoading(false);
                    setError(error);
                }
                );
        },
        enableReinitialize: true,
    });


    return (
        <div>
            <form onSubmit={formik.handleSubmit}>
                <Grid container spacing={2} alignItems="center" justifyContent="center" sx={{ width: "100%" }}>

                    <Grid item xs={12}>
                        <Typography variant="h5" component="h3">
                            {formName}
                        </Typography>
                        <Typography component="p">{formDescription}</Typography>
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
                        <CountrySelect name="country" width="100%" value={selectedCountry} onChange={setSelectedCountry} />
                    </Grid>
                    <Grid item xs={12}>
                        <CustomOutlinedInput placeholder="BirthDate" type="date" fullWidth name="dateOfBirth" label="Birth Date" value={selectedDateOfBirth} onChange={setSelecteddateOfBirth} />
                    </Grid>
                    <Grid item xs={12}>
                        <Stack direction="row" justifyContent="end">
                            {!(isLoading || existingUser) ? <Button disabled={isLoading} size="large" variant="text" sx={{ color: 'black' }} onClick={() => { navigate('/') }}>Skip</Button> : null}
                            <LoadingButton loading={isLoading} type="submit" size="large" variant="text" sx={{ ml: 2 }} label={buttonLabel} loadingText="saving" />
                        </Stack>

                    </Grid>

                </Grid>
            </form>
        </div >
    );

}

EditUserInfo.defaultProps = {
    existingUser: false,
    formName: "Edit User Info",
    formDescription: "Please fill in the form below to continue",
    name: "",
    surname: "",
    dateOfBirth: null,
    buttonLabel: "Continue",
    image: null,
    country: null,
}