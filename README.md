# Cấu trúc project

- **assets**: chứa các files tài nguyên như; images, fonts, file ngôn ngữ, audio, ...
- **assets/languages**: folder chứa file định nghĩa các ngôn ngữ của app
- **lib/components**: Chứa các thành phần có thể dùng lại nhiều lần trong app
- **lib/config**: chứa config của app (api, constant, routes)
- **lib/config/routes.dart**: file định nghĩa các màn hình có trong app
- **lib/data**: chứa các file model của app và providers tương tác với api hoặc sqlite
- **lib/extensions:** chứa các phần mở rộng của class trong project
- **lib/helpers**: chứa các classes/functions helpers
- **lib/repositores**: chứa các classes phục vụ cho việc request tới api hoặc thực hiện tương tác với sqlite
- **lib/screens**: chứa toàn bộ màn hình trong app
- **lib/services**: các classes phục vụ cho việc tương tác với thành phần native/socket,...
- **language.dart**: file xử lý logic cho đa ngôn ngữ
- **maint.dart**: file chính khi khởi chạy app
