const fs = require('fs');

global.window = global;
global.localStorage = {
	_data: {},
	getItem(k) { return this._data[k] || null; },
	setItem(k, v) { this._data[k] = v; },
	removeItem(k) { delete this._data[k]; }
};
const makeEl = (id) => {
	const el = {
		id,
		children: [],
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
		querySelectorAll(sel) { return this.children; },
		querySelector(sel) { return this.children[0] || makeEl('sub'); },
		appendChild(child) { this.children.push(child); },
		innerHTML: '',
		textContent: '',
		value: '',
		focus() {}
	};
	return el;
};

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

console.log('Testing Flow 2: Exam Pack (10 questions) & Options Rendering');
app.switchView('exam');
// Test the exact pack from the user's screenshot: pack index 1 (Chọn câu đối đáp tiếp theo)
const pack = app.examData.packs[1];
console.log('Testing Pack:', pack.typeName);
app.startExamFromPack(pack);
console.log('Active exam questions:', app.activeExamQuestions.length);

const optionBtns = app.examEls.qOptionsList.children;
console.log('Rendered options count:', optionBtns.length);
for (let i = 0; i < optionBtns.length; ++i) {
	const html = optionBtns[i].innerHTML;
	console.log(`Option ${i + 1} HTML:`, html);
	if (html.includes('undefined')) {
		console.error(`❌ CRITICAL BUG: Option ${i + 1} contains undefined!`, html);
		process.exit(1);
	}
	if (!optionBtns[i].dataset.index || optionBtns[i].dataset.index === 'undefined') {
		console.error(`❌ CRITICAL BUG: Option ${i + 1} dataset.index is undefined!`);
		process.exit(1);
	}
}

// Simulate user clicking option 1
optionBtns[0]._on_click();
console.log('Selected option after click:', app.selectedExamOption);
app.submitExamAnswer();
console.log('Solution panel display:', app.examEls.solutionPanel.style.display);
console.log('Bird feedback title:', app.examEls.birdTitle.textContent);
console.log('Bird feedback desc:', app.examEls.birdDesc.textContent);

// Verify explanation and options after solution
for (let i = 0; i < optionBtns.length; ++i) {
	if (optionBtns[i].innerHTML.includes('undefined')) {
		console.error(`❌ CRITICAL BUG: Option ${i + 1} contains undefined after solution!`);
		process.exit(1);
	}
}

console.log('Testing Flow 3: Communication Shadowing');
app.switchView('communication');
console.log('Active comm topic tag:', app.commEls.cardTopicTag.textContent);

console.log('Testing Flow 4: Notebook & Bird Gallery');
app.switchView('notebook');
console.log('Notebook items count:', app.storage.getNotebookItems('all').length);
app.switchView('birds');
console.log('✅ ALL VERIFICATIONS PASSED WITH ZERO "undefined"!');
