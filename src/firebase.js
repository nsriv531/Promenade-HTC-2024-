// src/firebase.js
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

// Firebase configuration (replace these values with your actual config from Firebase Console)
const firebaseConfig = {
    apiKey: "AIzaSyB43lrQn7guZQ6gO_whjHEiPAw6ifmpjaQ",
    authDomain: "back-end-promenade.firebaseapp.com",
    projectId: "back-end-promenade",
    storageBucket: "back-end-promenade.firebasestorage.app",
    messagingSenderId: "368238758659",
    appId: "1:368238758659:web:a8b6a3f1d70dc48be3f736",
    measurementId: "G-CCDKNV4WB9"
  };
// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize services
const auth = getAuth(app);      // For Authentication
const db = getFirestore(app);    // For Firestore database

// Export the Firebase services you need
export { auth, db };
