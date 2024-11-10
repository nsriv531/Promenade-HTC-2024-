import { useState } from "react";
import "./App.css";
import { useNavigate } from "react-router-dom";

function App() {
  const navigate = useNavigate();
  const [isTransitioning, setIsTransitioning] = useState(false);

  const handleNavigate = (path) => {
    setIsTransitioning(true);
    setTimeout(() => navigate(path), 1000); // Navigate after animation
  }

  return (
    <div className={`App h-screen flex justify-center items-center bg-gradient-to-r from-lavender-pink to-light-cyan ${isTransitioning ? "animate-fadeOut" : ""}`}>
      <header className="App-header text-center">
        <div className={`py-52 m-auto ${isTransitioning ? "animate-slideUp" : ""}`}>
          <h1 className='font-customi text-wenge'>
            Promenade
          </h1>
          <p className='font-inter-medium text-wenge'>
            Walk together, anytime.
          </p>
        </div>
        <div className={`grid gap-3 grid-rows-2 ${isTransitioning ? "animate-slideDown" : ""}`}>
          <button className="font-inter text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan" onClick={() => handleNavigate("/login")}>
            Sign In
          </button>
          <button className="font-inter text-wenge h-12 w-80 rounded-xl bg-opacity-45 bg-light-cyan" onClick={() => handleNavigate("/signup")}>
            Sign Up
          </button>
        </div>
      </header>
    </div>
  );
}

export default App;