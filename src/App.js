import './App.css';
import { useNavigate } from 'react-router-dom';

function App() {
  const navigate = useNavigate();

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to Our Platform</h1>
        <p>
          Join our community today and explore all the features we offer!
        </p>
        <div className="button-group flex items-center justify-center">
          <button className="App-button" onClick={() => navigate("/login")}>Login</button>
          <button className="App-button" onClick={() => navigate("/signup")}>Sign Up</button>
        </div>
      </header>
    </div>
  );
}

export default App;
