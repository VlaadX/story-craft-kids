const TEXT_APIS = {
  openai: "open ai",
  gemini: "gemini"
}

const MAX_IMAGES = 8;

const divideText = (splitedText) => {
  const dividedText = [];
  const partSize = Math.ceil(splitedText.length / MAX_IMAGES);

  for (let i = 0; i < splitedText.length; i += partSize) {
    const part = splitedText.slice(i, Math.min(i + partSize, splitedText.length)).join("\n\n");
    dividedText.push(part);
  }

  return dividedText;
}

const splitText = (text) => {
  const splited = text.split('\n\n');
  const splited_clean = splited.map(t => t.trim()).filter(t => t.length > 0).map(t => t + "\n");

  return splited_clean;
}

export { divideText, splitText, TEXT_APIS };


