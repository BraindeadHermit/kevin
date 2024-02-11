import { Route, Routes } from "react-router-dom";
import LogIn from "./pages/login/LogIn";
import Dashboard from "./pages/dashboard/Dashboard";
import ProvideAuth from "./hooks/useAuth";

const App = () => {
  return (
    <div>
      <Routes>
        <Route path="/login" element={<LogIn />} />
        <Route path="/" element={<Dashboard />} />
      </Routes>
    </div>
  );
};

export default App;
