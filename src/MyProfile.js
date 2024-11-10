// src/Components/MyProfile.js
import React, { useEffect, useState } from 'react';
import { db } from '../firebase';
import { collection, getDocs } from 'firebase/firestore';
import './Styling/MyProfile.css';

const MyProfile = () => {
  const [user, setUser] = useState(null);

  // Function to fetch a random user
  const fetchRandomUser = async () => {
    const usersCollection = collection(db, 'users');
    const snapshot = await getDocs(usersCollection);
    const users = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    
    if (users.length > 0) {
      // Select a random user from the list
      const randomUser = users[Math.floor(Math.random() * users.length)];
      setUser(randomUser);
    }
  };

  useEffect(() => {
    fetchRandomUser();
  }, []);

  if (!user) {
    return <div className="profile-loading">Loading profile...</div>;
  }

  return (
    <div className="profile-container">
      <div className="profile-card">
        <h2>{user.name}</h2>
        <p className="profile-rating">Rating: {user.rating} ★</p>
        <h3>Interests</h3>
        <ul className="profile-interests">
          {user.interests.map((interest, index) => (
            <li key={index}>{interest}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default MyProfile;
