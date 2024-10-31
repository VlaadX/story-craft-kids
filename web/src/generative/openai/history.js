import OpenAI from 'openai';

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
  const openai_api_key = process.env.REACT_APP_OPENAI_API_KEY;
  const openai = new OpenAI({ apiKey: openai_api_key, dangerouslyAllowBrowser: true });

  let prompt = `
  Crie uma história infantil encantadora e fantasiosa para uma criança de ${age} anos. A história deve cativar o coração da criança e ser apropriada para a faixa etária.  e deve incluir os seguintes elementos:
  
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
  prompt += "\nA história deve ser curta e com linguagem muito simples, com frases curtas e elementos visuais encantadores. adequado para uma crianca de menos de 5 anos que nao sabe ler direito";
} else if (age <= 8) {
  prompt += "\nA história deve ter um enredo simples e encantador, adequado para crianças pequenas, com uma linguagem simples. adequado para uma crianca entre 6 e 8 anos que ja sabe ler";
} else {
  prompt += "\nA história pode ter um enredo um pouco mais complexo, mas ainda adequado para uma criança, com uma linguagem leve e agradável.";
}

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
