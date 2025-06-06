import React from "react";
import ReactDOM from "react-dom/client";

import "./index.css";
import App from "./App";
import Dashboard from "./Dashboard";
import reportWebVitals from "./reportWebVitals";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import LoggingIn from "./Components/LoggingIn";
//import CreateAccount from "./Components/CreateAccount";
import SignUp from "./Components/SignUp";
import Interests from "./Components/Interests";
import LocationList from "./Components/LocationList";
import AuthProvider from "./Contexts/authContexts";
import MyProfile from "./MyProfile"; // Import MyProfile component
import MatchedUserPage from "./MatchedUserPage";


const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<App />} />
          <Route path="/login" element={<LoggingIn />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/signup" element={<SignUp />} />
          <Route path="/interests" element={<Interests />} />
          <Route path="/profile" element={<MyProfile />} /> {/* Add profile route */}
          <Route path="/dashboard/locationSelect" element={<LocationList />} />
          <Route path="/matched-users" element={<MatchedUserPage />} />
      </Routes>
      </BrowserRouter>
    </AuthProvider>
  </React.StrictMode>
);

reportWebVitals();
