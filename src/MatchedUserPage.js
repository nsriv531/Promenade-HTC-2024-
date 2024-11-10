import React, { useEffect, useState } from "react";
import { db } from "./firebase";
import { collection, getDocs } from "firebase/firestore";
import { useLocation } from "react-router-dom";

const MatchedUsersPage = () => {
  const location = useLocation();
  const { startLocation, endLocation } = location.state || {}; // Access start and end locations passed from LocationList
  const [matchedUsers, setMatchedUsers] = useState([]);

  useEffect(() => {
    const fetchMatchedUsers = async () => {
      try {
        // Fetch all users from Firestore
        const usersSnapshot = await getDocs(collection(db, "users"));
        const usersData = usersSnapshot.docs.map((doc) => doc.data());

        // Fetch all locations in the same category as endLocation for use as possible end locations
        const locationsSnapshot = await getDocs(collection(db, "locations"));
        const locationsData = locationsSnapshot.docs
          .map((doc) => doc.data())
          .filter((location) => location.category === endLocation.category);

        // Select three random users and assign each a random end location
        const randomUsers = usersData
          .sort(() => 0.5 - Math.random())
          .slice(0, 3)
          .map((user) => {
            const randomEndLocation =
              locationsData[Math.floor(Math.random() * locationsData.length)];
            return { ...user, endLocation: randomEndLocation?.name };
          });

        setMatchedUsers(randomUsers);
      } catch (error) {
        console.error("Error fetching matched users:", error);
      }
    };

    if (startLocation && endLocation) {
      fetchMatchedUsers();
    }
  }, [startLocation, endLocation]);

  return (
    <div className="container mx-auto p-6 bg-gray-100 rounded-lg shadow-md bg-gradient-to-r from-lavender-pink to-light-cyan">
      <h2 className="text-lg font-bold mb-3">Matched Users</h2>
      {matchedUsers.length > 0 ? (
        <ul className="space-y-4">
          {matchedUsers.map((user, index) => (
            <li
              key={index}
              className="flex items-center space-x-4 p-4 bg-white rounded-lg shadow-md"
            >
              <img
                src={user.profilePicture}
                alt={`${user.firstName}'s profile`}
                className="w-16 h-16 rounded-full object-cover border-2 border-gray-300"
              />
              <div>
                <p className="text-lg font-semibold">{user.firstName}</p>
                <p>
                  <strong>Starting Location:</strong> {startLocation.name}
                </p>
                <p>
                  <strong>End Location:</strong> {user.endLocation}
                </p>
              </div>
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
