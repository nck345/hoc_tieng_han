import json,sys
sys.stdout.reconfigure(encoding='utf-8')
data=[
	{
		"id":"unit_1","day":1,"titleKo":"가족","titleVi":"Gia đình","category":"Đời sống & Gia đình",
		"words":[
			{"id":"u1_w1","korean":"며느리","pos":"n","posName":"Danh từ","vietnamese":"Con dâu","hanja":"","hint_words":"셋째, 결혼하다, 맞다","sample_sentence":"셋째 며느리는 마음씨가 착하고 예뻐요.","sample_translation":"Cô con dâu thứ ba rất hiền lành và xinh đẹp.","collocations":["사랑받는 며느리","며느리를 맞다"]},
			{"id":"u1_w2","korean":"새어머니","pos":"n","posName":"Danh từ","vietnamese":"Mẹ kế","hanja":"","hint_words":"모시다, 부르다, 다정하다","sample_sentence":"처음에는 새어머니를 어머니라고 부르기 어려웠어요.","sample_translation":"Ban đầu việc gọi mẹ kế là mẹ rất khó khăn.","collocations":["새어머니를 모시다"]},
			{"id":"u1_w3","korean":"손자","pos":"n","posName":"Danh từ","vietnamese":"Cháu trai","hanja":"孫子","hint_words":"막내, 방학, 놀러 오다","sample_sentence":"방학이 되어서 막내 손자가 우리 집에 놀러 왔어요.","sample_translation":"Đến kỳ nghỉ hè cháu trai út đã sang nhà chúng tôi chơi.","collocations":["귀여운 손자","손자를 보다"]},
			{"id":"u1_w4","korean":"시부모님","pos":"n","posName":"Danh từ","vietnamese":"Bố mẹ chồng","hanja":"","hint_words":"모시다, 살다, 공경하다","sample_sentence":"시부모님을 정성껏 모시고 사는 것은 보람있어요.","sample_translation":"Chăm sóc và phụng dưỡng bố mẹ chồng là điều rất ý nghĩa.","collocations":["시부모님을 모시다"]},
			{"id":"u1_w5","korean":"자녀","pos":"n","posName":"Danh từ","vietnamese":"Con cái","hanja":"子女","hint_words":"교육, 기르다, 낳다","sample_sentence":"부모는 자녀의 교육에 관심이 매우 많아요.","sample_translation":"Cha mẹ rất quan tâm đến việc giáo dục con cái.","collocations":["자녀를 기르다","자녀 교육"]},
			{"id":"u1_w6","korean":"현모양처","pos":"n","posName":"Danh từ","vietnamese":"Người vợ hiền mẹ đảm","hanja":"賢妻良母","hint_words":"되다, 꿈, 가정","sample_sentence":"그녀의 어릴 적 꿈은 현모양처가 되는 것이었다.","sample_translation":"Ước mơ thuở nhỏ của cô ấy là trở thành người vợ hiền mẹ đảm.","collocations":["현모양처의 길"]},
			{"id":"u1_w7","korean":"효녀","pos":"n","posName":"Danh từ","vietnamese":"Người con gái hiếu thảo","hanja":"孝女","hint_words":"부모님, 효도하다, 소문나다","sample_sentence":"그녀는 부모님을 극진히 모시는 효녀로 유명해요.","sample_translation":"Cô ấy nổi tiếng là một người con gái hiếu thảo chăm sóc bố mẹ chu đáo.","collocations":["소문난 효녀"]},
			{"id":"u1_w8","korean":"막내","pos":"n","posName":"Danh từ","vietnamese":"Con út","hanja":"","hint_words":"태어나다, 사랑, 귀엽다","sample_sentence":"우리 집 막내는 가족들의 사랑을 독차지해요.","sample_translation":"Em út nhà tôi độc chiếm trọn tình yêu của cả gia đình.","collocations":["막내딸","막내아들"]},
			{"id":"u1_w9","korean":"맏딸","pos":"n","posName":"Danh từ","vietnamese":"Con gái cả (trưởng nữ)","hanja":"長女","hint_words":"책임감, 결혼식, 듬직하다","sample_sentence":"우리 집 맏딸은 책임감이 아주 강해요.","sample_translation":"Con gái cả nhà tôi có tinh thần trách nhiệm rất cao.","collocations":["맏딸 역할"]},
			{"id":"u1_w10","korean":"쌍둥이","pos":"n","posName":"Danh từ","vietnamese":"Sinh đôi","hanja":"","hint_words":"닮다, 태어나다, 얼굴","sample_sentence":"그 쌍둥이 형제는 얼굴과 성격이 완전히 달라요.","sample_translation":"Hai anh em sinh đôi đó khuôn mặt và tính cách hoàn toàn khác nhau.","collocations":["일란성 쌍둥이","이란성 쌍둥이"]},
			{"id":"u1_w11","korean":"외동딸","pos":"n","posName":"Danh từ","vietnamese":"Con gái một","hanja":"","hint_words":"자라다, 혼자, 귀엽다","sample_sentence":"외동딸로 자라서 가끔 형제가 있었으면 좋겠어요.","sample_translation":"Lớn lên là con gái một nên thỉnh thoảng tôi ước có anh chị em.","collocations":["하나뿐인 외동딸"]},
			{"id":"u1_w12","korean":"자매","pos":"n","posName":"Danh từ","vietnamese":"Chị em gái","hanja":"姉妹","hint_words":"사이좋다, 옷, 공유하다","sample_sentence":"두 자매는 항상 사이좋게 지내요.","sample_translation":"Hai chị em gái luôn luôn hòa thuận với nhau.","collocations":["자매결연","사이좋은 자매"]},
			{"id":"u1_w13","korean":"가정","pos":"n","posName":"Danh từ","vietnamese":"Gia đình (mái ấm)","hanja":"家庭","hint_words":"행복하다, 꾸리다, 이루다","sample_sentence":"따뜻하고 화목한 가정을 이루는 것이 제 소원이에요.","sample_translation":"Xây dựng một mái ấm gia đình ấm áp và hòa thuận là ước nguyện của tôi.","collocations":["화목한 가정","가정을 꾸리다"]},
			{"id":"u1_w14","korean":"식구","pos":"n","posName":"Danh từ","vietnamese":"Thành viên trong nhà (miệng ăn)","hanja":"食口","hint_words":"많다, 저녁, 모이다","sample_sentence":"우리 집은 식구가 많아서 매일 떠들썩해요.","sample_translation":"Nhà tôi đông người nên mỗi ngày đều rất rôm rả, náo nhiệt.","collocations":["대가족 식구","한 식구"]},
			{"id":"u1_w15","korean":"집안","pos":"n","posName":"Danh từ","vietnamese":"Gia phong, trong nhà","hanja":"","hint_words":"어른, 분위기, 행사","sample_sentence":"집안 어른들께서 모두 건강하셔서 다행이에요.","sample_translation":"Thật may mắn vì các bậc trưởng bối trong dòng họ đều khỏe mạnh.","collocations":["집안 분위기","집안 어른"]}
		]
	},
	{
		"id":"unit_2","day":2,"titleKo":"외모와 성격 1","titleVi":"Ngoại hình & Tính cách 1","category":"Đời sống & Con người",
		"words":[
			{"id":"u2_w1","korean":"외모","pos":"n","posName":"Danh từ","vietnamese":"Ngoại hình","hanja":"外貌","hint_words":"단정하다, 중요하다, 가꾸다","sample_sentence":"사람을 만날 때는 첫인상과 단정한 외모가 중요해요.","sample_translation":"Khi gặp gỡ mọi người, ấn tượng đầu tiên và ngoại hình chỉn chu rất quan trọng.","collocations":["외모 지상주의","외모를 가꾸다"]},
			{"id":"u2_w2","korean":"긍정적","pos":"adj","posName":"Tính từ","vietnamese":"Tích cực","hanja":"肯定的","hint_words":"생각하다, 마인드, 태도","sample_sentence":"어려운 상황에서도 긍정적으로 생각하려고 노력해요.","sample_translation":"Dù trong hoàn cảnh khó khăn tôi vẫn nỗ lực suy nghĩ tích cực.","collocations":["긍정적인 사고","긍정적인 영향"]},
			{"id":"u2_w3","korean":"꼼꼼하다","pos":"adj","posName":"Tính từ","vietnamese":"Tỉ mỉ, cẩn thận","hanja":"","hint_words":"일처리, 확인하다, 성격","sample_sentence":"그는 서류를 꼼꼼하게 검토하는 성격이에요.","sample_translation":"Anh ấy có tính cách kiểm tra tài liệu rất cẩn thận, tỉ mỉ.","collocations":["꼼꼼한 성격","꼼꼼히 살피다"]},
			{"id":"u2_w4","korean":"너그럽다","pos":"adj","posName":"Tính từ","vietnamese":"Khoan dung, rộng lượng","hanja":"","hint_words":"마음, 용서하다, 태도","sample_sentence":"선생님께서는 학생들의 실수를 너그럽게 감싸 주셨다.","sample_translation":"Thầy giáo đã rộng lượng bao dung cho lỗi lầm của các học sinh.","collocations":["너그러운 마음","너그럽게 대하다"]},
			{"id":"u2_w5","korean":"느긋하다","pos":"adj","posName":"Tính từ","vietnamese":"Ung dung, thong thả","hanja":"","hint_words":"마음, 기다리다, 성격","sample_sentence":"시간 여유가 있으니 느긋하게 차를 마셔요.","sample_translation":"Vì còn nhiều thời gian nên hãy ung dung thưởng trà nhé.","collocations":["느긋한 마음","느긋하게 쉬다"]},
			{"id":"u2_w6","korean":"다정하다","pos":"adj","posName":"Tính từ","vietnamese":"Ấm áp, tình cảm","hanja":"多情","hint_words":"말투, 목소리, 태도","sample_sentence":"그는 언제나 다정한 목소리로 이야기해요.","sample_translation":"Anh ấy lúc nào cũng trò chuyện bằng giọng nói rất tình cảm.","collocations":["다정한 눈빛","다정다감하다"]},
			{"id":"u2_w7","korean":"명랑하다","pos":"adj","posName":"Tính từ","vietnamese":"Vui vẻ, tươi sáng","hanja":"明朗","hint_words":"웃음, 성격, 분위기","sample_sentence":"그녀는 항상 명랑한 성격으로 주변을 밝혀 줍니다.","sample_translation":"Cô ấy luôn làm sáng bừng bầu không khí xung quanh với tính cách vui tươi.","collocations":["명랑한 웃음소리","명랑 쾌활하다"]},
			{"id":"u2_w8","korean":"활발하다","pos":"adj","posName":"Tính từ","vietnamese":"Hoạt bát, năng động","hanja":"活發","hint_words":"활동, 성격, 교류","sample_sentence":"아이들은 밖에서 활발하게 뛰어놀고 있어요.","sample_translation":"Lũ trẻ đang vui vẻ chạy nhảy hoạt bát ngoài trời.","collocations":["활발한 활동","활발한 성격"]},
			{"id":"u2_w9","korean":"부정적","pos":"adj","posName":"Tính từ","vietnamese":"Tiêu cực","hanja":"否定的","hint_words":"시각, 생각, 영향","sample_sentence":"매사를 부정적으로 보면 발전하기 힘들어요.","sample_translation":"Nếu nhìn nhận mọi việc một cách tiêu cực thì rất khó tiến bộ.","collocations":["부정적인 생각","부정적 평가"]},
			{"id":"u2_w10","korean":"게으르다","pos":"adj","posName":"Tính từ","vietnamese":"Lười biếng","hanja":"","hint_words":"주말, 늦잠, 고치다","sample_sentence":"주말이라고 너무 게으르게 뒹굴기만 하면 안 돼요.","sample_translation":"Không nên vì là cuối tuần mà cứ lười biếng nằm lăn qua lăn lại mãi.","collocations":["게으름을 피우다","게으른 사람"]},
			{"id":"u2_w11","korean":"고집","pos":"n","posName":"Danh từ","vietnamese":"Tính cố chấp, bướng bỉnh","hanja":"固執","hint_words":"세다, 피우다, 부리다","sample_sentence":"자기 고집만 부리지 말고 남의 말도 들어 보세요.","sample_translation":"Đừng chỉ khăng khăng bướng bỉnh theo ý mình mà hãy lắng nghe người khác.","collocations":["고집이 세다","고집을 부리다"]},
			{"id":"u2_w12","korean":"까다롭다","pos":"adj","posName":"Tính từ","vietnamese":"Khó tính, cầu kỳ","hanja":"","hint_words":"입맛, 성격, 조건","sample_sentence":"그 손님은 입맛이 까다로워서 음식을 고르기 힘들어요.","sample_translation":"Vị khách đó khẩu vị rất khó tính nên chọn món ăn khá khó.","collocations":["까다로운 조건","입맛이 까다롭다"]},
			{"id":"u2_w13","korean":"욕심","pos":"n","posName":"Danh từ","vietnamese":"Lòng tham, ham muốn","hanja":"慾心","hint_words":"부리다, 많다, 버리다","sample_sentence":"너무 많은 욕심을 부리면 결국 손해를 봐요.","sample_translation":"Nếu tham lam quá độ thì cuối cùng sẽ chịu thiệt thòi.","collocations":["욕심을 부리다","욕심이 많다"]},
			{"id":"u2_w14","korean":"이기적","pos":"adj","posName":"Tính từ","vietnamese":"Ích kỷ","hanja":"利己的","hint_words":"행동, 성격, 태도","sample_sentence":"남을 배려하지 않는 이기적인 행동은 피해야 해요.","sample_translation":"Cần tránh những hành vi ích kỷ không biết quan tâm đến người khác.","collocations":["이기적인 태도","이기주의"]}
		]
	},
	{
		"id":"unit_3","day":3,"titleKo":"외모와 성격 2","titleVi":"Ngoại hình & Tính cách 2","category":"Đời sống & Con người",
		"words":[
			{"id":"u3_w1","korean":"개성","pos":"n","posName":"Danh từ","vietnamese":"Cá tính","hanja":"個性","hint_words":"넘치다, 살리다, 패션","sample_sentence":"자신만의 개성을 살려 옷을 입는 것이 멋져요.","sample_translation":"Mặc quần áo làm nổi bật cá tính riêng của bản thân thật là ngầu.","collocations":["개성이 강하다","개성을 살리다"]},
			{"id":"u3_w2","korean":"매력","pos":"n","posName":"Danh từ","vietnamese":"Sức hút, sự quyến rũ","hanja":"魅力","hint_words":"넘치다, 끌리다, 사람","sample_sentence":"그녀의 밝은 미소는 사람을 끄는 매력이 있어요.","sample_translation":"Nụ cười rạng rỡ của cô ấy có sức hút lôi cuốn mọi người.","collocations":["매력적인 사람","매력에 빠지다"]},
			{"id":"u3_w3","korean":"인상","pos":"n","posName":"Danh từ","vietnamese":"Ấn tượng","hanja":"印象","hint_words":"좋다, 첫인상, 남기다","sample_sentence":"첫인상이 좋으면 대화가 한결 수월해집니다.","sample_translation":"Nếu ấn tượng đầu tiên tốt thì cuộc trò chuyện sẽ dễ dàng hơn nhiều.","collocations":["첫인상","인상이 좋다"]},
			{"id":"u3_w4","korean":"단정하다","pos":"adj","posName":"Tính từ","vietnamese":"Chỉn chu, gọn gàng","hanja":"端正","hint_words":"옷차림, 머리, 모습","sample_sentence":"면접을 볼 때는 단정한 복장이 필수적이에요.","sample_translation":"Khi đi phỏng vấn thì trang phục chỉn chu là điều thiết yếu.","collocations":["단정한 복장","단정하게 빗다"]},
			{"id":"u3_w5","korean":"날씬하다","pos":"adj","posName":"Tính từ","vietnamese":"Thon thả, mảnh mai","hanja":"","hint_words":"몸매, 유지하다, 다이어트","sample_sentence":"꾸준한 운동 덕분에 날씬한 몸매를 유지하고 있어요.","sample_translation":"Nhờ tập thể dục đều đặn mà tôi duy trì được vóc dáng thon thả.","collocations":["날씬한 몸매","날씬해 보이다"]},
			{"id":"u3_w6","korean":"뚱뚱하다","pos":"adj","posName":"Tính từ","vietnamese":"Béo, mập mạp","hanja":"","hint_words":"체격, 살찌다, 건강","sample_sentence":"예전에는 뚱뚱했지만 운동으로 건강해졌어요.","sample_translation":"Trước đây tôi béo mập nhưng nhờ thể thao đã khỏe mạnh hơn.","collocations":["뚱뚱한 체격"]},
			{"id":"u3_w7","korean":"깔끔하다","pos":"adj","posName":"Tính từ","vietnamese":"Gọn gàng, ngăn nắp, sạch sẽ","hanja":"","hint_words":"정리, 방, 성격","sample_sentence":"방을 깔끔하게 정리하니 기분이 상쾌해졌어요.","sample_translation":"Dọn dẹp phòng ngăn nắp sạch sẽ khiến tâm trạng trở nên sảng khoái.","collocations":["깔끔한 성격","깔끔하게 치우다"]},
			{"id":"u3_w8","korean":"생김새","pos":"n","posName":"Danh từ","vietnamese":"Nét mặt, tướng mạo","hanja":"","hint_words":"닮다, 독특하다, 모습","sample_sentence":"형제지만 두 사람의 생김새는 사뭇 달라요.","sample_translation":"Tuy là anh em nhưng diện mạo của hai người lại hoàn toàn khác nhau.","collocations":["독특한 생김새"]},
			{"id":"u3_w9","korean":"여드름","pos":"n","posName":"Danh từ","vietnamese":"Mụn trứng cá","hanja":"","hint_words":"나다, 짜다, 피부","sample_sentence":"사춘기가 되면서 얼굴에 여드름이 나기 시작했다.","sample_translation":"Khi bước vào tuổi dậy thì mụn bắt đầu mọc trên mặt.","collocations":["여드름이 나다","여드름을 짜다"]},
			{"id":"u3_w10","korean":"네모나다","pos":"adj","posName":"Tính từ","vietnamese":"Vuông vức, hình vuông","hanja":"","hint_words":"얼굴, 상자, 안경","sample_sentence":"네모난 안경이 그의 지적인 이미지와 잘 어울려요.","sample_translation":"Chiếc kính vuông rất hợp với hình tượng trí thức của anh ấy.","collocations":["네모난 얼굴","네모난 모양"]},
			{"id":"u3_w11","korean":"미인","pos":"n","posName":"Danh từ","vietnamese":"Người đẹp, mỹ nhân","hanja":"美人","hint_words":"대회, 소문나다, 예쁘다","sample_sentence":"그녀는 동네에서 소문난 미인이에요.","sample_translation":"Cô ấy là một người đẹp nổi tiếng khắp khu phố.","collocations":["세계 미인 대회","절세미인"]},
			{"id":"u3_w12","korean":"잘나다","pos":"adj","posName":"Tính từ","vietnamese":"Giỏi giang, tài giỏi, sáng sủa","hanja":"","hint_words":"체하다, 사람, 잘생기다","sample_sentence":"혼자만 잘난 체하지 말고 협력할 줄 알아야 해요.","sample_translation":"Đừng chỉ biết ra vẻ tài giỏi một mình mà phải biết hợp tác.","collocations":["잘난 척하다","잘난 사람"]},
			{"id":"u3_w13","korean":"미소","pos":"n","posName":"Danh từ","vietnamese":"Nụ cười mỉm","hanja":"微笑","hint_words":"짓다, 밝다, 띠다","sample_sentence":"따뜻한 미소로 손님들을 맞이하는 것이 중요해요.","sample_translation":"Việc đón tiếp khách với một nụ cười ấm áp là rất quan trọng.","collocations":["미소를 짓다","밝은 미소"]},
			{"id":"u3_w14","korean":"표정","pos":"n","posName":"Danh từ","vietnamese":"Biểu cảm khuôn mặt","hanja":"表情","hint_words":"밝다, 굳다, 짓다","sample_sentence":"좋은 소식을 듣고 그의 얼굴 표정이 밝아졌어요.","sample_translation":"Nghe được tin vui, nét mặt của anh ấy bừng sáng lên.","collocations":["밝은 표정","어두운 표정"]}
		]
	},
	{
		"id":"unit_4","day":4,"titleKo":"옷과 패션 1","titleVi":"Trang phục & Thời trang 1","category":"Đời sống & Con người",
		"words":[
			{"id":"u4_w1","korean":"곱슬머리","pos":"n","posName":"Danh từ","vietnamese":"Tóc xoăn","hanja":"","hint_words":"자연스럽다, 펴다, 파마","sample_sentence":"어릴 때는 심한 곱슬머리가 정말 큰 고민이었어요.","sample_translation":"Hồi nhỏ mái tóc xoăn tít là nỗi trăn trở rất lớn của tôi.","collocations":["천연 곱슬머리"]},
			{"id":"u4_w2","korean":"단발머리","pos":"n","posName":"Danh từ","vietnamese":"Tóc ngắn ngang vai (tóc bob)","hanja":"","hint_words":"자르다, 어울리다, 스타일","sample_sentence":"긴 머리를 자르고 상큼한 단발머리로 변신했어요.","sample_translation":"Tôi đã cắt mái tóc dài và biến hóa thành kiểu tóc ngắn tươi tắn.","collocations":["단발머리 소녀"]},
			{"id":"u4_w3","korean":"생머리","pos":"n","posName":"Danh từ","vietnamese":"Tóc thẳng tự nhiên","hanja":"","hint_words":"찰랑거리다, 길다, 좋아하다","sample_sentence":"찰랑거리는 긴 생머리는 많은 사람들의 로망이에요.","sample_translation":"Mái tóc thẳng dài bồng bềnh là niềm mơ ước của nhiều người.","collocations":["긴 생머리"]},
			{"id":"u4_w4","korean":"앞머리","pos":"n","posName":"Danh từ","vietnamese":"Tóc mái","hanja":"","hint_words":"자르다, 내리다, 올리다","sample_sentence":"앞머리를 내리니까 훨씬 더 어려 보여요.","sample_translation":"Hạ tóc mái xuống nhìn trẻ hơn hẳn đấy.","collocations":["앞머리를 자르다"]},
			{"id":"u4_w5","korean":"파마","pos":"n","posName":"Danh từ","vietnamese":"Uốn tóc, làm xoăn","hanja":"","hint_words":"하다, 미용실, 유행","sample_sentence":"기분 전환을 하려고 미용실에서 파마를 했어요.","sample_translation":"Để đổi gió tâm trạng tôi đã đi uốn tóc ở salon.","collocations":["파마머리","파마를 풀다"]},
			{"id":"u4_w6","korean":"눌러쓰다","pos":"v","posName":"Động từ","vietnamese":"Đội sụp xuống (mũ)","hanja":"","hint_words":"모자, 외출하다, 얼굴","sample_sentence":"민낯이라 모자를 푹 눌러쓰고 마트에 다녀왔어요.","sample_translation":"Vì để mặt mộc nên tôi đội sụp mũ xuống rồi đi siêu thị về.","collocations":["모자를 눌러쓰다"]},
			{"id":"u4_w7","korean":"다듬다","pos":"v","posName":"Động từ","vietnamese":"Tỉa, gọt, chỉnh sửa","hanja":"","hint_words":"머리, 눈썹, 재료","sample_sentence":"미용실에서 머리 끝부분만 살짝 다듬었어요.","sample_translation":"Ở tiệm làm tóc tôi chỉ tỉa nhẹ phần đuôi tóc một chút.","collocations":["머리를 다듬다","마음을 다듬다"]},
			{"id":"u4_w8","korean":"말리다","pos":"v","posName":"Động từ","vietnamese":"Làm khô, sấy khô","hanja":"","hint_words":"드라이기, 머리, 빨래","sample_sentence":"머리를 감은 후에는 드라이기로 잘 말려야 해요.","sample_translation":"Sau khi gội đầu thì phải sấy khô bằng máy sấy tóc.","collocations":["머리를 말리다","빨래를 말리다"]},
			{"id":"u4_w9","korean":"빗다","pos":"v","posName":"Động từ","vietnamese":"Chải (tóc)","hanja":"","hint_words":"머리, 빗, 단정하다","sample_sentence":"거울을 보며 엉킨 머리를 단정하게 빗었어요.","sample_translation":"Nhìn vào gương tôi chải lại mái tóc rối cho thật gọn gàng.","collocations":["머리를 빗다"]},
			{"id":"u4_w10","korean":"손질하다","pos":"v","posName":"Động từ","vietnamese":"Chăm sóc, tạo kiểu, chuẩn bị","hanja":"","hint_words":"머리, 옷, 생선","sample_sentence":"외출하기 전에 머리와 옷매무새를 손질했다.","sample_translation":"Trước khi ra ngoài tôi đã chỉnh trang lại đầu tóc và vạt áo.","collocations":["머리를 손질하다"]},
			{"id":"u4_w11","korean":"염색","pos":"n","posName":"Danh từ","vietnamese":"Nhuộm tóc, nhuộm màu","hanja":"染色","hint_words":"갈색, 하다, 약","sample_sentence":"봄을 맞아 머리를 밝은 갈색으로 염색했어요.","sample_translation":"Nhân dịp mùa xuân tôi đã nhuộm tóc sang màu nâu sáng.","collocations":["염색약","염색을 하다"]},
			{"id":"u4_w12","korean":"내복","pos":"n","posName":"Danh từ","vietnamese":"Áo ấm lót trong (đồ giữ nhiệt)","hanja":"內服","hint_words":"겨울, 입다, 따뜻하다","sample_sentence":"추운 겨울에는 내복을 입어야 감기에 안 걸려요.","sample_translation":"Vào mùa đông lạnh giá phải mặc áo giữ nhiệt mới không bị cảm cúm.","collocations":["내복을 입다"]}
		]
	},
	{
		"id":"unit_5","day":5,"titleKo":"옷과 패션 2","titleVi":"Trang phục & Thời trang 2","category":"Đời sống & Con người",
		"words":[
			{"id":"u5_w1","korean":"다리다","pos":"v","posName":"Động từ","vietnamese":"Là, ủi (quần áo)","hanja":"","hint_words":"다리미, 셔츠, 주름","sample_sentence":"구겨진 와이셔츠를 다리미로 반듯하게 다렸어요.","sample_translation":"Tôi đã là phẳng chiếc áo sơ mi nhăn nheo bằng bàn là.","collocations":["옷을 다리다","칼같이 다리다"]},
			{"id":"u5_w2","korean":"수선하다","pos":"v","posName":"Động từ","vietnamese":"Sửa chữa (quần áo, giày dép)","hanja":"修繕","hint_words":"바지, 기장, 세탁소","sample_sentence":"바지 길이가 너무 길어서 세탁소에 수선을 맡겼다.","sample_translation":"Ống quần dài quá nên tôi đã đem gửi tiệm giặt ủi sửa lại.","collocations":["옷을 수선하다"]},
			{"id":"u5_w3","korean":"찢어지다","pos":"v","posName":"Động từ","vietnamese":"Bị rách","hanja":"","hint_words":"옷, 걸리다, 바늘","sample_sentence":"못에 걸려 아끼던 코트가 찢어지고 말았어요.","sample_translation":"Mắc vào cây đinh khiến chiếc áo khoác yêu thích của tôi bị rách mất.","collocations":["바지가 찢어지다"]},
			{"id":"u5_w4","korean":"꾸미다","pos":"v","posName":"Động từ","vietnamese":"Trang hoàng, làm đẹp, trau chuốt","hanja":"","hint_words":"방, 외모, 예쁘다","sample_sentence":"파티에 가기 위해 예쁜 옷과 화장으로 멋지게 꾸몄어요.","sample_translation":"Để đi dự tiệc tôi đã xúng xính làm đẹp với trang phục và đồ trang điểm lộng lẫy.","collocations":["자신을 꾸미다","방을 꾸미다"]},
			{"id":"u5_w5","korean":"옷차림","pos":"n","posName":"Danh từ","vietnamese":"Cách ăn mặc, trang phục","hanja":"","hint_words":"단정하다, 신경 쓰다, 격식","sample_sentence":"격식 있는 자리에서는 옷차림에 각별히 신경 써야 한다.","sample_translation":"Ở những nơi trang trọng cần đặc biệt chú ý đến cách ăn mặc.","collocations":["단정한 옷차림"]},
			{"id":"u5_w6","korean":"눈에 띄다","pos":"v","posName":"Động từ","vietnamese":"Nổi bật, đập vào mắt","hanja":"","hint_words":"색상, 패션, 사람","sample_sentence":"그녀의 화려한 옷차림은 멀리서도 단연 눈에 띄었다.","sample_translation":"Trang phục rực rỡ của cô ấy nổi bật từ đằng xa.","collocations":["확 눈에 띄다"]},
			{"id":"u5_w7","korean":"독특하다","pos":"adj","posName":"Tính từ","vietnamese":"Độc đáo, đặc sắc","hanja":"獨特","hint_words":"디자인, 스타일, 개성","sample_sentence":"그 디자이너는 언제나 독특한 스타일의 옷을 선보인다.","sample_translation":"Nhà thiết kế đó luôn trình làng những bộ trang phục có phong cách độc đáo.","collocations":["독특한 매력","독특한 개성"]},
			{"id":"u5_w8","korean":"세련되다","pos":"adj","posName":"Tính từ","vietnamese":"Sành điệu, tinh tế, thanh lịch","hanja":"洗練","hint_words":"패션, 감각, 분위기","sample_sentence":"그녀는 항상 세련되고 감각적인 옷을 잘 골라 입어요.","sample_translation":"Cô ấy luôn chọn mặc những bộ quần áo rất sành điệu và tinh tế.","collocations":["세련된 디자인","세련된 매너"]},
			{"id":"u5_w9","korean":"우아하다","pos":"adj","posName":"Tính từ","vietnamese":"Tao nhã, quý phái","hanja":"優雅","hint_words":"드레스, 걸음걸이, 자태","sample_sentence":"드레스를 입은 신부의 모습이 참으로 우아했다.","sample_translation":"Hình ảnh cô dâu khoác lên mình chiếc váy cưới thật vô cùng quý phái.","collocations":["우아한 자태","우아한 분위기"]}
		]
	},
	{
		"id":"unit_6","day":6,"titleKo":"연애와 결혼 1","titleVi":"Hẹn hò & Kết hôn 1","category":"Đời sống & Gia đình",
		"words":[
			{"id":"u6_w1","korean":"연애","pos":"n","posName":"Danh từ","vietnamese":"Hẹn hò, yêu đương","hanja":"戀愛","hint_words":"하다, 시절, 경험","sample_sentence":"우리는 3년 동안 연애를 하고 올가을에 결혼하기로 했어요.","sample_translation":"Chúng tôi đã hẹn hò suốt 3 năm và quyết định kết hôn vào mùa thu này.","collocations":["연애결혼","연애편지"]},
			{"id":"u6_w2","korean":"소개팅","pos":"n","posName":"Danh từ","vietnamese":"Buổi xem mắt (hẹn hò qua giới thiệu)","hanja":"","hint_words":"나가다, 주선하다, 만나다","sample_sentence":"주말에 친구의 주선으로 소개팅을 나가기로 했다.","sample_translation":"Cuối tuần này tôi sẽ đi xem mắt qua sự sắp xếp của một người bạn.","collocations":["소개팅에 나가다"]},
			{"id":"u6_w3","korean":"짝사랑","pos":"n","posName":"Danh từ","vietnamese":"Tình yêu đơn phương","hanja":"","hint_words":"앓다, 가슴, 고백하다","sample_sentence":"학창 시절 선배를 남몰래 짝사랑했던 기억이 있어요.","sample_translation":"Tôi có kỷ niệm từng thầm yêu đơn phương một tiền bối thời đi học.","collocations":["짝사랑에 빠지다"]},
			{"id":"u6_w4","korean":"첫사랑","pos":"n","posName":"Danh từ","vietnamese":"Mối tình đầu","hanja":"","hint_words":"추억, 잊다, 순수하다","sample_sentence":"첫사랑은 누구에게나 아련하고 순수한 추억으로 남아요.","sample_translation":"Mối tình đầu luôn đọng lại trong mỗi người như một kỷ niệm trong trẻo và bồi hồi.","collocations":["첫사랑의 추억"]},
			{"id":"u6_w5","korean":"헤어지다","pos":"v","posName":"Động từ","vietnamese":"Chia tay","hanja":"","hint_words":"연인, 이별, 슬프다","sample_sentence":"서로 성격이 맞지 않아서 결국 헤어지기로 결정했다.","sample_translation":"Vì tính cách không hòa hợp nên cuối cùng họ đã quyết định chia tay.","collocations":["연인과 헤어지다"]},
			{"id":"u6_w6","korean":"한눈에 반하다","pos":"v","posName":"Động từ","vietnamese":"Yêu ngay từ cái nhìn đầu tiên","hanja":"","hint_words":"첫만남, 사랑, 설레다","sample_sentence":"도서관에서 그녀를 보자마자 한눈에 반해 버렸어요.","sample_translation":"Vừa nhìn thấy cô ấy ở thư viện là tôi đã trúng tiếng sét ái tình ngay.","collocations":["첫눈에 반하다"]},
			{"id":"u6_w7","korean":"사귀다","pos":"v","posName":"Động từ","vietnamese":"Hẹn hò, kết bạn","hanja":"","hint_words":"친구, 연인, 오래","sample_sentence":"두 사람은 대학교 동아리에서 만나 진지하게 사귀고 있어요.","sample_translation":"Hai người gặp nhau ở câu lạc bộ đại học và đang nghiêm túc hẹn hò.","collocations":["친구를 사귀다","깊이 사귀다"]},
			{"id":"u6_w8","korean":"약혼자","pos":"n","posName":"Danh từ","vietnamese":"Người đính hôn (hôn phu/hôn thê)","hanja":"約婚者","hint_words":"반지, 예식, 소개하다","sample_sentence":"그녀는 모임에서 자신의 약혼자를 친구들에게 소개했다.","sample_translation":"Cô ấy đã giới thiệu vị hôn phu của mình với các bạn trong buổi gặp mặt.","collocations":["약혼반지","약혼식"]}
		]
	},
	{
		"id":"unit_7","day":7,"titleKo":"연애와 결혼 2","titleVi":"Hẹn hò & Kết hôn 2","category":"Đời sống & Gia đình",
		"words":[
			{"id":"u7_w1","korean":"결혼식","pos":"n","posName":"Danh từ","vietnamese":"Lễ cưới, đám cưới","hanja":"結婚式","hint_words":"올리다, 참석하다, 축하하다","sample_sentence":"지난 주말에 절친한 친구의 결혼식에 다녀왔어요.","sample_translation":"Cuối tuần trước tôi đã đến dự đám cưới của người bạn thân thiết.","collocations":["결혼식을 올리다"]},
			{"id":"u7_w2","korean":"청첩장","pos":"n","posName":"Danh từ","vietnamese":"Thiệp cưới","hanja":"請牒狀","hint_words":"돌리다, 보내다, 받다","sample_sentence":"결혼을 앞두고 지인들에게 청첩장을 전달했어요.","sample_translation":"Trước thềm đám cưới tôi đã gửi thiệp mời đến bạn bè người quen.","collocations":["청첩장을 돌리다"]},
			{"id":"u7_w3","korean":"신랑","pos":"n","posName":"Danh từ","vietnamese":"Chú rể","hanja":"新郞","hint_words":"신부, 멋지다, 입장하다","sample_sentence":"턱시도를 입은 신랑이 늠름하게 예식장에 입장했다.","sample_translation":"Chú rể diện tuxedo hiên ngang bước vào lễ đường đám cưới.","collocations":["신랑 신부"]},
			{"id":"u7_w4","korean":"신부","pos":"n","posName":"Danh từ","vietnamese":"Cô dâu","hanja":"新婦","hint_words":"웨딩드레스, 아름답다, 부케","sample_sentence":"새하얀 웨딩드레스를 입은 신부의 모습이 눈부시게 아름다웠다.","sample_translation":"Hình ảnh cô dâu khoác lên chiếc váy cưới trắng muốt đẹp rạng rỡ.","collocations":["신부 대기실"]},
			{"id":"u7_w5","korean":"신혼여행","pos":"n","posName":"Danh từ","vietnamese":"Tuần trăng mật","hanja":"新婚旅行","hint_words":"떠나다, 하와이, 즐기다","sample_sentence":"결혼식을 무사히 마치고 하와이로 신혼여행을 떠났어요.","sample_translation":"Sau khi đám cưới diễn ra suôn sẻ họ đã bay đi Hawaii hưởng tuần trăng mật.","collocations":["신혼여행지"]},
			{"id":"u7_w6","korean":"축의금","pos":"n","posName":"Danh từ","vietnamese":"Tiền mừng cưới","hanja":"祝儀金","hint_words":"봉투, 내다, 전하다","sample_sentence":"예식장 입구에서 축의금 봉투를 전달하고 식장에 들어갔다.","sample_translation":"Ở cửa sảnh cưới tôi đã trao phong bì tiền mừng rồi mới bước vào hội trường.","collocations":["축의금을 내다"]},
			{"id":"u7_w7","korean":"주례","pos":"n","posName":"Danh từ","vietnamese":"Chủ hôn (người chủ trì lễ cưới)","hanja":"主禮","hint_words":"선생님, 말씀, 부탁하다","sample_sentence":"은사님께 주례를 부탁드려 뜻깊은 결혼식을 치렀다.","sample_translation":"Nhờ thầy giáo làm chủ hôn nên buổi lễ thành hôn càng thêm ý nghĩa.","collocations":["주례사","주례를 서다"]}
		]
	},
	{
		"id":"unit_8","day":8,"titleKo":"감정 1","titleVi":"Cảm xúc 1","category":"Cảm xúc & Tâm lý",
		"words":[
			{"id":"u8_w1","korean":"불안하다","pos":"adj","posName":"Tính từ","vietnamese":"Bất an, lo lắng","hanja":"不安","hint_words":"시험, 초조하다, 마음","sample_sentence":"결과 발표를 앞두고 가슴이 답답하고 불안해요.","sample_translation":"Trước khi kết quả được công bố lòng tôi cảm thấy bồn chồn và bất an.","collocations":["불안한 마음","불안에 떨다"]},
			{"id":"u8_w2","korean":"뿌듯하다","pos":"adj","posName":"Tính từ","vietnamese":"Hãnh diện, tự hào, viên mãn","hanja":"","hint_words":"보람, 완성하다, 성취감","sample_sentence":"어려운 프로젝트를 스스로 끝마치니 마음이 매우 뿌듯해요.","sample_translation":"Tự mình hoàn thành dự án khó nhằn khiến lòng tôi vô cùng hãnh diện.","collocations":["뿌듯한 성취감"]},
			{"id":"u8_w3","korean":"서운하다","pos":"adj","posName":"Tính từ","vietnamese":"Hụt hẫng, chạnh lòng, buồn bã","hanja":"","hint_words":"친구, 이별, 섭섭하다","sample_sentence":"친한 친구가 말도 없이 이사를 가서 너무 서운했다.","sample_translation":"Người bạn thân chuyển nhà mà chẳng nói một lời làm tôi rất chạnh lòng.","collocations":["서운한 마음"]},
			{"id":"u8_w4","korean":"섭섭하다","pos":"adj","posName":"Tính từ","vietnamese":"Nuối tiếc, buồn tủi, thất vọng","hanja":"","hint_words":"떠나다, 인사, 아쉽다","sample_sentence":"오랫동안 함께 일한 동료가 퇴사해서 무척 섭섭해요.","sample_translation":"Người đồng nghiệp làm việc cùng bấy lâu nay nghỉ việc làm tôi rất nuối tiếc.","collocations":["섭섭하게 생각하다"]},
			{"id":"u8_w5","korean":"억울하다","pos":"adj","posName":"Tính từ","vietnamese":"Oan ức, ức nghẹn","hanja":"","hint_words":"누명, 눈물, 진실","sample_sentence":"하지도 않은 일로 오해를 받아 너무 억울해서 눈물이 났다.","sample_translation":"Bị hiểu lầm về việc mình không làm khiến tôi vô cùng oan ức đến phát khóc.","collocations":["억울한 누명","억울함을 풀다"]},
			{"id":"u8_w6","korean":"홀가분하다","pos":"adj","posName":"Tính từ","vietnamese":"Nhẹ nhõm, thanh thản","hanja":"","hint_words":"시험, 끝나다, 마음","sample_sentence":"길었던 수능 시험이 드디어 끝나서 마음이 홀가분해요.","sample_translation":"Kỳ thi đại học dài dằng dặc cuối cùng cũng xong khiến lòng nhẹ nhõm hẳn.","collocations":["홀가분한 기분"]}
		]
	},
	{
		"id":"unit_9","day":9,"titleKo":"감정 2","titleVi":"Cảm xúc 2","category":"Cảm xúc & Tâm lý",
		"words":[
			{"id":"u9_w1","korean":"긴장되다","pos":"v","posName":"Động từ","vietnamese":"Căng thẳng, hồi hộp","hanja":"緊張","hint_words":"면접, 무대, 손에 땀","sample_sentence":"면접관 앞에 서니 너무 긴장되어 목소리가 떨렸다.","sample_translation":"Đứng trước người phỏng vấn tôi căng thẳng đến mức run cả giọng.","collocations":["긴장감이 돌다"]},
			{"id":"u9_w2","korean":"당황하다","pos":"v","posName":"Động từ","vietnamese":"Bối rối, lúng túng, hoang mang","hanja":"唐慌","hint_words":"갑자기, 질문, 실수","sample_sentence":"예상치 못한 날카로운 질문을 받아서 몹시 당황했다.","sample_translation":"Nhận phải câu hỏi hóc búa bất ngờ khiến tôi vô cùng bối rối.","collocations":["당황한 기색"]},
			{"id":"u9_w3","korean":"설레다","pos":"v","posName":"Động từ","vietnamese":"Xốn xang, hồi hộp rạo rực","hanja":"","hint_words":"여행, 가슴, 첫 데이트","sample_sentence":"내일 첫 해외여행을 떠날 생각에 가슴이 콩닥콩닥 설렌다.","sample_translation":"Nghĩ đến chuyến du lịch nước ngoài ngày mai lòng tôi xốn xang rạo rực.","collocations":["가슴이 설레다"]},
			{"id":"u9_w4","korean":"실망하다","pos":"v","posName":"Động từ","vietnamese":"Thất vọng","hanja":"失望","hint_words":"기대, 결과, 사람","sample_sentence":"노력한 만큼 결과가 좋지 않아서 크게 실망했어요.","sample_translation":"Kết quả không tương xứng với công sức bỏ ra làm tôi rất thất vọng.","collocations":["실망을 안겨주다"]},
			{"id":"u9_w5","korean":"허탈하다","pos":"adj","posName":"Tính từ","vietnamese":"Hụt hẫng, bàng hoàng rã rời","hanja":"虛脫","hint_words":"노력, 실패, 한숨","sample_sentence":"수개월 동안 공들인 탑이 무너지자 허탈한 심정뿐이었다.","sample_translation":"Công sức nhiều tháng trời đổ sông đổ bể làm lòng tôi bàng hoàng hụt hẫng.","collocations":["허탈한 웃음"]}
		]
	},
	{
		"id":"unit_10","day":10,"titleKo":"날씨와 계절 1","titleVi":"Thời tiết & Các mùa 1","category":"Tự nhiên & Đời sống",
		"words":[
			{"id":"u10_w1","korean":"기온","pos":"n","posName":"Danh từ","vietnamese":"Nhiệt độ không khí","hanja":"氣溫","hint_words":"떨어지다, 올라가다, 영하","sample_sentence":"내일부터 기온이 영하로 떨어져 매서운 한파가 찾아옵니다.","sample_translation":"Từ ngày mai nhiệt độ sẽ giảm xuống dưới 0 độ mang theo đợt rét buốt.","collocations":["평균 기온","기온 변화"]},
			{"id":"u10_w2","korean":"일교차","pos":"n","posName":"Danh từ","vietnamese":"Biên độ nhiệt trong ngày","hanja":"日較差","hint_words":"환절기, 크다, 감기","sample_sentence":"환절기에는 낮과 밤의 일교차가 크니 겉옷을 챙기세요.","sample_translation":"Giao mùa biên độ nhiệt ngày và đêm rất lớn nên hãy nhớ mang theo áo khoác.","collocations":["일교차가 크다"]},
			{"id":"u10_w3","korean":"장마철","pos":"n","posName":"Danh từ","vietnamese":"Mùa mưa dầm","hanja":"","hint_words":"우산, 비, 습하다","sample_sentence":"장마철에는 습도가 높고 비가 계속 내려 빨래가 잘 안 말라요.","sample_translation":"Mùa mưa dầm độ ẩm cao mưa triền miên làm quần áo rất khó khô.","collocations":["장마철 대비"]},
			{"id":"u10_w4","korean":"폭설","pos":"n","posName":"Danh từ","vietnamese":"Bão tuyết, tuyết rơi dữ dội","hanja":"暴雪","hint_words":"내리다, 교통마비, 쌓이다","sample_sentence":"밤새 내린 폭설로 인해 도로 교통이 마비되었다.","sample_translation":"Trận bão tuyết rơi suốt đêm đã làm tê liệt giao thông đường bộ.","collocations":["폭설주의보"]},
			{"id":"u10_w5","korean":"화창하다","pos":"adj","posName":"Tính từ","vietnamese":"Nắng đẹp, chan hòa, ấm áp","hanja":"","hint_words":"하늘, 봄날, 소풍","sample_sentence":"날씨가 너무 화창해서 가족들과 공원으로 나들이를 갔다.","sample_translation":"Thời tiết nắng đẹp rạng rỡ nên tôi đã cùng gia đình đi dã ngoại ở công viên.","collocations":["화창한 봄날"]}
		]
	}
]
print(f"Loaded {len(data)} basic units")
with open('scratch/seed_units.json', 'w', encoding='utf-8') as f:
	json.dump(data, f, ensure_ascii=False, indent=2)
