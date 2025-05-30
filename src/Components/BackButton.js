import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';

function BackButton() {
  const navigate = useNavigate();
  const location = useLocation();

  const handleBack = () => {
    // Check if the current path is /dashboard/locationSelect
    if (location.pathname === '/dashboard/locationSelect' || location.pathname === '/profile' ) {
      navigate('/dashboard'); // Navigate back to the Dashboard page
    } 
    
    else {
      navigate('/'); // Navigate to the home route (App.js)
    }
  };

  return (
    <div className='flex'>
      <button
      onClick={handleBack}
      className="items-start text-wenge text-lg font-inter-medium pl-4"
      >
      <span className="pr-2 text-2xl">←</span> {/* Back arrow icon */}
      Back
    </button>
    </div>
  );
}

export default BackButton;
