import React, { useEffect, useState } from "react";
import { db } from "./firebase";
import { collection, getDocs } from "firebase/firestore";
import { useLocation } from "react-router-dom";

const MatchedUsersPage = () => {
  const location = useLocation();
  const { startLocation, endLocation } = location.state || {};
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

  // Function to handle sending an invite
  const handleSendInvite = (userName) => {
    alert(`Invite sent to ${userName}`);
  };

  // Function to render star rating based on userRating
  const renderStarRating = (rating) => {
    const filledStars = Math.round(rating);
    const stars = [];
    for (let i = 0; i < 5; i++) {
      if (i < filledStars) {
        stars.push(<span key={i}>★</span>); // Filled star
      } else {
        stars.push(<span key={i}>☆</span>); // Empty star
      }
    }
    return <span className="text-yellow-500">{stars}</span>;
  };

  return (
    <div className="container mx-auto p-6 bg-gray-100 rounded-lg shadow-md bg-gradient-to-r from-lavender-pink to-light-cyan">
      <h2 className="text-lg font-bold mb-3">Matched Users</h2>
      {matchedUsers.length > 0 ? (
        <ul>
          {matchedUsers.map((user, index) => (
            <li key={index} className="mb-4 border-b pb-2">
              {/* Display profile picture */}
              {user.profilePicture && (
                <img
                  src={user.profilePicture}
                  alt={`${user.firstName}'s profile`}
                  className="w-16 h-16 rounded-full mb-2"
                />
              )}
              <strong>User:</strong> {user.firstName} <br />
              <strong>Starting Location:</strong> {startLocation.name} <br />
              <strong>End Location:</strong> {user.endLocation} <br />
              <strong>Rating:</strong> {renderStarRating(user.userRating)} <br />
              <button
                className="mt-2 px-4 py-2 text-white rounded transition duration-300"
                style={{
                  backgroundColor: '#ff94c2', // Lavender pink (adjust based on theme)
                  backgroundImage: 'linear-gradient(90deg, #ff94c2, #a6e7ff)', // Pink to cyan gradient
                  boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
                }}
                onMouseEnter={(e) => {
                  e.target.style.backgroundImage = 'linear-gradient(90deg, #a6e7ff, #ff94c2)';
                }}
                onMouseLeave={(e) => {
                  e.target.style.backgroundImage = 'linear-gradient(90deg, #ff94c2, #a6e7ff)';
                }}
                onClick={() => handleSendInvite(user.firstName)}
              >
                Send Invite
              </button>
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
