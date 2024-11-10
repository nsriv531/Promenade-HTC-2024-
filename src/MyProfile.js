// src/Components/MyProfile.js
import React, { useEffect, useState, useContext } from 'react';
import { db } from './firebase';
import { collection, getDocs, query, where } from 'firebase/firestore';
import { AuthContext } from './Contexts/authContexts';
import { getAuth } from 'firebase/auth';
import { useNavigate } from 'react-router-dom';
import './MyProfile.css';
import BackButton from './Components/BackButton';

const MyProfile = () => {
  const { logOut } = useContext(AuthContext);
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const auth = getAuth();

  // Function to fetch the logged-in user's profile
  const fetchUserProfile = async () => {
    const currentUser = auth.currentUser;
    if (currentUser) {
      const userEmail = currentUser.email;
      const usersCollection = collection(db, 'users');
      const q = query(usersCollection, where('email', '==', userEmail));
      const snapshot = await getDocs(q);
      
      if (!snapshot.empty) {
        // Retrieve the first document that matches the query
        const userData = snapshot.docs[0].data();
        setUser({
          ...userData,
          rating: userData.rating || 'Rating not found!',
        });
      } else {
        setUser({ firstName: 'User', rating: 'Rating not found!', interests: [] });
      }
    }
  };

  useEffect(() => {
    fetchUserProfile();
  }, []);

  if (!user) {
    return <div className="profile-loading">Loading profile...</div>;
  }

  const handleSignOut = () => {
    logOut().then(() => {
      console.log('User signed out successfully');
      navigate("/");
    }).catch((error) => {
      console.error('Error signing out:', error);
    });
  };

  return (
    <div className="profile-container">
      <div className="profile-card">
      <BackButton />
        <h2>{user.firstName ? `Hello, ${user.firstName}` : "Hello, User"}</h2>
        
        <p className="profile-rating">Welcome: {user.firstName} ★</p>
        
        <p className="profile-rating">Rating: {user.rating}</p>
        
        <h3>Interests</h3>
        <ul className="profile-interests">
          {user.interests && user.interests.length > 0 ? (
            user.interests.map((interest, index) => (
              <li key={index}>{interest}</li>
            ))
          ) : (
            <li>No interests found</li>
          )}
        </ul>
        <button onClick={handleSignOut}>Sign Out</button>
      </div>
    </div>
  );
};

export default MyProfile;
