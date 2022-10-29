import React, { useReducer } from "react";
import {useNavigate} from 'react-router-dom';

import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import Paper from "@mui/material/Paper";
import Stack from '@mui/material/Stack';
import Typography from "@mui/material/Typography";
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';
import InputLabel from '@mui/material/InputLabel';


function SignUpForm(props) {

  const [formInput, setFormInput] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      name: "",
      surname: "",
      email: "",
      password: "",
      userType: "",
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
              label="Name"
              name="name"
              defaultValue={formInput.name}
              onChange={handleInput}
              sx = {{marginY: 1}}
            />
            <TextField
              required
              id="outlined-required"
              label="Surname"
              name="surname"
              defaultValue={formInput.surname}
              onChange={handleInput}
              sx = {{marginY: 1}}
            />
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
            <InputLabel variant="standard" htmlFor="uncontrolled-native">
              Choose User Type:
            </InputLabel>
            <Select
              labelId="user-type"
              name='userType'
              value={formInput.userType}
              onChange={handleInput}
            >
              <MenuItem value={'artist'}>Artist</MenuItem>
              <MenuItem value={'regularUser'}>Regular User</MenuItem>
            </Select>

            <Button
              type="submit"
              variant="contained"
              color="primary"
              sx = {{marginY: 2}}
            >
              Sign Up
            </Button>
          </Stack>
        </form>
      </Paper>
    </div>
  );
}

function SignUpPage() {
  return (
    <div>
      <SignUpForm 
        formName="Sign Up"
        formDescription="You can sign up to the platform through this page."
      />
    </div>
  )
}

export default SignUpPage
