import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to Our Platform</h1>
        <p>
          Join our community today and explore all the features we offer!
        </p>
        <div className="button-group">
          <button className="App-button" onClick={() => alert("Redirect to Login")}>Login</button>
          <button className="App-button" onClick={() => alert("Redirect to Sign Up")}>Sign Up</button>
        </div>
      </header>
    </div>
  );
}

export default App;
