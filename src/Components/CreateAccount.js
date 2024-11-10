import React, { useState } from "react";

function CreateAccount() {
  const [firstName, setFirstName] = useState("");
  const [pronouns, setPronouns] = useState("");
  const [email, setEmail] = useState("");
  const [ageRange, setAgeRange] = useState("");
  const [genderIdentity, setGenderIdentity] = useState("");
  const [interests, setInterests] = useState([]);

  const interestOptions = [
    "Technology",
    "Sports",
    "Music",
    "Travel",
    "Reading",
    "Gaming",
  ];

  const handleInterestChange = (interest) => {
    setInterests((prev) =>
      prev.includes(interest)
        ? prev.filter((i) => i !== interest)
        : [...prev, interest]
    );
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission logic here
    // e.preventDefault();
    // if (username === "admin" && password === "password") {
    //   navigate("/dashboard"); // Redirect to dashboard if credentials are correct
    // } else {
    //   alert("Invalid credentials"); // Alert if credentials are incorrect
    // }
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="bg-white p-8 max-w-lg mx-auto rounded-lg shadow-lg">
      <h2 className="text-2xl font-bold mb-6 text-gray-800">Create Account</h2>

      <label className="block mb-4 font-bold text-gray-700">
        First Name:
        <input
          type="text"
          value={firstName}
          onChange={(e) => setFirstName(e.target.value)}
          required
          className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />
      </label>

      <label className="block mb-4 font-bold text-gray-700">
        Pronouns:
        <input
          type="text"
          value={pronouns}
          onChange={(e) => setPronouns(e.target.value)}
          className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />
      </label>

      <label className="block mb-4 font-bold text-gray-700">
        Email (not public):
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />
      </label>

      <label className="block mb-4 font-bold text-gray-700">
        Age Range:
        <select
          value={ageRange}
          onChange={(e) => setAgeRange(e.target.value)}
          required
          className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
          <option value="">Select Age Range</option>
          <option value="18-24">18-24</option>
          <option value="25-29">25-29</option>
          <option value="30-34">30-34</option>
          <option value="35+">35+</option>
        </select>
      </label>

      <label className="block mb-4 font-bold text-gray-700">
        Gender Identity:
        <input
          type="text"
          value={genderIdentity}
          onChange={(e) => setGenderIdentity(e.target.value)}
          className="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />
      </label>

      <fieldset className="mb-4">
        <legend className="text-gray-700 font-semibold mb-2">Interests:</legend>
        <div className="grid grid-cols-2 gap-2">
          {interestOptions.map((interest) => (
            <label key={interest} className="flex items-center">
              <input
                type="checkbox"
                value={interest}
                checked={interests.includes(interest)}
                onChange={() => handleInterestChange(interest)}
                className="mr-2 h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
              />
              <span className="text-gray-700">{interest}</span>
            </label>
          ))}
        </div>
      </fieldset>

      <button
        type="submit"
        className="w-full bg-indigo-600 text-white py-2 rounded-md font-semibold hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
        Create Account
      </button>
    </form>
  );
}

export default CreateAccount;
