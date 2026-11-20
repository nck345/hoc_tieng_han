const fs=require('fs');
const path=require('path');

let errors=[];
let dataContent=fs.readFileSync('js/exam_data.js','utf8');
if(!dataContent.startsWith('window.EXAM_DATA = ')){
	errors.push('exam_data.js does not start with window.EXAM_DATA');
}
let rawJson=dataContent.substring('window.EXAM_DATA = '.length).replace(/;\s*$/,'');
let examData;
try{
	examData=JSON.parse(rawJson);
}catch(e){
	errors.push('Failed to parse exam_data.js JSON: '+e.message);
}

if(examData){
	const cats=examData.categories||[];
	const expectedCats=['de_thi_that','topik_master','hot_topik','hop_kyuk_ui_sin'];
	expectedCats.forEach(c=>{
		if(!cats.find(x=>x.id===c))errors.push('Missing category: '+c);
	});
	const qs=examData.questions||[];
	console.log(`Total questions in exam_data.js: ${qs.length}`);
	const seenIds=new Set();
	let dupeCount=0;
	let undefinedCount=0;
	let passageLeakCount=0;
	let missingImgCount=0;
	for(let i=0;i<qs.length;++i){
		const q=qs[i];
		if(seenIds.has(q.id)){
			errors.push(`Duplicate question id: ${q.id}`);
			++dupeCount;
		}
		seenIds.add(q.id);
		if(JSON.stringify(q).includes('undefined')){
			++undefinedCount;
		}
		if(q.passage&&q.passage.includes('①')){
			++passageLeakCount;
		}
		if(q.section==='listening'&&(q.examId==='real_96'||q.examId==='real_102')&&q.questionNumber<=3){
			(q.options||[]).forEach(opt=>{
				if(opt.image&&!fs.existsSync(opt.image)){
					errors.push(`Missing choice image file: ${opt.image}`);
					++missingImgCount;
				}
			});
		}
	}
	if(dupeCount>0)errors.push(`Found ${dupeCount} duplicate IDs`);
	if(undefinedCount>0)errors.push(`Found ${undefinedCount} questions with 'undefined' text`);
	if(passageLeakCount>0)errors.push(`Found ${passageLeakCount} questions with leaked option ① in passage`);
	const packs=examData.packs||[];
	console.log(`Total packs: ${packs.length}`);
	if(packs.length!==10)errors.push(`Expected 10 packs, got ${packs.length}`);
	packs.forEach(p=>{
		if(!p.questions||p.questions.length!==10){
			errors.push(`Pack ${p.typeId} does not have exactly 10 questions (has ${p.questions?p.questions.length:0})`);
		}
		const packIds=new Set();
		(p.questions||[]).forEach(pq=>{
			if(packIds.has(pq.id))errors.push(`Pack ${p.typeId} has duplicate question: ${pq.id}`);
			packIds.add(pq.id);
		});
	});
}

try{
	require('../js/audio.js');
}catch(e){
	if(!e.message.includes('window')&&!e.message.includes('navigator'))errors.push('Syntax error in js/audio.js: '+e.message);
}
try{
	require('../js/app.js');
}catch(e){
	if(!e.message.includes('window')&&!e.message.includes('document'))errors.push('Syntax error in js/app.js: '+e.message);
}

if(errors.length>0){
	console.error('VERIFICATION FAILED:');
	errors.forEach(err=>console.error(' - '+err));
	process.exit(1);
}else{
	console.log('ALL INTEGRITY CHECKS PASSED PERFECTLY!');
	process.exit(0);
}
