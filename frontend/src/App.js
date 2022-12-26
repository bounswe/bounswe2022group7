
import React from 'react'

import { Routes, Route } from "react-router-dom";

import ResponsiveAppBar from './ResponsiveAppBar';
import HomePage from "./pages/HomePage/HomePage"
import Profile from "./pages/ProfilePage/Profile"
import CreateArtItemPage from "./pages/ArtItemPage/CreateArtItemPage"
import ArtItemPage from "./pages/ArtItemPage/ArtItemPage"
import EventPage from "./pages/EventPage/EventPage"
import SignInPage from './pages/Authentication/SignInPage';
import SignUpPage from './pages/Authentication/SignUpPage';
import ErrorPage from './pages/ErrorPage';
import SettingsPage from './pages/ProfilePage/SettingsPage';

import Alert from '@mui/material/Alert';
import Snackbar from '@mui/material/Snackbar';

import { AuthProvider } from './auth/useAuth';
import { ProtectedRoute } from './auth/ProtectedRoute';
import CreatePhysicalEventPage from './pages/EventPage/CreatePhysicalEventPage';
import CreateOnlineEventPage from "./pages/EventPage/CreateOnlineEventPage"
import CreateDiscussionPostPage from './pages/DiscussionPage/CreateDiscussionPostPage';
import DiscussionPostPage from './pages/DiscussionPage/DiscussionPostPage';


import { createTheme, ThemeProvider } from '@mui/material/styles';

import { Recogito } from '@recogito/recogito-js';
import '@recogito/recogito-js/dist/recogito.min.css';

const theme = createTheme({
  palette: {
    type: 'light',
    primary: {
      main: '#F05454',
      contrastText: '#fffefe',
    },
    secondary: {
      main: '#30475E',
    },
    text: {
      secondary: '#222831',
      disabled: '#3C4048',
      primary: '#222831',
    },
    background: {
      default: '#fafafa',
      paper: '#fffefe',
    },
  },
})

function App() {

  const [snackbar, setSnackbar] = React.useState({
    open: false,
    message: "",
    severity: "success",
    handleClose: () => { setSnackbar({ ...snackbar, open: false }) }
  });

  const r = new Recogito({
    content: document.getElementById("root"),
    widgets: [
      "COMMENT"
    ]
  });

  const handleResponse = (severity, message) => {
    setSnackbar({
      ...snackbar,
      open: true,
      severity: severity,
      message: message,
    })
  };

  return (
    <div>
      <AuthProvider>
        <ThemeProvider theme={theme}>
          <ResponsiveAppBar />
          <Routes>
            <Route
              path="/"
              element={<HomePage onResponse={(severity, message) => handleResponse(severity, message)}/>}
            />
            <Route
              path="/auth/signup"
              element={<SignUpPage />}
            />
            <Route
              path="/auth/signin"
              element={<SignInPage />}
            />
            <Route
              path="/artitem/new"
              element={<ProtectedRoute><CreateArtItemPage /></ProtectedRoute>}
            />
            <Route
              path="/artitem/:id"
              element={
                <ArtItemPage onResponse={(severity, message) => handleResponse(severity, message)}/>}
            />
            <Route
              path="/event/newPhysical"
              element={<ProtectedRoute><CreatePhysicalEventPage /></ProtectedRoute>}
            />
            <Route
            path="/event/newOnline"
            element={<ProtectedRoute><CreateOnlineEventPage/></ProtectedRoute>}
            />
            <Route
              path="/event/:id"
              element={<EventPage />}
            />
            <Route
              path="/discussionPost/new"
              element={<ProtectedRoute><CreateDiscussionPostPage /></ProtectedRoute>}
            />
            <Route
              path="/discussionPost/:id"
              element={<DiscussionPostPage />}
            />
            <Route
              path="/profile/settings"
              element={<ProtectedRoute><SettingsPage /></ProtectedRoute>}
            />
            <Route
              path="/profile/:username"
              element={<Profile />}
            />
            <Route
              path="*"
              element={
                <ErrorPage
                  message="It looks like you are trying to access a page that doesn't exist."
                />
              }
            />
          </Routes>
          <Snackbar open={snackbar.open} autoHideDuration={6000} onClose={snackbar.handleClose}>
            <Alert onClose={snackbar.handleClose} severity={snackbar.severity} sx={{ width: '100%' }}>
              {snackbar.message}
            </Alert>
          </Snackbar>
        </ThemeProvider>
      </AuthProvider>
    </div>
  );
}

export default App;