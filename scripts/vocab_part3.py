import sys
sys.stdout.reconfigure(encoding='utf-8')
units_raw=[
	(41,"동작 1","Hành động & Động tác 1","Hành động & Thói quen",[
		("굽히다","v","Động từ","Uốn cong, gập người","","허리, 무릎, 굽히다","무거운 물건을 들어 올릴 때는 허리를 굽히지 말고 무릎을 굽혀야 다치지 않아요.","Khi bê vật nặng không nên cúi gập lưng mà hãy gập đầu gối để tránh chấn thương.",["허리를 굽히다"]),
		("기울이다","v","Động từ","Nghiêng, dốc lòng dốc sức","","귀를 기울이다, 정성, 노력","상대방의 이야기에 진심으로 귀를 기울이는 태도가 깊은 신뢰를 형성합니다.","Thái độ chân thành lắng nghe câu chuyện của đối phương tạo nên niềm tin sâu sắc.",["귀를 기울이다"]),
		("넘어지다","v","Động từ","Ngã, té ngã","","빙판길, 조심, 다치다","겨울철 얼어붙은 빙판길에서 미끄러져 넘어지지 않도록 각별히 조심하세요.","Mùa đông hãy cẩn thận kẻo trượt chân té ngã trên đường băng trơn trượt.",["발이 걸려 넘어지다"]),
		("더듬다","v","Động từ","Dò dẫm, sờ soạng, ấp úng","","어둠, 기억, 손","갑작스러운 정전으로 불이 꺼지자 손을 더듬어 벽에 걸린 손전등을 찾았다.","Mất điện đột ngột đèn vụt tắt tôi liền dò dẫm tay tìm chiếc đèn pin trên tường.",["기억을 더듬다"]),
		("뒤돌아보다","v","Động từ","Ngoái nhìn lại, nhìn lại quá khứ","","발걸음, 과거, 반성","지나온 날들의 발자취를 차분히 뒤돌아보며 부족했던 점을 반성하는 시간을 가졌다.","Nhìn lại chặng đường tháng ngày đã qua tôi dành thời gian suy ngẫm điểm thiếu sót.",["뒤돌아보지 않다"])
	]),
	(42,"동작 2","Hành động & Động tác 2","Hành động & Thói quen",[
		("망설이다","v","Động từ","Ngập ngừng, do dự lưỡng lự","","선택, 기회, 주저하다","선택의 기로에서 너무 망설이다가 찾아온 절호의 기회를 놓치고 말았다.","Quá do dự trước ngã rẽ lựa chọn làm tôi tuột mất cơ hội ngàn vàng tìm đến.",["결정을 망설이다"]),
		("바라보다","v","Động từ","Ngắm nhìn, dõi theo","","하늘, 먼 곳, 응시","탁 트인 바다 수평선을 가만히 바라보고 있으니 복잡했던 마음이 평온해졌다.","Lặng ngắm đường chân trời biển khơi lộng gió lòng tôi bỗng trở nên tĩnh lặng.",["물끄러미 바라보다"]),
		("붙잡다","v","Động từ","Nắm giữ, níu giữ giữ chặt","","손잡이, 떠나다, 놓치지 않다","흔들리는 지하철 안에서는 안전을 위해 손잡이를 꼭 붙잡고 있어야 합니다.","Trong toa tàu điện lắc lư cần nắm chặt tay vịn để bảo đảm an toàn.",["기회를 붙잡다"]),
		("살펴보다","v","Động từ","Xem xét, quan sát kỹ lưỡng","","계약서, 조건, 꼼꼼히","중요한 계약서에 서명하기 전에 불리한 조항은 없는지 조목조목 살펴보았다.","Trước khi đặt bút ký hợp đồng quan trọng tôi đã soi xét từng điều khoản bất lợi.",["자세히 살펴보다"]),
		("움직이다","v","Động từ","Cử động, di chuyển, lay chuyển","","몸, 마음, 감동","한자리에 오래 앉아 있지 말고 수시로 일어나 몸을 움직여 스트레칭을 해 주세요.","Đừng ngồi lì một chỗ mà hãy thường xuyên đứng dậy vận động cơ thể thư giãn.",["마음을 움직이다"])
	]),
	(43,"동작 3","Hành động & Động tác 3","Hành động & Thói quen",[
		("흔들다","v","Động từ","Vẫy (tay), lắc, rung lắc","","손, 인사, 꼬리","기차가 출발하자 배웅 나온 친구들은 창밖에서 힘차게 손을 흔들어 주었다.","Khi chuyến tàu chuyển bánh các bạn ra tiễn vẫy tay thật mạnh ngoài khung cửa sổ.",["손을 흔들다"]),
		("끌다","v","Động từ","Kéo, thu hút lôi cuốn","","캐리어, 관심, 시선","공항 로비에서 무거운 캐리어를 끌며 탑승구를 향해 발걸음을 재촉했다.","Kéo chiếc vali nặng trĩu ở sảnh sân bay tôi rảo bước nhanh về phía cửa lên máy bay.",["시선을 끌다"]),
		("밀다","v","Động từ","Đẩy, cạo","","문, 쇼핑카트, 면도","출입문에 적힌 안내문을 보고 문을 앞으로 부드럽게 밀고 들어갔다.","Đọc biển hướng dẫn dán trên cửa tôi khẽ đẩy cửa về phía trước rồi bước vào.",["문을 밀다"]),
		("던지다","v","Động từ","Ném, quăng","","공, 질문, 던지다","투수가 스트라이크 존을 향해 온 힘을 다해 빠른 공을 힘차게 던졌다.","Cầu thủ ném bóng dồn hết sức lực ném quả bóng cực nhanh vào khu vực đánh bóng.",["질문을 던지다"]),
		("줍다","v","Động từ","Nhặt lên, lượm","","쓰레기, 길거리, 동전","깨끗한 거리를 만들기 위해 산책로에 떨어진 휴지와 쓰레기를 주웠다.","Để giữ cho đường phố tinh tươm tôi nhặt mẩu rác rơi vãi trên lối đi dạo.",["쓰레기를 줍다"])
	]),
	(44,"동작 4","Hành động & Động tác 4","Hành động & Thói quen",[
		("숨기다","v","Động từ","Che giấu, cất giấu","","비밀, 감정, 표정","기쁜 소식을 듣고 솟아오르는 웃음을 도무지 숨길 수가 없었다.","Nghe được tin vui tôi chẳng thể nào giấu nổi nụ cười hân hoan rạng rỡ.",["감정을 숨기다"]),
		("털다","v","Động từ","Phủi, giũ sạch bụi","","먼지, 옷, 훌훌","외출 후 집에 돌아와 현관 앞에서 외투에 묻은 흙먼지를 탁탁 털었다.","Đi ngoài đường về tôi đứng trước thềm giũ sạch bụi đất bám trên áo khoác ngoài.",["먼지를 털다"]),
		("헤매다","v","Động từ","Lạc lối, quanh co loay hoay","","길, 낯선 곳, 방황","골목길이 너무 복잡해서 지도를 보면서도 한참 동안 길을 헤맸다.","Các ngõ hẻm chằng chịt nên dù cầm bản đồ tôi vẫn loay hoay lạc lối một hồi lâu.",["길을 헤매다"]),
		("흘리다","v","Động từ","Chảy (nước mắt, mồ hôi), làm rơi vãi","","땀, 눈물, 흘리다","여름철 땡볕 아래서 마라톤을 완주하느라 온몸에 땀을 흠뻑 흘렸다.","Hoàn thành chặng đua marathon dưới trời hè gay gắt tôi túa mồ hôi ướt đẫm.",["눈물을 흘리다"]),
		("가리키다","v","Động từ","Chỉ về phía, trỏ","","손가락, 방향, 의미","지도를 짚으며 목적지로 가려면 어느 쪽으로 가야 하는지 손가락으로 가리켰다.","Chỉ vào bản đồ anh ấy lấy ngón tay trỏ hướng cần đi để đến đúng đích.",["방향을 가리키다"])
	]),
	(45,"개인과 사회 1","Cá nhân & Xã hội 1","Xã hội & Cộng đồng",[
		("공동체","n","Danh từ","Cộng đồng","共同體","의식, 연대, 발전","서로 돕고 배려하는 따뜻한 공동체 의식을 함양하는 것이 필요합니다.","Cần phải nuôi dưỡng ý thức cộng đồng ấm áp biết sẻ chia và quan tâm lẫn nhau.",["공동체 의식"]),
		("봉사","n","Danh từ","Thiện nguyện, phụng sự","奉仕","활동, 나눔, 따뜻하다","주말마다 복지관을 찾아 어르신들께 따뜻한 식사를 대접하는 봉사를 하고 있어요.","Mỗi dịp cuối tuần tôi đều đến trung tâm phúc lợi nấu bữa cơm thiện nguyện cho các cụ già.",["자원봉사"]),
		("기부","n","Danh từ","Quyên góp, từ thiện","寄附","문화, 성금, 동참","연말연시를 맞아 소외된 이웃들에게 희망을 전하는 모금 기부에 동참했다.","Dịp cuối năm đón xuân tôi đã tham gia quyên góp ủng hộ những mảnh đời khó khăn.",["기부금"]),
		("권리","n","Danh từ","Quyền lợi, quyền hạn","權利","주장, 보장, 의무","국민으로서 마땅히 누려야 할 기본적 권리를 당당히 주장하고 행사해야 한다.","Là công dân cần tự tin đòi hỏi và thực thi các quyền lợi cơ bản được hiến pháp bảo hộ.",["기본적 권리"]),
		("의무","n","Danh từ","Nghĩa vụ, bổn phận","義務","다하다, 납세, 국방","권리를 요구하기 전에 사회 구성원으로서 지켜야 할 법적 의무를 성실히 다해야 한다.","Trước khi đòi hỏi quyền lợi phải chu toàn các nghĩa vụ pháp lý của một thành viên xã hội.",["의무를 다하다"])
	]),
	(46,"개인과 사회 2","Cá nhân & Xã hội 2","Xã hội & Cộng đồng",[
		("다문화","n","Danh từ","Đa văn hóa","多文化","가정, 이해, 포용","다양한 문화적 배경을 가진 이웃들을 차별 없이 포용하는 열린 사회가 되어야 한다.","Cần trở thành xã hội cởi mở bao dung những người hàng xóm đa dạng văn hóa không phân biệt đối xử.",["다문화 가정"]),
		("소외","n","Danh từ","Bị cô lập, bị gạt ra lề xã hội","疎外","계층, 이웃, 돌보다","사회적 안전망에서 소외된 취약 계층을 발굴하여 실질적인 복지 혜택을 제공해야 한다.","Cần tìm kiếm các nhóm yếu thế bị lề hóa để cung cấp các gói phúc lợi thiết thực.",["소외 계층"]),
		("고령화","n","Danh từ","Già hóa dân số","高齡化","사회, 대책, 노인","급격한 고령화 사회로 접어들면서 노인 일자리와 복지 정책 마련이 시급한 과제다.","Bước vào xã hội già hóa nhanh việc lo việc làm và chính sách cho người cao tuổi rất cấp bách.",["고령화 사회"]),
		("저출산","n","Danh từ","Tỷ lệ sinh thấp","低出産","극복, 육아, 지원","저출산 문제를 극복하기 위해 정부 차원의 파격적인 육아 지원책이 절실하다.","Để khắc phục tỷ lệ sinh giảm sâu chính sách trợ cấp nuôi con của nhà nước là vô cùng cấp bách.",["저출산 대책"]),
		("복지","n","Danh từ","Phúc lợi xã hội","福祉","제도, 혜택, 향상","국민 모두가 안락한 삶을 누릴 수 있도록 촘촘한 복지 제도를 구축해 나가야 합니다.","Cần kiến tạo mạng lưới phúc lợi dày dặn để mọi người dân đều có cuộc sống ấm êm.",["사회 복지"])
	]),
	(47,"태도 1","Thái độ 1","Tính cách & Ứng xử",[
		("적극적","adj","Tính từ","Chủ động, tích cực","積極的","참여, 자세, 태도","수업 시간에 소극적으로 듣기만 하지 말고 적극적으로 질문하며 참여해 보세요.","Trong giờ học đừng thụ động chỉ ngồi nghe mà hãy chủ động đặt câu hỏi trao đổi.",["적극적인 태도"]),
		("소극적","adj","Tính từ","Bị động, tiêu cực rụt rè","消極的","성격, 태도, 변화","낯선 환경 앞에서도 너무 소극적인 태도를 보이지 말고 당당히 나서 보세요.","Đứng trước môi trường mới đừng rụt rè thụ động mà hãy tự tin bước tới.",["소극적인 자세"]),
		("솔직하다","adj","Tính từ","Thẳng thắn, thật thà","率直","고백, 마음, 털어놓다","거짓말로 둘러대지 말고 자신의 잘못을 솔직하게 인정하는 용기가 필요합니다.","Đừng quanh co nói dối mà cần dũng khí thẳng thắn thừa nhận lỗi lầm của bản thân.",["솔직한 마음"]),
		("겸손하다","adj","Tính từ","Khiêm tốn, nhún nhường","謙遜","자세, 사람, 미덕","뛰어난 성취를 거두었음에도 불구하고 시종일관 겸손한 태도를 잃지 않았다.","Dù gặt hái thành tựu lẫy lừng nhưng anh ấy trước sau vẫn giữ thái độ vô cùng khiêm nhường.",["겸손한 태도"]),
		("당당하다","adj","Tính từ","Tự tin, đàng hoàng đường hoàng","堂堂","자신감, 모습, 서다","실수를 두려워하지 않고 많은 청중 앞에서도 당당하게 자신의 주장을 펼쳤다.","Không sợ vấp váp anh ấy đàng hoàng tự tin diễn thuyết quan điểm trước đám đông.",["당당한 태도"])
	]),
	(49,"태도 2","Thái độ 2","Tính cách & Ứng xử",[
		("성실하다","adj","Tính từ","Chăm chỉ, thành thực cần mẫn","誠實","근무, 태도, 인정","맡은 바 업무에 늘 성실하게 임한 덕분에 회사에서 두터운 신망을 얻었다.","Luôn tận tụy cần mẫn với công việc được giao anh ấy nhận được sự tín nhiệm lớn từ công ty.",["성실한 태도"]),
		("정직하다","adj","Tính từ","Chính trực, trung thực","正直","사람, 살아가다, 신뢰","눈앞의 작은 이익에 흔들리지 않고 언제나 정직하게 행동하는 것이 가장 떳떳하다.","Không lay chuyển trước cái lợi nhỏ nhoi luôn hành xử trung thực mới là điều đàng hoàng nhất.",["정직한 성품"]),
		("책임감","n","Danh từ","Tinh thần trách nhiệm","責任感","강하다, 완수, 리더","리더에게는 팀을 위기에서 구해내고 끝까지 이끌어 갈 강한 책임감이 요구된다.","Ở người thủ lĩnh luôn đòi hỏi một tinh thần trách nhiệm thép để lèo lái cả đội.",["강한 책임감"]),
		("배려","n","Danh từ","Sự quan tâm, chu đáo chăm sóc người khác","配慮","마음, 베풀다, 따뜻하다","대중교통에서 노약자에게 자리를 양보하는 작은 배려가 사회를 따뜻하게 만듭니다.","Nhường ghế cho người già trên xe buýt là cử chỉ quan tâm nhỏ bé sưởi ấm cộng đồng.",["따뜻한 배려"]),
		("인내심","n","Danh từ","Lòng kiên nhẫn, sự nhẫn nại","忍耐心","기르다, 견디다, 부족하다","원하는 결실을 맺을 때까지 참고 견디는 인내심이 성공의 열쇠이다.","Kiên trì nhẫn nại đợi ngày hái quả ngọt chính là chiếc chìa khóa vạn năng của thành công.",["인내심을 가지다"])
	]),
	(50,"상태 1","Trạng thái & Tình trạng 1","Miêu tả & Đánh giá",[
		("원활하다","adj","Tính từ","Trôi chảy, thông suốt thuận lợi","圓滑","소통, 진행, 흐름","부서 간의 원활한 소통과 협조 덕분에 신규 프로젝트가 순조롭게 착수되었다.","Nhờ sự trao đổi trôi chảy thông suốt giữa các phòng ban dự án mới đã khởi động thuận lợi.",["원활한 소통"]),
		("심각하다","adj","Tính từ","Nghiêm trọng, gay gắt","深刻","문제, 상황, 고민","기후 변화로 인한 환경 파괴가 예상보다 훨씬 심각한 수준에 도달했다.","Sự tàn phá môi trường do biến đổi khí hậu đã chạm đến ngưỡng vô cùng nghiêm trọng.",["심각한 문제"]),
		("풍부하다","adj","Tính từ","Phong phú, dồi dào","豊富","경험, 자원, 상상력","그는 다년간의 현장 실무를 통해 풍부한 경험과 노하우를 두루 겸비하고 있다.","Trải qua nhiều năm thực tế anh ấy tích lũy vốn kinh nghiệm phong phú và bí quyết dày dạn.",["풍부한 경험"]),
		("부족하다","adj","Tính từ","Thiếu thốn, không đủ","不足","시간, 수면, 예산","마감 시한까지 시간이 턱없이 부족하여 전 팀원이 밤샘 작업을 진행했다.","Thời gian tới hạn chót thiếu hụt trầm trọng nên cả đội phải thức trắng đêm làm việc.",["수면이 부족하다"]),
		("안정되다","v","Động từ","Ổn định, bình ổn","安定","물가, 심리, 회복","정부의 신속한 조치로 인해 급등하던 생활 물가가 점차 안정세를 되찾았다.","Nhờ biện pháp can thiệp nhanh giá cả sinh hoạt leo thang đã dần lấy lại sự bình ổn.",["안정을 찾다"])
	]),
	(51,"상태 2","Trạng thái & Tình trạng 2","Miêu tả & Đánh giá",[
		("급격하다","adj","Tính từ","Đột ngột, nhanh chóng cấp tốc","急激","변화, 상승, 하락","기술의 급격한 발전으로 인해 우리의 일상생활 풍경이 180도 완전히 바뀌었다.","Sự phát triển vũ bão của công nghệ đã làm thay đổi hoàn toàn diện mạo đời sống.",["급격한 변화"]),
		("완만하다","adj","Tính từ","Thoai thoải, êm dịu từ từ","緩慢","경사, 상승, 곡선","산길의 경사가 비교적 완만하여 초보자도 큰 무리 없이 오를 수 있었다.","Độ dốc của lối mòn thoai thoải nên người mới leo núi cũng chinh phục dễ dàng.",["완만한 경사"]),
		("불가피하다","adj","Tính từ","Bất khả kháng, không thể tránh khỏi","不可避","선택, 연기, 결정","폭우와 기상 악화로 인해 예정되었던 야외 행사의 취소가 불가피했다.","Do mưa bão thời tiết xấu việc hủy sự kiện ngoài trời là điều bất khả kháng.",["불가피한 선택"]),
		("밀접하다","adj","Tính từ","Mật thiết, gắn bó chặt chẽ","密接","관계, 연관, 관련","식습관과 수면 패턴은 개인의 신체 면역력과 매우 밀접한 관계를 맺고 있다.","Thói quen ăn uống và giấc ngủ có mối liên hệ vô cùng mật thiết với sức đề kháng.",["밀접한 관계"]),
		("탁월하다","adj","Tính từ","Vượt trội, xuất sắc trác việt","卓越","능력, 성과, 선택","그녀의 탁월한 외국어 구사 능력과 협상력은 국제 회의에서 빛을 발했다.","Khả năng ngoại ngữ xuất sắc và tài thương thuyết của cô ấy đã tỏa sáng tại hội nghị.",["탁월한 능력"])
	]),
	(52,"문제와 해결 / 부탁과 거절","Vấn đề & Giải quyết / Nhờ vả & Từ chối","Giao tiếp & Ứng xử",[
		("해결책","n","Danh từ","Biện pháp giải quyết, giải pháp","解決策","모색하다, 찾다, 제시","노사 간의 갈등을 평화적으로 풀기 위해 지혜로운 해결책을 함께 모색했다.","Để tháo gỡ xung đột hai bên đã cùng tìm kiếm giải pháp khôn ngoan trong hòa bình.",["해결책을 모색하다"]),
		("극복하다","v","Động từ","Khắc phục, vượt qua thử thách","克服","위기, 난관, 이겨내다","모든 팀원이 한마음으로 뭉쳐 닥쳐온 재정적 위기를 훌륭하게 극복해 냈다.","Toàn thể thành viên đồng lòng vượt qua cuộc khủng hoảng tài chính ập đến.",["위기를 극복하다"]),
		("정중하다","adj","Tính từ","Lịch thiệp, trang trọng nhã nhặn","鄭重","거절, 부탁, 사과","선약이 있어 참석하기 어렵다는 뜻을 정중한 편지로 전해 양해를 구했다.","Vì có hẹn trước nên tôi đã gửi thư nhã nhặn xin cáo lỗi không thể đến dự.",["정중하게 거절하다"]),
		("양해","n","Danh từ","Sự thông cảm, lượng thứ","諒解","구하다, 바라다, 부탁","공사로 인한 소음 발생에 대해 주민 여러분의 너그러운 양해를 구합니다.","Chúng tôi mong nhận được sự lượng thứ thông cảm của bà con về tiếng ồn thi công.",["양해를 구하다"]),
		("거절하다","v","Động từ","Từ chối, cự tuyệt","拒絶","제안, 부탁, 완곡하다","무리한 부탁을 받았을 때는 상대방의 기분이 상하지 않게 완곡히 거절해야 한다.","Khi nhận lời nhờ vả quá sức cần từ chối khéo léo để không làm mếch lòng đối phương.",["딱 잘라 거절하다"])
	]),
	(53,"설득과 주장 / 칭찬과 벌","Thuyết phục & Tranh luận / Khen thưởng & Kỷ luật","Giao tiếp & Ứng xử",[
		("설득하다","v","Động từ","Thuyết phục","說得","부모님, 마음, 돌리다","타당한 근거와 논리적인 설명으로 반대하던 동료들을 마침내 설득했다.","Bằng dẫn chứng xác đáng và lập luận logic tôi đã thuyết phục được các đồng nghiệp.",["상대를 설득하다"]),
		("주장하다","v","Động từ","Chủ trương, khẳng định quả quyết","主張","권리, 의견, 강력히","자신의 권리를 정당하게 주장하되 타인의 의견에도 귀를 기울여야 합니다.","Hãy đường hoàng khẳng định quyền lợi chính đáng nhưng cũng cần lắng nghe người khác.",["강력히 주장하다"]),
		("칭찬","n","Danh từ","Khen ngợi, tán thưởng","稱讚","아끼지 않다, 고래, 격려","구체적인 칭찬과 따뜻한 격려는 아이들의 자신감을 쑥쑥 키워 줍니다.","Lời khen cụ thể cùng sự khích lệ ấm áp sẽ giúp lòng tự tin của trẻ lớn lên nhanh chóng.",["칭찬을 아끼지 않다"]),
		("처벌","n","Danh từ","Xử phạt, hình phạt","處罰","받다, 엄격하다, 법률","음주운전으로 인한 인명 사고에 대해서는 법적 처벌이 더욱 엄격해져야 한다.","Những tai nạn giao thông do rượu bia gây ra cần phải chịu mức xử phạt nghiêm khắc hơn.",["엄격한 처벌"]),
		("보상","n","Danh từ","Đền bù, tưởng thưởng","報償","주어지다, 손해, 대가","묵묵히 땀 흘려 일한 직원들에게 합당한 성과급과 복지 보상이 주어졌다.","Những nhân viên cần mẫn cống hiến đã nhận được mức tiền thưởng và phúc lợi xứng đáng.",["적절한 보상"])
	]),
	(54,"시간 1","Thời gian 1","Khái niệm & Đo lường",[
		("순식간","n","Danh từ","Chớp mắt, thoáng chốc tức thì","瞬息間","지나가다, 변하다, 일어난 일","행복했던 방학 두 달이 마치 순식간에 지나가 버린 것만 같아 아쉽다.","Hai tháng nghỉ hè tràn ngập niềm vui trôi qua nhanh như một cái chớp mắt nuối tiếc.",["순식간에 지나가다"]),
		("영원하다","adj","Tính từ","Vĩnh cửu, trường tồn mãi mãi","永遠","사랑, 기억, 간직","소중한 사람들과 함께 나눈 따뜻한 추억은 마음속에 영원히 살아 숨 쉰다.","Kỷ niệm ấm áp bên những người thân yêu sẽ sống mãi vĩnh cửu trong trái tim ta.",["영원한 사랑"]),
		("일시적","adj","Tính từ","Tạm thời, nhất thời","一時的","현상, 오류, 중단","이번 시스템 장애는 일시적인 네트워크 오류로 밝혀져 곧 복구되었다.","Sự cố hệ thống lần này chỉ là lỗi mạng tạm thời nên đã nhanh chóng được khắc phục.",["일시적인 현상"]),
		("지속적","adj","Tính từ","Liên tục, bền bỉ lâu dài","持續的","관심, 노력, 발전","외국어 실력을 키우기 위해서는 매일 지속적으로 듣고 말하는 훈련이 필요해요.","Muốn nâng cao ngoại ngữ cần kiên trì luyện nghe và nói bền bỉ mỗi ngày.",["지속적인 관심"]),
		("촉박하다","adj","Tính từ","Gấp rút, cận kề cấp bách","促迫","시간, 일정, 서두르다","제출 마감 시간이 촉박하니 서둘러 최종 보고서를 정리하고 인쇄합시다.","Thời hạn nộp bài rất gấp rút nên hãy mau chóng hoàn thiện và in báo cáo cuối.",["시간이 촉박하다"])
	]),
	(55,"시간 2","Thời gian 2","Khái niệm & Đo lường",[
		("세월","n","Danh từ","Tháng năm, thời gian cuộc đời","歲月","흐르다, 빠르다, 무상하다","쏜살같이 흐르는 세월 앞에 부모님의 희끗희끗한 흰머리가 눈에 밟혔다.","Trước năm tháng trôi nhanh như tên bắn mái tóc điểm bạc của cha mẹ làm tôi rưng rưng.",["세월이 흐르다"]),
		("시기","n","Danh từ","Thời kỳ, thời điểm thích hợp","時期","적절하다, 놓치다, 때","배움에는 때가 있으니 적절한 시기를 놓치지 말고 배움에 힘써야 합니다.","Việc học có thì nên đừng để lỡ thời điểm thích hợp mà hãy dốc sức trau dồi.",["적절한 시기"]),
		("시절","n","Danh từ","Thuở ấy, thời kỳ, những ngày tháng","時節","학창, 그립다, 추억","순수하고 걱정 없던 학창 시절의 친구들과 옛이야기를 나누며 웃음꽃을 피웠다.","Cùng bạn bè ôn lại kỷ niệm thuở cắp sách vô tư hồn nhiên rộn vang tiếng cười.",["학창 시절"]),
		("임시","n","Danh từ","Tạm thời, lâm thời","臨時","휴일, 개통, 처방","태풍 피해 복구를 위해 시청 광장에 임시 구호소가 신속히 설치되었다.","Để khắc phục hậu quả bão trạm cứu trợ tạm thời đã lập tức được dựng lên ở quảng trường.",["임시 휴일"]),
		("주기","n","Danh từ","Chu kỳ","週期","반복, 순환, 점검","기계 고장을 미연에 방지하기 위해 6개월 주기로 안전 점검을 실시한다.","Thực hiện kiểm tra an toàn theo chu kỳ 6 tháng một lần để phòng ngừa hỏng hóc máy móc.",["주기적인 점검"])
	]),
	(56,"수와 양 1","Con số & Số lượng 1","Khái niệm & Đo lường",[
		("비율","n","Danh từ","Tỷ lệ, tỷ phần","比率","증가, 감소, 차지하다","전체 가구 중에서 1인 가구가 차지하는 비율이 해마다 급증하고 있다.","Tỷ lệ hộ gia đình một người trong tổng số hộ đang gia tăng nhanh chóng qua từng năm.",["높은 비율"]),
		("평균","n","Danh từ","Mức trung bình","平均","수명, 점수, 달하다","의학 기술의 발전과 위생 개선으로 인류의 평균 수명이 80세를 넘어섰다.","Nhờ tiến bộ y tế và vệ sinh tuổi thọ trung bình của nhân loại đã vượt mốc 80 tuổi.",["평균 수명"]),
		("대다수","n","Danh từ","Đại đa số, phần lớn","大多數","동의, 찬성, 사람들","설문조사에 참여한 시민 대다수가 플라스틱 사용 규제 정책에 찬성표를 던졌다.","Đại đa số người dân tham gia khảo sát đã bỏ phiếu ủng hộ chính sách giảm đồ nhựa.",["대다수의 의견"]),
		("절반","n","Danh từ","Một nửa, bán phần","折半","뚝 떨어지다, 나누다, 차지","예상보다 많은 인파가 몰려 준비했던 식재료의 절반이 벌써 소진되었다.","Khách kéo đến đông hơn dự tính nên một nửa nguyên liệu đã hết sạch veo.",["절반을 넘다"]),
		("소량","n","Danh từ","Lượng nhỏ, số lượng ít","少量","첨가, 섭취, 사용","향신료는 아주 소량만 첨가해도 음식 전체의 풍미를 확 살려 줍니다.","Gia vị cay nồng chỉ cần nêm một lượng nhỏ cũng làm dậy bừng hương vị món ăn.",["소량의 소금"])
	]),
	(57,"수와 양 2","Con số & Số lượng 2","Khái niệm & Đo lường",[
		("초과하다","v","Động từ","Vượt quá, vượt ngưỡng","超過","기준치, 한도, 넘다","비행기 수하물 무게가 허용 한도를 3킬로그램 초과하여 추가 요금을 냈다.","Hành lý máy bay vượt quá hạn mức 3 cân nên tôi đã phải nộp thêm cước phí.",["한도를 초과하다"]),
		("미달하다","v","Động từ","Chưa đạt, thiếu hụt dưới chuẩn","未達","기준, 정원, 미치지 못하다","지원자 수가 모집 정원에 미달하여 추가 모집 공고를 신속히 냈다.","Số lượng hồ sơ chưa đạt chỉ tiêu tuyển dụng nên chúng tôi thông báo tuyển sinh bổ sung.",["정원 미달"]),
		("증가하다","v","Động từ","Gia tăng, tăng lên","增加","수출, 인구, 늘어나다","K-컬처의 인기에 힘입어 한국을 방문하는 외국인 관광객 수가 대폭 증가했다.","Nhờ sức hút của làn sóng K-culture lượng du khách nước ngoài đến Hàn Quốc tăng vọt.",["대폭 증가하다"]),
		("감소하다","v","Động từ","Giảm sút, sụt giảm","減少","출산율, 비용, 줄어들다","스마트 자동화 시스템을 공장에 도입한 이후 불량품 발생률이 현저히 감소했다.","Sau khi đưa dây chuyền tự động hóa vào nhà máy tỷ lệ hàng lỗi đã giảm rõ rệt.",["현저히 감소하다"]),
		("유지하다","v","Động từ","Duy trì, giữ vững","維持","건강, 균형, 이어가다","매일 30분씩 조깅을 실천하며 적정 체중과 건강한 체력을 꾸준히 유지하고 있다.","Duy trì chạy bộ 30 phút mỗi ngày tôi giữ vững cân nặng lý tưởng và thể lực dồi dào.",["현 상태를 유지하다"])
	]),
	(58,"위치와 방향","Vị trí & Phương hướng","Không gian & Vị trí",[
		("중심","n","Danh từ","Trung tâm, cốt lõi","中心","도시, 잡다, 흔들리다","외곽 지역에 머물기보다 교통이 사통팔달 발달한 도시 중심가에 숙소를 잡았다.","Thay vì ở ngoại ô tôi chọn chỗ nghỉ ngay khu trung tâm giao thông kết nối bốn phương.",["중심을 잡다"]),
		("주변","n","Danh từ","Khu vực xung quanh, lân cận","周邊","환경, 정리, 둘러보다","집 주변에 아름다운 산책로와 대형 공원이 조성되어 있어 주거 환경이 쾌적하다.","Quanh nhà có công viên lớn và đường dạo bộ đẹp đẽ nên môi trường sống rất thoáng đãng.",["주변 환경"]),
		("반대편","n","Danh từ","Phía đối diện, bờ bên kia","反對便","건너다, 위치, 횡단보도","지하철역 3번 출구로 나와 횡단보도를 건너면 반대편에 서점이 바로 보여요.","Ra cửa số 3 ga tàu điện băng qua vạch sang đường sẽ thấy hiệu sách ở ngay phía đối diện.",["길 반대편"]),
		("정면","n","Danh từ","Chính diện, mặt trước","正面","바라보다, 마주치다, 돌파","시련을 피하려 하지 않고 문제의 본질을 정면으로 마주하고 돌파해 나갔다.","Không trốn tránh khó khăn anh ấy đối diện thẳng thắn và đột phá giải quyết vấn đề.",["정면으로 돌파하다"]),
		("모퉁이","n","Danh từ","Góc ngoặt, khúc quanh đường","","돌다, 위치, 가게","골목길 모퉁이를 돌아서자 아담하고 향긋한 커피 냄새가 풍기는 카페가 나타났다.","Vừa rẽ qua góc ngoặt con hẻm một quán cà phê nhỏ thơm lừng mùi hạt rang hiện ra.",["골목 모퉁이"])
	]),
	(59,"순서와 범위","Thứ tự & Phạm vi","Không gian & Trật tự",[
		("우선순위","n","Danh từ","Thứ tự ưu tiên","優先順位","정하다, 중요하다, 먼저","많은 일이 한꺼번에 몰려올 때는 급한 일부터 우선순위를 정해 처리해야 한다.","Khi nhiều việc dồn dập cần xếp thứ tự ưu tiên việc khẩn cấp làm trước.",["우선순위를 정하다"]),
		("차례","n","Danh từ","Thứ tự, lượt, mục lục","次例","기다리다, 돌아오다, 지키다","줄을 서서 질서 정연하게 자기 차례가 오기를 차분히 기다렸다.","Xếp hàng trật tự mọi người điềm tĩnh chờ đợi tới lượt của mình.",["차례를 지키다"]),
		("범위","n","Danh từ","Phạm vi, giới hạn","範圍","넓히다, 시험, 벗어나다","이번 중간고사는 교과서 1과부터 5과까지가 출제 범위에 해당합니다.","Kỳ thi giữa kỳ lần này phạm vi ra đề bao gồm từ bài 1 đến hết bài 5 giáo trình.",["시험 범위"]),
		("단계","n","Danh từ","Giai đoạn, từng bước","段階","밟다, 거치다, 발전","서두르지 말고 기초부터 차근차근 한 단계씩 단계를 밟아 올라가야 탄탄하다.","Đừng hấp tấp mà hãy đi từng bước một từ căn bản thì nền tảng mới vững vàng.",["단계별 학습"]),
		("한계","n","Danh từ","Giới hạn, hạn mức ngưỡng","限界","부딪히다, 극복, 넘어서다","자신의 한계에 부딪혔을 때 포기하지 않고 한 걸음 더 내딛는 사람이 승리한다.","Khi chạm tới giới hạn của bản thân người không bỏ cuộc bước tiếp mới là người chiến thắng.",["한계를 넘어서다"])
	]),
	(60,"장소","Địa điểm & Nơi chốn","Không gian & Địa lý",[
		("목적지","n","Danh từ","Điểm đến, nơi đích","目的地","도착하다, 향하다, 설정","네비게이션에 목적지를 입력하고 안전벨트를 맨 뒤 차를 출발시켰다.","Nhập điểm đến vào định vị và thắt dây an toàn tôi nổ máy cho xe lăn bánh.",["목적지에 도달하다"]),
		("현장","n","Danh từ","Hiện trường, thực tế tại chỗ","現場","체험, 답사, 확인","책상머리 이론에만 머물지 않고 직접 생생한 생산 현장을 찾아가 문제점을 파악했다.","Không chỉ ngồi bàn giấy lý thuyết tôi đến tận hiện trường sản xuất nắm bắt thực trạng.",["사고 현장"]),
		("장소","n","Danh từ","Địa điểm, nơi chốn","場所","물색하다, 협소하다, 변경","동창회 모임을 가질 수 있도록 교통이 편리하고 쾌적한 장소를 물색 중이다.","Chúng tôi đang tìm địa điểm giao thông thuận tiện và thoáng đãng để tổ chức họp lớp.",["약속 장소"]),
		("공간","n","Danh từ","Không gian","空間","활용하다, 아늑하다, 부족","자투리 공간을 알뜰하게 활용하여 책을 읽을 수 있는 작은 서재를 꾸몄다.","Tận dụng không gian góc chết tôi đã bày biện một góc đọc sách nhỏ xinh ấm áp.",["문화 공간"]),
		("거리","n","Danh từ","Đường phố, con phố, khoảng cách","","번화하다, 축제, 걷다","주말을 맞아 활기찬 젊음의 열기로 가득 찬 홍대 거리를 친구들과 거닐었다.","Cuối tuần tôi cùng bạn bè dạo bước trên con phố Hongdae tràn trề sức sống thanh xuân.",["젊음의 거리"])
	]),
	(61,"집 1","Nhà ở 1","Nhà ở & Không gian sống",[
		("부동산","n","Danh từ","Bất động sản, văn phòng nhà đất","不動産","중개인, 계약, 매물","이사를 가기 위해 역세권 근처의 공인중개사 부동산을 방문해 상담을 받았다.","Để chuyển nhà tôi đến văn phòng môi giới bất động sản gần ga để xin tư vấn.",["부동산 중개"]),
		("전세","n","Danh từ","Thuê nhà đặt cọc trọn gói (Jeonse)","傳貰","보증금, 계약, 월세","한국 고유의 주거 임대 방식인 전세로 아파트 계약을 체결했다.","Tôi đã ký hợp đồng căn hộ chung cư theo hình thức đặt cọc trọn gói đặc thù của Hàn Quốc.",["전세 보증금"]),
		("월세","n","Danh từ","Tiền thuê nhà trả theo tháng","月貰","부담, 납부, 자취","매달 나가는 월세와 관리비 부담을 줄이기 위해 직장 근처 룸메이트를 구했다.","Để giảm bớt gánh nặng tiền thuê nhà và phí quản lý hàng tháng tôi tìm người ở ghép.",["월세를 내다"]),
		("인테리어","n","Danh từ","Nội thất, trang trí nhà cửa","","꾸미다, 공사, 조명","아늑하고 따뜻한 분위기를 연출하기 위해 은은한 조명으로 집 안 인테리어를 바꿨다.","Để tạo cảm giác ấm cúng tôi đã thay đổi nội thất bằng hệ thống ánh sáng dịu nhẹ.",["실내 인테리어"]),
		("관리비","n","Danh từ","Phí quản lý tòa nhà","管理費","고지서, 절약, 포함","전기요금과 수도요금이 합산된 아파트 관리비 고지서를 꼼꼼히 체크했다.","Tôi kiểm tra kỹ thông báo phí quản lý chung cư gộp cả tiền điện và tiền nước.",["관리비 내역"])
	]),
	(62,"집 2","Nhà ở 2","Nhà ở & Không gian sống",[
		("베란다","n","Danh từ","Ban công, hiên nhà (Veranda)","","화분, 빨래, 햇살","햇살이 따사롭게 비치는 베란다에 예쁜 꽃화분을 두고 빨래를 널었다.","Trên ban công ngập tràn ánh nắng ấm áp tôi đặt chậu hoa nhỏ và phơi quần áo.",["베란다 화단"]),
		("도어락","n","Danh từ","Khóa cửa điện tử thông minh","","비밀번호, 잠그다, 안전","최신형 디지털 도어락을 설치하여 열쇠 없이 비밀번호로 문을 편리하게 연다.","Lắp khóa điện tử thông minh tôi mở cửa tiện lợi bằng mật khẩu không cần chìa khóa.",["디지털 도어락"]),
		("수납공간","n","Danh từ","Không gian chứa đồ, tủ ngăn cữ","受納空間","넓다, 정리, 활용","붙박이장을 설치하니 옷과 이불을 깔끔하게 정리할 수 있는 수납공간이 넉넉해졌다.","Lắp tủ âm tường giúp không gian chứa đồ rộng rãi tha hồ cất gọn quần áo chăn màn.",["넉넉한 수납공간"]),
		("환기","n","Danh từ","Thông gió, thoáng khí","換氣","창문, 시키다, 신선한 공기","실내 공기가 답답할 때는 창문을 활짝 열어 맞바람으로 바깥공기를 환기해야 해요.","Khi không khí trong phòng bí bách hãy mở toang cửa sổ thông gió đón khí trời trong lành.",["환기를 시키다"]),
		("난방","n","Danh từ","Sưởi ấm, hệ thống sưởi","暖房","온돌, 보일러, 따뜻하다","한국의 전통 온돌 방식 난방 보일러 덕분에 한겨울에도 방바닥이 따스하다.","Nhờ hệ thống sưởi sàn Ondol truyền thống của Hàn Quốc mùa đông nền nhà ấm ran.",["난방 시설"])
	]),
	(63,"물건","Đồ vật & Vật dụng","Đồ vật & Đời sống",[
		("가전제품","n","Danh từ","Đồ điện gia dụng","家電製品","혼수, 에너지 효율, 스마트","이사할 때 에너지 소비 효율 등급이 높은 최신 가전제품으로 모두 교체했다.","Khi chuyển nhà tôi đã đổi mới toàn bộ đồ điện gia dụng tiết kiệm điện năng thông minh.",["가전제품 매장"]),
		("소모품","n","Danh từ","Đồ dùng tiêu hao","消耗品","교체, 정기적, 구입","복사기 토너와 프린터 용지 같은 사무실 필수 소모품을 대량으로 주문했다.","Tôi đã đặt mua số lượng lớn các đồ dùng tiêu hao như mực máy in và giấy photo.",["소모품 교체"]),
		("재활용품","n","Danh từ","Đồ tái chế","再活用品","분리수거, 배출, 환경","종이와 플라스틱 등 재활용품을 요일별 배출 규정에 맞춰 분리수거했다.","Tôi phân loại giấy rác và chai nhựa tái chế đúng theo quy định ngày gom rác.",["재활용품 분리배출"]),
		("귀중품","n","Danh từ","Đồ quý giá, tài sản có giá trị","貴重品","보관, 금고, 분실주의","여행 중에는 여권과 귀금속 등 귀중품을 호텔 객실 금고에 안전하게 보관하세요.","Khi đi du lịch hãy cất hộ chiếu và trang sức quý giá vào két sắt phòng khách sạn an toàn.",["귀중품 보관함"]),
		("생필품","n","Danh từ","Nhu yếu phẩm hàng ngày","生必需品","구입, 마트, 비축","대형 할인 마트에 들러 휴지와 비누, 치약 등 생활 필수품을 넉넉히 사두었다.","Ghé siêu thị lớn tôi mua dự trữ sẵn các nhu yếu phẩm như giấy vệ sinh xà phòng kem đánh răng.",["생필품 가격"])
	]),
	(65,"컴퓨터와 통신","Máy tính & Viễn thông","Công nghệ & Thông tin",[
		("인터넷","n","Danh từ","Mạng Internet","","검색, 연결, 속도","초고속 광대역 인터넷망 덕분에 고화질 영상도 끊김 없이 부드럽게 시청한다.","Nhờ mạng internet cáp quang siêu tốc xem video độ nét cao mượt mà không hề giật lag.",["인터넷 검색"]),
		("스마트폰","n","Danh từ","Điện thoại thông minh","","어플, 결제, 필수품","현대인들에게 스마트폰은 소통과 정보 검색, 금융 결제를 담당하는 필수 분신이다.","Với con người thời nay chiếc smartphone là vật bất ly thân đảm nhiệm mọi giao dịch.",["스마트폰 중독"]),
		("보안","n","Danh từ","Bảo mật, an ninh mạng","保安","프로그램, 백신, 유출 방지","개인정보 유출을 철저히 막기 위해 최신 백신 보안 프로그램을 업데이트했다.","Để ngăn chặn rò rỉ dữ liệu cá nhân tôi đã cập nhật phần mềm diệt virus bảo mật mới nhất.",["정보 보안"]),
		("와이파이","n","Danh từ","Mạng Wifi không dây","","비밀번호, 무료, 접속","카페에 들어서자마자 카운터에 적힌 무료 와이파이 비밀번호를 입력하고 접속했다.","Vừa bước vào quán cà phê tôi gõ mật khẩu wifi miễn phí dán ở quầy để kết nối mạng.",["와이파이 공유기"]),
		("인공지능","n","Danh từ","Trí tuệ nhân tạo (AI)","人工知能","기술, 번역, 미래","인공지능 기술의 눈부신 발전으로 실시간 자동 통번역의 정확도가 비약적으로 높아졌다.","Sự tiến bộ của trí tuệ nhân tạo đã nâng độ chính xác của dịch tự động lên tầm cao mới.",["인공지능 기술"])
	]),
	(66,"신문 / 방송 / 출판","Báo chí & Truyền thông & Xuất bản","Truyền thông & Báo chí",[
		("기사","n","Danh từ","Bài báo, tin tức","記事","보도, 읽다, 작성","조간신문 1면에 실린 경제 동향 관련 심층 분석 기사를 흥미롭게 읽었다.","Tôi chăm chú đọc bài báo phân tích chuyên sâu về biến động kinh tế trên trang nhất báo sáng.",["신문 기사"]),
		("취재","n","Danh từ","Tác nghiệp lấy tin, phỏng vấn thực địa","取材","기자, 열기, 보도","사회적 이슈의 진상을 파헤치기 위해 탐사보도 전문 기자가 현장 취재에 나섰다.","Để phơi bày sự thật vấn đề xã hội phóng viên điều tra đã trực tiếp đến tác nghiệp thực địa.",["현장 취재"]),
		("출판사","n","Danh từ","Nhà xuất bản","出版社","원고, 책, 발행","오랜 기간 공들여 집필한 한국어 학습서 원고를 출판사에 정식으로 넘겼다.","Bản thảo sách học tiếng Hàn tâm huyết tôi đã chính thức gửi tới nhà xuất bản.",["출판사 편집부"]),
		("베스트셀러","n","Danh từ","Sách bán chạy (Bestseller)","","등극, 독자, 인기","출간되자마자 독자들의 폭발적인 사랑을 받으며 종합 베스트셀러 1위에 올랐다.","Vừa ra mắt cuốn sách đã được độc giả nồng nhiệt đón nhận leo thẳng lên top 1 sách bán chạy.",["베스트셀러 작가"]),
		("방송사","n","Danh từ","Đài truyền hình, đài phát thanh","放送社","프로그램, 편성, 아나운서","주요 방송사들이 일제히 특별 생방송 뉴스 특보를 편성하여 긴급 송출했다.","Các đài truyền hình lớn đồng loạt phát sóng chương trình bản tin khẩn cấp đặc biệt.",["공영 방송사"])
	]),
	(67,"사건과 사고 1","Sự kiện & Tai nạn 1","Xã hội & Tin tức",[
		("화재","n","Danh từ","Vụ cháy, hỏa hoạn","火災","진압, 소방차, 대피","상가 건물에서 화재가 발생했으나 소방관들의 신속한 진압 덕분에 인명 피해는 없었다.","Xảy ra hỏa hoạn tại khu thương xá nhưng nhờ lính cứu hỏa dập lửa nhanh nên không ai thương vong.",["화재 진압"]),
		("구조","n","Danh từ","Cứu hộ, giải cứu","救助","대원, 신속, 손길","산에서 길을 잃고 조난당한 등산객들을 119 산악구조대가 무사히 구조했다.","Đội cứu nạn 119 đã cứu hộ an toàn nhóm người leo núi bị lạc đường trên đỉnh núi hiểm trở.",["구조 작업"]),
		("목격자","n","Danh từ","Nhân chứng, người nhìn thấy","目擊者","진술, 찾다, 단서","경찰은 뺑소니 사고 현장을 지나가던 목격자의 결정적 진술을 토대로 범인을 체포했다.","Cảnh sát bắt được thủ phạm nhờ lời khai mấu chốt của nhân chứng có mặt tại hiện trường.",["목격자 진술"]),
		("피해","n","Danh từ","Thiệt hại, tổn thất","被害","복구, 입다, 보상","태풍이 휩쓸고 간 농가의 수해 피해를 복구하기 위해 수많은 자원봉사자가 팔을 걷어붙였다.","Nhiều tình nguyện viên đã chung tay giúp bà con vùng lũ khắc phục thiệt hại hoa màu.",["피해를 입다"]),
		("신고","n","Danh từ","Khai báo, báo án","申告","접수, 경찰, 112","수상한 물건을 발견하자마자 지체 없이 경찰서 112에 신고 전화를 걸었다.","Phát hiện đồ vật khả nghi tôi đã lập tức gọi điện báo án cho đường dây nóng cảnh sát 112.",["신고를 접수하다"])
	]),
	(68,"사건과 사고 2","Sự kiện & Tai nạn 2","Xã hội & Tin tức",[
		("사기","n","Danh từ","Lừa đảo, gian lận","詐欺","수법, 주의, 피해자","보이스피싱 전화 사기 수법이 날로 지능화되고 있으니 각별히 유의해야 합니다.","Thủ đoạn lừa đảo qua điện thoại ngày càng tinh vi nên cần hết sức cảnh giác.",["전화 사기"]),
		("도난","n","Danh từ","Mất trộm, trộm cắp","盜難","방지, 신고, 귀중품","인파가 붐비는 관광지에서는 가방과 지갑의 도난 사고에 각별히 주의를 기울이세요.","Ở nơi du lịch đông người cần hết sức cẩn thận kẻo bị trộm mất ví tiền và túi xách.",["도난 방지"]),
		("수사","n","Danh từ","Điều tra phá án","搜査","착수, 경찰, 증거","경찰은 과학수사대를 긴급 투입하여 현장에 남겨진 지문과 증거물을 수집했다.","Cảnh sát điều động đội giám định pháp y tới thu thập dấu vân tay và bằng chứng tại hiện trường.",["수사를 진행하다"]),
		("체포","n","Danh từ","Bắt giữ, bắt giam","逮捕","영장, 범인, 검거","도주 중이던 용의자를 잠복근무 끝에 은신처에서 마침내 긴급 체포했다.","Sau thời gian mật phục cảnh sát đã bắt giữ khẩn cấp kẻ tình nghi tại nơi ẩn náu.",["체포 영장"]),
		("예방","n","Danh từ","Phòng ngừa, ngăn chặn trước","豫防","안전, 수칙, 캠페인","산업재해를 철저히 예방하기 위해 작업장 내 안전모 착용을 의무화했다.","Để phòng ngừa tai nạn lao động việc đội mũ bảo hộ trong công trường được bắt buộc.",["범죄 예방"])
	]),
	(69,"경제 1","Kinh tế 1","Kinh tế & Thị trường",[
		("물가","n","Danh từ","Giá cả thị trường","物價","상승, 안정, 장바구니","국제 유가 급등의 여파로 장바구니 물가가 크게 올라 서민들의 주머니 사정이 팍팍해졌다.","Hệ lụy giá dầu thế giới tăng vọt làm giá cả sinh hoạt leo thang đời sống người dân thêm chật vật.",["물가 상승"]),
		("소비","n","Danh từ","Tiêu dùng, chi tiêu","消費","위축, 패턴, 촉진","내수 경기를 살리기 위해 정부는 지역화폐를 발행하여 시민들의 소비를 촉진하고 있다.","Nhằm kích cầu kinh tế nội địa chính quyền phát hành thẻ tiền tệ địa phương để thúc đẩy tiêu dùng.",["소비 패턴"]),
		("투자","n","Danh từ","Đầu tư","投資","주식, 부동산, 위험","수익률만 좇지 말고 원금 손실의 위험성을 충분히 고려하여 신중한 투자를 해야 한다.","Đừng chỉ mải đuổi theo lợi nhuận mà phải cân nhắc rủi ro để đưa ra quyết định đầu tư sáng suốt.",["투자를 유치하다"]),
		("수출","n","Danh từ","Xuất khẩu","輸出","호조, 반도체, 품목","한국의 대표 수출 품목인 첨단 반도체와 친환경 자동차의 해외 판매가 크게 늘었다.","Mặt hàng xuất khẩu chủ lực bán dẫn và xe thân thiện môi trường của Hàn Quốc tăng trưởng mạnh.",["수출과 수입"]),
		("수입","n","Danh từ","Nhập khẩu, thu nhập","輸入","의존, 원자재, 증가","에너지 자원의 대부분을 해외 수입에 의존하고 있어 절약하는 습관이 절실하다.","Phần lớn tài nguyên năng lượng phụ thuộc vào nhập khẩu nên thói quen tiết kiệm là thiết yếu.",["원자재 수입"])
	]),
	(70,"경제 2","Kinh tế 2","Kinh tế & Thị trường",[
		("환율","n","Danh từ","Tỷ giá hối đoái","換率","변동, 달러, 강세","원화 대비 미국 달러 환율이 가파르게 상승하여 수입 원자재 가격 부담이 커졌다.","Tỷ giá đồng won so với đô la Mỹ tăng cao làm tăng gánh nặng giá nguyên liệu nhập khẩu.",["환율 변동"]),
		("금리","n","Danh từ","Lãi suất ngân hàng","金利","인상, 대출, 예금","중앙은행이 기준 금리를 인상함에 따라 시중 은행들의 대출 이자 부담도 늘어났다.","Ngân hàng trung ương tăng lãi suất cơ bản kéo theo gánh nặng lãi vay tăng theo.",["금리 인상"]),
		("경기","n","Danh từ","Tình hình kinh tế, chu kỳ kinh doanh","景氣","회복, 침체, 부양","세계적인 경기 침체 우려 속에서도 신산업 육성을 통해 돌파구를 마련하고 있다.","Dưới nỗi lo suy thoái kinh tế toàn cầu các ngành công nghiệp mới đang tạo lối thoát.",["경기 회복"]),
		("수익","n","Danh từ","Lợi nhuận, sinh lời","收益","창출, 배당, 극대화","새로운 해외 판로를 개척하여 기업의 연간 영업 수익을 극대화하는 데 성공했다.","Mở rộng thị trường xuất khẩu mới công ty đã tối đa hóa lợi nhuận hoạt động hàng năm.",["수익을 창출하다"]),
		("손실","n","Danh từ","Thua lỗ, tổn thất tài chính","損失","최소화, 발생, 메우다","위기관리 시스템을 가동하여 급격한 시장 변동에 따른 금융 손실을 최소화했다.","Kích hoạt hệ thống quản trị rủi ro giúp hạn chế tối đa các tổn thất tài chính.",["손실을 입다"])
	]),
	(71,"나라 / 법 / 정치","Đất nước, Pháp luật & Chính trị","Chính trị & Xã hội",[
		("헌법","n","Danh từ","Hiến pháp","憲法","수호, 가치, 기본권","헌법 제1조에는 대한민국의 주권은 국민에게 있고 모든 권력은 국민으로부터 나온다고 명시되어 있다.","Điều 1 Hiến pháp nêu rõ chủ quyền thuộc về nhân dân và mọi quyền lực bắt nguồn từ nhân dân.",["헌법 수호"]),
		("선거","n","Danh từ","Bầu cử","選擧","투표, 참정권, 참여","민주주의의 꽃인 국회의원 총선거 날 아침 일찍 투표소를 찾아 소중한 한 표를 행사했다.","Sáng ngày hội bầu cử quốc hội tôi đã đến điểm bỏ phiếu thực thi quyền công dân thiêng liêng.",["선거에 출마하다"]),
		("정부","n","Danh từ","Chính phủ","政府","정책, 수립, 발표","정부는 청년들의 주거 안정을 돕기 위해 파격적인 공공임대주택 정책을 발표했다.","Chính phủ đã công bố gói chính sách nhà ở xã hội ưu đãi lớn nhằm hỗ trợ thanh niên.",["정부 정책"]),
		("법률","n","Danh từ","Pháp luật, đạo luật","法律","제정, 준수, 위반","모든 국민은 법률 앞에 평등하며 정해진 법 규범을 엄격히 준수해야 마땅하다.","Mọi công dân đều bình đẳng trước pháp luật và phải nghiêm chỉnh chấp hành quy định.",["법률을 준수하다"]),
		("민주주의","n","Danh từ","Dân chủ, chế độ dân chủ","民主主義","발전, 시민의식, 실현","성숙한 시민의식과 적극적인 사회 참여는 민주주의를 지탱하는 굳건한 두 기둥이다.","Ý thức công dân trưởng thành và tinh thần dấn thân là hai trụ cột nâng đỡ nền dân chủ.",["자유민주주의"])
	]),
	(72,"언어 1","Ngôn ngữ 1","Ngôn ngữ & Giao tiếp",[
		("발음","n","Danh từ","Phát âm","發音","정확하다, 연습, 억양","원어민의 음성을 반복해서 들으며 부정확했던 한국어 받침 발음을 바르게 교정했다.","Nghe đi nghe lại giọng người bản xứ tôi đã chỉnh sửa chuẩn xác phát âm phụ âm cuối tiếng Hàn.",["발음이 정확하다"]),
		("어휘력","n","Danh từ","Vốn từ vựng, năng lực từ vựng","語彙力","풍부하다, 향상, 독서","다양한 분야의 책을 꾸준히 읽는 것은 어휘력을 풍부하게 넓히는 가장 훌륭한 지름길이다.","Đọc sách đa dạng lĩnh vực là con đường ngắn nhất giúp làm giàu vốn từ vựng phong phú.",["어휘력을 기르다"]),
		("문법","n","Danh từ","Ngữ pháp","文法","규칙, 예문, 적용","기본 문법 규칙을 철저히 익힌 후 다양한 실생활 예문에 적용하며 작문 실력을 키웠다.","Nắm vững quy tắc ngữ pháp nền tảng tôi áp dụng viết câu thực tế để nâng cao trình độ.",["문법에 맞다"]),
		("의사소통","n","Danh từ","Giao tiếp truyền đạt ý kiến","意思疎通","원활하다, 도구, 나누다","언어의 가장 근본적인 목적은 서로의 생각과 감정을 나누는 원활한 의사소통에 있다.","Mục đích cốt lõi nhất của ngôn ngữ là giao tiếp thông suốt sẻ chia tư tưởng tình cảm.",["원활한 의사소통"]),
		("통역","n","Danh từ","Phiên dịch viên (dịch nói)","通譯","동시, 번역, 매끄럽다","국제 정상회담에서 두 정상의 대화를 한 치의 오차도 없이 매끄럽게 동시통역했다.","Tại hội nghị thượng đỉnh anh ấy đã phiên dịch cabin chuẩn xác từng lời của hai nguyên thủ.",["동시통역"])
	]),
	(73,"언어 2","Ngôn ngữ 2","Ngôn ngữ & Giao tiếp",[
		("번역","n","Danh từ","Biên dịch (dịch viết)","飜譯","원작, 매끄럽다, 출간","외국의 유명 고전 문학 작품을 현대 한국어 정서에 맞게 자연스럽게 번역하여 출간했다.","Tác phẩm văn học kinh điển nước ngoài đã được dịch trau chuốt hợp cảm quan hiện đại.",["번역서"]),
		("사투리","n","Danh từ","Tiếng địa phương, phương ngữ","","정겹다, 억양, 쓰다","부산 출신 친구가 쓰는 구수하고 억센 경상도 사투리가 참으로 정겹게 느껴졌다.","Giọng phương ngữ Gyeongsang mộc mạc đặc trưng của người bạn Busan nghe thật thân thương.",["사투리를 쓰다"]),
		("표준어","n","Danh từ","Ngôn ngữ tiêu chuẩn (tiếng chuẩn Seoul)","標準語","사용, 아나운서, 구사","방송 아나운서들은 언제나 명확하고 바른 표준어를 구사하여 뉴스를 전달한다.","Các phát thanh viên đài truyền hình luôn dùng ngôn ngữ chuẩn xác rõ ràng đưa tin tức.",["표준어 구사"]),
		("은어","n","Danh từ","Từ lóng, tiếng lóng","隱語","신조어, 자제, 이해","청소년들 사이에서 유행하는 과도한 은어와 줄임말 사용을 자제하고 고운 말을 쓰자.","Hãy hạn chế dùng từ lóng thái quá và viết tắt nơi giới trẻ để giữ gìn sự trong sáng của tiếng nói.",["은어 사용"]),
		("맞춤법","n","Danh từ","Chính tả, quy tắc viết đúng","맞춤法","지키다, 틀리다, 검사","중요한 공식 서류를 제출하기 전에 맞춤법 검사기를 돌려 오탈자를 꼼꼼히 점검했다.","Trước khi nộp hồ sơ công vụ tôi kiểm tra kỹ bằng công cụ soát lỗi chính tả.",["맞춤법에 맞다"])
	]),
	(74,"인사와 예절","Chào hỏi & Lễ nghi","Văn hóa & Lễ nghi",[
		("존댓말","n","Danh từ","Kính ngữ, lời nói tôn kính","尊댓말","높이다, 쓰다, 반말","윗사람이나 처음 만나는 분과 대화를 나눌 때는 반드시 공손한 존댓말을 써야 합니다.","Khi nói chuyện với bề trên hay người mới gặp lần đầu bắt buộc phải dùng kính ngữ trang trọng.",["존댓말을 쓰다"]),
		("예절","n","Danh từ","Lễ nghi, phép tắc ứng xử","禮節","지키다, 식사, 바르다","식사 자리에서 어른이 수저를 드신 후에 밥을 먹는 것은 한국의 오랜 식사 예절이다.","Đợi người lớn nâng đũa trước rồi mới bắt đầu dùng bữa là nét đẹp lễ nghi ẩm thực truyền thống.",["예절을 지키다"]),
		("인사성","n","Danh từ","Tính hay chào hỏi, tính lễ phép","人事性","밝다, 바르다, 칭찬","엘리베이터에서 이웃을 만날 때마다 밝게 인사하는 아이의 인사성이 칭찬받았다.","Tính cách lễ phép ngoan ngoãn luôn tươi cười chào bà con trong thang máy của bé được khen ngợi.",["인사성이 밝다"]),
		("악수","n","Danh từ","Bắt tay","握手","청하다, 나누다, 비즈니스","비즈니스 파트너와 미팅을 마치고 상호 신뢰를 다짐하며 굳건한 악수를 나누었다.","Kết thúc cuộc họp kinh doanh chúng tôi đã siết chặt tay nhau thể hiện sự tin cậy.",["악수를 청하다"]),
		("절","n","Danh từ","Lạy, vái lạy (lễ bái truyền thống)","","올리다, 세배, 명절","설날 아침에 온 가족이 모여 한복을 곱게 차려입고 웃어른께 정성스레 세배 절을 올렸다.","Sáng mùng một Tết cả nhà diện Hanbok trang trọng vái lạy chúc thọ các bậc cao niên.",["절을 올리다"])
	]),
	(75,"전통과 역사","Truyền thống & Lịch sử","Văn hóa & Lịch sử",[
		("유적지","n","Danh từ","Di tích lịch sử","遺跡地","탐방, 보존, 고대","천년 고도 경주를 방문하여 조상들의 숨결이 깃든 찬란한 역사 유적지를 둘러보았다.","Đến thăm cố đô Gyeongju ngàn năm tôi đã dạo bước ngắm nhìn các di tích lịch sử rực rỡ.",["역사 유적지"]),
		("문화재","n","Danh từ","Di sản văn hóa","文化財","보호, 지정, 국보","선조들이 물려준 소중한 문화재를 훼손하지 않고 온전히 보존하여 후손에게 물려주자.","Hãy bảo tồn nguyên vẹn di sản văn hóa tổ tiên để lại trao truyền lại cho con cháu mai sau.",["지정 문화재"]),
		("한옥","n","Danh từ","Nhà truyền thống Hàn Quốc (Hanok)","韓屋","마을, 기와, 체험","전주 한옥마을의 고즈넉한 온돌방에서 하룻밤 머물며 전통 한옥의 정취를 만끽했다.","Nghỉ đêm tại gian phòng sưởi ở làng cổ Jeonju tôi đã tận hưởng trọn vẹn phong vị nhà Hanok xưa.",["한옥 마을"]),
		("명절","n","Danh từ","Ngày lễ tết cổ truyền","名節","풍습, 추석, 설날","한국의 최대 명절인 추석에는 온 가족이 모여 햇곡식으로 송편을 빚으며 정을 나눈다.","Dịp Tết Trung thu lớn nhất cả nhà sum vầy cùng nặn bánh Songpyeon từ gạo mới.",["전통 명절"]),
		("선조","n","Danh từ","Tổ tiên, tiền nhân","先祖","지혜, 물려받다, 얼","자연과 조화를 이루며 살아가고자 했던 옛 선조들의 깊은 지혜를 본받아야 합니다.","Chúng ta cần noi theo trí tuệ sâu sắc của các bậc tiền nhân ngày xưa sống chan hòa với thiên nhiên.",["선조들의 지혜"])
	]),
	(76,"식물과 동물","Thực vật & Động vật","Thiên nhiên & Sinh vật",[
		("야생동물","n","Danh từ","Động vật hoang dã","野生動物","보호, 서식지, 멸종","밀렵과 서식지 파괴로 인해 멸종 위기에 처한 야생동물을 보호하는 정책이 시급하다.","Chính sách bảo vệ động vật hoang dã đứng trước nguy cơ tuyệt chủng là việc cấp bách.",["야생동물 보호구역"]),
		("반려동물","n","Danh từ","Thú cưng, động vật bầu bạn","伴侶動物","키우다, 산책, 가족","반려동물을 단순한 애완동물이 아닌 한 가족 구성원으로 존중하고 사랑해 주어야 한다.","Cần trân trọng và yêu thương thú cưng như một thành viên thực thụ trong gia đình.",["반려동물 인구"]),
		("생태계","n","Danh từ","Hệ sinh thái","生態系","보존, 파괴, 균형","자연 생태계의 먹이사슬 균형이 깨지지 않도록 환경 보존 활동에 적극 동참합시다.","Hãy chung tay bảo vệ môi trường để chuỗi thức ăn hệ sinh thái không bị phá vỡ.",["생태계 복원"]),
		("식물원","n","Danh từ","Vườn bách thảo, vườn thực vật","植物園","온실, 희귀식물, 관람","세계 각지의 희귀 식물들이 모여 있는 대형 유리온실 식물원을 여유롭게 둘러보았다.","Tôi thong thả tham quan nhà kính thực vật trưng bày các loài thảo mộc quý hiếm khắp thế giới.",["국립 식물원"]),
		("재배하다","v","Động từ","Trồng trọt, canh tác gieo trồng","栽培","유기농, 채소, 수확","주말 농장에서 농약을 전혀 쓰지 않고 유기농으로 신선한 상추와 방울토마토를 재배했다.","Tại trang trại cuối tuần tôi tự tay trồng rau xà lách và cà chua bi hoàn toàn hữu cơ.",["유기농 재배"])
	]),
	(77,"자연과 경치","Thiên nhiên & Cảnh đẹp","Thiên nhiên & Du lịch",[
		("절경","n","Danh từ","Tuyệt cảnh, cảnh đẹp tuyệt trần","絶景","감탄, 빼어나다, 바다","해안 절벽 위에서 내려다본 푸른 바다의 풍경은 그야말로 숨이 멎을 듯한 절경이었다.","Từ vách đá ven biển nhìn xuống cảnh sắc biển xanh biếc quả thực là một tuyệt cảnh nghẹt thở.",["빼어난 절경"]),
		("단풍","n","Danh từ","Lá đỏ mùa thu, lá phong chuyển màu","丹楓","물들다, 구경, 설악산","가을이 깊어가자 설악산 전체가 울긋불긋 화려한 단풍 옷으로 곱게 갈아입었다.","Thu sang cả vùng núi Seorak rực rỡ thay màu áo mới bởi những thảm lá đỏ lá vàng.",["단풍놀이"]),
		("일출","n","Danh từ","Bình minh, mặt trời mọc","日出","감상, 동해, 새해","새해 첫날 동해 바다 수평선 위로 솟아오르는 붉은 일출을 보며 소원을 빌었다.","Sáng mùng một Tết ngắm mặt trời đỏ rực nhô lên từ biển đông tôi đã gửi gắm điều ước.",["일출 명소"]),
		("노을","n","Danh từ","Hoàng hôn, ráng chiều","","붉다, 지다, 서쪽 하늘","해 질 무렵 서쪽 하늘을 붉고 은은하게 물들이는 저녁 노을이 너무나 아름다웠다.","Lúc chạng vạng ráng chiều nhuộm đỏ rực cả khung trời phía tây đẹp tựa bức tranh.",["저녁 노을"]),
		("폭포","n","Danh từ","Thác nước","瀑布","시원하다, 떨어지다, 소리","깎아지른 절벽 사이로 거센 물줄기가 쏟아져 내리는 폭포 소리가 가슴을 뻥 뚫어 준다.","Tiếng thác nước dội ầm ầm từ vách đá cheo leo làm lòng ta khoan khoái nhẹ nhõm.",["시원한 폭포"])
	]),
	(78,"환경 / 종교","Môi trường & Tôn giáo","Môi trường & Xã hội",[
		("온실가스","n","Danh từ","Khí thải nhà kính","溫室가스","배출, 감축, 지구온난화","지구온난화를 막기 위해 전 세계 국가들이 온실가스 배출 감축 목표에 합의했다.","Để ngăn chặn trái đất nóng lên các quốc gia đã thống nhất chỉ tiêu cắt giảm khí nhà kính.",["온실가스 감축"]),
		("재활용","n","Danh từ","Tái chế, tái sử dụng","再活用","분리수거, 자원, 실천","일회용품 사용을 줄이고 재활용을 철저히 실천하는 생활 습관이 지구를 지킵니다.","Giảm dùng đồ một lần và phân loại rác tái chế là thói quen giúp bảo vệ hành tinh xanh.",["자원 재활용"]),
		("오염","n","Danh từ","Ô nhiễm","汚染","수질, 대기, 방지","공장 폐수로 인한 하천 수질 오염을 방지하기 위해 엄격한 정화 시설을 설치했다.","Để ngăn ô nhiễm nguồn nước do nước thải công nghiệp cơ sở xử lý đã được lắp đặt.",["대기 오염"]),
		("신앙","n","Danh từ","Đức tin, tín ngưỡng tôn giáo","信仰","생활, 자유, 기도","삶의 고난과 시련 앞에서도 깊은 신앙심을 바탕으로 마음의 평화를 유지했다.","Đứng trước sóng gió cuộc đời nhờ đức tin sâu sắc người ta vẫn giữ được an yên trong tâm hồn.",["신앙 생활"]),
		("자비","n","Danh từ","Lòng từ bi, nhân ái khoan dung","慈悲","베풀다, 가르침, 사랑","어려운 이웃들에게 따뜻한 자비와 사랑의 손길을 베풀며 나눔을 몸소 실천했다.","Trao gửi tình yêu và lòng từ bi nhân ái tới hoàn cảnh khó khăn tôi đã chung tay sẻ chia.",["자비를 베풀다"])
	]),
	(79,"기분","Tâm trạng & Cảm xúc","Cảm xúc & Tâm lý",[
		("상쾌하다","adj","Tính từ","Sảng khoái, tươi tỉnh thư thái","爽快","아침, 공기, 산책","맑은 아침 공기를 들이마시며 숲속을 걸으니 몸과 마음이 날아갈 듯 상쾌하다.","Hít căng lồng ngực bầu không khí buổi sớm mai tản bộ trong rừng thấy khoan khoái diệu kỳ.",["상쾌한 아침"]),
		("답답하다","adj","Tính từ","Bí bách, ngột ngạt ngột ngạt trong lòng","","마음, 공기, 속","일이 생각대로 잘 풀리지 않고 꼬여서 가슴이 꽉 막힌 듯 답답하기만 했다.","Công việc không suôn sẻ như ý muốn làm lồng ngực bí bách nặng trĩu ngột ngạt.",["마음이 답답하다"]),
		("유쾌하다","adj","Tính từ","Hài hước, dí dỏm vui vẻ khoái chí","愉快","성격, 대화, 웃음","그의 재치 넘치는 유머와 유쾌한 웃음소리는 언제나 주변 사람들을 즐겁게 만든다.","Sự dí dỏm cùng tiếng cười giòn tan của anh ấy luôn mang lại niềm vui cho mọi người.",["유쾌한 성격"]),
		("우울하다","adj","Tính từ","Buồn rầu, ủ rũ u uất","憂鬱","날씨, 기분, 극복","흐리고 비 오는 날이 계속되자 기분이 괜히 우울해져서 신나는 음악을 틀었다.","Những ngày mưa rả rích kéo dài làm lòng chùng xuống buồn rầu tôi bèn bật nhạc vui lên nghe.",["우울한 기분"]),
		("짜증","n","Danh từ","Cáu gắt, bực bội khó chịu","","내다, 솟다, 피로","무더운 날씨에 차까지 막혀 나도 모르게 불쑥 짜증이 솟구쳤지만 심호흡으로 달랬다.","Trời vừa nóng vừa kẹt xe làm cơn bực bội trào lên nhưng tôi đã hít thở sâu trấn tĩnh lại.",["짜증을 내다"])
	])
]
print(f"Loaded vocab part 3: {len(units_raw)} units")
