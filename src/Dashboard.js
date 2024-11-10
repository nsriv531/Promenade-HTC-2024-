// src/Components/Dashboard.js
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { getAuth } from "firebase/auth";
import { getFirestore, collection, query, where, getDocs } from "firebase/firestore";

import "./Styling/Dashboard.css";
import Footer from './Components/Footer';

function Dashboard() {
  const [activeTab, setActiveTab] = useState("trip");
  const [firstName, setFirstName] = useState(""); // Store the user's first name
  const navigate = useNavigate();
  const auth = getAuth();
  const db = getFirestore();

  useEffect(() => {
    // Get the current user email
    const user = auth.currentUser;
    if (user) {
      const userEmail = user.email;

      // Query Firestore to find the document with the matching email
      const fetchFirstName = async () => {
        const usersRef = collection(db, "users");
        const q = query(usersRef, where("email", "==", userEmail));
        const querySnapshot = await getDocs(q);

        if (!querySnapshot.empty) {
          const userData = querySnapshot.docs[0].data();
          setFirstName(userData.firstName);
        }
      };

      fetchFirstName();
    }
  }, [auth, db]);

  const handleClick = () => {
    // Perform login logic here, then navigate
    navigate("/dashboard/locationSelect"); // Replace "/home" with your desired route
  };

  return (
    <div className="dashboard bg-gradient-to-r from-lavender-pink to-light-cyan">
      <div className="dashboard-header">
        <button className="left-button">Left Button</button> {/* Placeholder button */}
        <h2>{firstName ? `Hello, ${firstName}` : "User Dashboard"}</h2>
        <div className="profile-icon">👤</div> {/* Profile icon */}
      </div>

      <div className="tab-buttons">
        <button
          className={`tab-button ${activeTab === "trip" ? "active" : ""}`}
          onClick={handleClick}
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

      <Footer />
    </div>
  );
}

function PlanYourTrip() {
  return (
    <div>
      <h3>Plan Your Trip</h3>
      <p>Trip planning tools will go here.</p>
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
