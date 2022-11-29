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
      userData
    }),
    [token, userData]
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};