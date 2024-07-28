import React, { useState } from "react";
import gemini_generate_history from "../generative/gemini/history";
import "./form.css";

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

  const handleSubmit = async (event) => {
    event.preventDefault();

    const newStory = {
      title,
      place,
      mainCharacter,
      mainCharacterDescription,
      context,
      problem,
      mainGoal,
      details,
      api,
    };

    console.log("New Story:", newStory);
    console.log("Generating story...");
    console.log(await gemini_generate_history())
    console.log("Generated!");


    // Limpar o formulário após o envio
    setTitle("");
    setPlace("");
    setMainCharacter("");
    setMainCharacterDescription("");
    setContext("");
    setProblem("");
    setMainGoal("");
    setDetails("");
    setApi("gemini");
  };

  return (
    <div className="form">
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
            />
          </div>
          <div className="form-group">
            <label htmlFor="mainCharacter">Personagem Principal</label>
            <input
              type="text"
              id="mainCharacter"
              name="mainCharacter"
              value={mainCharacter}
              onChange={(e) => setMainCharacter(e.target.value)}
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
              <option value="open ai">Open AI</option>
            </select>
          </div>
          <button type="submit">Salvar</button>
        </form>
      </div>
    </div>
  );
}

export default Form;
