import './main.css';

const removeFileExtension = (str) => str.replace(/\.(png|jpe?g|svg|gif)$/, '').replace('./', '');

const toDashes = (str) => str.replace('_', '-');

const toCamelCase = (str) => str.replace(/(?:^\w|[A-Z]|\b\w)/g, (ltr, idx) => idx === 0 ? ltr.toLowerCase() : ltr.toUpperCase()).replace(/(\s|\W)+/g, '');

const toElmName = (str) => toCamelCase(toDashes(removeFileExtension(str)));

function importAll(r) {
  let images = {};
  r.keys().map((item, index) => { images[toElmName(item)] = r(item); });
  return images;
}

// Tell Webpack this JS file uses the images in ../assets/images
// image names are converted to 'camelCase' and file suffixes are removed
const images = importAll(require.context('../assets/images', false, /\.(png|jpe?g|gif|svg)$/));


import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: images
});

registerServiceWorker();
