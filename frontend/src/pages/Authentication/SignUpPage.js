import React, { useReducer } from "react";
import { useNavigate, Navigate } from 'react-router-dom';

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


function SignUpForm(props) {

  const [formInput, setFormInput] = useReducer(
    (state, newState) => ({ ...state, ...newState }),
    {
      name: "",
      surname: "",
      age: undefined,
      username: "",
      email: "",
      password: "",
      userType: "",
      country: "",
    }
  );

  const [isLoading, setLoading] = React.useState(false);
  const [error, setError] = React.useState(null);

  // should be defined outside any function
  // otherwise breaks the 'Rules of Hooks' apparently.
  // ref: https://stackoverflow.com/questions/60700905/react-native-navigate-to-screen-invalid-hook-call
  const navigate = useNavigate();


  // Called when the user clicks the submit button. Observe how
  // the handleSubmit button is attached to the 'form' component
  // below in the return call of SignUpForm function.
  const handleSubmit = event => {
    event.preventDefault();
    setLoading(true);
    setError(null);


    let data = {
      name: formInput.name,
      surname: formInput.surname,
      age: parseInt(formInput.age),
      username: formInput.username,
      email: formInput.email,
      password: formInput.password,
      userType: formInput.userType,
      country: formInput.country,
    }

    console.log(data)


    // Here is how we will make a POST request in the backend.
    // This section is left out since the backend is not ready
    // yet.
    fetch("/signup", {
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
        console.log(responseText)
        setLoading(false);
        if (responseText === "true") {
          navigate(
            "/auth/signin",
            {
              state: { redirect: true, email: formInput.email }
            });

        } else {
          setFormInput({ password: "" });
          setError("An error occured");
        }
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
      <Paper>
        <Typography variant="h5" component="h3">
          {props.formName}
        </Typography>
        <Typography component="p">{props.formDescription}</Typography>

        <form onSubmit={handleSubmit}>
          <Stack sx={{ padding: 2 }}>
            {error ? <Alert severity="error" sx={{ mb: 2 }}><AlertTitle>Error signing up</AlertTitle>{error}</Alert> : null}

            <TextField
              required
              id="outlined-required"
              label="Username"
              name="username"
              value={formInput.username}
              onChange={handleInput}
              sx={{ marginY: 1 }}
            />
            <TextField
              required
              id="outlined-required"
              label="Name"
              name="name"
              value={formInput.name}
              onChange={handleInput}
              sx={{ marginY: 1 }}
            />
            <TextField
              required
              id="outlined-required"
              label="Surname"
              name="surname"
              value={formInput.surname}
              onChange={handleInput}
              sx={{ marginY: 1 }}
            />
            <TextField
              required
              id="outlined-required"
              label="Age"
              name="age"
              type="number"
              value={formInput.age}
              onChange={handleInput}
              sx={{ marginY: 1 }}
            />
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
            <TextField
              required
              id="outlined-required"
              label="Country"
              name="country"
              value={formInput.country}
              onChange={handleInput}
              sx={{ marginY: 1 }}
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
