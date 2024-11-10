// ButtonComponent.js (Footer)
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AiFillHome, AiOutlineUser } from 'react-icons/ai';

const Footer = () => {
  const navigate = useNavigate();

  return (
    <div style={{
      display: 'flex',
      justifyContent: 'space-around',
      alignItems: 'center',
      padding: '10px',
      background: 'linear-gradient(to right, #fbc2eb, #a6c1ee)',
      borderRadius: '20px',
      width: '100%',
      maxWidth: '400px',
      margin: 'auto',
    }}>
      <div
        style={{ textAlign: 'center', cursor: 'pointer' }}
        onClick={() => navigate('/dashboard')} // Navigates to Dashboard
      >
        <AiFillHome size={30} color="#8b5e83" />
        <p style={{ color: '#8b5e83', marginTop: '5px' }}>Start</p>
      </div>
      <div
        style={{ textAlign: 'center', cursor: 'pointer' }}
        onClick={() => navigate('/profile')} // Navigates to Profile
      >
        <AiOutlineUser size={30} color="#8b5e83" />
        <p style={{ color: '#8b5e83', marginTop: '5px' }}>Profile</p>
      </div>
    </div>
  );
};

export default Footer;
