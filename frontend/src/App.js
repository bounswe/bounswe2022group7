
import React from 'react'
import {
    createBrowserRouter,
    RouterProvider,
} from "react-router-dom";

import ResponsiveAppBar from './ResponsiveAppBar';
import HomePage from "./pages/HomePage/HomePage"
import ArtItemPage from "./pages/ArtItemPage/ArtItemPage"
import Container from '@mui/material/Container';

const router = createBrowserRouter([
    {
      path: "/",
      element: <HomePage />,
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
        <ResponsiveAppBar/>
        <Container
          minH
          maxWidth="lg"
          sx={{
            boxShadow: 1,
            paddingY: 2
          }}
        >
          <RouterProvider router = {router} />          
        </Container>
      </div>
    );
  }

export default App;