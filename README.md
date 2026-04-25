# Flutter Weather app 

Ứng dụng dự báo thời tiết di động được xây dựng bằng Flutter, cung cấp thông tin thời tiết chi tiết cho người dùng với giao diện đẹp mắt và hiện đại.

## Tính năng chính

- Xem thời tiết hiện tại theo vị trí GPS hoặc tìm kiếm thành phố
- Dự báo thời tiết 5 ngày với thông tin chi tiết cho từng giờ
- Dự báo từng giờ trong 24 giờ tới
- Chuyển đổi giữa đơn vị nhiệt độ (Celsius/Fahrenheit)
- Lưu trữ lịch sử tìm kiếm thành phố
- Kiểm tra kết nối mạng và lưu bộ đệm dữ liệu

## Công nghệ sử dụng

- Framework: Flutter 3.41.6
- Ngôn ngữ: Dart 3.11.4
- API: OpenWeatherMap API
- Quản lý trạng thái: Provider 6.1.1
- Quản lý vị trí: Geolocator 10.1.0
- Định địa chỉ: Geocoding 2.1.1
- Lưu trữ cục bộ: SharedPreferences 2.2.2
- Kiểm tra kết nối: Connectivity Plus 5.0.2
- Kiểm thử: Flutter Test

## Yêu cầu hệ thống

- Flutter SDK: ^3.11.4
- Dart SDK: ^3.11.4
- Android: Phiên bản 6.0 trở lên
- iOS: Phiên bản 12.0 trở lên
- Windows: Phiên bản 10 trở lên
- macOS: Phiên bản 10.14 trở lên
- Linux: Ubuntu 20.04 hoặc tương đương

## Thiết lập dự án

### 1. Lấy khóa API từ OpenWeatherMap

1. Truy cập trang web OpenWeatherMap (https://openweathermap.org/api)
2. Đăng ký tài khoản miễn phí
3. Vào phần "API keys" trong tài khoản của bạn
4. Sao chép khóa API mặc định

### 2. Cấu hình khóa API

Tạo file `.env` trong thư mục gốc của dự án:

```
OPENWEATHER_API_KEY=your_api_key_here
```

Thay phần `your_api_key_here` bằng khóa API thực của bạn. File `.env` đã được thêm vào `.gitignore` nên sẽ không bị đẩy lên GitHub.

### 3. Cài đặt dependencies

```bash
flutter pub get
```

### 4. Chạy ứng dụng

```bash
flutter run
```

### 5. Chạy tests

```bash
flutter test test/weather_service_test.dart
```

## Screenshots

Screenshot dưới đây hiển thị các tính năng chính của ứng dụng:

### Thời tiết quang đãng
<img width="597" height="888" alt="image" src="https://github.com/user-attachments/assets/f342b48e-1dc6-4010-aa28-12c26ed2fad6" />


### Thời tiết có mưa
<img width="597" height="881" alt="image" src="https://github.com/user-attachments/assets/3fd361f2-5576-41f3-bed8-23a40f7d9a01" />

### Thời tiết có mây
<img width="597" height="885" alt="image" src="https://github.com/user-attachments/assets/a03cd73a-7614-45f7-b25b-b1cbb3031092" />

### Chế độ tối
Ứng dụng hỗ trợ chế độ tối tự động theo cài đặt hệ thống.

### Màn hình tìm kiếm
<img width="601" height="898" alt="image" src="https://github.com/user-attachments/assets/ee3d8c7b-cbb9-4b46-8a90-edab8af6d929" />

### Màn hình dự báo
Hiển thị dự báo chi tiết cho 5 ngày tới với thông tin nhiệt độ, độ ẩm và khả năng mưa.
<img width="603" height="890" alt="image" src="https://github.com/user-attachments/assets/8623bbcc-ffe5-44bb-b355-33af48cfbfa1" />

### Trạng thái lỗi
s<img width="599" height="893" alt="image" src="https://github.com/user-attachments/assets/e7fcae98-4425-414b-8e4e-e46e59a833aa" />


### Trạng thái loading
<img width="597" height="887" alt="image" src="https://github.com/user-attachments/assets/1f437c89-dbc2-4ce8-9303-a9e4bf4387f9" />

## Hướng dẫn sử dụng

1. Mở ứng dụng, ứng dụng sẽ yêu cầu quyền truy cập vị trí
2. Cho phép quyền truy cập GPS để ứng dụng lấy vị trị hiện tại
3. Màn hình chính sẽ hiển thị thời tiết tại vị trí của bạn
4. Nhấn vào nút tìm kiếm để tìm kiếm thành phố khác
5. Vào phần cài đặt để thay đổi đơn vị nhiệt độ

## Kiểm thử

Ứng dụng đi kèm với 40 unit tests bao gồm:

- Kiểm thử phân tích JSON của các model thời tiết
- Kiểm thử định dạng ngày tháng
- Kiểm thử ánh xạ biểu tượng thời tiết
- Kiểm thử xác thực dữ liệu
- Kiểm thử phân tích timestamp Unix

Để chạy các test:

```bash
flutter test test/weather_service_test.dart
```

## Acknowledgments

- OpenWeatherMap API cung cấp dữ liệu thời tiết
- Flutter team để tạo ra framework tuyệt vời này
- Material Design cho các nguyên tắc thiết kế UI/UX
