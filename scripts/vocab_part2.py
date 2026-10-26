import sys
sys.stdout.reconfigure(encoding='utf-8')
units_raw=[
	(26,"음식 2","Ẩm thực 2","Ẩm thực & Đời sống",[
		("외식","n","Danh từ","Ăn ngoài, ăn tiệm","外食","주말, 가족, 식당","주말 저녁에는 요리 대신 가족들과 외식을 자주 즐겨요.","Tối cuối tuần thay vì nấu nướng tôi thường cùng gia đình đi ăn ngoài.",["외식 문화"]),
		("간식","n","Danh từ","Đồ ăn vặt, bữa phụ","間食","출출하다, 챙겨 먹다, 과일","오후에 출출할 때는 떡이나 과일 같은 건강 간식을 챙겨 먹어요.","Buổi chiều đói bụng tôi thường ăn nhẹ bằng bánh gạo hoặc trái cây tốt cho sức khỏe.",["간식거리"]),
		("후식","n","Danh từ","Món tráng miệng","後食","디저트, 커피, 과일","식사를 든든하게 마친 뒤 달콤한 케이크와 커피를 후식으로 먹었다.","Ăn xong bữa no nê tôi đã dùng bánh ngọt và cà phê làm món tráng miệng.",["후식을 즐기다"]),
		("싱겁다","adj","Tính từ","Nhạt, thiếu muối","","간, 소금, 국","국이 너무 싱거워서 소금을 조금 더 넣어 간을 맞췄다.","Nồi canh nhạt quá nên tôi đã thêm chút muối vào nêm cho vừa miệng.",["간이 싱겁다"]),
		("느끼하다","adj","Tính từ","Ngấy, béo ngậy","","기름, 튀김, 김치","기름진 음식을 많이 먹어 속이 느끼할 때는 시원한 김치를 찾게 된다.","Khi ăn nhiều đồ dầu mỡ bị ngấy bụng tôi liền tìm ăn kim chi cho mát dạ.",["느끼한 맛"])
	]),
	(27,"음식 3","Ẩm thực 3","Ẩm thực & Đời sống",[
		("배달","n","Danh từ","Giao hàng, ship đồ ăn","配達","앱, 주문하다, 음식","비가 내리는 날에는 배달 앱으로 치킨을 주문해 먹는 사람이 많아요.","Những ngày trời mưa có rất nhiều người đặt ship gà rán qua ứng dụng.",["음식 배달"]),
		("포장","n","Danh từ","Đóng gói mang về, bọc gói","包裝","테이크아웃, 용기, 깔끔하다","퇴근길에 단골 식당에 들러 따뜻한 국밥을 깔끔하게 포장해 갔다.","Trên đường đi làm về tôi ghé quán quen đóng gói canh súp nóng hổi mang về.",["포장 주문"]),
		("유통기한","n","Danh từ","Hạn sử dụng","流通期限","확인하다, 지나다, 안전","우유나 유제품을 살 때는 유통기한을 꼼꼼히 확인해야 해요.","Khi mua sữa hay đồ bơ sữa cần kiểm tra kỹ hạn sử dụng.",["유통기한 확인"]),
		("신선하다","adj","Tính từ","Tươi mới, tươi ngon","新鮮","야채, 과일, 생선","새벽 시장에서 갓 들여온 신선한 야채로 샐러드를 만들었다.","Tôi làm món salad từ những loại rau củ tươi rói vừa nhập về từ chợ sớm.",["신선한 재료"]),
		("부패하다","v","Động từ","Ô thiu, hư hỏng, thối rữa","腐敗","음식, 상하다, 여름","여름철에는 상온에 음식을 오래 두면 쉽게 부패하니 냉장 보관해야 해요.","Mùa hè để thức ăn ngoài nhiệt độ phòng lâu rất dễ ôi thiu nên phải trữ lạnh.",["음식 부패"])
	]),
	(28,"음식 4","Ẩm thực 4","Ẩm thực & Đời sống",[
		("식습관","n","Danh từ","Thói quen ăn uống","食習慣","개선하다, 불규칙, 건강","건강을 지키기 위해 불규칙한 식습관을 고치고 채소 섭취를 늘렸다.","Để bảo vệ sức khỏe tôi sửa thói quen ăn uống thất thường và ăn nhiều rau hơn.",["올바른 식습관"]),
		("영양소","n","Danh từ","Chất dinh dưỡng","營養素","골고루, 풍부하다, 섭취","단백질과 비타민 등 필수 영양소를 골고루 섭취하는 것이 중요합니다.","Hấp thụ đều đặn các chất dinh dưỡng thiết yếu như protein và vitamin rất quan trọng.",["영양소 섭취"]),
		("과식","n","Danh từ","Ăn quá nhiều, ăn bội thực","過食","소화제, 배부르다, 자제","맛있는 음식 앞에서도 과식하지 않도록 적당히 먹는 절제가 필요해요.","Dù đứng trước món ngon cũng cần tiết chế ăn lượng vừa đủ tránh ăn quá no.",["과식을 피하다"]),
		("편식","n","Danh từ","Ăn kén chọn, kén ăn","偏食","고치다, 골고루, 아이","아이들이 편식하지 않고 골고루 잘 먹도록 식단을 다양하게 꾸몄다.","Tôi thiết kế thực đơn đa dạng để lũ trẻ không kén ăn mà ăn đều các món.",["편식 습관"]),
		("소식","n","Danh từ","Ăn ít, ăn thanh đạm","小食","건강, 장수, 습관","소식하는 습관은 소화기에 부담을 주지 않아 장수의 비결로 꼽힌다.","Thói quen ăn ít không gây gánh nặng cho hệ tiêu hóa được xem là bí quyết trường thọ.",["소식하는 습관"])
	]),
	(29,"쇼핑","Mua sắm","Kinh tế & Đời sống",[
		("환불","n","Danh từ","Hoàn tiền","払戻","영수증, 요청하다, 기간","구입한 물건에 하자가 있어 영수증을 지참하고 환불을 요청했다.","Món hàng đã mua bị lỗi nên tôi đem theo hóa đơn để yêu cầu hoàn lại tiền.",["환불을 받다"]),
		("교환","n","Danh từ","Đổi hàng","交換","사이즈, 바꾸다, 일주일","옷 사이즈가 조금 작아서 매장을 다시 방문해 한 치수 큰 것으로 교환했다.","Kích cỡ áo hơi chật nên tôi đã quay lại cửa hàng để đổi sang size lớn hơn một cỡ.",["물품 교환"]),
		("할인","n","Danh từ","Giảm giá, chiết khấu","割引","행사, 쿠폰, 반값","백화점 정기 할인 행사 기간을 이용하면 좋은 품질의 상품을 알뜰하게 살 수 있다.","Tận dụng dịp giảm giá định kỳ của trung tâm thương mại có thể mua được hàng tốt giá hời.",["할인 쿠폰"]),
		("품질","n","Danh từ","Chất lượng sản phẩm","品質","보증, 우수하다, 비교","가격이 조금 비싸더라도 내구성이 좋고 품질이 뛰어난 제품을 선호해요.","Dù giá có hơi đắt tôi vẫn chuộng sản phẩm có độ bền cao và chất lượng xuất sắc.",["우수한 품질"]),
		("후기","n","Danh từ","Đánh giá, nhận xét trải nghiệm","後記","리뷰, 읽다, 참고","인터넷 쇼핑몰에서 상품을 고를 때 다른 구매자들의 실사용 후기를 참고한다.","Khi chọn hàng trên sàn mua sắm trực tuyến tôi luôn tham khảo đánh giá thực tế của người mua.",["구매 후기"])
	]),
	(30,"아동과 청소년","Trẻ em & Thanh thiếu niên","Con người & Xã hội",[
		("성장","n","Danh từ","Sự tăng trưởng, trưởng thành","成長","발달, 호르몬, 돕다","규칙적인 수면과 균형 있는 영양 공급은 어린이의 올바른 성장을 돕는다.","Giấc ngủ điều độ và nguồn dinh dưỡng cân bằng sẽ hỗ trợ trẻ nhỏ phát triển tốt.",["성장 과정"]),
		("사춘기","n","Danh từ","Tuổi dậy thì","思春期","방황, 겪다, 대화","사춘기를 겪고 있는 자녀와는 따뜻하고 솔직한 대화로 마음을 열어야 해요.","Với con cái đang trong tuổi dậy thì cần mở lòng bằng những cuộc chuyện trò ấm áp.",["사춘기 시절"]),
		("인성","n","Danh từ","Nhân cách","人性","교육, 바르다, 중요","지식을 쌓는 공부도 필요하지만 바른 인성을 기르는 교육이 더 기본적이다.","Học tích lũy tri thức rất cần thiết nhưng giáo dục bồi đắp nhân cách tốt đẹp càng nền tảng hơn.",["인성 교육"]),
		("보호자","n","Danh từ","Người giám hộ, phụ huynh","保護者","동반, 동의, 책임","어린이 놀이 시설을 이용할 때는 반드시 보호자가 동반해야 안전합니다.","Khi sử dụng khu vui chơi trẻ em bắt buộc phải có người giám hộ đi kèm mới đảm bảo an toàn.",["보호자 동의"]),
		("독립심","n","Danh từ","Tính tự lập, độc lập","獨立心","기르다, 스스로, 결정","어렸을 때부터 스스로 문제를 해결하며 자립할 수 있는 독립심을 길러 주었다.","Từ thuở nhỏ tôi đã rèn luyện cho con tính tự lập để tự giải quyết các vấn đề.",["독립심을 기르다"])
	]),
	(31,"인생","Đời sống & Nhân sinh","Triết lý & Cuộc sống",[
		("가치관","n","Danh từ","Hệ giá trị, quan điểm sống","價値觀","형성하다, 올바르다, 차이","살아가면서 다양한 경험을 쌓는 것은 건전한 가치관 형성에 큰 밑거름이 된다.","Tích lũy trải nghiệm phong phú trong đời là nền tảng lớn hình thành quan niệm sống lành mạnh.",["올바른 가치관"]),
		("도전","n","Danh từ","Thử thách, sự dấn thân","挑戰","두려워하다, 멈추지 않다, 정신","실패를 두려워하지 않고 새로운 분야에 끊임없이 도전하는 용기가 아름답다.","Dũng khí không sợ thất bại và không ngừng dấn thân thử thách lĩnh vực mới thật đẹp đẽ.",["도전 정신"]),
		("시련","n","Danh từ","Thử thách gian nan, sóng gió","試練","극복하다, 겪다, 이겨내다","살면서 겪는 온갖 시련을 슬기롭게 극복하면 사람이 더욱 성숙해집니다.","Vượt qua mọi thử thách sóng gió trong đời một cách khôn ngoan sẽ giúp con người trưởng thành hơn.",["시련을 이겨내다"]),
		("보람","n","Danh từ","Ý nghĩa, niềm tự hào thỏa nguyện","","느끼다, 찾다, 뿌듯하다","어려운 이웃을 위해 헌신적인 봉사활동을 하며 삶의 참된 보람을 찾았어요.","Làm thiện nguyện cống hiến cho những hoàn cảnh khó khăn tôi đã tìm thấy ý nghĩa thực sự của cuộc sống.",["보람을 느끼다"]),
		("행복","n","Danh từ","Hạnh phúc","幸福","추구하다, 소소하다, 일상","행복은 먼 곳에 있는 것이 아니라 일상의 소소한 순간들을 감사히 여길 때 찾아온다.","Hạnh phúc không ở đâu xa mà tìm đến khi ta biết trân trọng những khoảnh khắc nhỏ bé trong đời.",["진정한 행복"])
	]),
	(33,"학교 1","Trường học 1","Giáo dục & Học tập",[
		("수강신청","n","Danh từ","Đăng ký môn học","受講申請","경쟁, 성공하다, 시간표","새 학기 시작 전 수강신청 시스템이 열리자마자 원하는 과목을 모두 잡았다.","Trước học kỳ mới vừa mở cổng đăng ký môn học là tôi đã đăng ký trọn vẹn các môn mong muốn.",["수강신청 기간"]),
		("장학금","n","Danh từ","Học bổng","奬學金","받다, 성적, 신청","학기 내내 열심히 공부한 결과 성적 우수 장학금을 받게 되었어요.","Nhờ chăm chỉ học tập suốt cả học kỳ tôi đã giành được học bổng thành tích xuất sắc.",["장학금을 받다"]),
		("과제","n","Danh từ","Bài tập, nhiệm vụ học tập","課題","제출하다, 발표, 마감","교수님께서 내주신 팀 과제를 해결하기 위해 밤늦게까지 도서관에서 토론했다.","Để hoàn thành bài tập nhóm giáo sư giao chúng tôi thảo luận ở thư viện tới đêm muộn.",["과제를 제출하다"]),
		("성적표","n","Danh từ","Bảng điểm","成績表","확인하다, 우수하다, 나오다","기말고사가 끝나고 성적표를 확인해 보니 노력한 보람이 가득했다.","Thi cuối kỳ xong mở bảng điểm ra xem thấy công sức bỏ ra thật vô cùng xứng đáng.",["성적표를 확인하다"]),
		("졸업식","n","Danh từ","Lễ tốt nghiệp","卒業式","꽃다발, 학사모, 기념사진","정든 교정을 떠나며 졸업식장에서 친구들과 눈물의 작별 인사를 나누었다.","Rời xa mái trường thân yêu tại lễ tốt nghiệp tôi đã rưng rưng chào tạm biệt bạn bè.",["졸업식을 치르다"])
	]),
	(34,"학교 2","Trường học 2","Giáo dục & Học tập",[
		("학점","n","Danh từ","Tín chỉ, điểm số môn học","學點","따다, 관리하다, 인정","취업을 대비해 전공 학점을 꼼꼼히 관리하고 어학 점수도 차근차근 준비했다.","Chuẩn bị xin việc tôi quản lý chặt chẽ điểm tín chỉ chuyên ngành và trau dồi chứng chỉ ngoại ngữ.",["학점을 따다"]),
		("교재","n","Danh từ","Giáo trình, tài liệu học","敎材","구입하다, 강의, 참고","수업에 필요한 필수 교재를 미리 구입하여 예습을 철저히 진행했다.","Tôi đã mua trước giáo trình thiết yếu của khóa học để chuẩn bị bài thật chu đáo.",["강의 교재"]),
		("조별과제","n","Danh từ","Bài tập nhóm (Team project)","組別課題","협력, 분담하다, 발표","조원들과 역할을 공평하게 분담하여 조별과제를 성공적으로 완수했다.","Phân chia nhiệm vụ công bằng với các thành viên nhóm đã giúp hoàn thành xuất sắc bài tập lớn.",["조별과제 발표"]),
		("모의시험","n","Danh từ","Thi thử (Mock test)","模擬試驗","치르다, 실전, 점검","실전 감각을 기르기 위해 정기적으로 토픽 모의시험을 풀어 본다.","Để rèn luyện cảm giác phòng thi thực tế tôi đều đặn giải các đề thi thử TOPIK.",["모의시험을 치르다"]),
		("동기","n","Danh từ","Bạn cùng khóa, động lực","同期","입학, 친하다, 응원","대학교 입학 동기들과는 지금까지도 서로의 고민을 나누는 둘도 없는 친구 사이다.","Với các bạn cùng khóa đại học tới tận giờ chúng tôi vẫn là bạn tri kỷ sẻ chia mọi vui buồn.",["입학 동기"])
	]),
	(35,"일과 직업","Công việc & Nghề nghiệp","Nghề nghiệp & Việc làm",[
		("적성","n","Danh từ","Năng khiếu, sở trường phù hợp","適性","맞다, 검사, 고려하다","진로를 선택할 때는 연봉도 중요하지만 자신의 적성에 맞는지 먼저 살펴야 한다.","Khi chọn nghề tuy mức lương quan trọng nhưng trước hết phải xem có hợp sở trường của mình không.",["적성에 맞다"]),
		("전문직","n","Danh từ","Nghề nghiệp chuyên môn","專門職","자격증, 종사하다, 전문성","고도의 지식과 기술을 요하는 전문직에 종사하기 위해 자격증을 취득했다.","Để làm việc trong ngành nghề chuyên môn đòi hỏi kỹ thuật cao tôi đã thi lấy chứng chỉ.",["전문직 종사자"]),
		("구직","n","Danh từ","Tìm kiếm việc làm","求職","활동, 이력서, 사이트","졸업을 앞둔 취업준비생들이 구직 사이트에서 채용 공고를 꼼꼼히 살피고 있다.","Sinh viên sắp ra trường đang chăm chú xem các tin tuyển dụng trên trang tìm việc.",["구직 활동"]),
		("경력","n","Danh từ","Kinh nghiệm làm việc, thâm niên","經歷","쌓다, 이력서, 채용","인턴십과 실무 프로젝트를 통해 유관 분야의 경력을 차곡차곡 쌓아 나갔다.","Thông qua kỳ thực tập và dự án thực tế tôi đã từng bước tích lũy kinh nghiệm chuyên ngành.",["경력을 쌓다"]),
		("전망","n","Danh từ","Triển vọng tương lai","展望","밝다, 미래, 유망하다","인공지능과 데이터 분석 분야는 앞으로의 일자리 전망이 매우 밝습니다.","Lĩnh vực trí tuệ nhân tạo và phân tích dữ liệu có triển vọng việc làm rất sáng sủa.",["밝은 전망"])
	]),
	(36,"직장 생활 1","Đời sống công sở 1","Nghề nghiệp & Việc làm",[
		("출퇴근","n","Danh từ","Đi làm và tan làm","出退勤","시간, 지하철, 혼잡","매일 왕복 두 시간이 걸리는 고단한 출퇴근길이지만 책을 읽으며 시간을 보낸다.","Dù quãng đường đi làm mỗi ngày mất hai tiếng mệt mỏi nhưng tôi tranh thủ đọc sách giết thời gian.",["출퇴근 시간"]),
		("업무","n","Danh từ","Nghiệp vụ, công việc công sở","業務","보고, 분담, 추진","오전 회의를 통해 각 팀원에게 이번 주 핵심 업무를 명확히 분담했다.","Qua cuộc họp sáng chúng tôi đã phân công rõ ràng các nghiệp vụ cốt lõi trong tuần cho các thành viên.",["업무를 추진하다"]),
		("회식","n","Danh từ","Liên hoan công ty","會食","참석하다, 단합, 분위기","분기 마감을 무사히 끝내고 팀원들의 단합을 도모하기 위해 저녁 회식을 열었다.","Hoàn thành kỳ chốt quý thuận lợi chúng tôi tổ chức bữa liên hoan tối nhằm thắt chặt tinh thần đồng đội.",["회식 자리"]),
		("야근","n","Danh từ","Làm thêm giờ ban đêm","夜勤","줄이다, 수당, 피곤하다","갑작스러운 납기일 단축으로 인해 며칠 연속으로 늦게까지 야근을 해야 했다.","Hạn chót đột ngột rút ngắn nên chúng tôi phải tăng ca làm đêm liên tục mấy ngày liền.",["야근을 하다"]),
		("휴가","n","Danh từ","Kỳ nghỉ phép","休暇","내다, 떠나다, 충전","그동안 쓰지 못하고 아껴 두었던 연차 휴가를 내어 가족들과 힐링 여행을 다녀왔다.","Tôi xin nghỉ phép năm đã dành dụm bấy lâu để cùng cả nhà đi du lịch tái tạo năng lượng.",["휴가를 내다"])
	]),
	(37,"직장 생활 2","Đời sống công sở 2","Nghề nghiệp & Việc làm",[
		("승진","n","Danh từ","Thăng chức","昇進","시험, 축하하다, 능력","남다른 업무 추진력과 탁월한 성과를 인정받아 최연소 부장으로 승진했다.","Nhờ năng lực xuất sắc và hiệu suất vượt trội anh ấy đã được thăng chức trưởng phòng trẻ tuổi nhất.",["승진 축하"]),
		("이직","n","Danh từ","Chuyển nơi làm việc, đổi công ty","移職","결심하다, 조건, 헤드헌터","더 나은 대우와 자기 발전을 이룰 수 있는 유망한 기업으로 이직을 결심했다.","Tôi quyết định chuyển việc sang một doanh nghiệp nhiều triển vọng với đãi ngộ tốt hơn.",["이직을 결심하다"]),
		("퇴직","n","Danh từ","Nghỉ việc, hưu trí","退職","퇴직금, 정년, 새로운 출발","정년퇴직을 맞이하신 선배님의 오랜 헌신에 감사드리며 감사패를 전달했다.","Gửi lời tri ân đến sự cống hiến lâu năm của tiền bối về hưu chúng tôi đã trao tặng kỷ niệm chương.",["정년퇴직"]),
		("월급","n","Danh từ","Tiền lương tháng","月給","통장, 받다, 저축","기다리던 월급날이 되자마자 부모님 용돈을 먼저 챙겨 드리고 적금을 넣었다.","Đến ngày lĩnh lương mong chờ tôi liền trích tiền biếu bố mẹ và gửi tiết kiệm trước tiên.",["월급날"]),
		("성과","n","Danh từ","Thành quả, kết quả công việc","成果","달성, 평가, 인센티브","올해 목표 매출액을 초과 달성하는 눈부신 성과를 거두어 포상금을 받았다.","Đạt thành quả rực rỡ vượt chỉ tiêu doanh số năm nay cả đội đã được nhận tiền thưởng.",["높은 성과"])
	]),
	(38,"성공과 실패","Thành công & Thất bại","Sự nghiệp & Cuộc sống",[
		("노력","n","Danh từ","Nỗ lực, cố gắng","努力","기울이다, 결실, 아끼지 않다","꿈을 이루기 위해 밤낮없이 피땀 어린 노력을 기울여 마침내 합격했다.","Bỏ ra bao nỗ lực mồ hôi nước mắt ngày đêm để chạm tới ước mơ cuối cùng tôi đã thi đỗ.",["노력을 기울이다"]),
		("포기","n","Danh từ","Từ bỏ","抛棄","모르다, 끝까지, 금물","아무리 힘든 고비가 찾아와도 결코 중도에 포기하지 않는 끈기가 필요해요.","Dù gặp chặng đường gian nan tới đâu cũng cần sự bền bỉ quyết không bỏ cuộc giữa chừng.",["포기하지 않다"]),
		("좌절","n","Danh từ","Tuyệt vọng, nản lòng thoái chí","挫折","딛고 일어서다, 아픔, 극복","사업 실패의 뼈아픈 좌절을 딛고 다시 일어서서 멋진 성공을 거머쥐었다.","Vượt qua nỗi chán chường cay đắng của việc thất bại kinh doanh anh ấy đứng dậy thành công rực rỡ.",["좌절을 극복하다"]),
		("목표","n","Danh từ","Mục tiêu","目標","설정하다, 달성, 향하다","구체적이고 명확한 목표를 세워 흔들림 없이 한 걸음씩 나아가야 한다.","Cần thiết lập mục tiêu rõ ràng cụ thể để vững vàng tiến bước từng bước một.",["목표를 달성하다"]),
		("성취감","n","Danh từ","Cảm giác thỏa nguyện đạt được mục tiêu","成就感","맛보다, 뿌듯하다, 동기부여","험난한 등산 코스를 정복하고 정상에 섰을 때 맛보는 성취감은 이루 말할 수 없다.","Cảm giác thỏa nguyện khi chinh phục cung đường núi hiểm trở chạm tay lên đỉnh thật khó tả.",["성취감을 맛보다"])
	]),
	(39,"생각 1","Tư duy & Suy nghĩ 1","Tư duy & Hành vi",[
		("판단","n","Danh từ","Phán đoán, nhận định","判斷","내리다, 신중하다, 기준","감정에 치우치지 말고 객관적인 사실에 근거하여 냉철한 판단을 내려야 한다.","Đừng thiên vị cảm xúc mà hãy đưa ra phán đoán sáng suốt dựa trên sự thật khách quan.",["올바른 판단"]),
		("결심","n","Danh từ","Quyết tâm, hạ quyết tâm","決心","하다, 굳히다, 흔들리다","새해를 맞아 건강을 위해 담배를 완전히 끊겠다고 굳게 결심했다.","Đón năm mới tôi đã hạ quyết tâm cai hẳn thuốc lá vì sức khỏe bản thân.",["결심을 굳히다"]),
		("고민","n","Danh từ","Băn khoăn, nỗi trăn trở","苦悶","상담, 털어놓다, 해결","혼자 끙끙 앓지 말고 진솔한 고민을 믿을 수 있는 친구에게 털어놓아 보세요.","Đừng ôm một mình đau đáu mà hãy thử tâm sự nỗi trăn trở với người bạn đáng tin.",["고민을 해결하다"]),
		("의견","n","Danh từ","Ý kiến, quan điểm","意見","존중하다, 나누다, 일치","서로의 생각과 의견이 다를 때는 경청하며 차이점을 좁혀 나가야 합니다.","Khi ý kiến suy nghĩ khác biệt cần lắng nghe để thu hẹp khoảng cách.",["의견을 존중하다"]),
		("상상력","n","Danh từ","Trí tưởng tượng","想像力","풍부하다, 자극, 창의성","어릴 적 읽은 동화책들은 풍부한 상상력과 창의성을 키우는 데 큰 도움이 되었다.","Những trang truyện tranh đọc thuở nhỏ đã giúp ích rất lớn nuôi dưỡng trí tưởng tượng phong phú.",["풍부한 상상력"])
	]),
	(40,"생각 2","Tư duy & Suy nghĩ 2","Tư duy & Hành vi",[
		("편견","n","Danh từ","Định kiến, thành kiến","偏見","버리다, 깨다, 시선","문화적 차이에서 비롯된 낡은 편견을 버리고 열린 마음으로 타인을 대하자.","Hãy gạt bỏ định kiến cũ kỹ bắt nguồn từ dị biệt văn hóa và đón nhận người khác với tấm lòng rộng mở.",["편견을 버리다"]),
		("착각","n","Danh từ","Ảo tưởng, ngộ nhận nhầm lẫn","錯覺","빠지다, 바로잡다, 오해","자신의 지식이 완벽하다고 착각하는 순간 배움의 성장은 멈추게 된다.","Khoảnh khắc ngộ nhận tri thức của mình là tuyệt đối thì sự trưởng thành trong học hỏi sẽ khép lại.",["착각에 빠지다"]),
		("후회","n","Danh từ","Sự hối hận, tiếc nuối","後悔","남다, 하다, 늦다","그때 조금만 더 배려하고 참았더라면 이렇게 큰 후회는 남지 않았을 텐데.","Giá như lúc ấy biết bao dung và nhẫn nại thêm một chút thì đã không tiếc nuối nhường này.",["후회가 남다"]),
		("확신","n","Danh từ","Sự tin chắc, xác tín","確信","가지다, 서다, 들다","내가 선택한 진로가 옳다는 굳은 확신을 가지고 흔들림 없이 매진했다.","Mang niềm tin xác quyết vào con đường mình chọn tôi dốc lòng tiến bước không lung lay.",["확신을 가지다"]),
		("의문","n","Danh từ","Nghi vấn, thắc mắc","疑問","품다, 제기하다, 풀리다","강의를 들으며 생긴 의문점을 교수님께 질문하여 말끔하게 해소했다.","Những thắc mắc nảy sinh trong giờ học tôi đã hỏi giáo sư và được giải đáp sáng tỏ.",["의문을 품다"])
	])
]
print(f"Loaded vocab part 2: {len(units_raw)} units")
