import React from 'react';
import { useNavigate } from 'react-router-dom';

function BackButton() {
  const navigate = useNavigate();

  const handleBack = () => {
    navigate('/'); // Navigate to App.js or the home route
  };

  return (
    <button
      onClick={handleBack}
      className="flex items-center text-wenge text-lg font-inter-medium pl-4"
    >
      <span className="pr-2 text-2xl">←</span> {/* Back arrow icon */}
      Back
    </button>
  );
}

export default BackButton;
