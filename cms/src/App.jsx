import { Route, Routes } from "react-router-dom";
import LogIn from "./pages/login/LogIn";
import Dashboard from "./pages/dashboard/Dashboard";

const App = () => {
  return (
    <div>
      <Routes>
        <Route path="/" element={<LogIn />}/>
        <Route path="/home" element={<Dashboard/> } />
      </Routes>
    </div>
  );
};

export default App;
