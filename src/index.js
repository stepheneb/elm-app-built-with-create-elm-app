import './main.css';
import actionOkIcon from '../assets/images/Action-ok-icon.png'; // Tell Webpack this JS file uses this image
import actionCancelIcon from '../assets/images/Action-cancel-icon.png'; // Tell Webpack this JS file uses this image


import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    actionOkIcon: actionOkIcon,
    actionCancelIcon: actionCancelIcon
  }
});

registerServiceWorker();
