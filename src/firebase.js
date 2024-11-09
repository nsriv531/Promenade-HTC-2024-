// src/firebase.js
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

// Firebase configuration (replace these values with your actual config from Firebase Console)
const firebaseConfig = {
    apiKey: "YOUR_WEB_API_KEY",
    authDomain: "back-end-promenade.firebaseapp.com",
    projectId: "back-end-promenade",
    storageBucket: "back-end-promenade.appspot.com",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
  };
// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize services
const auth = getAuth(app);      // For Authentication
const db = getFirestore(app);    // For Firestore database

// Export the Firebase services you need
export { auth, db };
