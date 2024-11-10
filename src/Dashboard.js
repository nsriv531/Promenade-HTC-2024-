// src/Components/Dashboard.js
import React, { useState } from 'react';
import './Styling/Dashboard.css'; // For custom CSS styling

function Dashboard() {
  const [activeTab, setActiveTab] = useState("trip");

  return (
    <div className="dashboard bg-gradient-to-r from-lavender-pink to-light-cyan">
      <div className="dashboard-header">
        <button className="left-button">Left Button</button> {/* Placeholder button */}
        <h2>User Dashboard</h2>
        <div className="profile-icon">👤</div> {/* Profile icon */}
      </div>
      
      <div className="tab-buttons">
        <button
          className={`tab-button ${activeTab === "trip" ? "active" : ""}`}
          onClick={() => setActiveTab("trip")}
        >
          Plan Your Trip
        </button>
        <button
          className={`tab-button ${activeTab === "profile" ? "active" : ""}`}
          onClick={() => setActiveTab("profile")}
        >
          Check Your Profile
        </button>
      </div>

      <div className="tab-content">
        {activeTab === "trip" && <PlanYourTrip />}
        {activeTab === "profile" && <CheckYourProfile />}
      </div>
    </div>
  );
}

function PlanYourTrip() {
  return <div><h3>Plan Your Trip</h3><p>Trip planning tools will go here.</p></div>;
}

function CheckYourProfile() {
  return <div><h3>Your Profile</h3><p>Profile details and settings will go here.</p></div>;
}

export default Dashboard;
