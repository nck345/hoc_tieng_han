class TopikApp{
	constructor(){
		this.units=window.TOPIC_UNITS||[];
		this.examData=window.EXAM_DATA||{categories:[],packs:[]};
		this.commData=window.COMMUNICATION_DATA||{beginner:[],intermediate:[]};
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
		this.quizState={active:false,questions:[],currentIndex:0,userRecordedUrl:null,correctCount:0,speechResult:null,isUnitEnd:false};
		this.examSubnav="folders";
		this.currentExamCategory=null;
		this.currentExamItem=null;
		this.currentExamPack=null;
		this.activeExamQuestions=[];
		this.activeExamQuestionIndex=0;
		this.examTimerInterval=null;
		this.examTimerSeconds=0;
		this.examAudioSpeed=1.0;
		this.selectedExamOption=null;
		this.commLevel="beginner";
		this.currentTopicIndex=0;
		this.currentSentenceIndex=0;
		this.commUserAudioUrl=null;
		this.notebookFilter="all";
		this.birdDefinitions=[
			{id:"bird-happy",name:"Chim Sẻ Vui Vẻ",desc:"Chú chim sẻ may mắn khởi đầu hành trình và phần thưởng cho câu trả lời đúng.",icon:"assets/birds/bird-happy.svg",condition:"Trả lời đúng câu hỏi đề thi"},
			{id:"bird-genius",name:"Cú Mèo Bác Học",desc:"Biểu tượng thông tuệ xuất sắc dành cho người đạt điểm cao.",icon:"assets/birds/bird-genius.svg",condition:"Đạt kết quả xuất sắc trong kiểm tra"},
			{id:"bird-cry",name:"Cánh Cụt Mít Ướt",desc:"Chú chim nhắc nhở ôn luyện kỹ lưỡng khi chọn nhầm đáp án.",icon:"assets/birds/bird-cry.svg",condition:"Thử thách khi trả lời chưa đúng"},
			{id:"bird-sweeping",name:"Chim Siêng Năng",desc:"Chăm chỉ quét dọn, rèn luyện từng câu để vươn tới điểm tuyệt đối.",icon:"assets/birds/bird-sweeping.svg",condition:"Rèn luyện vượt qua sai sót"},
			{id:"bird-phoenix",name:"Phượng Hoàng Vàng",desc:"Huy hiệu hoàng kim vinh danh hoàn thành trọn vẹn gói 10 câu hỏi dạng đề thi.",icon:"assets/birds/bird-phoenix.svg",condition:"Hoàn thành trọn vẹn Gói 10 câu hỏi"},
			{id:"bird-cyber",name:"Robot Chiến Binh",desc:"Hộ vệ tương lai tối tân dành cho cao thủ chinh phục các dạng đề TOPIK II.",icon:"assets/birds/bird-cyber.svg",condition:"Chinh phục xuất sắc dạng đề thi"}
		];
		this.initElements();
		this.bindEvents();
		this.renderStats();
		this.renderUnits();
	}
	initElements(){
		this.views={
			home:document.getElementById("view-home"),
			units:document.getElementById("view-units"),
			study:document.getElementById("view-study"),
			exam:document.getElementById("view-exam"),
			communication:document.getElementById("view-communication"),
			notebook:document.getElementById("view-notebook"),
			birds:document.getElementById("view-birds")
		};
		this.navTabs={
			vocab:document.getElementById("tab-vocab"),
			exam:document.getElementById("tab-exam"),
			communication:document.getElementById("tab-communication"),
			notebook:document.getElementById("tab-notebook"),
			birds:document.getElementById("tab-birds")
		};
		this.statsEls={
			learnedCount:document.getElementById("stat-learned-count"),
			birdCount:document.getElementById("stat-bird-count"),
			navNbCount:document.getElementById("stat-nav-nb-count"),
			nbCountAll:document.getElementById("nb-count-all")
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
			btnStar:document.getElementById("btn-study-star"),
			koreanWord:document.getElementById("study-korean-word"),
			btnAudio:document.getElementById("btn-study-audio"),
			btnSpeed:document.getElementById("btn-study-speed"),
			vietnameseText:document.getElementById("study-vietnamese-text"),
			collocationsGrid:document.getElementById("study-collocations-grid"),
			orderedTokensRow:document.getElementById("study-ordered-tokens-row"),
			scrambleTranslation:document.getElementById("study-scramble-translation"),
			scrambleInput:document.getElementById("study-scramble-input"),
			btnCheckScramble:document.getElementById("btn-check-scramble"),
			btnFillScramble:document.getElementById("btn-fill-scramble"),
			scrambleFeedback:document.getElementById("study-scramble-feedback"),
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
		this.examEls={
			subnavFolders:document.getElementById("btn-exam-subnav-folders"),
			subnavPacks:document.getElementById("btn-exam-subnav-packs"),
			foldersContainer:document.getElementById("exam-folders-container"),
			folderDetailWrap:document.getElementById("exam-folder-detail-wrap"),
			btnFolderBack:document.getElementById("btn-exam-folder-back"),
			folderDetailTitle:document.getElementById("exam-folder-detail-title"),
			folderItemsGrid:document.getElementById("exam-folder-items-grid"),
			packsContainer:document.getElementById("exam-packs-container"),
			activePlayer:document.getElementById("exam-active-player"),
			btnPlayerBack:document.getElementById("btn-exam-player-back"),
			playerTypeBadge:document.getElementById("exam-player-type-badge"),
			playerProgressBadge:document.getElementById("exam-player-progress-badge"),
			playerTimer:document.getElementById("exam-player-timer"),
			qInstruction:document.getElementById("exam-q-instruction"),
			qAudioBox:document.getElementById("exam-q-audio-box"),
			btnAudioPlay:document.getElementById("btn-exam-audio-play"),
			audioStatus:document.getElementById("exam-audio-status"),
			btnSpeed1:document.getElementById("btn-exam-speed-1"),
			btnSpeedSlow:document.getElementById("btn-exam-speed-slow"),
			qPassage:document.getElementById("exam-q-passage"),
			qOptionsList:document.getElementById("exam-q-options-list"),
			btnSubmitAns:document.getElementById("btn-exam-submit-ans"),
			solutionPanel:document.getElementById("exam-solution-panel"),
			birdFeedback:document.getElementById("exam-bird-feedback"),
			birdImg:document.getElementById("exam-bird-img"),
			birdTitle:document.getElementById("exam-bird-title"),
			birdDesc:document.getElementById("exam-bird-desc"),
			answerTypeNote:document.getElementById("exam-answer-type-note"),
			explanationText:document.getElementById("exam-explanation-text"),
			transcriptSection:document.getElementById("exam-transcript-section"),
			transcriptBox:document.getElementById("exam-transcript-box"),
			grammarSection:document.getElementById("exam-grammar-section"),
			grammarList:document.getElementById("exam-grammar-list"),
			vocabSection:document.getElementById("exam-vocab-section"),
			vocabGrid:document.getElementById("exam-vocab-grid"),
			btnPrevQ:document.getElementById("btn-exam-prev-q"),
			btnNextQ:document.getElementById("btn-exam-next-q")
		};
		this.birdRewardModal=document.getElementById("bird-reward-modal");
		this.birdRewardEls={
			iconWrap:document.getElementById("modal-reward-bird-icon-wrap"),
			name:document.getElementById("modal-reward-bird-name"),
			desc:document.getElementById("modal-reward-bird-desc"),
			btnClose:document.getElementById("btn-close-bird-modal"),
			btnView:document.getElementById("btn-view-bird-collection")
		};
		this.commEls={
			btnBeginner:document.getElementById("btn-comm-beginner"),
			btnIntermediate:document.getElementById("btn-comm-intermediate"),
			topicPills:document.getElementById("comm-topic-pills"),
			cardTopicTag:document.getElementById("comm-card-topic-tag"),
			cardSentenceIdx:document.getElementById("comm-card-sentence-idx"),
			speakerTag:document.getElementById("comm-speaker-tag"),
			interactiveKorean:document.getElementById("comm-interactive-korean"),
			romajaText:document.getElementById("comm-romaja-text"),
			vietnameseText:document.getElementById("comm-vietnamese-text"),
			btnAudioNormal:document.getElementById("btn-comm-audio-normal"),
			btnAudioSlow:document.getElementById("btn-comm-audio-slow"),
			btnMic:document.getElementById("btn-comm-mic"),
			userAudioWrap:document.getElementById("comm-user-audio-wrap"),
			btnPlayUser:document.getElementById("btn-comm-play-user"),
			recStatus:document.getElementById("comm-rec-status"),
			accuracyBadgeWrap:document.getElementById("comm-accuracy-badge-wrap"),
			accuracyBadge:document.getElementById("comm-accuracy-badge"),
			accuracyVal:document.getElementById("comm-accuracy-val"),
			btnPrev:document.getElementById("btn-comm-prev"),
			btnNext:document.getElementById("btn-comm-next")
		};
		this.nbEls={
			filterPills:document.getElementById("nb-filter-pills"),
			itemsGrid:document.getElementById("notebook-items-grid")
		};
		this.birdsGrid=document.getElementById("birds-gallery-grid");
	}
	bindEvents(){
		document.getElementById("brand-home").addEventListener("click",()=>this.switchView("home"));
		this.navTabs.vocab.addEventListener("click",()=>this.switchView("units"));
		this.navTabs.exam.addEventListener("click",()=>this.switchView("exam"));
		this.navTabs.communication.addEventListener("click",()=>this.switchView("communication"));
		this.navTabs.notebook.addEventListener("click",()=>this.switchView("notebook"));
		this.navTabs.birds.addEventListener("click",()=>this.switchView("birds"));
		document.getElementById("btn-home-vocab").addEventListener("click",()=>this.switchView("units"));
		document.getElementById("btn-home-exam").addEventListener("click",()=>this.switchView("exam"));
		document.getElementById("btn-home-communication").addEventListener("click",()=>this.switchView("communication"));
		document.getElementById("btn-home-notebook").addEventListener("click",()=>this.switchView("notebook"));
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
		document.getElementById("btn-study-back").addEventListener("click",()=>this.switchView("units"));
		this.studyEls.btnAudio.addEventListener("click",()=>this.playCurrentWordAudio());
		this.studyEls.btnSpeed.addEventListener("click",()=>{
			this.audioSpeed=this.audioSpeed===1.0?0.8:1.0;
			this.studyEls.btnSpeed.textContent=this.audioSpeed===1.0?"1.0x":"0.8x Chậm";
		});
		this.studyEls.btnStar.addEventListener("click",()=>this.toggleStudyStar());
		this.studyEls.btnCheckScramble.addEventListener("click",()=>this.checkScrambleSentence());
		this.studyEls.btnFillScramble.addEventListener("click",()=>this.fillScrambleSentence());
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
		this.examEls.subnavFolders.addEventListener("click",()=>{
			this.examSubnav="folders";
			this.examEls.subnavFolders.classList.add("active");
			this.examEls.subnavPacks.classList.remove("active");
			this.renderExamView();
		});
		this.examEls.subnavPacks.addEventListener("click",()=>{
			this.examSubnav="packs";
			this.examEls.subnavPacks.classList.add("active");
			this.examEls.subnavFolders.classList.remove("active");
			this.renderExamView();
		});
		this.examEls.btnFolderBack.addEventListener("click",()=>{
			this.currentExamCategory=null;
			this.renderExamView();
		});
		this.examEls.btnPlayerBack.addEventListener("click",()=>{
			this.stopExamTimer();
			this.audio.stopAll();
			this.examEls.activePlayer.style.display="none";
			this.renderExamView();
		});
		this.examEls.btnSpeed1.addEventListener("click",()=>{
			this.examAudioSpeed=1.0;
			this.examEls.btnSpeed1.classList.add("active");
			this.examEls.btnSpeedSlow.classList.remove("active");
		});
		this.examEls.btnSpeedSlow.addEventListener("click",()=>{
			this.examAudioSpeed=0.8;
			this.examEls.btnSpeedSlow.classList.add("active");
			this.examEls.btnSpeed1.classList.remove("active");
		});
		this.examEls.btnAudioPlay.addEventListener("click",()=>this.playExamQuestionAudio());
		this.examEls.btnSubmitAns.addEventListener("click",()=>this.submitExamAnswer());
		this.examEls.btnPrevQ.addEventListener("click",()=>this.prevExamQuestion());
		this.examEls.btnNextQ.addEventListener("click",()=>this.nextExamQuestion());
		this.birdRewardEls.btnClose.addEventListener("click",()=>{
			this.birdRewardModal.classList.remove("active");
		});
		this.birdRewardEls.btnView.addEventListener("click",()=>{
			this.birdRewardModal.classList.remove("active");
			this.switchView("birds");
		});
		this.commEls.btnBeginner.addEventListener("click",()=>{
			this.commLevel="beginner";
			this.commEls.btnBeginner.classList.add("active");
			this.commEls.btnIntermediate.classList.remove("active");
			this.currentTopicIndex=0;
			this.currentSentenceIndex=0;
			this.renderCommunicationView();
		});
		this.commEls.btnIntermediate.addEventListener("click",()=>{
			this.commLevel="intermediate";
			this.commEls.btnIntermediate.classList.add("active");
			this.commEls.btnBeginner.classList.remove("active");
			this.currentTopicIndex=0;
			this.currentSentenceIndex=0;
			this.renderCommunicationView();
		});
		this.commEls.btnAudioNormal.addEventListener("click",()=>this.playCommAudio(1.0));
		this.commEls.btnAudioSlow.addEventListener("click",()=>this.playCommAudio(0.75));
		this.commEls.btnMic.addEventListener("click",()=>this.toggleCommRecording());
		this.commEls.btnPlayUser.addEventListener("click",()=>{
			if(this.commUserAudioUrl)this.audio.playAudioUrl(this.commUserAudioUrl);
		});
		this.commEls.btnPrev.addEventListener("click",()=>this.prevCommSentence());
		this.commEls.btnNext.addEventListener("click",()=>this.nextCommSentence());
		this.nbEls.filterPills.addEventListener("click",e=>{
			if(!e.target.classList.contains("filter-pill"))return;
			this.nbEls.filterPills.querySelectorAll(".filter-pill").forEach(p=>p.classList.remove("active"));
			e.target.classList.add("active");
			this.notebookFilter=e.target.dataset.filter;
			this.renderNotebookView();
		});
	}
	switchView(viewName){
		this.audio.stopAll();
		this.stopExamTimer();
		Object.keys(this.views).forEach(key=>{
			if(this.views[key])this.views[key].classList.toggle("active",key===viewName);
		});
		Object.keys(this.navTabs).forEach(key=>{
			const active=(key==="vocab"&&(viewName==="units"||viewName==="study"))||key===viewName;
			if(this.navTabs[key])this.navTabs[key].classList.toggle("active",active);
		});
		if(typeof window!=="undefined"&&window.scrollTo)window.scrollTo({top:0,behavior:"smooth"});
		this.renderStats();
		if(viewName==="units")this.renderUnits();
		else if(viewName==="exam")this.renderExamView();
		else if(viewName==="communication")this.renderCommunicationView();
		else if(viewName==="notebook")this.renderNotebookView();
		else if(viewName==="birds")this.renderBirdsView();
	}
	renderStats(){
		let totalLearned=0;
		for(let i=0;i<this.units.length;++i){
			const u=this.units[i];
			const prog=this.storage.getUnitProgress(u.id,u.words.length);
			totalLearned+=prog.learnedCount;
		}
		if(this.statsEls.learnedCount)this.statsEls.learnedCount.textContent=totalLearned;
		const birds=this.storage.getBirds();
		if(this.statsEls.birdCount)this.statsEls.birdCount.textContent=birds.length;
		const nbItems=this.storage.getNotebookItems("all");
		if(this.statsEls.navNbCount)this.statsEls.navNbCount.textContent=nbItems.length;
		if(this.statsEls.nbCountAll)this.statsEls.nbCountAll.textContent=nbItems.length;
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
			this.unitsGrid.innerHTML=`<div style="grid-column:1/-1;text-align:center;padding:48px;color:var(--text-muted);font-weight:600;">Không tìm thấy bài học nào phù hợp.</div>`;
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
		this.updateStudyStarState(word.korean);
		this.studyEls.koreanWord.textContent=word.korean;
		this.studyEls.vietnameseText.textContent=word.vietnamese;
		this.studyEls.collocationsGrid.innerHTML="";
		if(word.collocations&&word.collocations.length>0){
			for(let i=0;i<word.collocations.length;++i){
				const c=word.collocations[i];
				const pill=document.createElement("div");
				pill.className="colloc-pill";
				if(typeof c==="string"){
					pill.innerHTML=`<strong>${c}</strong>`;
				}else{
					pill.innerHTML=`<strong>${c.korean}</strong> <span style="font-size:11px;color:#94a3b8;">${c.vietnamese}</span>`;
				}
				this.studyEls.collocationsGrid.appendChild(pill);
			}
		}
		this.renderScrambleSection(word);
		this.studyEls.hintWords.textContent=word.hint_words||"Hãy thử đặt câu đơn giản.";
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
	updateStudyStarState(korean){
		const isSaved=this.storage.isBookmarked(korean);
		this.studyEls.btnStar.textContent=isSaved?"⭐":"☆";
		this.studyEls.btnStar.classList.toggle("bookmarked",isSaved);
	}
	toggleStudyStar(){
		const word=this.currentUnit.words[this.currentWordIndex];
		if(!word)return;
		const added=this.storage.toggleNotebookItem({
			type:"vocab",
			korean:word.korean,
			vietnamese:word.vietnamese,
			pos:word.posName||word.pos,
			example:word.sample_sentence||"",
			source:`TOPIK 2300 (Day ${this.currentUnit.day})`
		});
		this.updateStudyStarState(word.korean);
		this.renderStats();
	}
	renderScrambleSection(word){
		this.studyEls.orderedTokensRow.innerHTML="";
		const tokens=word.ordered_tokens||[word.korean];
		for(let i=0;i<tokens.length;++i){
			const chip=document.createElement("span");
			chip.className="ordered-token-chip";
			chip.textContent=tokens[i];
			chip.addEventListener("click",()=>{
				const cur=this.studyEls.scrambleInput.value.trim();
				this.studyEls.scrambleInput.value=cur?(cur+" "+tokens[i]):tokens[i];
			});
			this.studyEls.orderedTokensRow.appendChild(chip);
		}
		this.studyEls.scrambleTranslation.textContent=word.sample_translation||word.vietnamese;
		this.studyEls.scrambleInput.value="";
		this.studyEls.scrambleFeedback.style.display="none";
	}
	fillScrambleSentence(){
		const word=this.currentUnit.words[this.currentWordIndex];
		if(!word)return;
		const tokens=word.ordered_tokens||[word.korean];
		this.studyEls.scrambleInput.value=tokens.join(" ");
	}
	checkScrambleSentence(){
		const word=this.currentUnit.words[this.currentWordIndex];
		if(!word)return;
		const input=this.studyEls.scrambleInput.value.trim();
		const target=(word.sample_sentence||(word.ordered_tokens||[]).join(" ")).trim();
		const cleanInput=input.replace(/[.,!?~\s]/g,"");
		const cleanTarget=target.replace(/[.,!?~\s]/g,"");
		const isCorrect=cleanInput===cleanTarget;
		const box=this.studyEls.scrambleFeedback;
		box.className="grammar-feedback-box "+(isCorrect?"valid":"error");
		if(isCorrect){
			box.innerHTML=`<strong>✓ Chính xác tuyệt vời!</strong><br>Bạn đã hoàn thiện đúng cấu trúc câu.<div class="sample-sentence-box" style="margin-top:6px;"><strong>Câu chuẩn:</strong> ${target}</div>`;
		}else{
			box.innerHTML=`<strong>Chưa khớp hoàn toàn:</strong><br>Hãy thử kiểm tra lại trật tự từ hoặc dấu trợ từ.<div class="sample-sentence-box" style="margin-top:6px;"><strong>Câu mẫu chuẩn:</strong> ${target}<br><span style="font-size:12px;color:#94a3b8;">Dịch: ${word.sample_translation||""}</span></div>`;
		}
		box.style.display="block";
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
			html+=`<strong>✓ Ngữ pháp chuẩn xác!</strong><br>${res.praises.join("<br>")}`;
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
				()=>{
					this.quizEls.btnMic.classList.remove("recording");
					this.quizEls.recStatus.textContent="Microphone chưa khả dụng. Bạn có thể kiểm tra chữ gõ.";
				}
			);
			this.audio.startSpeechRecognition(
				q.korean,
				res=>{
					this.quizState.speechResult=res;
					this.quizEls.recStatus.textContent=`Nhận diện: "${res.transcript}"`;
				},
				()=>{}
			);
		}else{
			this.quizEls.btnMic.classList.remove("recording");
			this.quizEls.recStatus.textContent="Đang xử lý...";
			const rec=await this.audio.stopRecording();
			if(rec.audioUrl){
				this.quizState.userRecordedUrl=rec.audioUrl;
				this.quizEls.playbackArea.style.display="flex";
				this.quizEls.recStatus.textContent="Đã ghi âm xong. Bấm nút nghe lại!";
			}
		}
	}
	checkQuizAnswer(){
		const q=this.quizState.questions[this.quizState.currentIndex];
		const typed=this.quizEls.koreanInput.value.trim();
		const cleanTyped=typed.replace(/[.,!?\s]/g,"");
		const cleanTarget=q.korean.replace(/[.,!?\s]/g,"");
		const isTextMatch=cleanTyped===cleanTarget||(cleanTarget.includes(cleanTyped)&&cleanTyped.length>=2);
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
			html+=`<strong>✓ Chính xác!</strong><br>`;
			if(isVoiceMatch)html+=`<span>Phát âm nhận diện chuẩn: "${this.quizState.speechResult.transcript}"</span>`;
		}else{
			html+=`<strong>✗ Chưa chính xác!</strong><br>`;
			html+=`<div>Đáp án đúng: <span class="correct-ans-highlight">${q.korean}</span> (${q.vietnamese})</div>`;
		}
		html+=`
			<div class="quiz-audio-actions">
				<button class="btn-quiz-audio" id="btn-quiz-sample-audio">🔊 Nghe phát âm mẫu</button>
				${this.quizState.userRecordedUrl?`<button class="btn-quiz-audio" id="btn-quiz-my-audio">🎤 Nghe lại giọng bạn</button>`:""}
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
		if(this.quizState.correctCount===this.quizState.questions.length){
			this.storage.unlockBird("bird-genius","Cú Mèo Bác Học","Đạt điểm tuyệt đối trong bài kiểm tra từ vựng.","assets/birds/bird-genius.svg","Điểm kiểm tra tuyệt đối");
			this.renderStats();
		}
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
		this.completeEls.countdown.textContent=`Tự động quay lại danh sách sau ${sec} giây...`;
		const timer=setInterval(()=>{
			--sec;
			if(sec<=0){
				clearInterval(timer);
				this.completeModal.classList.remove("active");
				this.switchView("units");
			}else{
				this.completeEls.countdown.textContent=`Tự động quay lại danh sách sau ${sec} giây...`;
			}
		},1000);
	}
	renderExamView(){
		if(this.examEls.activePlayer.style.display==="flex"||this.examEls.activePlayer.style.display==="block")return;
		if(this.examSubnav==="folders"){
			this.examEls.packsContainer.style.display="none";
			if(this.currentExamCategory){
				this.examEls.foldersContainer.style.display="none";
				this.examEls.folderDetailWrap.style.display="flex";
				this.renderExamCategoryDetail(this.currentExamCategory);
			}else{
				this.examEls.foldersContainer.style.display="grid";
				this.examEls.folderDetailWrap.style.display="none";
				this.renderExamFolders();
			}
		}else{
			this.examEls.foldersContainer.style.display="none";
			this.examEls.folderDetailWrap.style.display="none";
			this.examEls.packsContainer.style.display="grid";
			this.renderExamPacks();
		}
	}
	renderExamFolders(){
		this.examEls.foldersContainer.innerHTML="";
		const cats=this.examData.categories||[];
		for(let i=0;i<cats.length;++i){
			const cat=cats[i];
			const card=document.createElement("div");
			card.className="exam-folder-card";
			card.innerHTML=`
				<div class="folder-icon">${cat.icon||"📁"}</div>
				<h3 style="font-size:18px;margin-bottom:6px;">${cat.name}</h3>
				<p style="font-size:13px;color:var(--text-secondary);margin-bottom:12px;line-height:1.4;">${cat.description}</p>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					<span style="font-size:12px;color:var(--warning);font-weight:700;">${(cat.exams||[]).length} bộ đề thi</span>
					<button class="mode-btn" style="padding:6px 14px;font-size:12px;">Mở bộ đề →</button>
				</div>
			`;
			card.addEventListener("click",()=>{
				this.currentExamCategory=cat;
				this.renderExamView();
			});
			this.examEls.foldersContainer.appendChild(card);
		}
	}
	renderExamCategoryDetail(cat){
		this.examEls.folderDetailTitle.textContent=`📁 ${cat.name} (${cat.titleVi||""})`;
		this.examEls.folderItemsGrid.innerHTML="";
		const exams=cat.exams||[];
		for(let i=0;i<exams.length;++i){
			const ex=exams[i];
			const card=document.createElement("div");
			card.className="exam-card";
			card.innerHTML=`
				<div class="exam-card-header">
					<span class="day-tag">${cat.name}</span>
					<span style="font-size:12px;color:var(--text-secondary);">${ex.questionCount||100} câu</span>
				</div>
				<h4 style="font-size:16px;margin:8px 0;">${ex.name}</h4>
				<div style="font-size:12px;color:var(--text-muted);margin-bottom:12px;">
					${ex.audioFile?`<span>🔊 Có file nghe mp3</span>`:""}
				</div>
				<div style="display:flex;gap:8px;">
					<button class="mode-btn" style="flex:1;font-size:13px;padding:8px 12px;background:#f59e0b;">Làm đề ngay</button>
				</div>
			`;
			card.addEventListener("click",()=>this.startExamFromItem(cat,ex));
			this.examEls.folderItemsGrid.appendChild(card);
		}
	}
	renderExamPacks(){
		this.examEls.packsContainer.innerHTML="";
		const packs=this.examData.packs||[];
		for(let i=0;i<packs.length;++i){
			const pk=packs[i];
			const packScore=this.storage.data.packScores?this.storage.data.packScores[pk.typeId]:null;
			const card=document.createElement("div");
			card.className="pack-card";
			card.innerHTML=`
				<div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:8px;">
					<span class="pack-badge">${pk.section==="listening"?"Nghe hiểu":"Đọc hiểu"}</span>
					${packScore?`<span style="font-size:12px;color:#10b981;font-weight:700;">✓ Đã xong (${packScore.score}/${packScore.total})</span>`:""}
				</div>
				<h4 style="font-size:17px;margin-bottom:6px;">${pk.typeName}</h4>
				<p style="font-size:13px;color:var(--text-secondary);margin-bottom:14px;line-height:1.4;">${pk.description}</p>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					<span style="font-size:12px;color:#fbbf24;font-weight:700;">🎁 Thưởng chim hoàng kim</span>
					<button class="mode-btn" style="padding:8px 16px;font-size:13px;background:var(--accent);">Làm bài (10 câu) →</button>
				</div>
			`;
			card.addEventListener("click",()=>this.startExamFromPack(pk));
			this.examEls.packsContainer.appendChild(card);
		}
	}
	startExamFromPack(pack){
		this.currentExamPack=pack;
		this.activeExamQuestions=pack.questions||[];
		if(this.activeExamQuestions.length===0)return;
		this.activeExamQuestionIndex=0;
		this.openExamPlayer(`${pack.typeName} (Gói 10 câu)`);
	}
	startExamFromItem(cat,ex){
		let qList=[];
		if(this.examData.packs){
			for(let i=0;i<this.examData.packs.length;++i){
				const pkQuestions=this.examData.packs[i].questions||[];
				for(let j=0;j<pkQuestions.length;++j){
					const q=pkQuestions[j];
					if(q.examCategory===cat.id||q.examId===ex.id){
						qList.push(q);
					}
				}
			}
		}
		if(qList.length===0&&this.examData.packs){
			for(let i=0;i<this.examData.packs.length&&qList.length<10;++i){
				const pkQuestions=this.examData.packs[i].questions||[];
				if(pkQuestions.length>0)qList.push(pkQuestions[i%pkQuestions.length]);
			}
		}
		if(qList.length===0&&this.examData.questions){
			qList=this.examData.questions;
		}
		this.currentExamPack=null;
		this.activeExamQuestions=qList.slice(0,10);
		if(this.activeExamQuestions.length===0)return;
		this.activeExamQuestionIndex=0;
		this.openExamPlayer(`${cat.name} - ${ex.name}`);
	}
	openExamPlayer(title){
		this.activeExamTitle=title;
		this.examEls.foldersContainer.style.display="none";
		this.examEls.folderDetailWrap.style.display="none";
		this.examEls.packsContainer.style.display="none";
		this.examEls.activePlayer.style.display="flex";
		this.examEls.activePlayer.style.flexDirection="column";
		this.examEls.activePlayer.style.gap="16px";
		this.startExamTimer();
		this.renderActiveExamQuestion();
	}
	startExamTimer(){
		this.stopExamTimer();
		this.examTimerSeconds=0;
		this.examEls.playerTimer.textContent="⏱️ 00:00";
		this.examTimerInterval=setInterval(()=>{
			++this.examTimerSeconds;
			const m=String(Math.floor(this.examTimerSeconds/60)).padStart(2,"0");
			const s=String(this.examTimerSeconds%60).padStart(2,"0");
			this.examEls.playerTimer.textContent=`⏱️ ${m}:${s}`;
		},1000);
	}
	stopExamTimer(){
		if(this.examTimerInterval){
			clearInterval(this.examTimerInterval);
			this.examTimerInterval=null;
		}
	}
	renderActiveExamQuestion(){
		this.audio.stopAll();
		const q=this.activeExamQuestions[this.activeExamQuestionIndex];
		const total=this.activeExamQuestions.length;
		this.examEls.playerTypeBadge.textContent=this.activeExamTitle||q.typeName||"Dạng đề";
		this.examEls.playerProgressBadge.textContent=`Câu ${this.activeExamQuestionIndex+1}/${total}`;
		this.examEls.qInstruction.textContent=`[${q.section==="listening"?"Kỹ năng Nghe":"Kỹ năng Đọc"}] ${q.instruction||""}`;
		if(q.section==="listening"){
			this.examEls.qAudioBox.style.display="flex";
			this.examEls.audioStatus.textContent=q.audioUrl?`Audio câu hỏi #${q.questionNumber||(this.activeExamQuestionIndex+1)}`:"Audio câu hỏi";
			this.examEls.btnAudioPlay.classList.remove("playing");
		}else{
			this.examEls.qAudioBox.style.display="none";
		}
		if(q.passage){
			this.examEls.qPassage.style.display="block";
			this.examEls.qPassage.textContent=q.passage;
		}else{
			this.examEls.qPassage.style.display="none";
		}
		this.examEls.qOptionsList.innerHTML="";
		this.selectedExamOption=null;
		const options=q.options||[];
		for(let i=0;i<options.length;++i){
			const opt=options[i];
			const optIndex=(typeof opt==="object"&&opt&&opt.index!==undefined)?opt.index:(i+1);
			const optText=(typeof opt==="object"&&opt&&opt.text!==undefined)?opt.text:(typeof opt==="string"?opt:String(opt||""));
			const btn=document.createElement("button");
			btn.className="option-btn";
			btn.dataset.index=optIndex;
			btn.innerHTML=`<span class="option-num">${optIndex}</span> <span>${optText}</span>`;
			btn.addEventListener("click",()=>{
				if(this.examEls.solutionPanel.style.display==="flex")return;
				this.examEls.qOptionsList.querySelectorAll(".option-btn").forEach(b=>b.classList.remove("selected"));
				btn.classList.add("selected");
				this.selectedExamOption=optIndex;
			});
			this.examEls.qOptionsList.appendChild(btn);
		}
		this.examEls.btnPrevQ.disabled=this.activeExamQuestionIndex===0;
		this.examEls.btnPrevQ.style.opacity=this.activeExamQuestionIndex===0?"0.4":"1";
		this.examEls.btnNextQ.textContent=this.activeExamQuestionIndex===total-1?"Hoàn thành gói đề":"Câu tiếp theo →";
		const savedAns=this.storage.getExamAnswer(q.id);
		if(savedAns&&savedAns.userAnswer!==undefined&&savedAns.userAnswer!==null&&!isNaN(savedAns.userAnswer)){
			this.selectedExamOption=Number(savedAns.userAnswer);
			const btns=this.examEls.qOptionsList.querySelectorAll(".option-btn");
			btns.forEach(b=>{
				if(parseInt(b.dataset.index,10)===Number(savedAns.userAnswer))b.classList.add("selected");
			});
			this.showExamSolution(q,Number(savedAns.userAnswer),savedAns.isCorrect);
		}else{
			this.examEls.solutionPanel.style.display="none";
			this.examEls.btnSubmitAns.style.display="inline-block";
		}
	}
	playExamQuestionAudio(){
		const q=this.activeExamQuestions[this.activeExamQuestionIndex];
		if(!q)return;
		if(this.examEls.btnAudioPlay.classList.contains("playing")){
			this.audio.stopAll();
			this.examEls.btnAudioPlay.classList.remove("playing");
			return;
		}
		this.examEls.btnAudioPlay.classList.add("playing");
		let scriptText="";
		if(q.transcript&&q.transcript.length>0){
			scriptText=q.transcript.map(t=>t.text).join(". ");
		}else{
			scriptText=q.passage||q.instruction||"";
		}
		if(q.audioUrl){
			this.audio.playAudioFile(
				q.audioUrl,
				this.examAudioSpeed,
				()=>this.examEls.btnAudioPlay.classList.add("playing"),
				()=>this.examEls.btnAudioPlay.classList.remove("playing"),
				scriptText
			);
		}else{
			this.audio.speakKorean(
				scriptText,
				this.examAudioSpeed,
				()=>this.examEls.btnAudioPlay.classList.add("playing"),
				()=>this.examEls.btnAudioPlay.classList.remove("playing")
			);
		}
	}
	submitExamAnswer(){
		if(this.selectedExamOption===null||this.selectedExamOption===undefined||isNaN(this.selectedExamOption)){
			if(typeof alert!=="undefined")alert("Vui lòng chọn 1 trong 4 phương án trước khi nộp câu trả lời.");
			return;
		}
		const q=this.activeExamQuestions[this.activeExamQuestionIndex];
		const isCorrect=Number(this.selectedExamOption)===Number(q.correctAnswer);
		this.storage.recordExamAnswer(q.id,Number(this.selectedExamOption),isCorrect);
		if(isCorrect){
			this.storage.unlockBird("bird-happy","Chim Sẻ Vui Vẻ","Trả lời chính xác câu hỏi trong đề thi.","assets/birds/bird-happy.svg","Trả lời đúng đề thi");
		}else{
			this.storage.unlockBird("bird-cry","Cánh Cụt Mít Ướt","Cần rèn luyện ôn tập thêm khi làm bài.","assets/birds/bird-cry.svg","Rèn luyện qua lỗi sai");
		}
		this.renderStats();
		this.showExamSolution(q,Number(this.selectedExamOption),isCorrect);
	}
	showExamSolution(q,userAns,isCorrect){
		this.examEls.btnSubmitAns.style.display="none";
		this.examEls.solutionPanel.style.display="flex";
		this.examEls.solutionPanel.style.flexDirection="column";
		this.examEls.solutionPanel.style.gap="16px";
		const optBtns=this.examEls.qOptionsList.querySelectorAll(".option-btn");
		optBtns.forEach(b=>{
			const idx=parseInt(b.dataset.index,10);
			if(idx===Number(q.correctAnswer))b.classList.add("correct-ans");
			if(idx===Number(userAns)&&!isCorrect)b.classList.add("wrong-ans");
		});
		if(isCorrect){
			this.examEls.birdFeedback.className="bird-feedback-card correct";
			this.examEls.birdImg.src="assets/birds/bird-happy.svg";
			this.examEls.birdTitle.textContent="Chính xác! Thưởng chú chim sẻ may mắn";
			this.examEls.birdDesc.textContent="Bạn đã chọn đúng đáp án chính xác của câu hỏi này.";
		}else{
			this.examEls.birdFeedback.className="bird-feedback-card wrong";
			this.examEls.birdImg.src="assets/birds/bird-cry.svg";
			this.examEls.birdTitle.textContent="Chưa chính xác! Chú chim đang động viên bạn";
			this.examEls.birdDesc.textContent=`Đáp án đúng là (${q.correctAnswer}). Hãy đọc kỹ phân tích bên dưới để rút kinh nghiệm.`;
		}
		this.examEls.answerTypeNote.textContent=q.isAiAnswer?"(Đáp án tham khảo)":"";
		this.examEls.explanationText.textContent=q.explanation||"Không có lời giải thích chi tiết.";
		if(q.transcript&&q.transcript.length>0){
			this.examEls.transcriptSection.style.display="block";
			this.examEls.transcriptBox.innerHTML="";
			for(let i=0;i<q.transcript.length;++i){
				const tr=q.transcript[i];
				const line=document.createElement("div");
				line.className="transcript-line";
				line.innerHTML=`
					<span class="line-speaker">${tr.speaker}:</span>
					<span class="line-korean">${tr.text}</span>
					<span class="line-vi">${tr.translation}</span>
				`;
				line.addEventListener("click",()=>this.audio.speakKorean(tr.text,this.examAudioSpeed));
				this.examEls.transcriptBox.appendChild(line);
			}
		}else{
			this.examEls.transcriptSection.style.display="none";
		}
		this.examEls.grammarList.innerHTML="";
		if(q.grammar&&q.grammar.length>0){
			this.examEls.grammarSection.style.display="block";
			for(let i=0;i<q.grammar.length;++i){
				const gm=q.grammar[i];
				const gCard=document.createElement("div");
				gCard.className="grammar-card";
				const isSaved=this.storage.isBookmarked(gm.point);
				gCard.innerHTML=`
					<div class="grammar-header">
						<span class="grammar-point">${gm.point}</span>
						<button class="btn-star ${isSaved?"bookmarked":""}" title="Lưu ngữ pháp vào sổ note">${isSaved?"⭐":"☆"}</button>
					</div>
					<div class="grammar-meaning">${gm.meaning}</div>
					<div class="grammar-example"><strong>Ví dụ:</strong> ${gm.example}</div>
				`;
				gCard.querySelector(".btn-star").addEventListener("click",e=>{
					const btn=e.currentTarget;
					const added=this.storage.toggleNotebookItem({
						type:"grammar",
						korean:gm.point,
						vietnamese:gm.meaning,
						example:gm.example,
						source:q.examTitle||"Đề thi TOPIK"
					});
					btn.textContent=added?"⭐":"☆";
					btn.classList.toggle("bookmarked",added);
					this.renderStats();
				});
				this.examEls.grammarList.appendChild(gCard);
			}
		}else{
			this.examEls.grammarSection.style.display="none";
		}
		this.examEls.vocabGrid.innerHTML="";
		if(q.vocabulary){
			this.examEls.vocabSection.style.display="block";
			const categories=[
				{key:"nouns",title:"Danh từ (명사)"},
				{key:"verbs",title:"Động từ (동사)"},
				{key:"adjectives",title:"Tính từ (형용사)"},
				{key:"adverbs",title:"Trạng từ (부사)"}
			];
			for(let i=0;i<categories.length;++i){
				const cat=categories[i];
				const words=q.vocabulary[cat.key]||[];
				if(words.length===0)continue;
				const col=document.createElement("div");
				col.className="vocab-type-col";
				col.innerHTML=`<h5>${cat.title}</h5>`;
				for(let j=0;j<words.length;++j){
					const w=words[j];
					const isSaved=this.storage.isBookmarked(w.korean);
					const item=document.createElement("div");
					item.className="vocab-item-row";
					item.innerHTML=`
						<div class="vocab-item-text">
							<span class="vocab-ko">${w.korean}</span>
							<span class="vocab-vi">${w.vietnamese}</span>
						</div>
						<div class="vocab-item-actions">
							<button class="btn-audio-mini" title="Nghe phát âm">🔊</button>
							<button class="btn-star-mini ${isSaved?"bookmarked":""}" title="Lưu vào sổ note">${isSaved?"⭐":"☆"}</button>
						</div>
					`;
					item.querySelector(".btn-audio-mini").addEventListener("click",()=>this.audio.speakKorean(w.korean));
					item.querySelector(".btn-star-mini").addEventListener("click",e=>{
						const btn=e.currentTarget;
						const added=this.storage.toggleNotebookItem({
							type:"vocab",
							korean:w.korean,
							vietnamese:w.vietnamese,
							pos:cat.title,
							source:q.examTitle||"Đề thi TOPIK"
						});
						btn.textContent=added?"⭐":"☆";
						btn.classList.toggle("bookmarked",added);
						this.renderStats();
					});
					col.appendChild(item);
				}
				this.examEls.vocabGrid.appendChild(col);
			}
		}else{
			this.examEls.vocabSection.style.display="none";
		}
		this.checkPackCompletion();
	}
	checkPackCompletion(){
		if(!this.currentExamPack)return;
		const total=this.activeExamQuestions.length;
		let answered=0;
		let score=0;
		for(let i=0;i<total;++i){
			const q=this.activeExamQuestions[i];
			const ans=this.storage.getExamAnswer(q.id);
			if(ans){
				++answered;
				if(ans.isCorrect)++score;
			}
		}
		if(answered>=total){
			this.storage.recordPackResult(this.currentExamPack.typeId,score,total);
			const unlocked=this.storage.unlockBird("bird-phoenix","Phượng Hoàng Vàng","Hoàn thành trọn vẹn gói 10 câu hỏi dạng đề thi TOPIK.","assets/birds/bird-phoenix.svg","Hoàn thành trọn vẹn Gói 10 câu");
			this.renderStats();
			if(unlocked){
				this.birdRewardEls.iconWrap.innerHTML=`<img src="assets/birds/bird-phoenix.svg" style="width:100%;height:100%;" alt="Chim Phượng Hoàng">`;
				this.birdRewardEls.name.textContent="Phượng Hoàng Vàng Hoàng Kim";
				this.birdRewardEls.desc.textContent=`Chúc mừng bạn đã hoàn thành trọn vẹn 10 câu hỏi dạng "${this.currentExamPack.typeName}" với số điểm ${score}/${total}!`;
				this.birdRewardModal.classList.add("active");
			}
		}
	}
	prevExamQuestion(){
		if(this.activeExamQuestionIndex>0){
			--this.activeExamQuestionIndex;
			this.renderActiveExamQuestion();
		}
	}
	nextExamQuestion(){
		if(this.activeExamQuestionIndex<this.activeExamQuestions.length-1){
			++this.activeExamQuestionIndex;
			this.renderActiveExamQuestion();
		}else{
			if(typeof alert!=="undefined")alert("Bạn đã hoàn thành câu hỏi cuối cùng của phần thi này!");
			this.examEls.activePlayer.style.display="none";
			this.renderExamView();
		}
	}
	renderCommunicationView(){
		this.commEls.topicPills.innerHTML="";
		const topics=this.commData[this.commLevel]||[];
		if(topics.length===0){
			this.commEls.topicPills.innerHTML=`<span style="color:var(--text-muted);">Đang cập nhật nội dung...</span>`;
			return;
		}
		if(this.currentTopicIndex>=topics.length)this.currentTopicIndex=0;
		for(let i=0;i<topics.length;++i){
			const t=topics[i];
			const pill=document.createElement("button");
			pill.className="filter-pill"+(i===this.currentTopicIndex?" active":"");
			pill.textContent=`${t.dialogueNumber?`Bài ${t.dialogueNumber}: `:""}${t.titleVi}`;
			pill.addEventListener("click",()=>{
				this.currentTopicIndex=i;
				this.currentSentenceIndex=0;
				this.commEls.topicPills.querySelectorAll(".filter-pill").forEach(p=>p.classList.remove("active"));
				pill.classList.add("active");
				this.renderCommunicationSentence();
			});
			this.commEls.topicPills.appendChild(pill);
		}
		this.renderCommunicationSentence();
	}
	renderCommunicationSentence(){
		this.audio.stopAll();
		const topics=this.commData[this.commLevel]||[];
		const topic=topics[this.currentTopicIndex];
		if(!topic||!topic.sentences||topic.sentences.length===0)return;
		if(this.currentSentenceIndex>=topic.sentences.length)this.currentSentenceIndex=0;
		const s=topic.sentences[this.currentSentenceIndex];
		const total=topic.sentences.length;
		this.commEls.cardTopicTag.textContent=`CHỦ ĐỀ: ${topic.titleKo} (${topic.titleVi})`;
		this.commEls.cardSentenceIdx.textContent=`Câu ${this.currentSentenceIndex+1}/${total}`;
		this.commEls.speakerTag.textContent=`Người nói: ${s.speaker||"Bản xứ"}`;
		this.renderInteractiveKoreanLine(s);
		this.commEls.romajaText.textContent=s.romaja||"";
		this.commEls.vietnameseText.textContent=s.vietnamese||"";
		this.commEls.btnMic.classList.remove("recording");
		this.commEls.recStatus.textContent="Bấm nút mic tròn đỏ rồi phát âm câu trên";
		this.commEls.userAudioWrap.style.display="none";
		this.commEls.accuracyBadgeWrap.style.display="none";
		this.commUserAudioUrl=null;
		this.commEls.btnPrev.disabled=this.currentSentenceIndex===0;
		this.commEls.btnPrev.style.opacity=this.currentSentenceIndex===0?"0.4":"1";
		this.commEls.btnNext.textContent=this.currentSentenceIndex===total-1?"Chuyển chủ đề tiếp →":"Câu tiếp theo →";
	}
	renderInteractiveKoreanLine(sentence){
		this.commEls.interactiveKorean.innerHTML="";
		const raw=sentence.korean;
		const words=sentence.words||[];
		const tokens=raw.split(" ");
		for(let i=0;i<tokens.length;++i){
			const token=tokens[i];
			const cleanToken=token.replace(/[.,!?~\s]/g,"");
			const wordObj=words.find(w=>cleanToken.includes(w.word)||w.word.includes(cleanToken));
			const span=document.createElement("span");
			span.className="word-span";
			span.textContent=token+" ";
			if(wordObj){
				const tooltip=document.createElement("div");
				tooltip.className="word-tooltip";
				const isSaved=this.storage.isBookmarked(wordObj.word);
				tooltip.innerHTML=`
					<div class="tooltip-header">
						<strong>${wordObj.word}</strong>
						<button class="btn-star ${isSaved?"bookmarked":""}">${isSaved?"⭐":"☆"}</button>
					</div>
					<div class="tooltip-meaning">${wordObj.meaning}</div>
					${wordObj.pos?`<div class="tooltip-pos">[${wordObj.pos}]</div>`:""}
				`;
				tooltip.querySelector(".btn-star").addEventListener("click",e=>{
					e.stopPropagation();
					const btn=e.currentTarget;
					const added=this.storage.toggleNotebookItem({
						type:"vocab",
						korean:wordObj.word,
						vietnamese:wordObj.meaning,
						pos:wordObj.pos||"",
						example:sentence.korean,
						source:"Giao tiếp Talk To Me In Korean"
					});
					btn.textContent=added?"⭐":"☆";
					btn.classList.toggle("bookmarked",added);
					this.renderStats();
				});
				span.appendChild(tooltip);
			}
			this.commEls.interactiveKorean.appendChild(span);
		}
	}
	playCommAudio(speed=1.0){
		const topics=this.commData[this.commLevel]||[];
		const topic=topics[this.currentTopicIndex];
		const s=topic.sentences[this.currentSentenceIndex];
		if(!s)return;
		if(topic.audioFile){
			this.audio.playLine(topic.audioFile,s.korean,speed);
		}else{
			this.audio.speakKorean(s.korean,speed);
		}
	}
	async toggleCommRecording(){
		const topics=this.commData[this.commLevel]||[];
		const topic=topics[this.currentTopicIndex];
		const s=topic.sentences[this.currentSentenceIndex];
		if(!this.audio.isRecording){
			this.commEls.btnMic.classList.add("recording");
			this.commEls.recStatus.textContent="Đang nghe bạn nói... Hãy phát âm câu tiếng Hàn!";
			await this.audio.startRecording(
				()=>{},
				()=>{
					this.commEls.btnMic.classList.remove("recording");
					this.commEls.recStatus.textContent="Chưa cấp quyền microphone.";
				}
			);
			this.audio.startSpeechRecognition(
				s.korean,
				res=>{
					const acc=res.accuracy;
					this.commEls.accuracyBadgeWrap.style.display="block";
					this.commEls.accuracyVal.textContent=`Độ chính xác: ${acc}% (Nhận diện: "${res.transcript}")`;
					this.commEls.accuracyBadge.className="accuracy-badge "+(acc>=80?"high":(acc>=50?"med":"low"));
				},
				()=>{}
			);
		}else{
			this.commEls.btnMic.classList.remove("recording");
			this.commEls.recStatus.textContent="Đang phân tích giọng nói...";
			const rec=await this.audio.stopRecording();
			if(rec.audioUrl){
				this.commUserAudioUrl=rec.audioUrl;
				this.commEls.userAudioWrap.style.display="block";
				this.commEls.recStatus.textContent="Đã thu âm xong. Bấm nghe lại giọng mình!";
			}
		}
	}
	prevCommSentence(){
		if(this.currentSentenceIndex>0){
			--this.currentSentenceIndex;
			this.renderCommunicationSentence();
		}
	}
	nextCommSentence(){
		const topics=this.commData[this.commLevel]||[];
		const topic=topics[this.currentTopicIndex];
		if(this.currentSentenceIndex<topic.sentences.length-1){
			++this.currentSentenceIndex;
			this.renderCommunicationSentence();
		}else{
			if(this.currentTopicIndex<topics.length-1){
				++this.currentTopicIndex;
				this.currentSentenceIndex=0;
				this.renderCommunicationView();
			}else{
				if(typeof alert!=="undefined")alert("Bạn đã hoàn thành toàn bộ bài hội thoại của phần này!");
			}
		}
	}
	renderNotebookView(){
		const items=this.storage.getNotebookItems(this.notebookFilter);
		this.nbEls.itemsGrid.innerHTML="";
		if(items.length===0){
			this.nbEls.itemsGrid.innerHTML=`<div style="grid-column:1/-1;text-align:center;padding:48px;color:var(--text-muted);font-weight:600;">Chưa có mục nào được lưu trong sổ note. Hãy bấm ⭐ khi học từ hoặc giải đề để lưu lại!</div>`;
			return;
		}
		for(let i=0;i<items.length;++i){
			const it=items[i];
			const card=document.createElement("div");
			card.className="notebook-card";
			card.innerHTML=`
				<div class="notebook-card-header">
					<span class="day-tag">${it.type==="grammar"?"Ngữ pháp":"Từ vựng"}</span>
					<span class="notebook-card-source">${it.source||"Đề thi"}</span>
				</div>
				<div class="notebook-card-korean">${it.korean}</div>
				<div class="notebook-card-vi">${it.vietnamese}</div>
				${it.example?`<div class="notebook-card-example"><strong>VD:</strong> ${it.example}</div>`:""}
				<div class="notebook-card-actions">
					<button class="btn-audio-mini" title="Nghe phát âm">🔊 Nghe</button>
					<button class="btn-delete" title="Xóa khỏi sổ note">🗑️ Xóa</button>
				</div>
			`;
			card.querySelector(".btn-audio-mini").addEventListener("click",()=>this.audio.speakKorean(it.korean));
			card.querySelector(".btn-delete").addEventListener("click",()=>{
				this.storage.removeNotebookItem(it.id);
				this.renderNotebookView();
				this.renderStats();
			});
			this.nbEls.itemsGrid.appendChild(card);
		}
	}
	renderBirdsView(){
		const unlockedBirds=this.storage.getBirds();
		this.birdsGrid.innerHTML="";
		for(let i=0;i<this.birdDefinitions.length;++i){
			const def=this.birdDefinitions[i];
			const unlocked=unlockedBirds.find(b=>b.id===def.id);
			const card=document.createElement("div");
			card.className="bird-card"+(unlocked?"":" locked");
			card.innerHTML=`
				<div class="bird-img-wrap">
					<img src="${def.icon}" alt="${def.name}">
				</div>
				<h4 class="bird-name">${def.name}</h4>
				<div class="bird-status-tag ${unlocked?"unlocked":"locked"}">${unlocked?"Đã mở khóa":"Chưa mở khóa"}</div>
				<p class="bird-desc">${unlocked?(unlocked.reason||def.desc):def.condition}</p>
			`;
			this.birdsGrid.appendChild(card);
		}
	}
}
document.addEventListener("DOMContentLoaded",()=>{
	window.app=new TopikApp();
});
