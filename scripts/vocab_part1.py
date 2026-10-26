import json,sys,os
sys.stdout.reconfigure(encoding='utf-8')
units_raw=[
	(1,"가족","Gia đình","Đời sống & Gia đình",[
		("며느리","n","Danh từ","Con dâu","","셋째, 결혼하다, 맞다","셋째 며느리는 마음씨가 착하고 예뻐요.","Cô con dâu thứ ba rất hiền lành và xinh xắn.",["사랑받는 며느리","며느리를 맞다"]),
		("새어머니","n","Danh từ","Mẹ kế","","모시다, 부르다, 다정하다","처음에는 새어머니를 어머니라고 부르기 어려웠어요.","Ban đầu việc gọi mẹ kế là mẹ rất khó khăn.",["새어머니를 모시다"]),
		("손자","n","Danh từ","Cháu trai","孫子","막내, 방학, 놀러 오다","방학이 되어서 막내 손자가 우리 집에 놀러 왔어요.","Đến kỳ nghỉ hè cháu trai út đã sang nhà chúng tôi chơi.",["귀여운 손자","손자를 보다"]),
		("시부모님","n","Danh từ","Bố mẹ chồng","","모시다, 살다, 공경하다","시부모님을 정성껏 모시고 사는 것은 보람있어요.","Chăm sóc và phụng dưỡng bố mẹ chồng là điều rất ý nghĩa.",["시부모님을 모시다"]),
		("자녀","n","Danh từ","Con cái","子女","교육, 기르다, 낳다","부모는 자녀의 교육에 관심이 매우 많아요.","Cha mẹ rất quan tâm đến việc giáo dục con cái.",["자녀를 기르다","자녀 교육"]),
		("현모양처","n","Danh từ","Người vợ hiền mẹ đảm","賢妻良母","되다, 꿈, 가정","그녀의 어릴 적 꿈은 현모양처가 되는 것이었다.","Ước mơ thuở nhỏ của cô ấy là trở thành người vợ hiền mẹ đảm.",["현모양처의 길"]),
		("효녀","n","Danh từ","Người con gái hiếu thảo","孝女","부모님, 효도하다, 소문나다","그녀는 부모님을 극진히 모시는 효녀로 유명해요.","Cô ấy nổi tiếng là một người con gái hiếu thảo chăm sóc bố mẹ chu đáo.",["소문난 효녀"]),
		("막내","n","Danh từ","Con út","","태어나다, 사랑, 귀엽다","우리 집 막내는 가족들의 사랑을 독차지해요.","Em út nhà tôi độc chiếm trọn tình yêu của cả gia đình.",["막내딸","막내아들"]),
		("맏딸","n","Danh từ","Con gái cả (trưởng nữ)","長女","책임감, 결혼식, 듬직하다","우리 집 맏딸은 책임감이 아주 강해요.","Con gái cả nhà tôi có tinh thần trách nhiệm rất cao.",["맏딸 역할"]),
		("쌍둥이","n","Danh từ","Sinh đôi","","닮다, 태어나다, 얼굴","그 쌍둥이 형제는 얼굴과 성격이 완전히 달라요.","Hai anh em sinh đôi đó khuôn mặt và tính cách hoàn toàn khác nhau.",["일란성 쌍둥이","이란성 쌍둥이"]),
		("외동딸","n","Danh từ","Con gái một","","자라다, 혼자, 귀엽다","외동딸로 자라서 가끔 형제가 있었으면 좋겠어요.","Lớn lên là con gái một nên thỉnh thoảng tôi ước có anh chị em.",["하나뿐인 외동딸"]),
		("자매","n","Danh từ","Chị em gái","姉妹","사이좋다, 옷, 공유하다","두 자매는 항상 사이좋게 지내요.","Hai chị em gái luôn luôn hòa thuận với nhau.",["자매결연","사이좋은 자매"]),
		("가정","n","Danh từ","Gia đình (mái ấm)","家庭","행복하다, 꾸리다, 이루다","따뜻하고 화목한 가정을 이루는 것이 제 소원이에요.","Xây dựng một mái ấm gia đình ấm áp và hòa thuận là ước nguyện của tôi.",["화목한 가정","가정을 꾸리다"]),
		("식구","n","Danh từ","Thành viên gia đình","食口","많다, 저녁, 모이다","우리 집은 식구가 많아서 매일 떠들썩해요.","Nhà tôi đông người nên mỗi ngày đều rất rôm rả náo nhiệt.",["대가족 식구","한 식구"]),
		("집안","n","Danh từ","Gia phong, gia đình","","어른, 분위기, 행사","집안 어른들께서 모두 건강하셔서 다행이에요.","Thật may mắn vì các bậc trưởng bối trong dòng họ đều khỏe mạnh.",["집안 분위기","집안 어른"])
	]),
	(2,"외모와 성격 1","Ngoại hình & Tính cách 1","Đời sống & Con người",[
		("외모","n","Danh từ","Ngoại hình","外貌","단정하다, 중요하다, 가꾸다","사람을 만날 때는 첫인상과 단정한 외모가 중요해요.","Khi gặp gỡ mọi người, ấn tượng đầu tiên và ngoại hình chỉn chu rất quan trọng.",["외모 지상주의","외모를 가꾸다"]),
		("긍정적","adj","Tính từ","Tích cực","肯定的","생각하다, 마인드, 태도","어려운 상황에서도 긍정적으로 생각하려고 노력해요.","Dù trong hoàn cảnh khó khăn tôi vẫn nỗ lực suy nghĩ tích cực.",["긍정적인 사고","긍정적인 영향"]),
		("꼼꼼하다","adj","Tính từ","Tỉ mỉ, cẩn thận","","일처리, 확인하다, 성격","그는 서류를 꼼꼼하게 검토하는 성격이에요.","Anh ấy có tính cách kiểm tra tài liệu rất cẩn thận, tỉ mỉ.",["꼼꼼한 성격","꼼꼼히 살피다"]),
		("너그럽다","adj","Tính từ","Khoan dung, rộng lượng","","마음, 용서하다, 태도","선생님께서는 학생들의 실수를 너그럽게 감싸 주셨다.","Thầy giáo đã rộng lượng bao dung cho lỗi lầm của các học sinh.",["너그러운 마음","너그럽게 대하다"]),
		("느긋하다","adj","Tính từ","Ung dung, thong thả","","마음, 기다리다, 성격","시간 여유가 있으니 느긋하게 차를 마셔요.","Vì còn nhiều thời gian nên hãy ung dung thưởng trà nhé.",["느긋한 마음","느긋하게 쉬다"]),
		("다정하다","adj","Tính từ","Ấm áp, tình cảm","多情","말투, 목소리, 태도","그는 언제나 다정한 목소리로 이야기해요.","Anh ấy lúc nào cũng trò chuyện bằng giọng nói rất tình cảm.",["다정한 눈빛","다정다감하다"]),
		("명랑하다","adj","Tính từ","Vui vẻ, tươi sáng","明朗","웃음, 성격, 분위기","그녀는 항상 명랑한 성격으로 주변을 밝혀 줍니다.","Cô ấy luôn làm sáng bừng bầu không khí xung quanh với tính cách vui tươi.",["명랑한 웃음소리","명랑 쾌활하다"]),
		("활발하다","adj","Tính từ","Hoạt bát, năng động","活發","활동, 성격, 교류","아이들은 밖에서 활발하게 뛰어놀고 있어요.","Lũ trẻ đang vui vẻ chạy nhảy hoạt bát ngoài trời.",["활발한 활동","활발한 성격"]),
		("부정적","adj","Tính từ","Tiêu cực","否定的","시각, 생각, 영향","매사를 부정적으로 보면 발전하기 힘들어요.","Nếu nhìn nhận mọi việc một cách tiêu cực thì rất khó tiến bộ.",["부정적인 생각","부정적 평가"]),
		("게으르다","adj","Tính từ","Lười biếng","","주말, 늦잠, 고치다","주말이라고 너무 게으르게 뒹굴기만 하면 안 돼요.","Không nên vì là cuối tuần mà cứ lười biếng nằm lăn qua lăn lại mãi.",["게으름을 피우다","게으른 사람"]),
		("고집","n","Danh từ","Tính cố chấp, bướng bỉnh","固執","세다, 피우다, 부리다","자기 고집만 부리지 말고 남의 말도 들어 보세요.","Đừng chỉ khăng khăng bướng bỉnh theo ý mình mà hãy lắng nghe người khác.",["고집이 세다","고집을 부리다"]),
		("까다롭다","adj","Tính từ","Khó tính, cầu kỳ","","입맛, 성격, 조건","그 손님은 입맛이 까다로워서 음식을 고르기 힘들어요.","Vị khách đó khẩu vị rất khó tính nên chọn món ăn khá khó.",["까다로운 조건","입맛이 까다롭다"]),
		("욕심","n","Danh từ","Lòng tham, ham muốn","慾心","부리다, 많다, 버리다","너무 많은 욕심을 부리면 결국 손해를 봐요.","Nếu tham lam quá độ thì cuối cùng sẽ chịu thiệt thòi.",["욕심을 부리다","욕심이 많다"]),
		("이기적","adj","Tính từ","Ích kỷ","利己的","행동, 성격, 태도","남을 배려하지 않는 이기적인 행동은 피해야 해요.","Cần tránh những hành vi ích kỷ không biết quan tâm đến người khác.",["이기적인 태도","이기주의"])
	]),
	(3,"외모와 성격 2","Ngoại hình & Tính cách 2","Đời sống & Con người",[
		("개성","n","Danh từ","Cá tính","個性","넘치다, 살리다, 패션","자신만의 개성을 살려 옷을 입는 것이 멋져요.","Mặc quần áo làm nổi bật cá tính riêng của bản thân thật là ngầu.",["개성이 강하다","개성을 살리다"]),
		("매력","n","Danh từ","Sức hút, sự quyến rũ","魅力","넘치다, 끌리다, 사람","그녀의 밝은 미소는 사람을 끄는 매력이 있어요.","Nụ cười rạng rỡ của cô ấy có sức hút lôi cuốn mọi người.",["매력적인 사람","매력에 빠지다"]),
		("인상","n","Danh từ","Ấn tượng","印象","좋다, 첫인상, 남기다","첫인상이 좋으면 대화가 한결 수월해집니다.","Nếu ấn tượng đầu tiên tốt thì cuộc trò chuyện sẽ dễ dàng hơn nhiều.",["첫인상","인상이 좋다"]),
		("단정하다","adj","Tính từ","Chỉn chu, gọn gàng","端正","옷차림, 머리, 모습","면접을 볼 때는 단정한 복장이 필수적이에요.","Khi đi phỏng vấn thì trang phục chỉn chu là điều thiết yếu.",["단정한 복장","단정하게 빗다"]),
		("날씬하다","adj","Tính từ","Thon thả, mảnh mai","","몸매, 유지하다, 다이어트","꾸준한 운동 덕분에 날씬한 몸매를 유지하고 있어요.","Nhờ tập thể dục đều đặn mà tôi duy trì được vóc dáng thon thả.",["날씬한 몸매","날씬해 보이다"]),
		("뚱뚱하다","adj","Tính từ","Béo, mập mạp","","체격, 살찌다, 건강","예전에는 뚱뚱했지만 운동으로 건강해졌어요.","Trước đây tôi béo mập nhưng nhờ thể thao đã khỏe mạnh hơn.",["뚱뚱한 체격"]),
		("깔끔하다","adj","Tính từ","Gọn gàng, ngăn nắp, sạch sẽ","","정리, 방, 성격","방을 깔끔하게 정리하니 기분이 상쾌해졌어요.","Dọn dẹp phòng ngăn nắp sạch sẽ khiến tâm trạng trở nên sảng khoái.",["깔끔한 성격","깔끔하게 치우다"]),
		("생김새","n","Danh từ","Nét mặt, tướng mạo","","닮다, 독특하다, 모습","형제지만 두 사람의 생김새는 사뭇 달라요.","Tuy là anh em nhưng diện mạo của hai người lại hoàn toàn khác nhau.",["독특한 생김새"]),
		("여드름","n","Danh từ","Mụn trứng cá","","나다, 짜다, 피부","사춘기가 되면서 얼굴에 여드름이 나기 시작했다.","Khi bước vào tuổi dậy thì mụn bắt đầu mọc trên mặt.",["여드름이 나다","여드름을 짜다"]),
		("네모나다","adj","Tính từ","Vuông vức, hình vuông","","얼굴, 상자, 안경","네모난 안경이 그의 지적인 이미지와 잘 어울려요.","Chiếc kính vuông rất hợp với hình tượng trí thức của anh ấy.",["네모난 얼굴","네모난 모양"]),
		("미인","n","Danh từ","Người đẹp, mỹ nhân","美人","대회, 소문나다, 예쁘다","그녀는 동네에서 소문난 미인이에요.","Cô ấy là một người đẹp nổi tiếng khắp khu phố.",["세계 미인 대회","절세미인"]),
		("잘나다","adj","Tính từ","Giỏi giang, tài giỏi, sáng sủa","","체하다, 사람, 잘생기다","혼자만 잘난 체하지 말고 협력할 줄 알아야 해요.","Đừng chỉ biết ra vẻ tài giỏi một mình mà phải biết hợp tác.",["잘난 척하다","잘난 사람"]),
		("미소","n","Danh từ","Nụ cười mỉm","微笑","짓다, 밝다, 띠다","따뜻한 미소로 손님들을 맞이하는 것이 중요해요.","Việc đón tiếp khách với một nụ cười ấm áp là rất quan trọng.",["미소를 짓다","밝은 미소"]),
		("표정","n","Danh từ","Biểu cảm khuôn mặt","表情","밝다, 굳다, 짓다","좋은 소식을 듣고 그의 얼굴 표정이 밝아졌어요.","Nghe được tin vui, nét mặt của anh ấy bừng sáng lên.",["밝은 표정","어두운 표정"])
	]),
	(4,"옷과 패션 1","Trang phục & Thời trang 1","Đời sống & Con người",[
		("곱슬머리","n","Danh từ","Tóc xoăn","","자연스럽다, 펴다, 파마","어릴 때는 심한 곱슬머리가 정말 큰 고민이었어요.","Hồi nhỏ mái tóc xoăn tít là nỗi trăn trở rất lớn của tôi.",["천연 곱슬머리"]),
		("단발머리","n","Danh từ","Tóc ngắn ngang vai (tóc bob)","","자르다, 어울리다, 스타일","긴 머리를 자르고 상큼한 단발머리로 변신했어요.","Tôi đã cắt mái tóc dài và biến hóa thành kiểu tóc ngắn tươi tắn.",["단발머리 소녀"]),
		("생머리","n","Danh từ","Tóc thẳng tự nhiên","","찰랑거리다, 길다, 좋아하다","찰랑거리는 긴 생머리는 많은 사람들의 로망이에요.","Mái tóc thẳng dài bồng bềnh là niềm mơ ước của nhiều người.",["긴 생머리"]),
		("앞머리","n","Danh từ","Tóc mái","","자르다, 내리다, 올리다","앞머리를 내리니까 훨씬 더 어려 보여요.","Hạ tóc mái xuống nhìn trẻ hơn hẳn đấy.",["앞머리를 자르다"]),
		("파마","n","Danh từ","Uốn tóc, làm xoăn","","하다, 미용실, 유행","기분 전환을 하려고 미용실에서 파마를 했어요.","Để đổi gió tâm trạng tôi đã đi uốn tóc ở salon.",["파마머리","파마를 풀다"]),
		("눌러쓰다","v","Động từ","Đội sụp xuống (mũ)","","모자, 외출하다, 얼굴","민낯이라 모자를 푹 눌러쓰고 마트에 다녀왔어요.","Vì để mặt mộc nên tôi đội sụp mũ xuống rồi đi siêu thị về.",["모자를 눌러쓰다"]),
		("다듬다","v","Động từ","Tỉa, gọt, chỉnh sửa","","머리, 눈썹, 재료","미용실에서 머리 끝부분만 살짝 다듬었어요.","Ở tiệm làm tóc tôi chỉ tỉa nhẹ phần đuôi tóc một chút.",["머리를 다듬다","마음을 다듬다"]),
		("말리다","v","Động từ","Làm khô, sấy khô","","드라이기, 머리, 빨래","머리를 감은 후에는 드라이기로 잘 말려야 해요.","Sau khi gội đầu thì phải sấy khô bằng máy sấy tóc.",["머리를 말리다","빨래를 말리다"]),
		("빗다","v","Động từ","Chải (tóc)","","머리, 빗, 단정하다","거울을 보며 엉킨 머리를 단정하게 빗었어요.","Nhìn vào gương tôi chải lại mái tóc rối cho thật gọn gàng.",["머리를 빗다"]),
		("손질하다","v","Động từ","Chăm sóc, tạo kiểu, chuẩn bị","","머리, 옷, 생선","외출하기 전에 머리와 옷매무새를 손질했다.","Trước khi ra ngoài tôi đã chỉnh trang lại đầu tóc và vạt áo.",["머리를 손질하다"]),
		("염색","n","Danh từ","Nhuộm tóc, nhuộm màu","染色","갈색, 하다, 약","봄을 맞아 머리를 밝은 갈색으로 염색했어요.","Nhân dịp mùa xuân tôi đã nhuộm tóc sang màu nâu sáng.",["염색약","염색을 하다"]),
		("내복","n","Danh từ","Áo ấm lót trong (đồ giữ nhiệt)","內服","겨울, 입다, 따뜻하다","추운 겨울에는 내복을 입어야 감기에 안 걸려요.","Vào mùa đông lạnh giá phải mặc áo giữ nhiệt mới không bị cảm cúm.",["내복을 입다"])
	]),
	(5,"옷과 패션 2","Trang phục & Thời trang 2","Đời sống & Con người",[
		("다리다","v","Động từ","Là, ủi (quần áo)","","다리미, 셔츠, 주름","구겨진 와이셔츠를 다리미로 반듯하게 다렸어요.","Tôi đã là phẳng chiếc áo sơ mi nhăn nheo bằng bàn là.",["옷을 다리다","칼같이 다리다"]),
		("수선하다","v","Động từ","Sửa chữa (quần áo, giày dép)","修繕","바지, 기장, 세탁소","바지 길이가 너무 길어서 세탁소에 수선을 맡겼다.","Ống quần dài quá nên tôi đã đem gửi tiệm giặt ủi sửa lại.",["옷을 수선하다"]),
		("찢어지다","v","Động từ","Bị rách","","옷, 걸리다, 바늘","못에 걸려 아끼던 코트가 찢어지고 말았어요.","Mắc vào cây đinh khiến chiếc áo khoác yêu thích của tôi bị rách mất.",["바지가 찢어지다"]),
		("꾸미다","v","Động từ","Trang hoàng, làm đẹp, trau chuốt","","방, 외모, 예쁘다","파티에 가기 위해 예쁜 옷과 화장으로 멋지게 꾸몄어요.","Để đi dự tiệc tôi đã xúng xính làm đẹp với trang phục và đồ trang điểm lộng lẫy.",["자신을 꾸미다","방을 꾸미다"]),
		("옷차림","n","Danh từ","Cách ăn mặc, trang phục","","단정하다, 신경 쓰다, 격식","격식 있는 자리에서는 옷차림에 각별히 신경 써야 한다.","Ở những nơi trang trọng cần đặc biệt chú ý đến cách ăn mặc.",["단정한 옷차림"]),
		("눈에 띄다","v","Động từ","Nổi bật, đập vào mắt","","색상, 패션, 사람","그녀의 화려한 옷차림은 멀리서도 단연 눈에 띄었다.","Trang phục rực rỡ của cô ấy nổi bật từ đằng xa.",["확 눈에 띄다"]),
		("독특하다","adj","Tính từ","Độc đáo, đặc sắc","獨特","디자인, 스타일, 개성","그 디자이너는 언제나 독특한 스타일의 옷을 선보인다.","Nhà thiết kế đó luôn trình làng những bộ trang phục có phong cách độc đáo.",["독특한 매력","독특한 개성"]),
		("세련되다","adj","Tính từ","Sành điệu, tinh tế, thanh lịch","洗練","패션, 감각, 분위기","그녀는 항상 세련되고 감각적인 옷을 잘 골라 입어요.","Cô ấy luôn chọn mặc những bộ quần áo rất sành điệu và tinh tế.",["세련된 디자인","세련된 매너"]),
		("우아하다","adj","Tính từ","Tao nhã, quý phái","優雅","드레스, 걸음걸이, 자태","드레스를 입은 신부의 모습이 참으로 우아했다.","Hình ảnh cô dâu khoác lên mình chiếc váy cưới thật vô cùng quý phái.",["우아한 자태","우아한 분위기"])
	]),
	(6,"연애와 결혼 1","Hẹn hò & Kết hôn 1","Đời sống & Gia đình",[
		("연애","n","Danh từ","Hẹn hò, yêu đương","戀愛","하다, 시절, 경험","우리는 3년 동안 연애를 하고 올가을에 결혼하기로 했어요.","Chúng tôi đã hẹn hò suốt 3 năm và quyết định kết hôn vào mùa thu này.",["연애결혼","연애편지"]),
		("소개팅","n","Danh từ","Buổi xem mắt (hẹn hò qua giới thiệu)","","나가다, 주선하다, 만나다","주말에 친구의 주선으로 소개팅을 나가기로 했다.","Cuối tuần này tôi sẽ đi xem mắt qua sự sắp xếp của một người bạn.",["소개팅에 나가다"]),
		("짝사랑","n","Danh từ","Tình yêu đơn phương","","앓다, 가슴, 고백하다","학창 시절 선배를 남몰래 짝사랑했던 기억이 있어요.","Tôi có kỷ niệm từng thầm yêu đơn phương một tiền bối thời đi học.",["짝사랑에 빠지다"]),
		("첫사랑","n","Danh từ","Mối tình đầu","","추억, 잊다, 순수하다","첫사랑은 누구에게나 아련하고 순수한 추억으로 남아요.","Mối tình đầu luôn đọng lại trong mỗi người như một kỷ niệm trong trẻo và bồi hồi.",["첫사랑의 추억"]),
		("헤어지다","v","Động từ","Chia tay","","연인, 이별, 슬프다","서로 성격이 맞지 않아서 결국 헤어지기로 결정했다.","Vì tính cách không hòa hợp nên cuối cùng họ đã quyết định chia tay.",["연인과 헤어지다"]),
		("한눈에 반하다","v","Động từ","Yêu ngay từ cái nhìn đầu tiên","","첫만남, 사랑, 설레다","도서관에서 그녀를 보자마자 한눈에 반해 버렸어요.","Vừa nhìn thấy cô ấy ở thư viện là tôi đã trúng tiếng sét ái tình ngay.",["첫눈에 반하다"]),
		("사귀다","v","Động từ","Hẹn hò, kết bạn","","친구, 연인, 오래","두 사람은 대학교 동아리에서 만나 진지하게 사귀고 있어요.","Hai người gặp nhau ở câu lạc bộ đại học và đang nghiêm túc hẹn hò.",["친구를 사귀다","깊이 사귀다"]),
		("약혼자","n","Danh từ","Người đính hôn (hôn phu/hôn thê)","約婚者","반지, 예식, 소개하다","그녀는 모임에서 자신의 약혼자를 친구들에게 소개했다.","Cô ấy đã giới thiệu vị hôn phu của mình với các bạn trong buổi gặp mặt.",["약혼반지","약혼식"])
	]),
	(7,"연애와 결혼 2","Hẹn hò & Kết hôn 2","Đời sống & Gia đình",[
		("결혼식","n","Danh từ","Lễ cưới, đám cưới","結婚式","올리다, 참석하다, 축하하다","지난 주말에 절친한 친구의 결혼식에 다녀왔어요.","Cuối tuần trước tôi đã đến dự đám cưới của người bạn thân thiết.",["결혼식을 올리다"]),
		("청첩장","n","Danh từ","Thiệp cưới","請牒狀","돌리다, 보내다, 받다","결혼을 앞두고 지인들에게 청첩장을 전달했어요.","Trước thềm đám cưới tôi đã gửi thiệp mời đến bạn bè người quen.",["청첩장을 돌리다"]),
		("신랑","n","Danh từ","Chú rể","新郞","신부, 멋지다, 입장하다","턱시도를 입은 신랑이 늠름하게 예식장에 입장했다.","Chú rể diện tuxedo hiên ngang bước vào lễ đường đám cưới.",["신랑 신부"]),
		("신부","n","Danh từ","Cô dâu","新婦","웨딩드레스, 아름답다, 부케","새하얀 웨딩드레스를 입은 신부의 모습이 눈부시게 아름다웠다.","Hình ảnh cô dâu khoác lên chiếc váy cưới trắng muốt đẹp rạng rỡ.",["신부 대기실"]),
		("신혼여행","n","Danh từ","Tuần trăng mật","新婚旅行","떠나다, 하와이, 즐기다","결혼식을 무사히 마치고 하와이로 신혼여행을 떠났어요.","Sau khi đám cưới diễn ra suôn sẻ họ đã bay đi Hawaii hưởng tuần trăng mật.",["신혼여행지"]),
		("축의금","n","Danh từ","Tiền mừng cưới","祝儀金","봉투, 내다, 전하다","예식장 입구에서 축의금 봉투를 전달하고 식장에 들어갔다.","Ở cửa sảnh cưới tôi đã trao phong bì tiền mừng rồi mới bước vào hội trường.",["축의금을 내다"]),
		("주례","n","Danh từ","Chủ hôn (chủ trì lễ cưới)","主禮","선생님, 말씀, 부탁하다","은사님께 주례를 부탁드려 뜻깊은 결혼식을 치렀다.","Nhờ thầy giáo làm chủ hôn nên buổi lễ thành hôn càng thêm ý nghĩa.",["주례사","주례를 서다"])
	]),
	(8,"감정 1","Cảm xúc 1","Cảm xúc & Tâm lý",[
		("불안하다","adj","Tính từ","Bất an, lo lắng","不安","시험, 초조하다, 마음","결과 발표를 앞두고 가슴이 답답하고 불안해요.","Trước khi kết quả được công bố lòng tôi cảm thấy bồn chồn và bất an.",["불안한 마음","불안에 떨다"]),
		("뿌듯하다","adj","Tính từ","Hãnh diện, tự hào, viên mãn","","보람, 완성하다, 성취감","어려운 프로젝트를 스스로 끝마치니 마음이 매우 뿌듯해요.","Tự mình hoàn thành dự án khó nhằn khiến lòng tôi vô cùng hãnh diện.",["뿌듯한 성취감"]),
		("서운하다","adj","Tính từ","Hụt hẫng, chạnh lòng, buồn bã","","친구, 이별, 섭섭하다","친한 친구가 말도 없이 이사를 가서 너무 서운했다.","Người bạn thân chuyển nhà mà chẳng nói một lời làm tôi rất chạnh lòng.",["서운한 마음"]),
		("섭섭하다","adj","Tính từ","Nuối tiếc, buồn tủi, thất vọng","","떠나다, 인사, 아쉽다","오랫동안 함께 일한 동료가 퇴사해서 무척 섭섭해요.","Người đồng nghiệp làm việc cùng bấy lâu nay nghỉ việc làm tôi rất nuối tiếc.",["섭섭하게 생각하다"]),
		("억울하다","adj","Tính từ","Oan ức, ức nghẹn","","누명, 눈물, 진실","하지도 않은 일로 오해를 받아 너무 억울해서 눈물이 났다.","Bị hiểu lầm về việc mình không làm khiến tôi vô cùng oan ức đến phát khóc.",["억울한 누명","억울함을 풀다"]),
		("홀가분하다","adj","Tính từ","Nhẹ nhõm, thanh thản","","시험, 끝나다, 마음","길었던 수능 시험이 드디어 끝나서 마음이 홀가분해요.","Kỳ thi đại học dài dằng dặc cuối cùng cũng xong khiến lòng nhẹ nhõm hẳn.",["홀가분한 기분"])
	]),
	(9,"감정 2","Cảm xúc 2","Cảm xúc & Tâm lý",[
		("긴장되다","v","Động từ","Căng thẳng, hồi hộp","緊張","면접, 무대, 손에 땀","면접관 앞에 서니 너무 긴장되어 목소리가 떨렸다.","Đứng trước người phỏng vấn tôi căng thẳng đến mức run cả giọng.",["긴장감이 돌다"]),
		("당황하다","v","Động từ","Bối rối, lúng túng, hoang mang","唐慌","갑자기, 질문, 실수","예상치 못한 날카로운 질문을 받아서 몹시 당황했다.","Nhận phải câu hỏi hóc búa bất ngờ khiến tôi vô cùng bối rối.",["당황한 기색"]),
		("설레다","v","Động từ","Xốn xang, hồi hộp rạo rực","","여행, 가슴, 첫 데이트","내일 첫 해외여행을 떠날 생각에 가슴이 콩닥콩닥 설렌다.","Nghĩ đến chuyến du lịch nước ngoài ngày mai lòng tôi xốn xang rạo rực.",["가슴이 설레다"]),
		("실망하다","v","Động từ","Thất vọng","失望","기대, 결과, 사람","노력한 만큼 결과가 좋지 않아서 크게 실망했어요.","Kết quả không tương xứng với công sức bỏ ra làm tôi rất thất vọng.",["실망을 안겨주다"]),
		("허탈하다","adj","Tính từ","Hụt hẫng, bàng hoàng rã rời","虛脫","노력, 실패, 한숨","수개월 동안 공들인 탑이 무너지자 허탈한 심정뿐이었다.","Công sức nhiều tháng trời đổ sông đổ bể làm lòng tôi bàng hoàng hụt hẫng.",["허탈한 웃음"])
	]),
	(10,"날씨와 계절 1","Thời tiết & Các mùa 1","Tự nhiên & Môi trường",[
		("기온","n","Danh từ","Nhiệt độ không khí","氣溫","떨어지다, 올라가다, 영하","내일부터 기온이 영하로 떨어져 매서운 한파가 찾아옵니다.","Từ ngày mai nhiệt độ sẽ giảm xuống dưới 0 độ mang theo đợt rét buốt.",["평균 기온","기온 변화"]),
		("일교차","n","Danh từ","Biên độ nhiệt trong ngày","日較差","환절기, 크다, 감기","환절기에는 낮과 밤의 일교차가 크니 겉옷을 챙기세요.","Giao mùa biên độ nhiệt ngày và đêm rất lớn nên hãy nhớ mang theo áo khoác.",["일교차가 크다"]),
		("장마철","n","Danh từ","Mùa mưa dầm","","우산, 비, 습하다","장마철에는 습도가 높고 비가 계속 내려 빨래가 잘 안 말라요.","Mùa mưa dầm độ ẩm cao mưa triền miên làm quần áo rất khó khô.",["장마철 대비"]),
		("폭설","n","Danh từ","Bão tuyết, tuyết rơi dữ dội","暴雪","내리다, 교통마비, 쌓이다","밤새 내린 폭설로 인해 도로 교통이 마비되었다.","Trận bão tuyết rơi suốt đêm đã làm tê liệt giao thông đường bộ.",["폭설주의보"]),
		("화창하다","adj","Tính từ","Nắng đẹp, chan hòa, ấm áp","","하늘, 봄날, 소풍","날씨가 너무 화창해서 가족들과 공원으로 나들이를 갔다.","Thời tiết nắng đẹp rạng rỡ nên tôi đã cùng gia đình đi dã ngoại ở công viên.",["화창한 봄날"])
	]),
	(11,"날씨와 계절 2","Thời tiết & Các mùa 2","Tự nhiên & Môi trường",[
		("가뭄","n","Danh từ","Hạn hán","","농사, 비, 메마르다","오랜 가뭄으로 인해 저수지의 물이 바닥을 드러냈다.","Hạn hán kéo dài khiến nước trong hồ chứa cạn trơ đáy.",["극심한 가뭄"]),
		("황사","n","Danh từ","Bụi vàng (cát vàng)","黃砂","마스크, 봄, 호흡기","봄철 황사가 심한 날에는 외출할 때 마스크를 착용해야 합니다.","Vào những ngày bụi vàng mùa xuân nặng hạt, khi ra ngoài cần đeo khẩu trang.",["황사 경보"]),
		("무덥다","adj","Tính từ","Oi bức, nóng nực ngột ngạt","","여름, 에어컨, 땀","한여름의 무더운 날씨 때문에 잠을 이루기 힘들었다.","Thời tiết nóng nực oi bức của giữa hè làm tôi trằn trọc khó ngủ.",["무더운 날씨"]),
		("선선하다","adj","Tính từ","Mát mẻ, se lạnh dễ chịu","","가을, 바람, 산책","선선한 가을바람이 불어와 산책하기에 딱 좋은 날씨예요.","Gió thu mát mẻ thổi về, thời tiết quả là tuyệt vời để đi tản bộ.",["선선한 바람"]),
		("쌀쌀하다","adj","Tính từ","Se se lạnh, giá lạnh","","늦가을, 옷, 감기","아침저녁으로 공기가 쌀쌀하니 감기 조심하세요.","Sáng và tối không khí se lạnh nên bạn hãy chú ý giữ ấm kẻo bị cảm.",["쌀쌀한 날씨"])
	]),
	(12,"교통 1","Giao thông 1","Đời sống & Xã hội",[
		("대중교통","n","Danh từ","Phương tiện giao thông công cộng","大衆交通","이용하다, 편리하다, 버스","환경 보호를 위해 출퇴근할 때 대중교통을 애용합시다.","Để bảo vệ môi trường hãy tích cực dùng phương tiện công cộng khi đi làm.",["대중교통 이용"]),
		("환승하다","v","Động từ","Chuyển tuyến, đổi xe","換乘","지하철, 버스, 할인","신도림역에서 2호선으로 환승하여 목적지로 이동했다.","Tôi đã chuyển sang tuyến số 2 ở ga Sindorim để đi đến điểm đến.",["환승 할인"]),
		("정체","n","Danh từ","Ùn tắc, kẹt xe","停滯","도로, 명절, 꽉 막히다","명절 연휴를 맞아 고속도로 곳곳에서 극심한 정체가 빚어졌다.","Nhân kỳ nghỉ lễ, các tuyến đường cao tốc xảy ra ùn tắc nghiêm trọng.",["교통 정체"]),
		("운전면허","n","Danh từ","Bằng lái xe","運轉免許","취득하다, 시험, 따다","방학 동안 열심히 연습해서 운전면허를 취득했어요.","Trong kỳ nghỉ tôi đã chăm chỉ luyện tập và thi đỗ bằng lái xe.",["운전면허증"]),
		("안전벨트","n","Danh từ","Dây an toàn","安全벨트","매다, 착용하다, 생명","차에 타자마자 안전벨트를 매는 습관은 생명을 지켜 줍니다.","Thói quen cài dây an toàn ngay khi lên xe sẽ bảo vệ sinh mạng bạn.",["안전벨트를 매다"])
	]),
	(13,"교통 2","Giao thông 2","Đời sống & Xã hội",[
		("신호위반","n","Danh từ","Vượt đèn tín hiệu","信號違反","단속, 벌금, 위험하다","신호위반은 대형 사고를 유발하는 위험한 행위입니다.","Vượt đèn tín hiệu là hành vi nguy hiểm dễ gây tai nạn nghiêm trọng.",["신호위반 단속"]),
		("과속","n","Danh từ","Chạy quá tốc độ","過速","카메라, 속도, 줄이다","과속 단속 카메라가 있으니 규정 속도를 지켜 운전하세요.","Có camera bắn tốc độ nên hãy lái xe tuân thủ đúng tốc độ quy định.",["과속 운전"]),
		("음주운전","n","Danh từ","Lái xe khi say rượu","飮酒運轉","금지, 처벌, 대리운전","음주운전은 자신뿐만 아니라 타인의 생명을 위협하는 범죄예요.","Lái xe say rượu là tội ác đe dọa sinh mạng của bản thân và người khác.",["음주운전 처벌"]),
		("보행자","n","Danh từ","Người đi bộ","步行者","우선, 신호등, 건너다","횡단보도에서는 항상 보행자가 우선이어야 합니다.","Tại vạch sang đường người đi bộ phải luôn được ưu tiên hàng đầu.",["보행자 신호등"]),
		("사고","n","Danh từ","Tai nạn, sự cố","事故","발생하다, 예방, 처리","빗길에 미끄러져 추돌 사고가 발생했으나 다행히 다친 사람은 없었다.","Đường mưa trơn trượt gây tai nạn đâm đuôi nhưng may mắn không ai bị thương.",["교통사고"])
	]),
	(14,"돈과 은행","Tiền tệ & Ngân hàng","Kinh tế & Tài chính",[
		("계좌","n","Danh từ","Tài khoản ngân hàng","計座","개설하다, 번호, 이체","은행에 직접 방문하여 새로운 입출금 계좌를 개설했다.","Tôi đã đến tận ngân hàng để mở tài khoản tiền gửi thanh toán mới.",["계좌 이체","계좌 번호"]),
		("예금","n","Danh từ","Tiền gửi tiết kiệm","預金","이자, 만기, 은행","매달 일정 금액을 은행에 정기예금으로 넣고 있어요.","Hàng tháng tôi đều gửi một khoản tiền cố định vào tiền gửi định kỳ ở ngân hàng.",["정기예금"]),
		("대출","n","Danh từ","Khoản vay, vay tiền","貸出","받다, 상환하다, 금리","내 집 마련을 위해 은행에서 주택 담보 대출을 받았다.","Để mua được căn nhà cho riêng mình tôi đã vay thế chấp nhà ở ngân hàng.",["대출을 받다"]),
		("환전","n","Danh từ","Đổi ngoại tệ","換錢","수수료, 달러, 공항","해외여행을 떠나기 전 공항 은행에서 달러로 환전했다.","Trước khi lên đường đi du lịch nước ngoài tôi đã đổi sang tiền đô ở ngân hàng sân bay.",["환전 수수료"]),
		("송금","n","Danh từ","Chuyển tiền","送金","앱, 보내다, 확인","스마트폰 뱅킹 앱을 이용하면 간편하게 송금할 수 있어요.","Sử dụng ứng dụng ngân hàng thông minh có thể chuyển tiền rất dễ dàng.",["송금 확인"])
	]),
	(15,"건강과 질병 1","Sức khỏe & Bệnh tật 1","Sức khỏe & Thể chất",[
		("면역력","n","Danh từ","Khả năng miễn dịch, đề kháng","免疫力","강화하다, 높이다, 비타민","충분한 수면과 균형 잡힌 식사는 면역력을 높여 줍니다.","Ngủ đủ giấc và ăn uống cân bằng giúp tăng cường khả năng miễn dịch.",["면역력 증진"]),
		("피로","n","Danh từ","Sự mệt mỏi, mệt nhọc","疲勞","회복하다, 쌓이다, 풀다","따뜻한 물로 목욕을 하니 하루 동안 쌓였던 피로가 풀렸다.","Tắm bằng nước ấm giúp xua tan đi sự mệt mỏi tích tụ suốt cả ngày.",["피로를 풀다"]),
		("소화","n","Danh từ","Tiêu hóa","消化","불량, 잘되다, 돕다","식사 후 가벼운 산책은 소화를 돕는 데 아주 효과적이에요.","Đi dạo nhẹ nhàng sau bữa ăn rất hiệu quả trong việc hỗ trợ tiêu hóa.",["소화 불량"]),
		("처방전","n","Danh từ","Đơn thuốc","處方箋","받다, 약국, 약사","병원 진료 후 처방전을 받아 약국에서 약을 지었다.","Sau khi khám bệnh xong tôi nhận đơn thuốc rồi sang nhà thuốc lấy thuốc.",["처방전을 받다"]),
		("진찰","n","Danh từ","Khám bệnh","診察","의사, 받다, 청진기","의사 선생님께 꼼꼼한 진찰을 받고 안도했다.","Được bác sĩ thăm khám cẩn thận tỉ mỉ tôi đã thở phào an tâm.",["진찰을 받다"])
	]),
	(17,"건강과 질병 2","Sức khỏe & Bệnh tật 2","Sức khỏe & Thể chất",[
		("감염","n","Danh từ","Lây nhiễm, truyền nhiễm","感染","예방하다, 바이러스, 손씻기","바이러스 감염을 예방하려면 외출 후 손을 깨끗이 씻어야 합니다.","Để phòng ngừa nhiễm virus sau khi ra ngoài về phải rửa tay thật sạch.",["감염 예방"]),
		("알레르기","n","Danh từ","Dị ứng (Allergy)","","반응, 체질, 꽃가루","봄철만 되면 꽃가루 알레르기 때문에 재채기가 멈추지 않는다.","Cứ đến mùa xuân là tôi hắt hơi không ngớt vì dị ứng phấn hoa.",["알레르기 반응"]),
		("염증","n","Danh từ","Viêm nhiễm, sưng viêm","炎症","가라앉히다, 생기다, 약","상처 부위에 염증이 생기지 않도록 소독약을 발랐다.","Tôi đã bôi thuốc sát trùng để vết thương không bị sưng viêm.",["염증 치료"]),
		("두통","n","Danh từ","Đau đầu","頭痛","심하다, 약, 어지럽다","심한 두통이 지속되어 신경과 진료를 예약했다.","Cơn đau đầu dữ dội kéo dài nên tôi đã đặt lịch khám chuyên khoa thần kinh.",["두통약"]),
		("불면증","n","Danh từ","Chứng mất ngủ","不眠症","시달리다, 밤, 커피","스트레스 때문에 불면증에 시달려 밤새 잠을 못 잤다.","Do căng thẳng nên tôi bị chứng mất ngủ hành hạ suốt cả đêm.",["불면증 치료"])
	]),
	(18,"건강과 질병 3","Sức khỏe & Bệnh tật 3","Sức khỏe & Thể chất",[
		("입원","n","Danh từ","Nhập viện","入院","치료, 병원, 퇴원","수술을 받기 위해 내일부터 일주일 동안 입원하기로 했다.","Để tiến hành phẫu thuật tôi sẽ nhập viện một tuần bắt đầu từ ngày mai.",["입원 치료"]),
		("퇴원","n","Danh từ","Xuất viện","退院","수속, 건강하다, 회복","건강이 완전히 회복되어 드디어 오늘 퇴원 수속을 밟았다.","Sức khỏe đã hồi phục hoàn toàn nên cuối cùng hôm nay tôi đã làm thủ tục xuất viện.",["퇴원 수속"]),
		("진통제","n","Danh từ","Thuốc giảm đau","鎭痛劑","복용하다, 가라앉히다, 통증","통증이 너무 심해서 의사의 처방에 따라 진통제를 복용했다.","Cơn đau quá dữ dội nên tôi đã uống thuốc giảm đau theo đơn của bác sĩ.",["진통제 복용"]),
		("부작용","n","Danh từ","Tác dụng phụ","副作用","생기다, 우려, 주의","약의 설명서를 꼼꼼히 읽어 부작용을 사전에 예방해야 한다.","Cần đọc kỹ hướng dẫn sử dụng thuốc để phòng ngừa trước các tác dụng phụ.",["부작용이 나타나다"]),
		("건강검진","n","Danh từ","Khám sức khỏe tổng quát","健康檢診","받다, 정기적, 결과","질병을 조기에 발견하기 위해 매년 정기 건강검진을 받아요.","Để phát hiện bệnh sớm hàng năm tôi đều đi khám sức khỏe định kỳ.",["건강검진 결과"])
	]),
	(19,"신체와 감각","Cơ thể & Giác quan","Sức khỏe & Thể chất",[
		("시각","n","Danh từ","Thị giác, cái nhìn","視覺","손상, 자극, 느끼다","눈을 감으면 청각과 후각이 더욱 예민해지는 것을 느낄 수 있다.","Khi nhắm mắt lại bạn sẽ cảm nhận thính giác và khứu giác trở nên nhạy bén hơn.",["시각 장애"]),
		("청각","n","Danh từ","Thính giác","聽覺","보호, 소음, 듣다","큰 소음에 오래 노출되면 청각이 손상될 위험이 높아요.","Tiếp xúc lâu với tiếng ồn lớn có nguy cơ tổn thương thính giác rất cao.",["청각 보호"]),
		("후각","n","Danh từ","Khứu giác","嗅覺","향기, 냄새, 예민하다","강아지는 사람보다 후각이 수만 배 이상 발달해 있다.","Loài chó có khứu giác phát triển nhạy hơn con người gấp hàng vạn lần.",["예민한 후각"]),
		("미각","n","Danh từ","Vị giác","味覺","맛, 느끼다, 마비","감기에 심하게 걸려서 미각을 잠시 잃어버렸어요.","Bị cảm nặng khiến tôi tạm thời mất đi vị giác chẳng thấy ngon miệng.",["미각을 돋우다"]),
		("촉각","n","Danh từ","Xúc giác","觸覺","손끝, 부드럽다, 느끼다","손끝의 섬세한 촉각으로 옷감의 부드러움을 확인했다.","Tôi cảm nhận độ mềm mại của sợi vải bằng xúc giác tinh tế ở đầu ngón tay.",["섬세한 촉각"])
	]),
	(20,"여행과 여가 생활 1","Du lịch & Giải trí 1","Du lịch & Giải trí",[
		("숙소","n","Danh từ","Chỗ ở, nơi lưu trú","宿所","예약하다, 호텔, 머물다","관광지 중심에 위치한 아늑한 숙소를 미리 예약해 두었다.","Tôi đã đặt trước một chỗ ở ấm cúng nằm ngay trung tâm điểm tham quan.",["숙소를 정하다"]),
		("일정","n","Danh từ","Lịch trình","日程","짜다, 빡빡하다, 소화하다","3박 4일 동안 알차게 둘러볼 수 있도록 여행 일정을 짰어요.","Tôi đã lên lịch trình du lịch để tham quan trọn vẹn trong 4 ngày 3 đêm.",["여행 일정"]),
		("명소","n","Danh từ","Địa danh nổi tiếng, thắng cảnh","名所","관광, 방문하다, 사진","제주도에 가면 꼭 들러야 하는 관광 명소를 찾아다녔다.","Đến đảo Jeju tôi đã tìm đến các thắng cảnh du lịch nhất định phải ghé qua.",["관광 명소"]),
		("경비","n","Danh từ","Chi phí, kinh phí","經費","절약하다, 예산, 부족하다","교통비와 식비를 포함한 총 여행 경비를 꼼꼼히 계산했다.","Tôi đã tính toán cẩn thận tổng kinh phí du lịch gồm cả tiền xe và ăn uống.",["여행 경비"]),
		("기념품","n","Danh từ","Đồ lưu niệm","紀念品","사다, 선물, 가게","여행지 특산품 가게에서 가족들에게 줄 기념품을 구입했다.","Ở tiệm đặc sản địa phương tôi đã mua quà lưu niệm về tặng gia đình.",["기념품 가게"])
	]),
	(21,"여행과 여가 생활 2","Du lịch & Giải trí 2","Du lịch & Giải trí",[
		("배낭여행","n","Danh từ","Du lịch ba lô (du lịch bụi)","背囊旅行","떠나다, 청춘, 자유롭다","대학 시절 친구들과 함께 유럽으로 배낭여행을 떠났던 순간이 그립다.","Nhớ khoảnh khắc thời đại học xách ba lô đi du lịch bụi châu Âu cùng bạn bè.",["배낭여행객"]),
		("패키지여행","n","Danh từ","Du lịch theo tour trọn gói","패키지旅行","가이드, 편리하다, 선택하다","부모님을 모시고 가는 여행이라 안전하고 편리한 패키지여행을 선택했어요.","Vì đưa bố mẹ đi cùng nên tôi đã chọn tour trọn gói an toàn và tiện lợi.",["패키지 상품"]),
		("체험","n","Danh từ","Trải nghiệm, thực tế","體驗","프로그램, 전통, 즐기다","도자기 마을에서 흙을 빚어 그릇을 만드는 전통 체험을 해 보았다.","Ở làng gốm tôi đã tham gia trải nghiệm truyền thống tự tay nặn đất làm bát.",["체험 학습"]),
		("휴양지","n","Danh từ","Khu nghỉ dưỡng","休養地","바다, 휴식, 힐링","도심의 소음을 벗어나 한적하고 아름다운 휴양지에서 푹 쉬었다.","Thoát khỏi ồn ào phố thị tôi đã nghỉ ngơi thư giãn ở khu nghỉ dưỡng yên bình.",["세계적인 휴양지"]),
		("환상적","adj","Tính từ","Huyền ảo, tuyệt vời, kỳ diệu","幻想的","풍경, 노을, 감탄","바닷가 언덕에서 바라본 붉은 노을은 정말 환상적이었어요.","Hoàng hôn đỏ rực nhìn từ trên đồi ven biển quả thực tuyệt vời kỳ diệu.",["환상적인 야경"])
	]),
	(22,"여행과 여가 생활 3","Du lịch & Giải trí 3","Du lịch & Giải trí",[
		("캠핑","n","Danh từ","Cắm trại","","텐트, 야외, 바비큐","주말에 가족들과 숲속 캠핑장에 가서 텐트를 치고 놀았어요.","Cuối tuần tôi cùng gia đình đến khu cắm trại giữa rừng dựng lều vui chơi.",["캠핑 장비"]),
		("드라이브","n","Danh từ","Lái xe dạo mát","","코스, 바닷길, 즐기다","날씨가 좋아 해안 도로를 따라 시원하게 드라이브를 즐겼다.","Thời tiết đẹp nên chúng tôi lái xe dạo mát ngắm biển lộng gió.",["드라이브 코스"]),
		("취미","n","Danh từ","Sở thích","趣味","생활, 가지다, 즐기다","퇴근 후 스트레스를 해소하기 위해 그림 그리는 취미를 시작했다.","Để giải tỏa căng thẳng sau giờ làm tôi đã bắt đầu sở thích vẽ tranh.",["취미 생활"]),
		("동호회","n","Danh từ","Câu lạc bộ những người cùng sở thích","同好會","가입하다, 모임, 활동","자전거 타는 사람들의 모임인 라이딩 동호회에 가입했어요.","Tôi đã gia nhập câu lạc bộ những người đam mê đạp xe đạp.",["동호회 활동"]),
		("휴식","n","Danh từ","Sự nghỉ ngơi","休息","취하다, 재충전, 필요하다","지친 몸과 마음에 진정한 휴식을 주는 주말을 보냈다.","Tôi đã trải qua một kỳ cuối tuần nghỉ ngơi thực sự để tiếp thêm năng lượng.",["휴식을 취하다"])
	]),
	(23,"운동과 스포츠","Vận động & Thể thao","Thể thao & Thể chất",[
		("근력","n","Danh từ","Sức mạnh cơ bắp","筋力","운동, 강화하다, 키우다","건강한 신체를 유지하려면 유산소 운동과 함께 근력 운동도 필수적이에요.","Để duy trì cơ thể khỏe mạnh cùng với bài tập cardio thì tập cơ bắp cũng thiết yếu.",["근력 운동"]),
		("지구력","n","Danh từ","Sức bền, độ dẻo dai","持久力","마라톤, 기르다, 끈기","오래 달리기 훈련을 반복하면 심폐 지구력이 크게 향상됩니다.","Luyện chạy đường dài lặp đi lặp lại sẽ nâng cao đáng kể sức bền tim phổi.",["지구력을 기르다"]),
		("스트레칭","n","Danh từ","Giãn cơ, khởi động","","부상 방지, 유연성, 풀다","운동을 시작하기 전에 충분한 스트레칭으로 몸을 풀어야 부상을 막아요.","Trước khi bắt đầu tập luyện cần giãn cơ kỹ để phòng ngừa chấn thương.",["스트레칭을 하다"]),
		("승패","n","Danh từ","Thắng bại","勝敗","갈리다, 중요하지 않다, 정정당당","스포츠에서는 승패보다 끝까지 최선을 다하는 스포츠맨십이 더 소중해요.","Trong thể thao tinh thần thi đấu hết mình quý hơn là chuyện thắng thua.",["승패를 가리다"]),
		("규칙","n","Danh từ","Quy tắc, luật chơi","規則","지키다, 위반, 페어플레이","경기에 참여할 때는 정해진 규칙을 철저히 준수해야 합니다.","Khi tham gia thi đấu cần phải tuân thủ nghiêm ngặt các quy tắc đã đề ra.",["규칙을 준수하다"])
	]),
	(24,"공연과 예술","Biểu diễn & Nghệ thuật","Văn hóa & Nghệ thuật",[
		("전시회","n","Danh từ","Triển lãm","展示會","관람하다, 미술관, 열리다","시립 미술관에서 유명 화가의 특별 기획 전시회가 열리고 있다.","Tại bảo tàng mỹ thuật thành phố đang mở triển lãm đặc biệt của họa sĩ nổi tiếng.",["전시회 관람"]),
		("뮤지컬","n","Danh từ","Vở nhạc kịch (Musical)","","배우, 무대, 감동","웅장한 음악과 화려한 무대가 어우러진 뮤지컬을 보고 감동받았어요.","Xem vở nhạc kịch kết hợp âm nhạc hùng tráng và sân khấu lộng lẫy tôi rất xúc động.",["뮤지컬 관람"]),
		("관객","n","Danh từ","Khán giả","觀客","환호하다, 박수, 가득 차다","공연이 끝나자 객석을 가득 채운 관객들이 기립 박수를 보냈다.","Khi buổi diễn kết thúc toàn thể khán giả lấp kín khán phòng đã đứng dậy vỗ tay.",["관객의 호응"]),
		("예매","n","Danh từ","Đặt vé trước","豫買","티켓, 매진, 성공하다","인기 콘서트 티켓 예매가 시작되자마자 단 몇 분 만에 매진되었다.","Vừa mở bán đặt vé buổi hòa nhạc nổi tiếng là chỉ vài phút đã cháy vé.",["티켓 예매"]),
		("작품","n","Danh từ","Tác phẩm","作品","감상하다, 걸작, 탄생","작가의 깊은 고뇌와 예술혼이 담긴 훌륭한 작품을 감상했다.","Tôi đã thưởng thức tác phẩm tuyệt vời chứa đựng sự trăn trở và linh hồn nghệ thuật.",["예술 작품"])
	]),
	(25,"음식 1","Ẩm thực 1","Ẩm thực & Đời sống",[
		("재료","n","Danh từ","Nguyên liệu","材料","신선하다, 준비하다, 썰다","신선한 제철 재료를 사용하여 정성껏 저녁 요리를 만들었어요.","Dùng nguyên liệu tươi ngon theo mùa tôi đã chu đáo nấu bữa tối.",["신선한 재료"]),
		("조리법","n","Danh từ","Công thức, cách chế biến","調理法","간단하다, 따르다, 레시피","인터넷에 나와 있는 간단한 조리법을 보고 찌개를 끓였다.","Xem công thức chế biến đơn giản trên mạng tôi đã nấu món canh hầm.",["전통 조리법"]),
		("양념","n","Danh từ","Gia vị, đồ nêm","","골고루, 버무리다, 맛을 내다","고기에 갖은 양념을 골고루 재워 두면 육질이 한결 부드러워져요.","Tẩm ướp đủ gia vị vào thịt thì thớ thịt sẽ mềm ngon hơn hẳn.",["양념에 재우다"]),
		("담백하다","adj","Tính từ","Thanh đạm, thanh nhẹ","","국물, 맛, 깔끔하다","기름기가 전혀 없이 맑고 담백한 국물 맛이 일품이다.","Nước dùng trong veo không chút váng mỡ vị thanh đạm thật tuyệt hảo.",["담백한 맛"]),
		("매콤하다","adj","Tính từ","Cay cay, the the hấp dẫn","","떡볶이, 입맛, 돋우다","매콤한 떡볶이를 먹으니 스트레스가 확 풀리는 기분이에요.","Ăn bánh gạo cay cay hấp dẫn thấy căng thẳng tan biến ngay tức khắc.",["매콤달콤하다"])
	])
]
print(f"Loaded core curated datasets: {len(units_raw)} units")
