# Ứng dụng Thời tiết Flutter

Ứng dụng dự báo thời tiết di động được xây dựng bằng Flutter, cung cấp thông tin thời tiết chi tiết cho người dùng với giao diện đẹp mắt và hiện đại.

## Tính năng chính

- Xem thời tiết hiện tại theo vị trí GPS hoặc tìm kiếm thành phố
- Dự báo thời tiết 5 ngày với thông tin chi tiết cho từng giờ
- Dự báo từng giờ trong 24 giờ tới
- Chuyển đổi giữa đơn vị nhiệt độ (Celsius/Fahrenheit)
- Lưu trữ lịch sử tìm kiếm thành phố
- Hỗ trợ chế độ tối/sáng theo hệ thống
- Kiểm tra kết nối mạng và lưu bộ đệm dữ liệu
- Giao diện đáp ứng tương thích với các thiết bị có kích thước khác nhau

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
# Trên thiết bị Android hoặc iOS
flutter run

# Trên nền tảng cụ thể
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d macos
flutter run -d linux
flutter run -d chrome
```

### 5. Chạy tests

```bash
flutter test test/weather_service_test.dart
```

## Screenshots

Screenshot dưới đây hiển thị các tính năng chính của ứng dụng:

### Thời tiết quang đãng
Màn hình chính hiển thị thời tiết mặt trời, nhiệt độ hiện tại và dự báo theo giờ.

### Thời tiết có mưa
Màn hình chính khi có mưa, hiển thị thông tin lượng mưa và độ ẩm.

### Thời tiết có mây
Màn hình chính khi có mây, nhận dạng tình trạng thời tiết đám mây.

### Chế độ tối
Ứng dụng hỗ trợ chế độ tối tự động theo cài đặt hệ thống.

### Màn hình tìm kiếm
Người dùng có thể tìm kiếm thành phố bằng tên để xem thời tiết địa phương.

### Màn hình dự báo
Hiển thị dự báo chi tiết cho 5 ngày tới với thông tin nhiệt độ, độ ẩm và khả năng mưa.

### Trạng thái lỗi
Khi có lỗi (không có kết nối, thành phố không tìm thấy), ứng dụng hiển thị thông báo lỗi rõ ràng.

### Trạng thái loading
Khi đang tải dữ liệu, ứng dụng hiển thị shimmer effect để cho biết là đang xử lý.

## Hướng dẫn sử dụng

1. Mở ứng dụng, ứng dụng sẽ yêu cầu quyền truy cập vị trí
2. Cho phép quyền truy cập GPS để ứng dụng lấy vị trị hiện tại
3. Màn hình chính sẽ hiển thị thời tiết tại vị trí của bạn
4. Nhấn vào nút tìm kiếm để tìm kiếm thành phố khác
5. Kéo xuống để tải lại dữ liệu thời tiết
6. Vào phần cài đặt để thay đổi đơn vị nhiệt độ

## Các hạn chế đã biết

- Ứng dụng yêu cầu kết nối Internet để lấy dữ liệu thời tiết mới
- API miễn phí của OpenWeatherMap có giới hạn 1000 lần gọi API mỗi ngày
- Dự báo theo giờ chỉ hiển thị 24 giờ tới
- Ứng dụng lưu bộ đệm dữ liệu nhưng sẽ cũ nếu không có kết nối mạng
- Vị trí GPS có thể mất một chút thời gian để lấy tọa độ chính xác
- Trên một số thiết bị, quyền tiếp cận vị trị có thể bị từ chối

## Những cải tiến trong tương lai

- Thêm tính năng thông báo cảnh báo thời tiết nguy hiểm
- Tích hợp bản đồ hiển thị thông tin thời tiết trên khu vực địa lý
- Hỗ trợ độ ẩm tuyệt đối và chỉ số UV
- Thêm tính năng chia sẻ thông tin thời tiết qua mạng xã hội
- Cải thiện hiệu suất bộ đệm dữ liệu
- Thêm hỗ trợ cho nhiều ngôn ngữ
- Tích hợp với dịch vụ lịch để gợi ý hoạt động dựa trên thời tiết
- Thêm widget để xem thời tiết nhanh chóng từ màn hình chính Android

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

## Đóng góp

Nếu bạn muốn đóng góp vào dự án này, vui lòng tạo một pull request hoặc report issue.

## Giấy phép

Dự án này được cấp phép dưới MIT License. Xem file LICENSE để chi tiết.

## Liên hệ

Nếu có câu hỏi hoặc gợi ý, vui lòng mở một issue trên GitHub hoặc liên hệ trực tiếp.

## Acknowledgments

- OpenWeatherMap API cung cấp dữ liệu thời tiết
- Flutter team để tạo ra framework tuyệt vời này
- Material Design cho các nguyên tắc thiết kế UI/UX
