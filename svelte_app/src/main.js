import App from './App.svelte';
import serviceWorker from '../public/serviceWorker';

const app = new App({
	target: document.body,
	props: {
		name: 'world'
	}
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.register();

export default app;