import React from "react";
import { useNavigate } from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";

import { useFormik } from 'formik';
import * as Yup from 'yup';

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Button from "@mui/material/Button";
import Box from '@mui/material/Box';
import CircularProgress from '@mui/material/CircularProgress';
import TextField from "@mui/material/TextField";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";
import GenericCardLayout from "../../layouts/GenericCardLayout";

const validationSchema = Yup.object().shape({
  email: Yup.string().email().required(),
  password: Yup.string().required(),
});

function SignInForm(props) {

  const [isLoading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();
  const { saveToken } = useAuth()

  const formik = useFormik({
    initialValues: {
      email: "",
      password: "",
    },
    validationSchema: validationSchema,
    onSubmit: (values) => {
      setLoading(true);
      setError(null);

      fetch("/api/login", {
        method: "POST",
        body: JSON.stringify(values),
        headers: {
          "Content-Type": "application/json"
        }
      })
        .then((response) => response.json())
        .then((data) => {
          setLoading(false);
          if (data.error) {
            formik.setFieldValue("password", "");
            setError(data.message);
          } else {
            saveToken(data.token);
            navigate("/");
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
          {error && <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error signing in</AlertTitle>{error}</Alert>}
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
          {isLoading ? <Box sx={{ display: 'flex', width: '100%', justifyContent: 'center' }} ><CircularProgress /></Box> : null}
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
    </div>
  );
}

function SignInPage() {
  return (
    <GenericCardLayout maxWidth={500}>
      <SignInForm
        formName="Sign In"
        formDescription="You can sign in to your account through this page."
      />
    </GenericCardLayout>
  )
}

export default SignInPage