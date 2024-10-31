import { GoogleGenerativeAI } from "@google/generative-ai";

const generate = async (
  titleParam,
  placeParam,
  mainCharacterParam,
  mainCharacterDescriptionParam,
  contextParam,
  problemParam,
  mainGoalParam,
  detailsParam,
  age
) => {
  const gemini_api_key = process.env.REACT_APP_GEMINI_API_KEY;
  const googleAI = new GoogleGenerativeAI(gemini_api_key);
  const geminiConfig = {
    temperature: 0.9,
    topP: 1,
    topK: 1,
  };

  const geminiModel = googleAI.getGenerativeModel({
    model: "gemini-1.5-flash",
    geminiConfig,
  });

  let prompt = `
  Crie uma história infantil encantadora e fantasiosa que cative o coração de uma criança. A história deve ser apropriada para criaças e deve incluir os seguintes elementos:
  
  ${titleParam ? `Título: ${titleParam}` : ""}
  ${placeParam ? `Local: ${placeParam}` : ""}
  ${mainCharacterParam ? `Personagem principal: ${mainCharacterParam}` : ""}
  ${
    mainCharacterDescriptionParam
      ? `Descrição do personagem principal: ${mainCharacterDescriptionParam}`
      : ""
  }
  ${contextParam ? `Contexto: ${contextParam}` : ""}
  ${problemParam ? `Problema: ${problemParam}` : ""}
  ${mainGoalParam ? `Objetivo principal: ${mainGoalParam}` : ""}
  ${detailsParam ? `Detalhes adicionais: ${detailsParam}` : ""}
  
  Seja detalhista e criativo, adicionando elementos mágicos e encantadores para tornar a história ainda mais envolvente.
  Importante que ela não contenha elementos que possam assustar ou traumatizar a criança.
  Também não deve conter elementos violentos ou inapropriados para menores.
`;
if (age <= 5) {
  prompt += "\nA história deve ser curta e com linguagem muito simples, com frases curtas e elementos visuais encantadores.";
} else if (age <= 8) {
  prompt += "\nA história deve ter um enredo simples e encantador, adequado para crianças pequenas, com uma linguagem simples.";
} else {
  prompt += "\nA história pode ter um enredo um pouco mais complexo, mas ainda adequado para uma criança, com uma linguagem leve e agradável.";
}

  const result = await geminiModel.generateContent(prompt);
  const response = result.response;
  return response.text();
};

export default generate;
