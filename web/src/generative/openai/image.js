import OpenAI from "openai";

const generate = async (context, mainCharacterDescriptionParam, style) => {
  const openai_api_key = process.env.REACT_APP_OPENAI_API_KEY;
  const openai = new OpenAI({
    apiKey: openai_api_key,
    dangerouslyAllowBrowser: true,
  });

  const prompt = `
  Crie uma imagem encantadora e adequada para crianças.
  O cenário deve ser baseado no seguinte contexto: ${context}.
  O personagem principal é: ${mainCharacterDescriptionParam}.
  A imagem deve apresentar cores vibrantes e elementos visuais lúdicos, focando em criar um ambiente acolhedor e amigável para crianças.
  Evite incluir qualquer tipo de texto, números ou símbolos na cena. 
`;


  console.log("contexto: ", context);


  const response = await openai.images.generate({
    model: "dall-e-3",
    prompt: prompt,
  });


  return response.data[0].url;
}

export default generate;
