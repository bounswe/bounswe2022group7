import React, { useReducer } from "react";
import {useNavigate} from 'react-router-dom';

import Button from "@mui/material/Button";
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

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();

  // Called when the user clicks the submit button. Observe how
  // the handleSubmit button is attached to the 'form' component
  // below in the return call of SignUpForm function.
  const handleSubmit = event => {
    event.preventDefault();

    let data = { formInput };

    /*
    // Here is how we will make a POST request in the backend.
    // This section is left out since the backend is not ready
    // yet.
    fetch("https://pointy-gauge.glitch.me/api/form", {
      method: "POST",
      body: JSON.stringify(data),
      headers: {
        "Content-Type": "application/json"
      }
    })
      .then(response => response.json())
      .then(response => console.log("Success:", JSON.stringify(response)))
      .catch(error => console.error("Error:", error));
    */

    // Since the backend is not ready to receive our
    // calls yet, I will redirect to the home page
    // if the user enters whenever the user clicks
    // the button.
    navigate('/');
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
      <Paper>
        <Typography variant="h5" component="h3">
          {props.formName}
        </Typography>
        <Typography component="p">{props.formDescription}</Typography>

        <form onSubmit={handleSubmit}>
          <Stack sx={{padding: 2}}>
            <TextField
              required
              id="outlined-required"
              label="Email"
              name="email"
              defaultValue={formInput.email}
              onChange={handleInput}
              sx = {{marginY: 1}}
            />
            <TextField
              required
              type="password"
              id="outlined-password-input"
              label="Password"
              name="password"
              defaultValue={formInput.password}
              onChange={handleInput}
              autoComplete="current-password"
              sx = {{marginY: 1}}
            />
            <Button
              type="submit"
              variant="contained"
              color="primary"
              sx = {{marginY: 2}}
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