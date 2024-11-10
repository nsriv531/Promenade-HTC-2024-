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
import MyProfile from "./MyProfile"; // Import MyProfile component

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/login" element={<LoggingIn />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/interests" element={<Interests />} />
        <Route path="/profile" element={<MyProfile />} /> {/* Add profile route */}
      </Routes>
    </BrowserRouter>
  </React.StrictMode>
);

reportWebVitals();
