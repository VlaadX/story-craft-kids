import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './home/home';
import Form from './form/form';
import './index.css';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="create" element={<Form />} />
        {/* <Route path="article/:id" element={<ArticleElement />} /> */}
      </Routes>
    </BrowserRouter>
  );
}

export default App;
