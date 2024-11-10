import "./App.css";
import { useNavigate } from "react-router-dom";
import { ThemeProvider } from "@material-tailwind/react";

function App() {
  const navigate = useNavigate();

  return (
    <div className="App flex h-screen bg-gradient-to-r from-lavender-pink to-light-cyan">
      <header className="App-header m-auto">
        <h1 className="font-customi text-wenge">Promenade</h1>
        <p className="font-custom text-wenge">Walk together, anytime.</p>
        <div className="button-group flex items-center justify-center">
          <button className="App-button" onClick={() => navigate("/login")}>
            Login
          </button>
          <button className="App-button" onClick={() => navigate("/signup")}>
            Sign Up
          </button>
        </div>
      </header>
    </div>
  );
}

export default App;
