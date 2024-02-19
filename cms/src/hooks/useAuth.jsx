import { createContext, useEffect, useContext, useState } from "react";
import { useNavigate } from "react-router";

const AuthContext = createContext({});

const useProvideAuth = () => {
  const navigate = useNavigate();
  const [isLogged, setIsLogged] = useState(false);

  const isCookiePresent = () => {
    return document.cookie.split().some((cookie) => {
      return cookie.trim().startsWith(`KevinCookie=`);
    });
  }

  console.log(isCookiePresent());

  useEffect(() => {
    isLogged ? navigate("/") : navigate("login");
  }, [isLogged]);

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

    setIsLogged(true);
  };

  const logout = async (url) => {
    const response = await fetch(url, {
      method: "POST",
    });

    if (!response.ok) throw new Error(`${response.status}`);

    setIsLogged(false);
  };

  return {
    isLogged,
    login,
    logout,
  };
};

const ProvideAuth = ({ children }) => {
  const auth = useProvideAuth();

  return <AuthContext.Provider value={auth}>{children}</AuthContext.Provider>;
};

export default ProvideAuth;
export const useAuth = () => useContext(AuthContext);
