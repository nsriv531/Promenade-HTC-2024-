import React, { useState } from 'react';

function LoggingIn() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle login form submission logic here
  };

  return (
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
    </form>
  );
}

export default LoggingIn;
