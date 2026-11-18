const fs = require('fs');
const content = fs.readFileSync('js/exam_data.js', 'utf-8');
const vm = require('vm');
const sandbox = { window: {} };
vm.createContext(sandbox);
vm.runInContext(content, sandbox);
const data = sandbox.window.EXAM_DATA;
console.log('Categories:', data.categories.map(c => ({ id: c.id, name: c.name, examCount: c.exams.length })));
console.log('Question types count:', data.questionTypes.length);
console.log('Question types:', data.questionTypes.map(t => ({ id: t.id, name: t.name })));
console.log('Total questions:', data.questions.length);
const perExam = {};
data.questions.forEach(q => {
    perExam[q.examId] = (perExam[q.examId] || 0) + 1;
});
console.log('Questions per exam:', perExam);
console.log('Sample questions 1-3:');
console.log(JSON.stringify(data.questions.slice(0, 3), null, 2));
