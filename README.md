# English Learning App

## Giới thiệu

English Learning App là ứng dụng học tiếng Anh được xây dựng bằng Flutter, kết hợp Firebase và backend AI để hỗ trợ người học luyện tập theo nhiều hình thức khác nhau. Ứng dụng không chỉ có phần học cơ bản như từ vựng và quiz, mà còn mở rộng sang 4 kỹ năng `Listening`, `Speaking`, `Reading`, `Writing`, kèm chatbot AI và hệ thống quản trị nội dung cho admin.

Dự án hiện gồm 2 phần chính:

- `flutter_application_1/`: ứng dụng Flutter cho người học và quản trị viên
- `AI_backend/`: backend FastAPI dùng để chấm bài nói, chấm bài viết và trả lời chat AI

## Chức năng chính của ứng dụng

### 1. Chức năng dành cho người học

#### Đăng ký, đăng nhập và phân quyền

- Đăng ký tài khoản bằng email và mật khẩu
- Đăng nhập bằng Firebase Authentication
- Sau khi đăng nhập, hệ thống đọc thông tin người dùng trong Firestore để xác định vai trò `user` hoặc `admin`
- Điều hướng sang giao diện phù hợp theo vai trò người dùng

#### Trang chủ học tập

- Hiển thị lời chào theo tài khoản đang đăng nhập
- Tải tiến độ học tập từ Firestore
- Hiển thị thanh tiến độ tổng quan số bài đã hoàn thành
- Điều hướng nhanh đến các nhóm kỹ năng và danh mục học tập

#### Học từ vựng

- Tìm kiếm từ vựng trong bộ dữ liệu mặc định và bộ từ vựng do người dùng tự tạo
- Hiển thị lịch sử tìm kiếm gần đây
- Tạo bộ từ vựng cá nhân
- Xem chi tiết từng chủ đề từ vựng
- Hiển thị từ tiếng Anh, nghĩa tiếng Việt, ảnh minh họa và audio phát âm nếu dữ liệu có sẵn

#### Flashcard và Quiz

- Hiển thị danh sách các bộ quiz từ Firestore
- Theo dõi tiến độ từng quiz của từng người dùng
- Làm bài trắc nghiệm nhiều câu hỏi
- Chấm điểm ngay sau khi hoàn thành
- Lưu kết quả vào:
  - `users/{uid}/progress` để theo dõi tiến độ cá nhân
  - `user_progress` để admin thống kê
  - `logs` để lưu nhật ký hoạt động

#### Luyện kỹ năng Listening

- Hiển thị danh sách chủ đề nghe
- Mỗi chủ đề gồm ảnh, audio và bộ câu hỏi trắc nghiệm
- Cho phép phát hoặc dừng audio
- Người học chọn đáp án và nộp bài
- Hệ thống tính điểm, hiển thị kết quả và lưu tiến độ
- Có hiệu ứng chúc mừng khi đạt kết quả tốt

#### Luyện kỹ năng Reading

- Hiển thị danh sách chủ đề đọc
- Mỗi chủ đề gồm đoạn văn và các câu hỏi đi kèm
- Người học đọc bài, chọn đáp án và nộp bài
- Hệ thống tự chấm điểm, lưu log và lưu kết quả vào Firestore

#### Luyện kỹ năng Speaking có AI chấm điểm

- Hiển thị danh sách chủ đề nói và các câu hỏi gợi ý
- Cho phép ghi âm trực tiếp trong ứng dụng
- Có thể nghe lại bản ghi âm trước khi nộp
- Gửi file ghi âm sang backend FastAPI
- Backend dùng Gemini để đánh giá các tiêu chí như:
  - độ trôi chảy
  - phát âm
  - ngữ pháp
  - mức độ phù hợp nội dung
- Hiển thị kết quả đánh giá và lưu lịch sử luyện tập

#### Luyện kỹ năng Writing có AI chấm điểm

- Hiển thị chủ đề viết và các câu hỏi gợi ý
- Người học nhập bài viết trực tiếp trong ứng dụng
- Gửi nội dung bài viết sang backend AI để chấm
- Backend đánh giá theo các tiêu chí như:
  - grammar
  - vocabulary
  - coherence
  - task achievement
- Trả về nhận xét ngắn và lưu lịch sử làm bài

#### ChatBox AI hỗ trợ học tiếng Anh

- Gửi câu hỏi tự do về từ vựng, ngữ pháp, idiom, cách viết hoặc cách phát âm
- Backend AI trả lời theo vai trò gia sư tiếng Anh
- Có sẵn các câu gợi ý để người dùng bắt đầu nhanh

#### Theo dõi tiến độ học tập

- Hiển thị phần trăm hoàn thành quiz bằng biểu đồ tròn
- Thống kê số bài đã luyện theo từng kỹ năng
- Có thể kéo để tải lại dữ liệu mới nhất

#### Hồ sơ cá nhân

- Hiển thị thông tin người dùng đang đăng nhập
- Thống kê số quiz và số bài kỹ năng đã thực hiện
- Hiển thị ngày tham gia
- Hỗ trợ đổi mật khẩu
- Hỗ trợ bật hoặc tắt giao diện tối
- Đăng xuất tài khoản

### 2. Chức năng dành cho quản trị viên

#### Dashboard quản trị

- Hiển thị khu vực điều hướng tới các chức năng quản lý
- Thống kê số người dùng và số quiz
- Hiển thị biểu đồ tăng trưởng người dùng trong 3 tháng gần nhất
- Hiển thị nhật ký hoạt động mới nhất của hệ thống

#### Quản lý từ vựng

- Thêm chủ đề từ vựng mới
- Sửa tên và mô tả chủ đề
- Xóa chủ đề từ vựng
- Tìm kiếm chủ đề
- Đi sâu vào từng chủ đề để quản lý nội dung chi tiết

#### Quản lý quiz

- Thêm quiz mới
- Cập nhật quiz hiện có
- Xóa quiz
- Tìm kiếm quiz theo tiêu đề

#### Quản lý nội dung 4 kỹ năng

- Quản lý riêng từng nhóm `Listening`, `Speaking`, `Reading`, `Writing`
- Thêm, sửa, xóa topic trong từng kỹ năng
- Thêm, sửa, xóa nội dung con:
  - bài đọc và câu hỏi cho `Reading`
  - audio và transcript cho `Listening`
  - prompt và tips cho `Speaking`
  - prompt và tips cho `Writing`

#### Quản lý người dùng

- Xem danh sách người dùng có role `user`
- Tìm kiếm người dùng theo tên hoặc email
- Xem tiến độ trung bình
- Hiển thị top 3 người dùng có điểm trung bình cao nhất
- Xóa người dùng khỏi Firestore

#### Báo cáo và nhật ký

- Xem tổng số lượt làm bài
- Xem số lượng người dùng tham gia
- Xem điểm trung bình
- Xem biểu đồ kết quả theo ngày trong tuần
- Lọc nhật ký theo từ khóa và theo khoảng thời gian

#### Cài đặt quản trị

- Bật hoặc tắt dark mode
- Bật hoặc tắt thông báo nội bộ
- Đổi mật khẩu
- Đăng xuất

#### Cloud Function hỗ trợ tạo tài khoản có role

Trong thư mục `functions/` có Cloud Function `createUserWithRole` dùng để:

- kiểm tra người gọi có phải admin hay không
- tạo tài khoản mới trong Firebase Authentication
- lưu thông tin và role vào Firestore

## Công nghệ sử dụng

### Frontend mobile / desktop

- `Flutter`
- `Dart`
- `Material 3`

### Firebase

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `Firebase Cloud Functions`

### Backend AI

- `FastAPI`
- `Uvicorn`
- `python-multipart`
- `google-generativeai`
- `Gemini`

### Các package Flutter nổi bật

- `http`: gọi API tới backend AI
- `record`: ghi âm cho bài speaking
- `audioplayers`: phát audio luyện nghe và nghe lại bản ghi
- `percent_indicator`: hiển thị phần trăm tiến độ
- `fl_chart`: vẽ biểu đồ thống kê cho admin
- `confetti`: hiệu ứng chúc mừng khi đạt kết quả tốt
- `intl`: định dạng thời gian trong báo cáo

## Cấu trúc thư mục

```text
flutter_application_1/
|-- lib/
|   |-- admin/              # Màn hình quản trị
|   |-- core/route/         # Định nghĩa route
|   |-- screens/            # Login, register, layout chính
|   |-- state/              # Màn hình học tập, profile, progress, AI chat
|   |-- data/               # Dữ liệu seed mẫu
|   `-- config/             # Cấu hình Firebase
|-- functions/              # Firebase Cloud Functions
|-- firebase.json
|-- firestore.rules
`-- pubspec.yaml

AI_backend/
|-- main.py                 # API chấm speaking, writing và chat AI
`-- requirements.txt
```

## Yêu cầu trước khi cài đặt

- Flutter SDK tương thích với `Dart SDK ^3.9.0`
- Python 3.10 trở lên
- Android Studio hoặc VS Code + Flutter extension
- Thiết bị Android Emulator hoặc máy thật
- Tài khoản Firebase để cấu hình Authentication và Firestore
- API key Gemini để backend AI hoạt động

## Hướng dẫn cài đặt và chạy dự án

### 1. Cài dependency cho Flutter app

Mở terminal tại thư mục app:

```powershell
cd f:\EnglishApp\flutter_application_1
flutter pub get
```

### 2. Cấu hình Firebase

Dự án hiện đã có sẵn các file cấu hình Firebase trong repo, nhưng nếu bạn chạy bằng project Firebase của riêng mình thì nên cấu hình lại:

- cập nhật `android/app/google-services.json`
- cập nhật `lib/config/firebase_options.dart`
- bật `Authentication` với phương thức Email/Password
- tạo Firestore Database

Nếu cần cấu hình lại bằng FlutterFire CLI:

```powershell
dart pub global activate flutterfire_cli
flutterfire configure
```

Lưu ý quan trọng:

- File `firestore.rules` hiện đang chứa rule mẫu có hạn đến ngày `2025-11-16`
- Ngày hiện tại của môi trường này là `2026-04-09`, nên nếu bạn dùng đúng rule đó thì Firestore sẽ bị từ chối truy cập
- Bạn cần cập nhật lại security rules trước khi chạy thực tế

### 3. Cài backend AI

Mở terminal khác tại thư mục backend:

```powershell
cd f:\EnglishApp\AI_backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 4. Cấu hình Gemini API key

Trong file `AI_backend/main.py`, backend đang gọi Gemini để:

- chấm bài nói
- chấm bài viết
- trả lời chat AI

Hiện tại code đang cấu hình API key trực tiếp trong file nguồn. Trước khi chạy thực tế, bạn nên thay bằng API key của mình hoặc chuyển sang đọc từ biến môi trường để an toàn hơn.

### 5. Chạy backend FastAPI

```powershell
cd f:\EnglishApp\AI_backend
.\.venv\Scripts\Activate.ps1
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Khi backend chạy thành công, các API chính sẽ sẵn sàng tại:

- `POST /chat/`
- `POST /evaluate-speaking/`
- `POST /evaluate-writing/`

### 6. Chạy ứng dụng Flutter

Mở terminal mới:

```powershell
cd f:\EnglishApp\flutter_application_1
flutter run
```

### 7. Lưu ý khi chạy trên emulator hoặc máy thật

Code Flutter hiện đang gọi backend bằng địa chỉ:

- `http://10.0.2.2:8000/chat/`
- `http://10.0.2.2:8000/evaluate-speaking/`
- `http://10.0.2.2:8000/evaluate-writing/`

`10.0.2.2` chỉ phù hợp với Android Emulator. Nếu bạn chạy trên:

- máy thật: đổi sang IP LAN của máy đang chạy backend
- iOS simulator: thường có thể dùng `http://127.0.0.1:8000`

Các vị trí cần chỉnh URL backend:

- `lib/state/ai_chat_screen.dart`
- `lib/state/skills/speaking_detail_screen.dart`
- `lib/state/skills/writing_detail_screen.dart`

### 8. Tùy chọn chạy Firebase Cloud Functions

Nếu bạn muốn dùng Cloud Function tạo user theo role:

```powershell
cd f:\EnglishApp\flutter_application_1\functions
npm install
firebase emulators:start --only functions
```

Hoặc deploy:

```powershell
firebase deploy --only functions
```

## Luồng hoạt động tổng quát

1. Người dùng đăng ký hoặc đăng nhập bằng Firebase Authentication.
2. Ứng dụng đọc dữ liệu người dùng trong Firestore để phân quyền.
3. Người học làm quiz, học từ vựng hoặc luyện 4 kỹ năng.
4. Kết quả được lưu vào Firestore để hiển thị tiến độ và phục vụ thống kê.
5. Với speaking, writing và chat AI, Flutter gửi request sang backend FastAPI.
6. Backend dùng Gemini để xử lý và trả kết quả về cho ứng dụng.

## Gợi ý cải thiện thêm trong tương lai

- Chuyển API key sang biến môi trường
- Tách URL backend ra file cấu hình môi trường
- Viết security rules chặt chẽ hơn cho Firestore
- Bổ sung test cho các luồng quan trọng
- Chuẩn hóa `requirements.txt` và cấu hình backend theo môi trường dev/prod

## Tác giả

Dự án được xây dựng như một ứng dụng hỗ trợ học tiếng Anh với định hướng kết hợp học truyền thống, luyện kỹ năng và hỗ trợ từ AI trong cùng một nền tảng.
