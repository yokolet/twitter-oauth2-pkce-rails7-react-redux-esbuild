import { Controller } from "@hotwired/stimulus"
import React from 'react';
import { createRoot } from 'react-dom/client';
import { Provider } from 'react-redux';
import { ChakraProvider } from '@chakra-ui/react';
import { store } from '../app/store';
import App from '../App';

// Connects to data-controller="client"
export default class extends Controller {
  connect() {
    console.log("connected");
    const container = document.getElementById('root');
    const root = createRoot(container);

    root.render(
      <React.StrictMode>
        <Provider store={store}>
          <ChakraProvider>
            <App />
          </ChakraProvider>
        </Provider>
      </React.StrictMode>
    );
  }
}
