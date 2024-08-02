import OpenAI from 'openai';

const generate = async (
  titleParam,
  placeParam,
  mainCharacterParam,
  mainCharacterDescriptionParam,
  contextParam,
  problemParam,
  mainGoalParam,
  detailsParam
) => {
  const openai_api_key = process.env.REACT_APP_OPENAI_API_KEY;
  const openai = new OpenAI({ apiKey: openai_api_key, dangerouslyAllowBrowser: true });

  const prompt = `
  Crie uma história infantil encantadora e fantasiosa que cative o coração de uma criança. A história deve ser apropriada para crianças e deve incluir os seguintes elementos:
  
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

  const response = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: prompt },
    ],
    // temperature: 0.9,
    // top_p: 1,
    // frequency_penalty: 0,
    // presence_penalty: 0,
  });

  return response.choices[0].message.content.trim();
};

export default generate;
