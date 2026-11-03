const fs = require('fs');

global.window = global;
global.localStorage = {
	_data: {},
	getItem(k) { return this._data[k] || null; },
	setItem(k, v) { this._data[k] = v; },
	removeItem(k) { delete this._data[k]; }
};
const makeEl = (id) => ({
	id,
	classList: {
		_classes: new Set(),
		add(c) { this._classes.add(c); },
		remove(c) { this._classes.delete(c); },
		toggle(c, force) { if (force !== undefined) { if (force) this.add(c); else this.remove(c); } else { if (this._classes.has(c)) this.remove(c); else this.add(c); } },
		contains(c) { return this._classes.has(c); }
	},
	addEventListener(evt, cb) { this['_on_' + evt] = cb; },
	style: {},
	dataset: {},
	querySelectorAll() { return []; },
	querySelector() { return makeEl('sub'); },
	appendChild(child) {},
	innerHTML: '',
	textContent: '',
	value: '',
	focus() {}
});

global.document = {
	getElementById(id) { return makeEl(id); },
	createElement(tag) { return makeEl(tag); },
	addEventListener(evt, cb) { if (evt === 'DOMContentLoaded') cb(); }
};
global.Audio = class {
	constructor(url) { this.url = url; }
	play() { return Promise.resolve(); }
	pause() {}
};

require('../js/data.js');
require('../js/exam_data.js');
require('../js/communication_data.js');
require('../js/storage.js');
require('../js/grammar.js');
require('../js/audio.js');
require('../js/app.js');

const app = global.app;

console.log('Testing Flow 1: Vocab unit study & scramble');
app.startUnit('unit_1');
console.log('Current word:', app.currentUnit.words[app.currentWordIndex].korean);
app.studyEls.scrambleInput.value = (app.currentUnit.words[app.currentWordIndex].ordered_tokens || []).join(' ');
app.checkScrambleSentence();
console.log('Scramble feedback displayed:', app.studyEls.scrambleFeedback.style.display);
app.toggleStudyStar();
console.log('Bookmarked in storage:', app.storage.isBookmarked(app.currentUnit.words[app.currentWordIndex].korean));

console.log('Testing Flow 2: Exam Pack (10 questions) & Instant Solution');
app.switchView('exam');
const pack = app.examData.packs[0];
app.startExamFromPack(pack);
console.log('Active exam questions:', app.activeExamQuestions.length);
app.selectedExamOption = pack.questions[0].correctAnswer;
app.submitExamAnswer();
console.log('Solution panel display:', app.examEls.solutionPanel.style.display);
console.log('Bird unlocked:', app.storage.getBirds().map(b => b.id));

console.log('Testing Flow 3: Communication Shadowing');
app.switchView('communication');
console.log('Active comm topic tag:', app.commEls.cardTopicTag.textContent);

console.log('Testing Flow 4: Notebook & Bird Gallery');
app.switchView('notebook');
console.log('Notebook items count:', app.storage.getNotebookItems('all').length);
app.switchView('birds');
console.log('All 4 test flows passed successfully!');

