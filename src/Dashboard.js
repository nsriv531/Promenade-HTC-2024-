// src/Components/Dashboard.js
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

import "./Styling/Dashboard.css"; // For custom CSS styling
import Footer from './Components/Footer';

function Dashboard() {
  const [activeTab, setActiveTab] = useState("trip");
  const navigate = useNavigate();
  const handleClick = () => {
    // Perform login logic here, then navigate
    navigate("/dashboard/locationSelect"); // Replace "/home" with your desired route
  };
  return (
    <div className="h-screen flex flex-col gap-6 bg-gradient-to-r from-lavender-pink to-light-cyan">
      <div className="text-left text-wenge pl-4">
        <h2 className="font-customi text-5xl py-6">
          Promenade...
        </h2>
        <h1 className="font-inter-medium text-2xl">
          Safety first.
        </h1>
      </div>

      <div className={`font-inter-medium grid gap-3 grid-rows-2`}>
        <button
          className={`text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan ${activeTab === "trip" ? "active" : ""}`}
          onClick={handleClick}>
          Plan Your Trip...
        </button>
      </div>

      <div className="tab-content">
        {activeTab === "trip" && <PlanYourTrip />}
        {activeTab === "profile" && <CheckYourProfile />}
      </div>

      <div className="">
      <Footer />
      </div>
    </div>
  );
}

function PlanYourTrip({ value }) {
  return (
    <div>
      <h3>Plan Your Trip</h3>
      <p>Trip planning tools will go here.</p>
      <p>{value}</p>
    </div>
  );
}

function CheckYourProfile() {
  return (
    <div>
      <h3>Your Profile</h3>
      <p>Profile details and settings will go here.</p>
    </div>
  );
}

export default Dashboard;
