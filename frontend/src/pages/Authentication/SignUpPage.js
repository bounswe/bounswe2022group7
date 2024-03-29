import React from "react";
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";
import { useFormik } from 'formik';
import * as yup from 'yup';

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import TextField from "@mui/material/TextField";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import InputLabel from '@mui/material/InputLabel';

import EditUserInfo from "../../components/EditUserInfo"
import GenericCardLayout from "../../layouts/GenericCardLayout";
import LoadingButton from "../../components/LoadingButton";

const validationSchema = yup.object({
  email: yup
    .string('Enter your email')
    .email('Enter a valid email')
    .required('Email is required'),

  password: yup
    .string('Enter your password')
    .min(8, 'Password should be of minimum 8 characters length')
    .required('Password is required'),

  confirmPassword: yup
    .string('Verify your password')
    .oneOf([yup.ref('password'), null], 'Passwords must match')
    .required('Password verification is required'),

  username: yup
    .string('Enter your username')
    .min(3, 'Username should be of minimum 3 characters length')
    .required('Username is required')
    .matches(/^[a-zA-Z0-9]+$/, 'Username should only contain letters and numbers'),

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

  // Auth token save
  const { saveToken } = useAuth()

  // Validation
  const formik = useFormik({
    initialValues: {
      username: "",
      email: "",
      password: "",
      confirmPassword: "",
      userType: "artist",
    },
    validationSchema: validationSchema,
    validateOnChange: true,
    onSubmit: (values) => {
      setLoading(true);
      setError(null);

      fetch('/api/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(values)
      }).then(res => res.json())
        .then(
          (result) => {
            setLoading(false);

            if (result.error) {
              setError(result.message);
            } else {
              saveToken(result.token);
              navigate('/auth/signup', { state: { success: true } });
            }

          },
          (error) => {
            setLoading(false);
            setError(error);
          }
        )
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
            type="password"
            id="outlined-password-input"
            label="Verify Password"
            name="confirmPassword"
            value={formik.values.confirmPassword}
            onChange={formik.handleChange}
            error={formik.touched.confirmPassword && Boolean(formik.errors.confirmPassword)}
            helperText={formik.touched.confirmPassword && formik.errors.confirmPassword}
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
            <MenuItem value={'Regular User'}>Regular User</MenuItem>
          </Select>
          <LoadingButton
            loading={isLoading}
            label="Sign Up"
            loadingText="Loading"
            type="submit"
            variant="contained"
            color="primary"
            sx={{ marginY: 2 }}
          />
        </Stack>
      </form>
    </div>
  );
}

function SignUpPage() {
  const { state } = useLocation();
  const success = state ? state.success : false;

  return (

    success ?
      <GenericCardLayout maxWidth={600}>
        <EditUserInfo formName="Complete your profile" formDescription="You can complete your profile by filling these fields." buttonLabel="Continue" />
      </GenericCardLayout>
      :
      <GenericCardLayout maxWidth={500}>
        < SignUpForm
          formName="Sign Up"
          formDescription="You can sign up to the platform through this page."
        />
      </GenericCardLayout>

  )
}

export default SignUpPage
