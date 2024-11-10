// ButtonComponent.js (Footer)
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { AiFillHome, AiOutlineUser } from 'react-icons/ai';
import { FaWalking } from 'react-icons/fa';

const Footer = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col items-center gap-6 w-full text-center">
      <div
        className='text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan items-center justify-center'
        onClick={() => navigate('/dashboard')} // Navigates to Dashboard
      >
        <div className='place-items-center'>
          <AiFillHome className='inline' size={24} color="#8b5e83" />
          <p className='ml-2 inline' style={{ color: '#8b5e83'}}>Start</p>
        </div>
      </div>
      <div
        className='text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan items-center justify-center'
        onClick={() => navigate('/profile')} // Navigates to Profile
      >
        <div className='place-items-center'>
          <AiOutlineUser className='inline' size={24} color="#8b5e83" />
          <p className='ml-2 inline' style={{ color: '#8b5e83'}}>Your Profile</p>
        </div>
      </div>
    </div>
  );
};

export default Footer;
