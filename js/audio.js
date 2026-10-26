class AudioManager{
	constructor(){
		this.synth=window.speechSynthesis;
		this.koreanVoice=null;
		this.mediaRecorder=null;
		this.recordedChunks=[];
		this.currentAudioUrl=null;
		this.isRecording=false;
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
		this.synth.cancel();
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
	stopSpeech(){
		if(this.synth)this.synth.cancel();
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
		return new Promise((resolve)=>{
			if(!this.mediaRecorder||this.mediaRecorder.state==='inactive'){
				this.isRecording=false;
				resolve({audioUrl:null,blob:null});
				return;
			}
			this.mediaRecorder.onstop=()=>{
				const blob=new Blob(this.recordedChunks,{type:'audio/webm'});
				if(this.mediaRecorder.stream){
					this.mediaRecorder.stream.getTracks().forEach(track=>track.stop());
				}
				this.currentAudioUrl=URL.createObjectURL(blob);
				this.isRecording=false;
				resolve({audioUrl:this.currentAudioUrl,blob});
			};
			this.mediaRecorder.stop();
		});
	}
	startSpeechRecognition(targetKorean,onResult,onError){
		const SpeechRecognition=window.SpeechRecognition||window.webkitSpeechRecognition;
		if(!SpeechRecognition){
			if(onError)onError(new Error("Trình duyệt không hỗ trợ Web Speech Recognition. Bạn có thể nghe lại đoạn ghi âm vừa thu."));
			return null;
		}
		const recognizer=new SpeechRecognition();
		recognizer.lang='ko-KR';
		recognizer.interimResults=false;
		recognizer.maxAlternatives=3;
		recognizer.onresult=(event)=>{
			const transcript=event.results[0][0].transcript.trim();
			const cleanTranscript=transcript.replace(/[.,!?\s]/g,"");
			const cleanTarget=targetKorean.replace(/[.,!?\s]/g,"");
			const isMatch=cleanTranscript.includes(cleanTarget)||cleanTarget.includes(cleanTranscript);
			if(onResult)onResult({transcript,isMatch,confidence:event.results[0][0].confidence});
		};
		recognizer.onerror=(event)=>{
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
	playAudioUrl(url,onEnd){
		if(!url)return;
		const audio=new Audio(url);
		if(onEnd){
			audio.onended=onEnd;
			audio.onerror=onEnd;
		}
		audio.play().catch(e=>{if(onEnd)onEnd();});
		return audio;
	}
}
window.audioManager=new AudioManager();
