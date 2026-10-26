class TopikApp{
	constructor(){
		this.units=window.TOPIC_UNITS||[];
		this.storage=window.learningStorage;
		this.grammar=window.koreanGrammarChecker;
		this.audio=window.audioManager;
		this.currentUnit=null;
		this.currentWordIndex=0;
		this.wordsLearnedInSession=0;
		this.sessionWordHistory=[];
		this.audioSpeed=1.0;
		this.activeCategory="all";
		this.activeStatus="all";
		this.searchQuery="";
		this.quizState={
			active:false,
			questions:[],
			currentIndex:0,
			userRecordedUrl:null,
			correctCount:0,
			speechResult:null
		};
		this.initElements();
		this.bindEvents();
		this.renderStats();
		this.renderUnits();
	}
	initElements(){
		this.views={
			home:document.getElementById("view-home"),
			exam:document.getElementById("view-exam"),
			units:document.getElementById("view-units"),
			study:document.getElementById("view-study")
		};
		this.navTabs={
			study:document.getElementById("tab-study"),
			exam:document.getElementById("tab-exam")
		};
		this.statsEls={
			learnedCount:document.getElementById("stat-learned-count"),
			completedUnits:document.getElementById("stat-completed-units")
		};
		this.unitsGrid=document.getElementById("units-grid");
		this.searchInput=document.getElementById("search-units");
		this.categoryPills=document.getElementById("category-pills");
		this.statusPills=document.getElementById("status-pills");
		this.studyEls={
			unitTitle:document.getElementById("study-unit-title"),
			wordProgressText:document.getElementById("study-word-progress-text"),
			progressFill:document.getElementById("study-progress-fill"),
			posBadge:document.getElementById("study-pos-badge"),
			hanjaBadge:document.getElementById("study-hanja-badge"),
			koreanWord:document.getElementById("study-korean-word"),
			btnAudio:document.getElementById("btn-study-audio"),
			btnSpeed:document.getElementById("btn-study-speed"),
			vietnameseText:document.getElementById("study-vietnamese-text"),
			collocationsWrap:document.getElementById("study-collocations-wrap"),
			collocationsList:document.getElementById("study-collocations-list"),
			hintWords:document.getElementById("study-hint-words"),
			sentenceInput:document.getElementById("study-sentence-input"),
			btnCheckGrammar:document.getElementById("btn-check-grammar"),
			grammarFeedback:document.getElementById("study-grammar-feedback"),
			btnPrev:document.getElementById("btn-prev-word"),
			btnNext:document.getElementById("btn-next-word")
		};
		this.quizModal=document.getElementById("quiz-modal");
		this.quizEls={
			progressText:document.getElementById("quiz-progress-text"),
			viWord:document.getElementById("quiz-vi-word"),
			posHint:document.getElementById("quiz-pos-hint"),
			koreanInput:document.getElementById("quiz-korean-input"),
			btnMic:document.getElementById("btn-quiz-mic"),
			recStatus:document.getElementById("quiz-rec-status"),
			playbackArea:document.getElementById("quiz-playback-area"),
			btnPlayUserVoice:document.getElementById("btn-play-user-voice"),
			btnCheckAnswer:document.getElementById("btn-quiz-check"),
			feedbackBox:document.getElementById("quiz-feedback-box"),
			btnNextQuestion:document.getElementById("btn-quiz-next-q"),
			summaryCard:document.getElementById("quiz-summary-card"),
			questionCard:document.getElementById("quiz-question-card"),
			summaryScore:document.getElementById("quiz-summary-score"),
			btnFinishQuiz:document.getElementById("btn-finish-quiz")
		};
		this.completeModal=document.getElementById("complete-modal");
		this.completeEls={
			unitTitle:document.getElementById("complete-unit-title"),
			countdown:document.getElementById("complete-countdown"),
			btnBack:document.getElementById("btn-complete-back")
		};
	}
	bindEvents(){
		document.getElementById("brand-home").addEventListener("click",()=>this.switchView("home"));
		this.navTabs.study.addEventListener("click",()=>this.switchView("units"));
		this.navTabs.exam.addEventListener("click",()=>this.switchView("exam"));
		document.getElementById("btn-start-study").addEventListener("click",()=>this.switchView("units"));
		document.getElementById("btn-start-exam").addEventListener("click",()=>this.switchView("exam"));
		document.getElementById("btn-exam-back").addEventListener("click",()=>this.switchView("home"));
		document.getElementById("btn-exam-to-study").addEventListener("click",()=>this.switchView("units"));
		document.getElementById("btn-study-back").addEventListener("click",()=>this.switchView("units"));
		this.searchInput.addEventListener("input",e=>{
			this.searchQuery=e.target.value.trim().toLowerCase();
			this.renderUnits();
		});
		this.categoryPills.addEventListener("click",e=>{
			if(!e.target.classList.contains("filter-pill"))return;
			this.categoryPills.querySelectorAll(".filter-pill").forEach(p=>p.classList.remove("active"));
			e.target.classList.add("active");
			this.activeCategory=e.target.dataset.cat;
			this.renderUnits();
		});
		this.statusPills.addEventListener("click",e=>{
			if(!e.target.classList.contains("filter-pill"))return;
			this.statusPills.querySelectorAll(".filter-pill").forEach(p=>p.classList.remove("active"));
			e.target.classList.add("active");
			this.activeStatus=e.target.dataset.status;
			this.renderUnits();
		});
		this.studyEls.btnAudio.addEventListener("click",()=>this.playCurrentWordAudio());
		this.studyEls.btnSpeed.addEventListener("click",()=>{
			this.audioSpeed=this.audioSpeed===1.0?0.8:1.0;
			this.studyEls.btnSpeed.textContent=this.audioSpeed===1.0?"1.0x":"0.8x Chậm";
		});
		this.studyEls.btnCheckGrammar.addEventListener("click",()=>this.checkSentenceGrammar());
		this.studyEls.btnPrev.addEventListener("click",()=>this.prevWord());
		this.studyEls.btnNext.addEventListener("click",()=>this.nextWord());
		this.quizEls.btnMic.addEventListener("click",()=>this.toggleQuizRecording());
		this.quizEls.btnPlayUserVoice.addEventListener("click",()=>{
			if(this.quizState.userRecordedUrl)this.audio.playAudioUrl(this.quizState.userRecordedUrl);
		});
		this.quizEls.btnCheckAnswer.addEventListener("click",()=>this.checkQuizAnswer());
		this.quizEls.btnNextQuestion.addEventListener("click",()=>this.nextQuizQuestion());
		this.quizEls.btnFinishQuiz.addEventListener("click",()=>this.finishQuizAndResumeStudy());
		this.completeEls.btnBack.addEventListener("click",()=>{
			this.completeModal.classList.remove("active");
			this.switchView("units");
		});
	}
	switchView(viewName){
		Object.keys(this.views).forEach(key=>{
			this.views[key].classList.toggle("active",key===viewName);
		});
		this.navTabs.study.classList.toggle("active",viewName==="units"||viewName==="study");
		this.navTabs.exam.classList.toggle("active",viewName==="exam");
		window.scrollTo({top:0,behavior:"smooth"});
		if(viewName==="units"){
			this.renderStats();
			this.renderUnits();
		}
	}
	renderStats(){
		let totalLearned=0;
		let completed=0;
		for(let i=0;i<this.units.length;++i){
			const u=this.units[i];
			const prog=this.storage.getUnitProgress(u.id,u.words.length);
			totalLearned+=prog.learnedCount;
			if(prog.status==="completed")++completed;
		}
		this.statsEls.learnedCount.textContent=totalLearned;
		this.statsEls.completedUnits.textContent=`${completed}/${this.units.length}`;
	}
	renderUnits(){
		this.unitsGrid.innerHTML="";
		const filtered=this.units.filter(u=>{
			if(this.activeCategory!=="all"&&u.category!==this.activeCategory)return false;
			const prog=this.storage.getUnitProgress(u.id,u.words.length);
			if(this.activeStatus!=="all"&&prog.status!==this.activeStatus)return false;
			if(this.searchQuery){
				const matchKo=u.titleKo.toLowerCase().includes(this.searchQuery);
				const matchVi=u.titleVi.toLowerCase().includes(this.searchQuery);
				const matchDay=`day ${u.day}`.includes(this.searchQuery);
				if(!matchKo&&!matchVi&&!matchDay)return false;
			}
			return true;
		});
		if(filtered.length===0){
			this.unitsGrid.innerHTML=`<div style="grid-column:1/-1;text-align:center;padding:48px;color:var(--text-muted);font-weight:600;">Không tìm thấy bài học nào phù hợp với bộ lọc.</div>`;
			return;
		}
		for(let i=0;i<filtered.length;++i){
			const u=filtered[i];
			const prog=this.storage.getUnitProgress(u.id,u.words.length);
			const card=document.createElement("div");
			card.className="unit-card";
			let statusLabel="Chưa học";
			if(prog.status==="completed")statusLabel="Đã hoàn thành";
			else if(prog.status==="in_progress")statusLabel="Đang học";
			card.innerHTML=`
				<div>
					<div class="unit-card-top">
						<span class="day-tag">DAY ${u.day}</span>
						<span class="status-badge ${prog.status}">${statusLabel}</span>
					</div>
					<h4>${u.titleKo}</h4>
					<p class="unit-vi-title">${u.titleVi}</p>
				</div>
				<div class="unit-progress-container">
					<div class="unit-progress-bar">
						<div class="unit-progress-fill" style="width:${prog.percent}%"></div>
					</div>
					<div class="unit-progress-text">
						<span>${prog.learnedCount}/${u.words.length} từ</span>
						<span>${prog.percent}%</span>
					</div>
				</div>
			`;
			card.addEventListener("click",()=>this.startUnit(u.id));
			this.unitsGrid.appendChild(card);
		}
	}
	startUnit(unitId){
		const u=this.units.find(x=>x.id===unitId);
		if(!u||!u.words||u.words.length===0)return;
		this.currentUnit=u;
		const prog=this.storage.getUnitProgress(u.id,u.words.length);
		this.currentWordIndex=prog.lastWordIndex<u.words.length?prog.lastWordIndex:0;
		this.wordsLearnedInSession=0;
		this.sessionWordHistory=[];
		this.switchView("study");
		this.renderCurrentWord();
	}
	renderCurrentWord(){
		const word=this.currentUnit.words[this.currentWordIndex];
		const total=this.currentUnit.words.length;
		this.studyEls.unitTitle.textContent=`DAY ${this.currentUnit.day}: ${this.currentUnit.titleKo} (${this.currentUnit.titleVi})`;
		this.studyEls.wordProgressText.textContent=`Từ ${this.currentWordIndex+1}/${total}`;
		const pct=Math.round(((this.currentWordIndex+1)/total)*100);
		this.studyEls.progressFill.style.width=`${pct}%`;
		this.studyEls.posBadge.textContent=word.posName||word.pos.toUpperCase();
		if(word.hanja){
			this.studyEls.hanjaBadge.textContent=`Hán tự: ${word.hanja}`;
			this.studyEls.hanjaBadge.style.display="inline";
		}else{
			this.studyEls.hanjaBadge.style.display="none";
		}
		this.studyEls.koreanWord.textContent=word.korean;
		this.studyEls.vietnameseText.textContent=word.vietnamese;
		if(word.collocations&&word.collocations.length>0){
			this.studyEls.collocationsWrap.style.display="flex";
			this.studyEls.collocationsList.innerHTML=word.collocations.map(c=>`<span class="colloc-pill">${c}</span>`).join("");
		}else{
			this.studyEls.collocationsWrap.style.display="none";
		}
		this.studyEls.hintWords.textContent=word.hint_words||"Hãy thử đặt một câu đơn giản với từ này.";
		this.studyEls.sentenceInput.value="";
		this.studyEls.grammarFeedback.style.display="none";
		this.studyEls.btnPrev.disabled=this.currentWordIndex===0;
		this.studyEls.btnPrev.style.opacity=this.currentWordIndex===0?"0.4":"1";
		if(this.currentWordIndex===total-1){
			this.studyEls.btnNext.innerHTML=`<span>Hoàn thành Unit</span> <span>✓</span>`;
		}else{
			this.studyEls.btnNext.innerHTML=`<span>Tiếp tục (Đã học)</span> <span>→</span>`;
		}
		this.playCurrentWordAudio();
	}
	playCurrentWordAudio(){
		const word=this.currentUnit.words[this.currentWordIndex];
		if(!word)return;
		this.studyEls.btnAudio.classList.add("playing");
		this.audio.speakKorean(
			word.korean,
			this.audioSpeed,
			()=>this.studyEls.btnAudio.classList.add("playing"),
			()=>this.studyEls.btnAudio.classList.remove("playing")
		);
	}
	checkSentenceGrammar(){
		const word=this.currentUnit.words[this.currentWordIndex];
		const input=this.studyEls.sentenceInput.value;
		const res=this.grammar.checkSentence(input,word);
		const box=this.studyEls.grammarFeedback;
		box.className="grammar-feedback-box "+(res.isValid?"valid":"error");
		let html="";
		if(res.isValid){
			html+=`<strong>✓ Ngữ pháp chính xác!</strong><br>${res.praises.join("<br>")}`;
		}else{
			html+=`<strong>Lưu ý ngữ pháp:</strong><br>${res.errors.join("<br>")}`;
		}
		html+=`
			<div class="sample-sentence-box">
				<strong>Câu mẫu tham khảo:</strong> ${res.sampleSentence}<br>
				<span style="color:#94a3b8;font-size:12px;">Dịch nghĩa: ${res.sampleTranslation}</span>
			</div>
		`;
		box.innerHTML=html;
		box.style.display="block";
	}
	prevWord(){
		if(this.currentWordIndex>0){
			--this.currentWordIndex;
			this.renderCurrentWord();
		}
	}
	nextWord(){
		const word=this.currentUnit.words[this.currentWordIndex];
		this.storage.markWordLearned(this.currentUnit.id,word.id,this.currentWordIndex);
		if(!this.sessionWordHistory.some(w=>w.id===word.id)){
			this.sessionWordHistory.push(word);
		}
		++this.wordsLearnedInSession;
		const total=this.currentUnit.words.length;
		const isLastWord=this.currentWordIndex>=total-1;
		if(this.wordsLearnedInSession%5===0&&!isLastWord){
			this.startMiniQuiz();
			return;
		}
		if(isLastWord){
			this.storage.markUnitCompleted(this.currentUnit.id);
			if(this.sessionWordHistory.length>0){
				this.startMiniQuiz(true);
			}else{
				this.showUnitCompleteCelebration();
			}
			return;
		}
		++this.currentWordIndex;
		this.renderCurrentWord();
	}
	startMiniQuiz(isUnitEnd=false){
		const recentWords=this.sessionWordHistory.slice(-10);
		if(recentWords.length===0){
			if(isUnitEnd)this.showUnitCompleteCelebration();
			return;
		}
		this.quizState={
			active:true,
			questions:[...recentWords],
			currentIndex:0,
			userRecordedUrl:null,
			correctCount:0,
			speechResult:null,
			isUnitEnd
		};
		this.quizEls.questionCard.style.display="flex";
		this.quizEls.questionCard.style.flexDirection="column";
		this.quizEls.questionCard.style.gap="16px";
		this.quizEls.summaryCard.style.display="none";
		this.quizModal.classList.add("active");
		this.renderQuizQuestion();
	}
	renderQuizQuestion(){
		const q=this.quizState.questions[this.quizState.currentIndex];
		const total=this.quizState.questions.length;
		this.quizEls.progressText.textContent=`Câu ${this.quizState.currentIndex+1}/${total}`;
		this.quizEls.viWord.textContent=q.vietnamese;
		this.quizEls.posHint.textContent=`[${q.posName||q.pos.toUpperCase()}]`;
		this.quizEls.koreanInput.value="";
		this.quizEls.koreanInput.disabled=false;
		this.quizEls.koreanInput.focus();
		this.quizEls.recStatus.textContent="Bấm nút mic để phát âm";
		this.quizEls.playbackArea.style.display="none";
		this.quizEls.btnCheckAnswer.style.display="inline-block";
		this.quizEls.btnNextQuestion.style.display="none";
		this.quizEls.feedbackBox.style.display="none";
		this.quizState.userRecordedUrl=null;
		this.quizState.speechResult=null;
	}
	async toggleQuizRecording(){
		const q=this.quizState.questions[this.quizState.currentIndex];
		if(!this.audio.isRecording){
			this.quizEls.btnMic.classList.add("recording");
			this.quizEls.recStatus.textContent="Đang ghi âm... Hãy phát âm từ tiếng Hàn!";
			await this.audio.startRecording(
				()=>{},
				err=>{
					this.quizEls.btnMic.classList.remove("recording");
					this.quizEls.recStatus.textContent="Không thể truy cập microphone. Bạn vẫn có thể kiểm tra chữ gõ.";
				}
			);
			this.audio.startSpeechRecognition(
				q.korean,
				res=>{
					this.quizState.speechResult=res;
					this.quizEls.recStatus.textContent=`Nhận diện được: "${res.transcript}"`;
				},
				err=>{}
			);
		}else{
			this.quizEls.btnMic.classList.remove("recording");
			this.quizEls.recStatus.textContent="Đang xử lý bản ghi âm...";
			const rec=await this.audio.stopRecording();
			if(rec.audioUrl){
				this.quizState.userRecordedUrl=rec.audioUrl;
				this.quizEls.playbackArea.style.display="flex";
				this.quizEls.recStatus.textContent="Đã thu âm xong. Bấm nút loa nhỏ để nghe lại giọng mình!";
			}
		}
	}
	checkQuizAnswer(){
		const q=this.quizState.questions[this.quizState.currentIndex];
		const typed=this.quizEls.koreanInput.value.trim();
		const cleanTyped=typed.replace(/[.,!?\s]/g,"");
		const cleanTarget=q.korean.replace(/[.,!?\s]/g,"");
		const isTextMatch=cleanTyped===cleanTarget||cleanTarget.includes(cleanTyped)&&cleanTyped.length>=2;
		let isVoiceMatch=false;
		if(this.quizState.speechResult&&this.quizState.speechResult.isMatch){
			isVoiceMatch=true;
		}
		const isCorrect=isTextMatch||isVoiceMatch;
		if(isCorrect)++this.quizState.correctCount;
		this.quizEls.koreanInput.disabled=true;
		this.quizEls.btnCheckAnswer.style.display="none";
		this.quizEls.btnNextQuestion.style.display="inline-block";
		const box=this.quizEls.feedbackBox;
		box.className="quiz-feedback-box "+(isCorrect?"correct":"wrong");
		let html="";
		if(isCorrect){
			html+=`<strong>✓ Chính xác! Bạn đã ghi nhớ từ này rất tốt.</strong><br>`;
			if(isVoiceMatch)html+=`<span>Phát âm nhận diện chuẩn: "${this.quizState.speechResult.transcript}"</span>`;
		}else{
			html+=`<strong>✗ Chưa chính xác!</strong><br>`;
			html+=`<div>Đáp án đúng: <span class="correct-ans-highlight">${q.korean}</span> (${q.vietnamese})</div>`;
		}
		html+=`
			<div class="quiz-audio-actions">
				<button class="btn-quiz-audio" id="btn-quiz-sample-audio">🔊 Nghe phát âm mẫu chuẩn</button>
				${this.quizState.userRecordedUrl?`<button class="btn-quiz-audio" id="btn-quiz-my-audio">🎤 Nghe lại giọng của bạn</button>`:""}
			</div>
		`;
		box.innerHTML=html;
		box.style.display="block";
		document.getElementById("btn-quiz-sample-audio").addEventListener("click",()=>this.audio.speakKorean(q.korean));
		if(this.quizState.userRecordedUrl){
			document.getElementById("btn-quiz-my-audio").addEventListener("click",()=>{
				this.audio.playAudioUrl(this.quizState.userRecordedUrl);
			});
		}
	}
	nextQuizQuestion(){
		++this.quizState.currentIndex;
		if(this.quizState.currentIndex<this.quizState.questions.length){
			this.renderQuizQuestion();
		}else{
			this.showQuizSummary();
		}
	}
	showQuizSummary(){
		this.storage.recordQuizResult(this.quizState.questions.length,this.quizState.correctCount);
		this.quizEls.questionCard.style.display="none";
		this.quizEls.summaryCard.style.display="flex";
		this.quizEls.summaryScore.textContent=`Kết quả: ${this.quizState.correctCount}/${this.quizState.questions.length} từ chính xác`;
	}
	finishQuizAndResumeStudy(){
		this.quizModal.classList.remove("active");
		if(this.quizState.isUnitEnd){
			this.showUnitCompleteCelebration();
		}else{
			++this.currentWordIndex;
			this.renderCurrentWord();
		}
	}
	showUnitCompleteCelebration(){
		this.completeEls.unitTitle.textContent=`DAY ${this.currentUnit.day}: ${this.currentUnit.titleKo} (${this.currentUnit.titleVi})`;
		this.completeModal.classList.add("active");
		let sec=3;
		this.completeEls.countdown.textContent=`Tự động quay lại danh sách bài học sau ${sec} giây...`;
		const timer=setInterval(()=>{
			--sec;
			if(sec<=0){
				clearInterval(timer);
				this.completeModal.classList.remove("active");
				this.switchView("units");
			}else{
				this.completeEls.countdown.textContent=`Tự động quay lại danh sách bài học sau ${sec} giây...`;
			}
		},1000);
	}
}
document.addEventListener("DOMContentLoaded",()=>{
	window.app=new TopikApp();
});
