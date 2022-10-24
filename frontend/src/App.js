
import React from 'react'
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

import ResponsiveAppBar from './ResponsiveAppBar';
import HomePage from "./pages/HomePage/HomePage"
import ArtItemPage from "./pages/ArtItemPage/ArtItemPage"
import SignInPage from './pages/Authentication/SignInPage';
import SignUpPage from './pages/Authentication/SignUpPage';

import Container from '@mui/material/Container';

const router = createBrowserRouter([
  {
    path: "/",
    element: <HomePage />,
  },
  {
    path: "/auth/signup",
    element: <SignUpPage />
  },
  {
    path: "/auth/signin",
    element: <SignInPage />
  },
  {
    // dynamic routing: id parameter can be accessed
    // in ArtItemPage. See ArtItemPage code to learn
    // how.
    path: "/art_item/:id",
    element: <ArtItemPage />
  }
]);

function App() {
  return (
    <div>
      <ResponsiveAppBar />
      <RouterProvider router={router} />
    </div>
  );
}

export default App;