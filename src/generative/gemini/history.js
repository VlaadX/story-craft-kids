import { GoogleGenerativeAI } from "@google/generative-ai";

const generate = async (
  titleParam,
  placeParam,
  mainCharacterParam,
  mainCharacterDescriptionParam,
  contextParam,
  problemParam,
  mainGoalParam
) => {
  const gemini_api_key = process.env.REACT_APP_GEMINI_API_KEY;
  const googleAI = new GoogleGenerativeAI( gemini_api_key);
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
    Crie uma grande história infantil fantasiosa e com alguns detalhes na qual uma criança irá gostar.
    A história deve conter os seguintes elementos:
    ${titleParam}
    ${placeParam}
    ${mainCharacterParam}
    ${mainCharacterDescriptionParam}
    ${contextParam}
    ${problemParam}
    ${mainGoalParam}
    Seja detalhista e criativo.
  `;

  const result = await geminiModel.generateContent(prompt);
  const response = result.response;
  return response.text();
};

export default generate;
