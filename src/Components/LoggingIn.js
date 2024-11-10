import React, { useState, useContext } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { AuthContext } from "../Contexts/authContexts";
import { GoogleAuthProvider } from 'firebase/auth';
import BackButton from './BackButton';

function LoggingIn() {
  const { currentUser, userLoggedIn, createGoogleUser, loading } = useContext(AuthContext);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isSigningIn, setIsSigningIn] = useState(false);
  const [isTransitioning, setIsTransitioning] = useState(false);

  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (username === 'admin' && password === 'password') {
      handleNavigate('/dashboard'); // Redirect to dashboard if credentials are correct
    } else {
      alert('Invalid credentials'); // Alert if credentials are incorrect
    }
  };

  const handleNavigate = (path) => {
    setIsTransitioning(true);
    setTimeout(() => navigate(path), 1000); // Navigate after animation
  };

  const handleGoogleSignIn = () => {
    const provider = new GoogleAuthProvider(); // Create GoogleAuthProvider instance
    createGoogleUser(provider)
      .then(() => {
        handleNavigate("/dashboard");
      })
      .catch((error) => {
        console.error('Error signing in with Google:', error);
      });
  };

  return (
    <div className={`min-h-screen flex flex-col items-center justify-center bg-gray-100 bg-gradient-to-r from-lavender-pink to-light-cyan ${isTransitioning ? "animate-fadeOut" : ""}`}>
      { userLoggedIn && (<Navigate to={'/dashboard'} replace={true} />) }
      <div className='absolute top-4 left-2'>
        <BackButton />
      </div>
      <form onSubmit={handleSubmit} className={`bg-white p-8 max-w-lg mx-auto rounded-lg shadow-lg ${isTransitioning ? "" : "animate-slideIn"}`}>
        <h2 className="text-2xl font-bold mb-6 text-wenge">Login</h2>

        <label className="block mb-4 font-bold text-wenge">
          Username:
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-2 border border-orchid-pink rounded-md shadow-sm focus:outline-none focus:ring-orchid-pink focus:border-orchid-pink"
          />
        </label>

        <label className="block mb-4 font-bold text-wenge">
          Password:
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-2 border border-orchid-pink rounded-md shadow-sm focus:outline-none focus:ring-orchid-pink focus:border-orchid-pink"
          />
        </label>

        <button
          type="submit"
          className="w-full bg-wenge text-white py-2 rounded-md font-semibold hover:bg-lavender-pink focus:outline-none focus:ring-2 focus:ring-wenge focus:ring-offset-2"
        >
          Login
        </button>
        
        <button
          onClick={handleGoogleSignIn}
          className="w-full mt-4 bg-wenge text-white py-2 rounded-md font-semibold hover:bg-lavender-pink focus:outline-none focus:ring-2 focus:ring-wenge focus:ring-offset-2"
        >
          Log In with Google
        </button>
      </form>
    </div>
  );
}

export default LoggingIn;
