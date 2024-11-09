import React, { useState } from 'react';

function CreateAccount() {
  const [firstName, setFirstName] = useState('');
  const [pronouns, setPronouns] = useState('');
  const [email, setEmail] = useState('');
  const [ageRange, setAgeRange] = useState('');
  const [genderIdentity, setGenderIdentity] = useState('');
  const [interests, setInterests] = useState([]);

  // Options for interests
  const interestOptions = ['Technology', 'Sports', 'Music', 'Travel', 'Reading', 'Gaming'];

  const handleInterestChange = (interest) => {
    setInterests((prev) => 
      prev.includes(interest) ? prev.filter((i) => i !== interest) : [...prev, interest]
    );
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission logic here
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        First Name:
        <input
          type="text"
          value={firstName}
          onChange={(e) => setFirstName(e.target.value)}
          required
        />
      </label>
      
      <label>
        Pronouns:
        <input
          type="text"
          value={pronouns}
          onChange={(e) => setPronouns(e.target.value)}
        />
      </label>

      <label>
        Email (not public):
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
      </label>

      <label>
        Age Range:
        <select value={ageRange} onChange={(e) => setAgeRange(e.target.value)} required>
          <option value="">Select Age Range</option>
          <option value="18-24">18-24</option>
          <option value="25-29">25-29</option>
          <option value="30-34">30-34</option>
          <option value="35+">35+</option>
        </select>
      </label>

      <label>
        Gender Identity:
        <input
          type="text"
          value={genderIdentity}
          onChange={(e) => setGenderIdentity(e.target.value)}
        />
      </label>

      <fieldset>
        <legend>Interests:</legend>
        {interestOptions.map((interest) => (
          <label key={interest}>
            <input
              type="checkbox"
              value={interest}
              checked={interests.includes(interest)}
              onChange={() => handleInterestChange(interest)}
            />
            {interest}
          </label>
        ))}
      </fieldset>

      <button type="submit">Create Account</button>
    </form>
  );
}

export default CreateAccount;
