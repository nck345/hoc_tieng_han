const fs = require('fs');

global.window = global;
global.localStorage = {
	_data: {},
	getItem(k) { return this._data[k] || null; },
	setItem(k, v) { this._data[k] = v; },
	removeItem(k) { delete this._data[k]; }
};
global.document = {
	getElementById(id) {
		return {
			id,
			classList: {
				add() {}, remove() {}, toggle() {}, contains() { return false; }
			},
			addEventListener() {},
			style: {},
			dataset: {},
			querySelectorAll() { return []; },
			appendChild() {},
			innerHTML: '',
			textContent: '',
			focus() {}
		};
	},
	createElement(tag) {
		return {
			tagName: tag,
			classList: { add() {}, remove() {}, toggle() {} },
			addEventListener() {},
			style: {},
			dataset: {},
			querySelectorAll() { return []; },
			querySelector() { return { addEventListener() {} }; },
			appendChild() {},
			innerHTML: '',
			textContent: ''
		};
	},
	addEventListener(evt, cb) {
		if (evt === 'DOMContentLoaded') cb();
	}
};
global.Audio = class {
	constructor(url) { this.url = url; }
	play() { return Promise.resolve(); }
	pause() {}
};

try {
	require('../js/data.js');
	console.log('✓ data.js loaded successfully. Units:', global.TOPIC_UNITS.length);
	require('../js/exam_data.js');
	console.log('✓ exam_data.js loaded successfully. Categories:', global.EXAM_DATA.categories.length, 'Packs:', global.EXAM_DATA.packs.length);
	require('../js/communication_data.js');
	console.log('✓ communication_data.js loaded successfully. Beginner topics:', global.COMMUNICATION_DATA.beginner.length, 'Intermediate:', global.COMMUNICATION_DATA.intermediate.length);
	require('../js/storage.js');
	console.log('✓ storage.js loaded successfully.');
	require('../js/grammar.js');
	console.log('✓ grammar.js loaded successfully.');
	require('../js/audio.js');
	console.log('✓ audio.js loaded successfully.');
	require('../js/app.js');
	console.log('✓ app.js loaded and instantiated successfully! App views:', Object.keys(global.app.views));
} catch (e) {
	console.error('❌ Error loading scripts:', e);
	process.exit(1);
}
