import React, { useState, useEffect } from 'react';
import './App.css';

function ZenTimer() {
  const [isRunning, setIsRunning] = useState(false);
  const [remainingTime, setRemainingTime] = useState(300); // 5 minutes in seconds
  const [theme, setTheme] = useState('nature'); // Default theme
  const [guidedSession, setGuidedSession] = useState('mindfulness'); // Default session type
  const [isMusicOn, setIsMusicOn] = useState(false);
  const [chimeSound, setChimeSound] = useState(null);

  useEffect(() => {
    const intervalId = setInterval(() => {
      if (isRunning) {
        if (remainingTime > 0) {
          setRemainingTime((prevTime) => prevTime - 1);
        } else {
          // Timer completed
          // Play selected chime sound
          // Save session history
          setIsRunning(false);
        }
      }
    }, 1000);

    return () => clearInterval(intervalId);
  }, [isRunning, remainingTime]);

  const handleToggleRunning = () => {
    setIsRunning(!isRunning);
  };

  const handleMusicToggle = () => {
    setIsMusicOn(!isMusicOn);
  };

  const handleSessionChange = (selectedSession) => {
    setGuidedSession(selectedSession);
  };

  const formatTime = (time) => {
    const minutes = Math.floor(time / 60);
    const seconds = time % 60;
    return `${minutes}:${seconds < 10 ? '0' + seconds : seconds}`;
  };

  const playChimeSound = () => {
    // Play the selected chime sound
  };

  const saveSessionHistory = () => {
    // Save the current session to history
  };

  return (
    <div className="zen-timer">
      <header>Zen Timer Pro</header>
      <section>
        <h2>{formatTime(remainingTime)}</h2>
        <button onClick={handleToggleRunning}>
          {isRunning ? 'Pause' : 'Start'}
        </button>
        <button onClick={handleMusicToggle}>
          {isMusicOn ? 'Mute Music' : 'Play Music'}
        </button>
      </section>
      <section>
        <h3>Select Session:</h3>
        <select value={guidedSession} onChange={(event) => handleSessionChange(event.target.value)}>
          <option value="mindfulness">Mindfulness</option>
          <option value="relaxation">Relaxation</option>
          <option value="focus">Focus</option>
        </select>
      </section>
      <footer>
        <img
          src={`/${theme}.png`}
          alt="Theme Background"
          className="theme-background"
        />
        <button onClick={playChimeSound}>Play Chime Sound</button>
        <button onClick={saveSessionHistory}>Save Session History</button>
      </footer>
    </div>
  );
}

export default ZenTimer;