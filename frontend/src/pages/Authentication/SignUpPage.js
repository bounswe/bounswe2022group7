import React from "react";
import { useNavigate } from 'react-router-dom';

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Box from '@mui/material/Box';
import Button from "@mui/material/Button";
import CircularProgress from '@mui/material/CircularProgress';
import TextField from "@mui/material/TextField";
import Paper from "@mui/material/Paper";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import InputLabel from '@mui/material/InputLabel';
import { useFormik } from 'formik';
import * as yup from 'yup';
import FormLayout from "../../layouts/FormLayout";

const validationSchema = yup.object({
  email: yup
    .string('Enter your email')
    .email('Enter a valid email')
    .required('Email is required'),

  password: yup
    .string('Enter your password')
    // .min(8, 'Password should be of minimum 8 characters length')
    .required('Password is required'),

  username: yup
    .string('Enter your username')
    .min(3, 'Username should be of minimum 3 characters length')
    .required('Username is required')
    .matches(/^[a-zA-Z0-9]+$/, 'Username should only contain letters and numbers'),

  name: yup
    .string('Enter your name')
    .required('Name is required'),

  surname: yup
    .string('Enter your surname')
    .required('Surname is required'),

  country: yup
    .string('Enter your country')
    .required('Country is required'),
  age: yup
    .number('Enter your age')
    .positive('Age must be positive')
    .integer('Age must be an integer')
    .max(125, 'Age must be less than 125')
    .required('Age is required'),

  userType: yup
    .string("Please select an user type.")
    .required('User type is required')
});

function SignUpForm(props) {

  const [isLoading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();


  // Validation
  const formik = useFormik({
    initialValues: {
      email: "",
      password: "",
      username: "",
      name: "",
      surname: "",
      country: "",
      age: undefined,
      userType: "",
    },
    validationSchema: validationSchema,
    onSubmit: (values) => {
      setLoading(true);
      setError(null);

      // Here is how we will make a POST request in the backend.
      // This section is left out since the backend is not ready
      // yet.
      fetch("/api/signup", {
        method: "POST",
        body: JSON.stringify(values),
        headers: {
          "Content-Type": "application/json"
        }
      })
        .then((response) => {
          if (response.ok) {
            return response.text();
          } else {
            throw new Error('Something went wrong.');
          }
        })
        .then((responseText) => {
          setLoading(false);
          if (responseText === "true") {
            navigate(
              "/auth/signin",
              {
                state: { redirect: true, email: values.email }
              });

          } else {
            formik.setFieldValue("password", "");
            setError("An error occured");
          }
        })
        .catch((error) => {
          setLoading(false);
          setError(error.message);
        });
    },
  });

  return (
    <div>
        <Typography variant="h5" component="h3">
          {props.formName}
        </Typography>
        <Typography component="p">{props.formDescription}</Typography>

        <form onSubmit={formik.handleSubmit}>
          <Stack sx={{ padding: 2 }}>
            {error ? <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error signing up</AlertTitle>{error}</Alert> : null}

            <TextField
              id="outlined-required"
              label="Username"
              name="username"
              value={formik.values.username}
              onChange={formik.handleChange}
              error={formik.touched.username && Boolean(formik.errors.username)}
              helperText={formik.touched.username && formik.errors.username}
              sx={{ marginY: 1 }}
            />
            <TextField
              id="outlined-required"
              label="Name"
              name="name"
              value={formik.values.name}
              onChange={formik.handleChange}
              error={formik.touched.name && Boolean(formik.errors.name)}
              helperText={formik.touched.name && formik.errors.name}
              sx={{ marginY: 1 }}
            />
            <TextField
              id="outlined-required"
              label="Surname"
              name="surname"
              value={formik.values.surname}
              onChange={formik.handleChange}
              error={formik.touched.surname && Boolean(formik.errors.surname)}
              helperText={formik.touched.surname && formik.errors.surname}
              sx={{ marginY: 1 }}
            />
            <TextField
              id="outlined-required"
              label="Age"
              name="age"
              value={formik.values.age}
              onChange={formik.handleChange}
              error={formik.touched.age && Boolean(formik.errors.age)}
              helperText={formik.touched.age && formik.errors.age}
              sx={{ marginY: 1 }}
            />
            <TextField
              id="outlined-required"
              label="Email"
              name="email"
              value={formik.values.email}
              onChange={formik.handleChange}
              error={formik.touched.email && Boolean(formik.errors.email)}
              helperText={formik.touched.email && formik.errors.email}
              sx={{ marginY: 1 }}
            />
            <TextField
              type="password"
              id="outlined-password-input"
              label="Password"
              name="password"
              value={formik.values.password}
              onChange={formik.handleChange}
              error={formik.touched.password && Boolean(formik.errors.password)}
              helperText={formik.touched.password && formik.errors.password}
              autoComplete="current-password"
              sx={{ marginY: 1 }}
            />
            <TextField
              id="outlined-required"
              label="Country"
              name="country"
              value={formik.values.country}
              onChange={formik.handleChange}
              error={formik.touched.country && Boolean(formik.errors.country)}
              helperText={formik.touched.country && formik.errors.country}
              sx={{ marginY: 1 }}
            />
            <InputLabel variant="standard" htmlFor="uncontrolled-native">
              Choose User Type:
            </InputLabel>
            <Select
              labelId="user-type"
              name='userType'
              value={formik.values.userType}
              onChange={formik.handleChange}
              error={formik.touched.userType && Boolean(formik.errors.userType)}
              helperText={formik.touched.userType && formik.errors.userType}
            >
              <MenuItem value={'artist'}>Artist</MenuItem>
              <MenuItem value={'regularUser'}>Regular User</MenuItem>
            </Select>
            {isLoading ? <Box sx={{ display: 'flex', width: '100%', justifyContent: 'center' }} ><CircularProgress /></Box> : null}
            <Button
              type="submit"
              variant="contained"
              color="primary"
              sx={{ marginY: 2 }}
            >
              Sign Up
            </Button>
          </Stack>
        </form>
    </div>
  );
}

function SignUpPage() {
  return (
    <FormLayout>
      <SignUpForm
        formName="Sign Up"
        formDescription="You can sign up to the platform through this page."
      />
    </FormLayout>
  )
}

export default SignUpPage
