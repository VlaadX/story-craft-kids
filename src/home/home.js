import React, { useEffect, useState } from "react";
import "./home.css";

function Home() {
  const [stories, setStories] = useState([]);

  useEffect(() => {
    // Simulando a carga de histórias do localStorage
    const initialStories = [
      {
        id: 1,
        title: "Aventuras na Floresta",
        date: 1689811200,
        api: "gemini",
        body: "Uma emocionante jornada pela floresta amazônica.".repeat(100),
        image_1_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_2_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_3_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_4_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_5_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_6_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_7_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
        image_8_url:
          "https://avatars.githubusercontent.com/u/62778691?s=400&u=855736d03392dacac209820cf0969e0112501fbe&v=4",
      },
    ];
    localStorage.setItem("stories", JSON.stringify(initialStories));

    const loadedStories = JSON.parse(localStorage.getItem("stories")) || [];
    setStories(loadedStories);
  }, []);

  const handleCreateStoryClick = () => {
    window.location.href = "/create";
  };

  const handleStoryClick = (id) => {
    window.location.href = `history/index.html?id=${id}`;
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
