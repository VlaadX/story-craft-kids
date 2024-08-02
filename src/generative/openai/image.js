import OpenAI from "openai";

const generate = async (context, mainCharacterDescriptionParam) => {
  const openai_api_key = process.env.REACT_APP_OPENAI_API_KEY;
  const openai = new OpenAI({
    apiKey: openai_api_key,
    dangerouslyAllowBrowser: true,
  });

  const prompt = `
  Crie uma imagem agradavel para uma criança baseada no seguinte contexto:,
  contexto: ${context}
  personagem principal : ${mainCharacterDescriptionParam}

  A imagem está sendo usada para ilustrar uma história infantil.
  É muito importante que a imagem não contenha algo que possa ser considerado ofensivo ou inadequado para crianças.
  É importante que a imagem seja agradável e bem desenhada .
`;

  console.log(prompt);

  const response = await openai.images.generate({
    model: "dall-e-3",
    prompt: prompt,
    // size="1024x1024",
    // quality="standard",
    // n=1
  });

  console.log(response);

  return response.data[0].url;
}

export default generate;
