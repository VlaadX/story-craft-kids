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

  const formatDate = (epoch) => {
    const date = new Date(epoch);
    const options = {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    };
    return date.toLocaleString('pt-BR', options);
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
                    {formatDate(story.date)}
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
