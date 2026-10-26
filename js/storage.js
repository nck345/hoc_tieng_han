const STORAGE_KEY="topik2300_progress_v1";
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
			stats:{totalWordsLearned:0,quizzesTaken:0,perfectQuizzes:0,lastStudyDate:null}
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
	resetUnit(unitId){
		this.data.completedUnits=this.data.completedUnits.filter(id=>id!==unitId);
		delete this.data.inProgressUnits[unitId];
		this.save();
	}
	resetAll(){
		this.data={
			completedUnits:[],
			inProgressUnits:{},
			learnedWords:{},
			recentLearnedWords:[],
			stats:{totalWordsLearned:0,quizzesTaken:0,perfectQuizzes:0,lastStudyDate:null}
		};
		this.save();
	}
	getRecentWords(unitWordList,count=10){
		if(!unitWordList||unitWordList.length===0)return[];
		const learnedInUnit=unitWordList.filter(w=>this.data.learnedWords[w.id]);
		if(learnedInUnit.length===0)return unitWordList.slice(0,Math.min(count,unitWordList.length));
		return learnedInUnit.slice(-count);
	}
	recordQuizResult(totalQuestions,correctCount){
		++this.data.stats.quizzesTaken;
		if(correctCount===totalQuestions)++this.data.stats.perfectQuizzes;
		this.save();
	}
}
window.learningStorage=new LearningStorage();
