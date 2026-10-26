# Web App Học Tiếng Hàn TOPIK 2300 (Mind Map TOPIK Vocabulary)

Ứng dụng web học từ vựng tiếng Hàn trung cấp được xây dựng dựa trên giáo trình **마인드맵으로 배우는 토픽 어휘 2300** (Mind Map TOPIK Vocabulary 2300 by Han Hoo-young, Jeong Bo-young).

## Tính năng chính

### 1. Phân hệ học từ vựng theo Unit
- Danh sách 75 Unit bài học tương ứng 80 Day trong sách, phân loại theo chủ đề đời sống, cảm xúc, công sở, giao thông, ẩm thực, văn hóa.
- Lưu trữ trạng thái học tập chi tiết (đã học xong, đang học dở, chưa học) và số từ đã nắm vững thông qua LocalStorage.
- Tìm kiếm từ khóa và lọc nhanh theo danh mục hoặc trạng thái tiến độ.

### 2. Thẻ học từ vựng tương tác (Flashcard)
- Hiển thị từ vựng tiếng Hàn, loại từ (danh từ, động từ, tính từ, phó từ), nghĩa tiếng Việt và chữ Hán tương ứng.
- Nút loa phát âm giọng Seoul chuẩn bản xứ (Web Speech API) với tùy chọn tốc độ đọc (1.0x chuẩn hoặc 0.8x chậm).
- Khung luyện đặt câu: Cung cấp từ gợi ý, kiểm tra ngữ pháp tiếng Hàn tự động (trợ từ 은/는, 이/가, 을/를, đuôi câu vị ngữ), chỉ rõ lỗi sai kèm câu mẫu chuẩn trích xuất từ sách.
- Nút điều hướng chuyển tiếp (đánh dấu đã học) và quay lại từ trước đó.

### 3. Bài kiểm tra củng cố định kỳ (Mini-Quiz)
- Tự động kích hoạt sau mỗi 5 từ học xong trong Unit.
- Kiểm tra tối đa 10 từ học gần nhất: hiển thị nghĩa tiếng Việt, yêu cầu gõ từ tiếng Hàn tương ứng.
- Tích hợp nút Micro thu âm giọng đọc của người dùng bằng MediaRecorder và nhận diện giọng nói (Speech Recognition).
- Đánh giá độ chính xác chữ viết và phát âm: nếu sai hiển thị đáp án chuẩn, cho phép nghe lại phát âm mẫu và nghe lại chính bản ghi âm của người học để đối chiếu.

### 4. Kết thúc Unit
- Màn hình chúc mừng hoàn thành và tự động quay lại danh sách bài học sau 3 giây.

### 5. Phân hệ làm đề thi
- Mục luyện giải đề thi thử TOPIK I và TOPIK II. Hiện tại hiển thị trạng thái đang cập nhật ("Hiện tại chưa có đề nào").

## Cấu trúc thư mục
```
hoc_tieng_han/
├── index.html         # Giao diện chính
├── css/
│   └── main.css       # Toàn bộ định dạng giao diện
├── js/
│   ├── data.js        # Dữ liệu từ vựng 75 Unit từ sách TOPIK 2300
│   ├── storage.js     # Quản lý tiến độ học tập và LocalStorage
│   ├── grammar.js     # Bộ kiểm tra và phân tích ngữ pháp tiếng Hàn
│   ├── audio.js       # Bộ xử lý âm thanh phát âm và thu âm micro
│   └── app.js         # Logic điều hướng và tương tác người dùng
├── sach/              # File PDF sách gốc
├── de/                # Thư mục lưu trữ đề thi cập nhật sau này
└── scripts/           # Các script trích xuất và xử lý dữ liệu
```
