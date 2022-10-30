import React, { useReducer } from "react";
import { useNavigate } from 'react-router-dom';
import { useAuth } from "../../auth/useAuth";

import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';
import Button from "@mui/material/Button";
import Box from '@mui/material/Box';
import CircularProgress from '@mui/material/CircularProgress';
import TextField from "@mui/material/TextField";
import Paper from "@mui/material/Paper";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";

function SignInForm(props) {

  const [formInput, setFormInput] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      email: "",
      password: "",
    }
  );

  const [isLoading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();
  const { saveToken } = useAuth()

  // Called when the user clicks the submit button. Observe how
  // the handleSubmit button is attached to the 'form' component
  // below in the return call of SignUpForm function.
  const handleSubmit = event => {
    event.preventDefault();
    setLoading(true);
    setError(null);

    let data = {
      email: formInput.email,
      password: formInput.password
    }

    // Here is how we will make a POST request in the backend.
    // This section is left out since the backend is not ready
    // yet.
    fetch("/login", {
      method: "POST",
      body: JSON.stringify(data),
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
          setFormInput({ password: "" });
          setError("Your email or password is incorrect. Please try again.");
        }
        setLoading(false);
      })
      .catch((error) => {
        setLoading(false);
        setError(error.message);
      });

  };

  // updates the state (formInput) defined in useReducer function above
  // with the function (setFormInput) defined in useReducer.
  // Called everytime user makes an update to the fields with
  // 'onChange={handleInput}'.
  const handleInput = event => {
    const name = event.target.name;
    const newValue = event.target.value;
    setFormInput({ [name]: newValue });
  };

  return (
    <div>
      <Paper sx={{p: 2}}>
        <Typography variant="h5" component="h3">
          {props.formName}
        </Typography>
        <Typography component="p">{props.formDescription}</Typography>

        <form onSubmit={handleSubmit}>
          <Stack sx={{mt: 2}}>
            { error ? <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error signing in</AlertTitle>{error}</Alert> : null}
            <TextField
              required
              id="outlined-required"
              label="Email"
              name="email"
              value={formInput.email}
              onChange={handleInput}
              sx={{ marginY: 1 }}
            />
            <TextField
              required
              type="password"
              id="outlined-password-input"
              label="Password"
              name="password"
              value={formInput.password}
              onChange={handleInput}
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