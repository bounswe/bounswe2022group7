import React from "react";
import { useAuth } from "./useAuth";
import ErrorPage from '../pages/ErrorPage';

export const ProtectedRoute = ({ children }) => {
  const { token } = useAuth();
  if (!token) {
    // user is not authenticated
    return (    
        <ErrorPage
          message="You are not authorised to access this page. Please login."
          hyperlink={{
            to: "/auth/signin",
            text: "Go to Login Page"
          }}
          />
      )
  }
  return children;
};