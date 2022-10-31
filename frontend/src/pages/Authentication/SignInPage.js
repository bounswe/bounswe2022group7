import React from "react";
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";

import { useFormik } from 'formik';
import * as Yup from 'yup';

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Button from "@mui/material/Button";
import Box from '@mui/material/Box';
import CircularProgress from '@mui/material/CircularProgress';
import TextField from "@mui/material/TextField";
import Paper from "@mui/material/Paper";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";

const validationSchema = Yup.object().shape({
  email: Yup.string().email().required(),
  password: Yup.string().required(),
});

function SignInForm(props) {

  const { state } = useLocation();


  const [isLoading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);
  const redirected = state ? state.redirect : false;

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();
  const { saveToken } = useAuth()

  const formik = useFormik({
    initialValues: {
      email: state ? state.email : "",
      password: "",
    },
    validationSchema: validationSchema,
    onSubmit: (values) => {
      setLoading(true);
    setError(null);


    // Here is how we will make a POST request in the backend.
    // This section is left out since the backend is not ready
    // yet.
    fetch("/login", {
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
        if (responseText) {
          saveToken(responseText);
          navigate('/');
        } else {
          formik.setFieldValue("password", "");
          setError("Your email or password is incorrect. Please try again.");
        }
        setLoading(false);
      })
      .catch((error) => {
        setLoading(false);
        setError(error.message);
      });
    },
  });


  return (
    <div>
      <Paper sx={{p: 2}}>
        <Typography variant="h5" component="h3">
          {props.formName}
        </Typography>
        <Typography component="p">{props.formDescription}</Typography>

        <form onSubmit={formik.handleSubmit}>
          <Stack sx={{mt: 2}}>
            { error ? <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error signing in</AlertTitle>{error}</Alert> :           
               redirected ? <Alert severity="info" sx={{mb: 2}}>You have succesfully signed up, you can login with your crediantials.</Alert> : null}
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
            {isLoading ? <Box sx={{display: 'flex', width: '100%', justifyContent: 'center'}} ><CircularProgress /></Box>  : null }
            <Button
              disabled={isLoading}
              type="submit"
              variant="contained"
              color="primary"
              sx={{ marginY: 2 }}
            >
              Sign In
            </Button>
          </Stack>
        </form>
      </Paper>
    </div>
  );
}

function SignInPage() {
  return (
    <SignInForm
      formName="Sign In"
      formDescription="You can sign in to your account through this page."
    />
  )
}

export default SignInPage