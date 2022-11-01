
import React from 'react'

import { Routes, Route } from "react-router-dom";

import ResponsiveAppBar from './ResponsiveAppBar';
import HomePage from "./pages/HomePage/HomePage"
import CreateArtItemPage from "./pages/ArtItemPage/CreateArtItemPage"
import ArtItemPage from "./pages/ArtItemPage/ArtItemPage"
import EventPage from "./pages/EventPage/EventPage"
import SignInPage from './pages/Authentication/SignInPage';
import SignUpPage from './pages/Authentication/SignUpPage';
import ErrorPage from './pages/ErrorPage';

import { AuthProvider } from './auth/useAuth';
import {ProtectedRoute} from './auth/ProtectedRoute';


function App() {
  return (
    <div>
      <AuthProvider>
        <ResponsiveAppBar />
        <Routes>
          <Route
            path="/"
            element={<HomePage />}
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
            path="/artitem/:id"
            element={<ArtItemPage />}
          />
          <Route
            path="/event/:id"
            element={<EventPage />}
          />
          <Route
            path="/new/art_item"
            element={<ProtectedRoute><CreateArtItemPage /></ProtectedRoute>} 
          />
          <Route path="*" element={<ErrorPage />} />
        </Routes>
      </AuthProvider>
    </div>
  );
}

export default App;