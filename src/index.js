import './main.css';
import imagePath from '../assets/images/Action-ok-icon.png'; // Tell Webpack this JS file uses this image

import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: imagePath
});

registerServiceWorker();
