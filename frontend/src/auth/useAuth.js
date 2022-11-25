import React, {useState, useEffect} from 'react'
import { createContext, useContext, useMemo } from "react";
import { useNavigate } from "react-router-dom";
import { useLocalStorage } from "./useLocalStorage";

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [token, setToken] = useLocalStorage("token", null);
  const navigate = useNavigate();

  // call this function when you want to authenticate the user
  const saveToken = (token) => {
    setToken(token);
    navigate("/");
  };

  // call this function to sign out logged in user
  const clearToken = () => {
    setToken(null);
    window.location.href = '/'
  };

  const postRequestWithImage = (
    url, // address we are making a request to
    base64String, // base64String is the string of the image
    formatFunction, // a function that receives id of the image and constructs the request body
    navigateToFunction // a function that constructs a path to navigate to from the response
    ) => {
      fetch("/api/image", {
        method: "POST",
        body: JSON.stringify({base64String: base64String}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      })
        .then((response) => response.json())
        .then((data) => {
          const posterId = data.id
  
          fetch(url, {
            method: "POST",
            body: JSON.stringify(formatFunction(posterId)),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + token
            },
          })
            .then((response) => response.json())
            .then((data) => navigate(navigateToFunction(data)))
        }
      )
  }

  const [userData, setUserData] = useState(null)
  useEffect(() => {
    fetch('/api/profile', {
      method: "GET",
      headers: {
        "Authorization": "Bearer " + token
      }
    })
      .then(response => response.json())
      .then(data => setUserData(data))
  }, [token])

  const value = useMemo(
    () => ({
      token,
      saveToken,
      clearToken,
      postRequestWithImage,
      userData
    }),
    [token, userData]
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};