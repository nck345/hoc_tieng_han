const STORAGE_KEY="topik2300_progress_v2";
class LearningStorage{
	constructor(){
		this.data=this.load();
	}
	load(){
		try{
			const raw=localStorage.getItem(STORAGE_KEY);
			if(raw)return JSON.parse(raw);
		}catch(e){}
		return{
			completedUnits:[],
			inProgressUnits:{},
			learnedWords:{},
			recentLearnedWords:[],
			stats:{totalWordsLearned:0,quizzesTaken:0,perfectQuizzes:0,lastStudyDate:null},
			notebook:[],
			birdCollection:[
				{id:"bird-happy",name:"Chim Vui Vẻ",desc:"Chú chim sẻ may mắn khởi đầu hành trình học tiếng Hàn.",icon:"assets/birds/bird-happy.svg",unlockedAt:new Date().toISOString(),reason:"Gia nhập ứng dụng"}
			],
			examAnswers:{},
			packScores:{}
		};
	}
	save(){
		try{
			localStorage.setItem(STORAGE_KEY,JSON.stringify(this.data));
		}catch(e){}
	}
	getUnitStatus(unitId,totalWords){
		if(this.data.completedUnits.includes(unitId))return"completed";
		const prog=this.data.inProgressUnits[unitId];
		if(prog&&prog.learnedWordIds&&prog.learnedWordIds.length>0){
			if(prog.learnedWordIds.length>=totalWords)return"completed";
			return"in_progress";
		}
		return"not_started";
	}
	getUnitProgress(unitId,totalWords){
		const isComp=this.data.completedUnits.includes(unitId);
		const prog=this.data.inProgressUnits[unitId]||{learnedWordIds:[],lastWordIndex:0};
		const count=isComp?totalWords:prog.learnedWordIds.length;
		const pct=totalWords>0?Math.round((count/totalWords)*100):0;
		return{
			status:isComp?"completed":(count>0?"in_progress":"not_started"),
			learnedCount:count,
			totalCount:totalWords,
			percent:isComp?100:pct,
			lastWordIndex:prog.lastWordIndex||0
		};
	}
	markWordLearned(unitId,wordId,wordIndex){
		if(!this.data.inProgressUnits[unitId]){
			this.data.inProgressUnits[unitId]={learnedWordIds:[],lastWordIndex:0};
		}
		const prog=this.data.inProgressUnits[unitId];
		prog.lastWordIndex=wordIndex;
		if(!prog.learnedWordIds.includes(wordId)){
			prog.learnedWordIds.push(wordId);
			if(!this.data.learnedWords[wordId]){
				this.data.learnedWords[wordId]=Date.now();
				++this.data.stats.totalWordsLearned;
			}
			this.data.recentLearnedWords=this.data.recentLearnedWords.filter(id=>id!==wordId);
			this.data.recentLearnedWords.push(wordId);
			if(this.data.recentLearnedWords.length>50)this.data.recentLearnedWords.shift();
		}
		this.data.stats.lastStudyDate=new Date().toISOString();
		this.save();
	}
	markUnitCompleted(unitId){
		if(!this.data.completedUnits.includes(unitId)){
			this.data.completedUnits.push(unitId);
		}
		this.save();
	}
	recordQuizResult(totalQuestions,correctCount){
		++this.data.stats.quizzesTaken;
		if(correctCount===totalQuestions)++this.data.stats.perfectQuizzes;
		this.save();
	}
	isBookmarked(korean){
		if(!this.data.notebook)this.data.notebook=[];
		return this.data.notebook.some(item=>item.korean===korean);
	}
	toggleNotebookItem(item){
		if(!this.data.notebook)this.data.notebook=[];
		const idx=this.data.notebook.findIndex(n=>n.korean===item.korean);
		if(idx>=0){
			this.data.notebook.splice(idx,1);
			this.save();
			return false;
		}
		this.data.notebook.unshift({
			id:"nb_"+Date.now()+"_"+Math.random().toString(36).substr(2,4),
			type:item.type||"vocab",
			korean:item.korean,
			vietnamese:item.vietnamese||"",
			pos:item.pos||"",
			example:item.example||"",
			source:item.source||"Đề thi",
			dateAdded:new Date().toLocaleDateString("vi-VN")
		});
		this.save();
		return true;
	}
	removeNotebookItem(id){
		if(!this.data.notebook)return;
		this.data.notebook=this.data.notebook.filter(n=>n.id!==id);
		this.save();
	}
	getNotebookItems(filterType="all"){
		if(!this.data.notebook)this.data.notebook=[];
		if(filterType==="all")return this.data.notebook;
		return this.data.notebook.filter(n=>n.type===filterType||n.source===filterType);
	}
	unlockBird(birdId,name,desc,icon,reason){
		if(!this.data.birdCollection)this.data.birdCollection=[];
		if(this.data.birdCollection.some(b=>b.id===birdId))return false;
		this.data.birdCollection.push({
			id:birdId,
			name,
			desc,
			icon,
			unlockedAt:new Date().toISOString(),
			reason
		});
		this.save();
		return true;
	}
	getBirds(){
		if(!this.data.birdCollection)this.data.birdCollection=[];
		return this.data.birdCollection;
	}
	recordExamAnswer(qId,userAns,isCorrect){
		if(!this.data.examAnswers)this.data.examAnswers={};
		this.data.examAnswers[qId]={userAnswer:userAns,isCorrect,time:Date.now()};
		this.save();
	}
	getExamAnswer(qId){
		if(!this.data.examAnswers)return null;
		return this.data.examAnswers[qId]||null;
	}
	recordPackResult(packId,score,total){
		if(!this.data.packScores)this.data.packScores={};
		this.data.packScores[packId]={score,total,completed:true,time:Date.now()};
		this.save();
	}
}
window.learningStorage=new LearningStorage();
