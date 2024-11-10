<<<<<<< HEAD
import './App.css';
import { useNavigate } from 'react-router-dom';
import uploadDataToFirestore from './uploadData';
=======
import "./App.css";
import { useNavigate } from "react-router-dom";
>>>>>>> main

function App() {
  const navigate = useNavigate();

  // Function to handle data upload
  const handleUpload = async () => {
    await uploadDataToFirestore();
  };

  return (
<<<<<<< HEAD
    <div className="App">
      <header className="App-header">
        <h1>Welcome to Our Platform</h1>
        <p>
          Join our community today and explore all the features we offer!
        </p>
        <div className="button-group flex items-center justify-center">
          <button className="App-button" onClick={() => navigate("/login")}>Login</button>
          <button className="App-button" onClick={() => navigate("/signup")}>Sign Up</button>
          <button className="App-button" onClick={handleUpload}>Upload Data</button>
=======
    <div className="App h-screen flex justify-center items-center bg-gradient-to-r from-lavender-pink to-light-cyan">
      <header className="App-header text-center">
        <div className='py-56 m-auto'>
          <h1 className='font-customi text-wenge'>
            Promenade
          </h1>
          <p className='font-inter-medium text-wenge'>
            Walk together, anytime.
          </p>
        </div>
        <div className="">
          <button className="font-inter text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan" onClick={() => navigate("/login")}>Continue</button>
>>>>>>> main
        </div>
      </header>
    </div>
  );
}

export default App;
