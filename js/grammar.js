class KoreanGrammarChecker{
	isHangul(char){
		if(!char)return false;
		const code=char.charCodeAt(0);
		return code>=0xAC00&&code<=0xD7A3;
	}
	getBatchimInfo(char){
		if(!this.isHangul(char))return{hasBatchim:false,batchimIndex:0};
		const code=char.charCodeAt(0);
		const bIdx=(code-0xAC00)%28;
		return{hasBatchim:bIdx!==0,batchimIndex:bIdx,isRieul:bIdx===8};
	}
	checkSentence(userInput,targetWordObj){
		const trimmed=(userInput||"").trim();
		const errors=[];
		const praises=[];
		if(!trimmed){
			return{
				isValid:false,
				errors:["Vui lòng nhập câu tiếng Hàn của bạn vào ô trống."],
				praises:[],
				sampleSentence:targetWordObj.sample_sentence,
				sampleTranslation:targetWordObj.sample_translation
			};
		}
		const cleanSentence=trimmed.replace(/[.!?~]+$/,"").trim();
		const targetWord=targetWordObj.korean.trim();
		const stem=targetWord.endsWith("다")?targetWord.slice(0,-1):targetWord;
		let wordFound=false;
		if(cleanSentence.includes(targetWord)||cleanSentence.includes(stem)){
			wordFound=true;
		}else if(stem.length>=2){
			const subStem=stem.slice(0,2);
			if(cleanSentence.includes(subStem))wordFound=true;
		}
		if(!wordFound){
			errors.push(`Câu của bạn chưa chứa từ vựng "${targetWord}" hoặc dạng chia phù hợp của từ.`);
		}else{
			praises.push(`Đã sử dụng chính xác từ vựng mục tiêu "${targetWord}".`);
		}
		this.validateParticles(cleanSentence,errors);
		this.validateEndings(cleanSentence,errors,praises);
		const isValid=errors.length===0;
		return{
			isValid,
			errors,
			praises,
			sampleSentence:targetWordObj.sample_sentence,
			sampleTranslation:targetWordObj.sample_translation
		};
	}
	validateParticles(text,errors){
		const tokens=text.split(/\s+/);
		for(let i=0;i<tokens.length;++i){
			const token=tokens[i];
			if(token.length<2)continue;
			if(token.endsWith("은")&&!token.endsWith("좋은")&&!token.endsWith("많은")&&!token.endsWith("작은")){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&!this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (không có patchim), nên dùng trợ từ chủ ngữ "는" thay vì "은" (ví dụ: ${token.slice(0,-1)}는).`);
				}
			}
			if(token.endsWith("는")){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (có patchim), nên dùng trợ từ chủ ngữ "은" thay vì "는" (ví dụ: ${token.slice(0,-1)}은).`);
				}
			}
			if(token.endsWith("이")&&token.length>=2){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&!this.getBatchimInfo(prevChar).hasBatchim&&!["같","많","높","깊","굳","끝"].includes(prevChar)){
					errors.push(`Sau âm "${prevChar}" (không có patchim), nên dùng trợ từ "가" thay vì "이" (ví dụ: ${token.slice(0,-1)}가).`);
				}
			}
			if(token.endsWith("가")&&token.length>=2){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (có patchim), nên dùng trợ từ "이" thay vì "가" (ví dụ: ${token.slice(0,-1)}이).`);
				}
			}
			if(token.endsWith("을")){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&!this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (không có patchim), nên dùng trợ từ tân ngữ "를" thay vì "을" (ví dụ: ${token.slice(0,-1)}를).`);
				}
			}
			if(token.endsWith("를")){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (có patchim), nên dùng trợ từ tân ngữ "을" thay vì "를" (ví dụ: ${token.slice(0,-1)}을).`);
				}
			}
			if(token.endsWith("과")){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&!this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (không có patchim), nên dùng "와" thay vì "과" (ví dụ: ${token.slice(0,-1)}와).`);
				}
			}
			if(token.endsWith("와")&&token.length>=2){
				const prevChar=token[token.length-2];
				if(this.isHangul(prevChar)&&this.getBatchimInfo(prevChar).hasBatchim){
					errors.push(`Sau âm "${prevChar}" (có patchim), nên dùng "과" thay vì "와" (ví dụ: ${token.slice(0,-1)}과).`);
				}
			}
			if(token.endsWith("으로")){
				const prevChar=token[token.length-3];
				if(this.isHangul(prevChar)){
					const info=this.getBatchimInfo(prevChar);
					if(!info.hasBatchim||info.isRieul){
						errors.push(`Sau âm "${prevChar}" (không có patchim hoặc có patchim 'ㄹ'), nên dùng "로" thay vì "으로" (ví dụ: ${token.slice(0,-2)}로).`);
					}
				}
			}
		}
	}
	validateEndings(cleanSentence,errors,praises){
		const validEndingPatterns=[
			/[아어여해]요$/,
			/[았었였했]어요$/,
			/겠어요$/,
			/[스습]니다$/,
			/[았었였했]습니다$/,
			/[스습]니까$/,
			/[았었였했]습니까$/,
			/[으]?세요$/,
			/[으]?십시오$/,
			/[으]?ㄹ게요$/,
			/[으]?ㄹ까요$/,
			/[으]?ㄹ[거겁]예요$/,
			/[으]?ㄹ\s*[거겁]예요$/,
			/[으]?ㄹ\s*것이다$/,
			/[으]?ㄹ\s*수\s*[있없]다$/,
			/[으]?ㄹ\s*수\s*[있없]어요$/,
			/[으]?ㄹ\s*수\s*[있없]습니다$/,
			/고\s*싶[다어요습니다]+$/,
			/지\s*않[다아요습니다]+$/,
			/[이예]에요$/,
			/입니다$/,
			/입니까$/,
			/거든요$/,
			/잖아요$/,
			/네요$/,
			/군요$/,
			/지요$/,
			/죠$/,
			/[ㄴ는]?다$/,
			/[았었였했]다$/
		];
		const hasValidEnding=validEndingPatterns.some(ptn=>ptn.test(cleanSentence));
		if(!hasValidEnding){
			errors.push("Câu tiếng Hàn nên kết thúc bằng đuôi câu vị ngữ chuẩn (như -아/어요, -(스)ㅂ니다, -(으)세요 hoặc danh từ đi với 이에요/예요, 입니다).");
		}else{
			praises.push("Đuôi câu được chia hợp quy tắc ngữ pháp.");
		}
	}
}
window.koreanGrammarChecker=new KoreanGrammarChecker();
