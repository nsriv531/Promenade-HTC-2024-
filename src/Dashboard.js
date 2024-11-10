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
  const [isTransitioning, setIsTransitioning] = useState(false);
  const navigate = useNavigate();
  const auth = getAuth();
  const db = getFirestore();

  const handleNavigate = (path) => {
    setIsTransitioning(true);
    setTimeout(() => navigate(path), 1000); // Navigate after animation
  }

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
    handleNavigate("/dashboard/locationSelect"); // Replace "/home" with your desired route
  };

  return (
    <div className="h-screen flex flex-col items-center gap-6 bg-gradient-to-r from-lavender-pink to-light-cyan">
      <div className="text-left text-wenge pl-4">
        <h2 className="font-customi text-5xl py-6">
          Promenade...
        </h2>
        <h1 className="font-inter-medium text-2xl">
          Safety first.
        </h1>
      </div>

      <div className={`font-inter-medium grid grid-rows-2 place-items-center`}>
        <button
          className={`text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan ${activeTab === "trip" ? "active" : ""} ${isTransitioning ? "animate-LslideOut" : "animate-LslideIn"}`}
          onClick={handleClick}>
          Plan Your Trip...
        </button>
        <div className={`${isTransitioning ? "animate-LslideOut" : "animate-LslideIn"}`}>
          <Footer />
        </div>
      </div>
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
