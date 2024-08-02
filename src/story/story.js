import React, { useEffect, useState } from "react";
import "./story.css";
import { divideText, splitText } from "../common/utils";
import { redirect } from "react-router-dom";

const Story = () => {
  const [story, setStory] = useState(null);
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    loadStory();
  }, []);

  const loadStory = () => {
    const params = window.location.pathname.split('/');
    const storyId = params[params.length - 1];

    const stories = JSON.parse(localStorage.getItem("stories"));

    if (!stories) {
      setNotFound(true);
      return;
    }

    const story = stories.find((story) => story.id == storyId);

    if (!story) {
      setNotFound(true);
      return;
    }

    setStory(story);
  };

  const formatDate = (timestamp) => {
    const date = new Date(timestamp * 1000);
    return (
      date.toLocaleDateString("pt-BR") +
      " " +
      date.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" })
    );
  };

  const generatePDF = () => {
    window.print();
  }

  const redirectToForm = () => {
    window.open("https://forms.gle/PfodSdF2oqxgYUvw7", '_blank');
  }

  if (notFound) {
    return <div id="not-found-message">História não encontrada</div>;
  }

  if (!story) {
    return <div>Carregando...</div>;
  }

  const paragraphs = divideText(splitText(story.body));
  const images = story.images;

  return (
    <div className="story">
      <div className="container">
        <header>
          <h1 id="story-title">{story.title}</h1>
          <p id="story-date">Data de Criação: {formatDate(story.date)}</p>
        </header>
        <main id="story-content">
          {paragraphs.map((paragraph, index) => (
            <React.Fragment key={index}>
              <p>{paragraph}</p>
              {images[index] && (
                <img src={images[index]} alt={`Imagem ${index + 1}`} />
              )}
            </React.Fragment>
          ))}
        </main>
        <button className="pdf" onClick={generatePDF}>Gerar PDF</button>
        <br />
        <button className="google-form" onClick={redirectToForm}>Preencha o formulário de satisfação por favor :)</button>
      </div>
    </div>
  );
};

export default Story;
