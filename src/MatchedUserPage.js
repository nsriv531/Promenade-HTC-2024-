// MatchedUsersPage.js
import React, { useEffect, useState } from "react";
import { db } from "./firebase";
import { collection, getDocs } from "firebase/firestore";
import { useLocation } from "react-router-dom";

const MatchedUsersPage = () => {
  const location = useLocation();
  const { startLocation } = location.state || {}; // Access the start location passed from LocationList
  const [matchedUsers, setMatchedUsers] = useState([]);

  useEffect(() => {
    const fetchMatchedUsers = async () => {
      try {
        // Get all users from Firestore
        const usersSnapshot = await getDocs(collection(db, "users"));
        const usersData = usersSnapshot.docs.map((doc) => doc.data());

        // Filter users based on preferredLocations matching the startLocation's category
        const filteredUsers = usersData.filter(
          (user) =>
            user.preferredLocations &&
            user.preferredLocations.includes(startLocation.category) // Check if the user's preferredLocations includes the startLocation category
        );

        // Get all locations in the same category as startLocation for use as possible end locations
        const locationsSnapshot = await getDocs(collection(db, "locations"));
        const locationsData = locationsSnapshot.docs
          .map((doc) => doc.data())
          .filter((location) => location.category === startLocation.category);

        // Select three random users from the filtered list and assign them a random end location
        const randomUsers = filteredUsers
          .sort(() => 0.5 - Math.random())
          .slice(0, 3)
          .map((user) => {
            const randomEndLocation =
              locationsData[Math.floor(Math.random() * locationsData.length)];
            return { ...user, endLocation: randomEndLocation.name };
          });

        setMatchedUsers(randomUsers);
      } catch (error) {
        console.error("Error fetching matched users:", error);
      }
    };

    if (startLocation) {
      fetchMatchedUsers();
    }
  }, [startLocation]);

  return (
    <div className="container mx-auto p-6 bg-gray-100 rounded-lg shadow-md">
      <h2 className="text-lg font-bold mb-3">Matched Users</h2>
      {matchedUsers.length > 0 ? (
        <ul>
          {matchedUsers.map((user, index) => (
            <li key={index} className="mb-2">
              <strong>User:</strong> {user.firstName} <br />
              <strong>Starting Location:</strong> {startLocation.name} <br />
              <strong>Random End Location:</strong> {user.endLocation}
            </li>
          ))}
        </ul>
      ) : (
        <p>No matching users found.</p>
      )}
    </div>
  );
};

export default MatchedUsersPage;
