import React, { useEffect, useState } from "react";
import "./home.css";

function Home() {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    const loadedStories = JSON.parse(localStorage.getItem("stories")) || [];
    setStories(loadedStories);
  }, []);

  const handleCreateStoryClick = () => {
    window.location.href = "/create";
  };

  const handleStoryClick = (id) => {
    window.location.href = `story/${id}`;
  };

  return (
    <div className="home">
      <div className="App">
        <div className="container">
          <header>
            <h1>Lista de Histórias</h1>
            <button id="create-story-button" onClick={handleCreateStoryClick}>
              Criar Nova História
            </button>
          </header>
          <main>
            <ul id="story-list">
              {stories.map((story) => (
                <li key={story.id} onClick={() => handleStoryClick(story.id)}>
                  <h2>{story.title}</h2>
                  <p>
                    Data de criação:{" "}
                    {new Date(story.date * 1000).toLocaleDateString()}
                  </p>
                </li>
              ))}
            </ul>
          </main>
        </div>
      </div>
    </div>
  );
}

export default Home;
