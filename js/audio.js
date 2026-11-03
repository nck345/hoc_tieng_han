class AudioManager{
	constructor(){
		this.synth=window.speechSynthesis;
		this.koreanVoice=null;
		this.mediaRecorder=null;
		this.recordedChunks=[];
		this.currentAudioUrl=null;
		this.isRecording=false;
		this.currentAudioEl=null;
		this.initVoices();
	}
	initVoices(){
		if(!this.synth)return;
		const load=()=>{
			const voices=this.synth.getVoices();
			this.koreanVoice=voices.find(v=>v.lang==='ko-KR'||v.lang.startsWith('ko'))||null;
		};
		load();
		if(this.synth.onvoiceschanged!==undefined)this.synth.onvoiceschanged=load;
	}
	speakKorean(text,speed=1.0,onStart,onEnd){
		if(!this.synth)return;
		this.stopAll();
		const utter=new SpeechSynthesisUtterance(text);
		utter.lang='ko-KR';
		utter.rate=speed;
		utter.pitch=1.0;
		if(this.koreanVoice)utter.voice=this.koreanVoice;
		if(onStart)utter.onstart=onStart;
		if(onEnd){
			utter.onend=onEnd;
			utter.onerror=onEnd;
		}
		this.synth.speak(utter);
	}
	playAudioFile(url,speed=1.0,onStart,onEnd){
		this.stopAll();
		if(!url){
			if(onEnd)onEnd();
			return null;
		}
		const audio=new Audio(url);
		this.currentAudioEl=audio;
		audio.playbackRate=speed;
		if(onStart)audio.onplay=onStart;
		audio.onended=()=>{
			this.currentAudioEl=null;
			if(onEnd)onEnd();
		};
		audio.onerror=(e)=>{
			this.currentAudioEl=null;
			if(onEnd)onEnd(e);
		};
		audio.play().catch(err=>{
			this.currentAudioEl=null;
			if(onEnd)onEnd(err);
		});
		return audio;
	}
	playLine(audioUrl,koreanText,speed=1.0,onStart,onEnd){
		if(audioUrl){
			this.playAudioFile(audioUrl,speed,onStart,onEnd);
		}else{
			this.speakKorean(koreanText,speed,onStart,onEnd);
		}
	}
	stopAll(){
		if(this.synth)this.synth.cancel();
		if(this.currentAudioEl){
			try{
				this.currentAudioEl.pause();
				this.currentAudioEl.currentTime=0;
			}catch(e){}
			this.currentAudioEl=null;
		}
	}
	async startRecording(onSuccess,onError){
		try{
			if(this.currentAudioUrl){
				URL.revokeObjectURL(this.currentAudioUrl);
				this.currentAudioUrl=null;
			}
			const stream=await navigator.mediaDevices.getUserMedia({audio:true});
			this.recordedChunks=[];
			this.mediaRecorder=new MediaRecorder(stream);
			this.mediaRecorder.ondataavailable=e=>{
				if(e.data.size>0)this.recordedChunks.push(e.data);
			};
			this.mediaRecorder.start();
			this.isRecording=true;
			if(onSuccess)onSuccess();
		}catch(err){
			this.isRecording=false;
			if(onError)onError(err);
		}
	}
	stopRecording(){
		return new Promise(resolve=>{
			if(!this.mediaRecorder||this.mediaRecorder.state==='inactive'){
				this.isRecording=false;
				resolve({audioUrl:null,blob:null});
				return;
			}
			this.mediaRecorder.onstop=()=>{
				const blob=new Blob(this.recordedChunks,{type:'audio/webm'});
				if(this.mediaRecorder.stream){
					this.mediaRecorder.stream.getTracks().forEach(t=>t.stop());
				}
				this.currentAudioUrl=URL.createObjectURL(blob);
				this.isRecording=false;
				resolve({audioUrl:this.currentAudioUrl,blob});
			};
			this.mediaRecorder.stop();
		});
	}
	playAudioUrl(url,onEnd){
		if(!url)return;
		const a=new Audio(url);
		if(onEnd){
			a.onended=onEnd;
			a.onerror=onEnd;
		}
		a.play().catch(e=>{if(onEnd)onEnd();});
		return a;
	}
	startSpeechRecognition(targetKorean,onResult,onError){
		const SpeechRecognition=window.SpeechRecognition||window.webkitSpeechRecognition;
		if(!SpeechRecognition){
			if(onError)onError(new Error("Trình duyệt không hỗ trợ Web Speech API. Bạn vẫn có thể nghe lại giọng ghi âm."));
			return null;
		}
		const recognizer=new SpeechRecognition();
		recognizer.lang='ko-KR';
		recognizer.interimResults=false;
		recognizer.maxAlternatives=3;
		recognizer.onresult=event=>{
			const transcript=event.results[0][0].transcript.trim();
			const accuracy=this.calcAccuracy(transcript,targetKorean);
			const isMatch=accuracy>=60;
			if(onResult)onResult({
				transcript,
				target:targetKorean,
				accuracy,
				isMatch,
				confidence:event.results[0][0].confidence
			});
		};
		recognizer.onerror=event=>{
			if(onError)onError(event);
		};
		try{
			recognizer.start();
			return recognizer;
		}catch(e){
			if(onError)onError(e);
			return null;
		}
	}
	calcAccuracy(recognized,target){
		const c1=recognized.replace(/[.,!?~\s]/g,"").toLowerCase();
		const c2=target.replace(/[.,!?~\s]/g,"").toLowerCase();
		if(!c1||!c2)return 0;
		if(c1===c2)return 100;
		const d=this.levenshtein(c1,c2);
		const maxLen=Math.max(c1.length,c2.length);
		const score=Math.max(0,Math.round(((maxLen-d)/maxLen)*100));
		return score;
	}
	levenshtein(a,b){
		const dp=Array(a.length+1).fill(null).map(()=>Array(b.length+1).fill(0));
		for(let i=0;i<=a.length;++i)dp[i][0]=i;
		for(let j=0;j<=b.length;++j)dp[0][j]=j;
		for(let i=1;i<=a.length;++i){
			for(let j=1;j<=b.length;++j){
				const cost=a[i-1]===b[j-1]?0:1;
				dp[i][j]=Math.min(dp[i-1][j]+1,dp[i][j-1]+1,dp[i-1][j-1]+cost);
			}
		}
		return dp[a.length][b.length];
	}
}
window.audioManager=new AudioManager();
