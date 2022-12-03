
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

import { AuthProvider } from './auth/useAuth';
import {ProtectedRoute} from './auth/ProtectedRoute';
import CreatePhysicalEventPage from './pages/EventPage/CreatePhysicalEventPage';
import CreateDiscussionPostPage from './pages/DiscussionPage/CreateDiscussionPostPage';
import DiscussionPostPage from './pages/DiscussionPage/DiscussionPostPage';


import { createTheme, ThemeProvider, styled } from '@mui/material/styles';

const theme = createTheme({
  palette: {
    type: 'light',
    primary: {
      main: '#00ABB3',
      contrastText: '#fffefe',
    },
    secondary: {
      main: '#f50057',
    },
    text: {
      secondary: '#3C4048',
      disabled: '#3C4048',
      primary: '#3C4048',
    },
    background: {
      default: '#fafafa',
      paper: '#fffefe',
    },
  },
})

function App() {
  return (
    <div>
      <AuthProvider>
        <ThemeProvider theme={theme}>
        <ResponsiveAppBar />
        <Routes>
          <Route
            path="/"
            element={<HomePage />}
          />
          <Route
            path="/:username"
            element={<Profile />}
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
            element={<ProtectedRoute><CreateArtItemPage/></ProtectedRoute>}
          />
          <Route
            path="/artitem/:id"
            element={<ArtItemPage />}
          />
          <Route
            path="/event/newPhysical"
            element={<ProtectedRoute><CreatePhysicalEventPage/></ProtectedRoute>}
          />
          <Route
            path="/event/:id"
            element={<EventPage />}
          />
          <Route
            path="/discussionPost/new"
            element={<CreateDiscussionPostPage />}
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
            path="*"
            element={
              <ErrorPage
                message="It looks like you are trying to access a page that doesn't exist."
              />
              }
            />
        </Routes>
      </ThemeProvider>
      </AuthProvider>
    </div>
  );
}

export default App;