import { GoogleGenerativeAI } from "@google/generative-ai";

const generate = async (mainCharacterDescriptionParam) => {
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

  const prompt = `
    Crie uma descrição física com mais detalhes para o personagem principal de uma história infantil.
    A descrição deve ser basear nessas informações: ${mainCharacterDescriptionParam}.
`;

  const result = await geminiModel.generateContent(prompt);
  const response = result.response;
  return response.text();
};

export default generate;
