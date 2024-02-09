import { createContext, useState, useEffect, useContext } from "react";
import { useNavigate } from "react-router";

const AuthContext = createContext({});

const useProvideAuth = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    if (isLoggedIn) navigate("/");
    else navigate("/login");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isLoggedIn]);

  const login = async (url, userData) => {
    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(userData),
    });
    if (!response.ok) {
      throw new Error(`${response.status}`);
    }
    setIsLoggedIn(true);
  };

  const logout = async (url = "") => {
    await fetch(url, {
      method: "POST",
    });
    setIsLoggedIn(false);
  };

  return {
    isLoggedIn,
    login,
    logout,
  };
};

// eslint-disable-next-line react/prop-types
const ProvideAuth = ({ children }) => {
  const auth = useProvideAuth();
  return <AuthContext.Provider value={auth}>{children}</AuthContext.Provider>;
};

export default ProvideAuth;

export const useAuth = () => useContext(AuthContext);
