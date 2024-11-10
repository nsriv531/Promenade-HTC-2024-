import React, { useState, useContext } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { AuthContext } from "../Contexts/authContexts";
import { GoogleAuthProvider } from 'firebase/auth';

function LoggingIn() {
  const { currentUser, userLoggedIn, createGoogleUser, loading } = useContext(AuthContext);
  // const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isSigningIn, setIsSigningIn] = useState(false);

  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    if (username === 'admin' && password === 'password') {
      navigate('/dashboard'); // Redirect to dashboard if credentials are correct
    } else {
      alert('Invalid credentials'); // Alert if credentials are incorrect
    }
  };

  // const emailSubmit = async (e) => {
  //   e.preventDefault();
  //   if (!isSigningIn) {
  //     setIsSigningIn(true);
  //     await signInWithEmail(email, password);
  //   }
  // }

  // seperate submission with Google
  const handleGoogleSignIn = () => {
    const provider = new GoogleAuthProvider(); // Create GoogleAuthProvider instance
    createGoogleUser(provider)
      .then(() => {
        navigate("/dashboard");
      })
      .catch((error) => {
        console.error('Error signing in with Google:', error);
      });
  };

  return (
    <div>
      { userLoggedIn && (<Navigate to={'/dashboard'} replace={true} />) }
      <form onSubmit={handleSubmit} className="bg-white p-8 max-w-lg mx-auto rounded-lg shadow-lg">
        <h2 className="text-2xl font-bold mb-6 text-gray-800">Login</h2>

        <label className="block mb-4 font-bold text-gray-700">
          Username:
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
          />
        </label>

        <label className="block mb-4 font-bold text-gray-700">
          Password:
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
          />
        </label>

        <button
          type="submit"
          className="w-full bg-indigo-600 text-white py-2 rounded-md font-semibold hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
        >
          Login
        </button>

        <button
          onClick={handleGoogleSignIn}
          className="w-full mt-4 bg-red-600 text-white py-2 rounded-md font-semibold hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2"
        >Log In with Google</button>
      </form>
    </div>
  );
}

export default LoggingIn;
