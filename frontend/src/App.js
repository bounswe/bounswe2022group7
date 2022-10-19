
import React from 'react'
import {
    createBrowserRouter,
    RouterProvider,
} from "react-router-dom";

import ResponsiveAppBar from './ResponsiveAppBar';
import HomePage from "./pages/HomePage/HomePage"
import ArtItemPage from "./pages/ArtItemPage/ArtItemPage"

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
  console.log(ArtItemPage)
    return (
      <div>
        <ResponsiveAppBar/>
        <RouterProvider router = {router} />
      </div>
    );
  }

export default App;