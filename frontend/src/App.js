
import React from 'react'
import {
    createBrowserRouter,
    RouterProvider,
    Route,
} from "react-router-dom";

import HomePage from "./pages/HomePage/HomePage"
import ResponsiveAppBar from './ResponsiveAppBar';

const router = createBrowserRouter([
    {
      path: "/",
      element: <HomePage />,
    },
  ]);

function App() {
    return (
    <React.StrictMode>
        <ResponsiveAppBar/>
        <RouterProvider router = {router} />
    </React.StrictMode>
      
    );
  }

export default App;