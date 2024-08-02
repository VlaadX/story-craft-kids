import React, { useState } from "react";
import gemini_generate_history from "../generative/gemini/history";
import openai_generate_history from "../generative/openai/history";
import openai_generate_image from "../generative/openai/image";
import gemini_generate_description from "../generative/gemini/character_description";
import "./form.css";
import { divideText, splitText } from "../common/utils";

function Form() {
  const [title, setTitle] = useState("");
  const [place, setPlace] = useState("");
  const [mainCharacter, setMainCharacter] = useState("");
  const [mainCharacterDescription, setMainCharacterDescription] = useState("");
  const [context, setContext] = useState("");
  const [problem, setProblem] = useState("");
  const [mainGoal, setMainGoal] = useState("");
  const [details, setDetails] = useState("");
  const [api, setApi] = useState("gemini");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setIsLoading(true);

    const stories = JSON.parse(localStorage.getItem("stories")) || [];

    const better_character_description = await gemini_generate_description(mainCharacterDescription);
    console.log(mainCharacterDescription);
    console.log(better_character_description);

    const generate_function = api === "openai" ? openai_generate_history : gemini_generate_history;

    const story_body = remove_markdown(
      await generate_function(
        title,
        place,
        mainCharacter,
        better_character_description,
        context,
        problem,
        mainGoal,
        details
      )
    );

    const paragraphs = divideText(splitText(story_body));

    console.log(paragraphs);

    const images = [];

    for (let i = 0; i < paragraphs.length; i++) {
      const url = await openai_generate_image(paragraphs[i], better_character_description);
      images.push(url);
    }

    console.log(images);

    const storyId = stories.length + 1;

    const newStory = {
      id: storyId,
      title,
      date: Date.now(),
      api,
      body: story_body,
      images: images,
    };

    stories.push(newStory);

    localStorage.setItem("stories", JSON.stringify(stories));

    window.location.href = "/story/" + storyId;
  };

  function remove_markdown(markdownText) {
    const regexHeaders = /##.*\n/g;
    let cleanedText = markdownText.replace(regexHeaders, "");

    const regexBold = /\*\*(.*?)\*\*/g;
    cleanedText = cleanedText.replace(regexBold, (_match, p1) => p1);

    const regexBoldUnderscore = /__(.*?)__/g;
    cleanedText = cleanedText.replace(regexBoldUnderscore, (_match, p1) => p1);

    return cleanedText;
  }

  return (
    <div className="form">
      {isLoading ? (
        <div className="loading-screen">
          Gerando sua história, por favor aguarde...
        </div>
      ) : (
        <div className="container">
          <h1>Criar Nova História</h1>
          <form id="story-form" onSubmit={handleSubmit}>
            <div className="form-group">
              <label htmlFor="title">Título</label>
              <input
                type="text"
                id="title"
                name="title"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                required={true}
              />
            </div>
            <div className="form-group">
              <label htmlFor="place">Lugar</label>
              <input
                type="text"
                id="place"
                name="place"
                value={place}
                onChange={(e) => setPlace(e.target.value)}
                required={true}
              />
            </div>
            <div className="form-group">
              <label htmlFor="mainCharacter">Personagem Principal (Nome)</label>
              <input
                type="text"
                id="mainCharacter"
                name="mainCharacter"
                value={mainCharacter}
                onChange={(e) => setMainCharacter(e.target.value)}
                required={true}
              />
            </div>
            <div className="form-group">
              <label htmlFor="mainCharacterDescription">
                Descrição do Personagem Principal
              </label>
              <input
                type="text"
                id="mainCharacterDescription"
                name="mainCharacterDescription"
                value={mainCharacterDescription}
                onChange={(e) => setMainCharacterDescription(e.target.value)}
                required={true}
              />
            </div>
            <div className="form-group">
              <label htmlFor="context">Contexto</label>
              <textarea
                id="context"
                name="context"
                value={context}
                onChange={(e) => setContext(e.target.value)}
              ></textarea>
            </div>
            <div className="form-group">
              <label htmlFor="problem">Problema</label>
              <textarea
                id="problem"
                name="problem"
                value={problem}
                onChange={(e) => setProblem(e.target.value)}
              ></textarea>
            </div>
            <div className="form-group">
              <label htmlFor="mainGoal">Objetivo Principal</label>
              <textarea
                id="mainGoal"
                name="mainGoal"
                value={mainGoal}
                onChange={(e) => setMainGoal(e.target.value)}
              ></textarea>
            </div>
            <div className="form-group">
              <label htmlFor="details">Detalhes</label>
              <textarea
                id="details"
                name="details"
                value={details}
                onChange={(e) => setDetails(e.target.value)}
              ></textarea>
            </div>
            <div className="form-group">
              <label htmlFor="api">API</label>
              <select
                id="api"
                name="api"
                className="styled-select"
                value={api}
                onChange={(e) => setApi(e.target.value)}
              >
                <option value="gemini">Gemini</option>
                <option value="openai">OpenAI</option>
              </select>
            </div>
            <button type="submit">Salvar</button>
          </form>
        </div>
      )}
    </div>
  );
}

export default Form;
