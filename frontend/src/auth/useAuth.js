import React from 'react'
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
    navigate("/", { replace: true });
  };

  const value = useMemo(
    () => ({
      token,
      saveToken,
      clearToken
    }),
    [token]
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};