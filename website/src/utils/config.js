import {homepage} from '../../package.json';

export const origin = new URL(homepage);
const localApiOrigin = new URL('http://localhost:3000');

export const apiOrigin =
  process.env.NODE_ENV === 'development' ? localApiOrigin : origin;
