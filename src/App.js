import "./App.css";
import { useNavigate } from "react-router-dom";

function App() {
  const navigate = useNavigate();

  return (
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
        </div>
      </header>
    </div>
  );
}

export default App;
