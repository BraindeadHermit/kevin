import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { BrowserRouter } from "react-router-dom";
import ProvideAuth from "./hooks/useAuth.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <BrowserRouter>
    <React.StrictMode>
      <ProvideAuth>
        <App />
      </ProvideAuth>
    </React.StrictMode>
  </BrowserRouter>
);
