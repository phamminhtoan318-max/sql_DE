-- ==========================================================================================
-- ████████████████████████████████████████████████████████████████████████████████████████
-- TẦNG 3: KIẾN TRÚC DATA PIPELINE & DATA WAREHOUSING (END-TO-END DATA ENGINEERING)
-- Database thực hành: E_commerse (Olist Brazilian E-Commerce)
-- ████████████████████████████████████████████████████████████████████████████████████████
-- ==========================================================================================

-- ==========================================================================================
-- ████████████████████████████████████████████████████████████████████████████████████████
-- PHẦN 3: ETL / ELT END-TO-END QUERY (BIẾN ĐỔI LIÊN HOÀN TRONG 1 TRUY VẤN)
-- Luồng chuẩn: RAW → Extract → Clean → Transform → Validate → Dedup → Load
-- Mẫu: WITH cleaned AS (...), transformed AS (...), ranked AS (...), validated AS (...)
-- ████████████████████████████████████████████████████████████████████████████████████████
-- ==========================================================================================

-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 1]: KIẾN TRÚC CTE PHÂN TẦNG (LAYERED CTE PIPELINE)
-- ------------------------------------------------------------------------------------------

-- Câu 3.1.1:
-- Xây dựng một truy vấn biến đổi khép kín 3 tầng cho bảng khách hàng:
-- Tầng 1: Trích xuất các trường dữ liệu thô cần thiết.
-- Tầng 2: Làm sạch khoảng trắng thừa và chuẩn hóa viết hoa tên thành phố.
-- Tầng 3: Chuẩn hóa mã bưu chính về chuỗi 5 chữ số có số 0 ở đầu.
-- Xuất tập dữ liệu sạch sẵn sàng để nạp vào kho.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.1.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.1.2:
-- Xây dựng truy vấn phân tầng 4 bước cho bảng đánh giá:
-- Trích xuất thô $\rightarrow$ Xử lý nội dung nhận xét bị thiếu $\rightarrow$ Khử trùng lặp chỉ lấy đánh giá mới nhất của mỗi đơn hàng $\rightarrow$ Xuất tập dữ liệu đạt chuẩn.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.1.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.1.3:
-- Viết truy vấn chứng minh sự khác biệt trong mô hình ELT:
-- Đưa toàn bộ dữ liệu thô vào bảng tạm Staging trước, sau đó dùng 1 câu lệnh SQL biến đổi trực tiếp trong kho
-- thay vì biến đổi trên đường truyền.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.1.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 2]: NHÚNG BƯỚC KIỂM THỬ TỰ ĐỘNG VÀO TRUY VẤN BIẾN ĐỔI (VALIDATION LAYER)
-- ------------------------------------------------------------------------------------------

-- Câu 3.2.1:
-- Tích hợp tầng kiểm tra hợp lệ thời gian (Validation Step) vào giữa pipeline CTE đơn hàng:
-- Phát hiện và đánh dấu các đơn hàng có ngày khách nhận diễn ra trước ngày đặt hàng
-- để loại bỏ khỏi luồng nạp dữ liệu sạch.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.2.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.2.2:
-- Nhúng bước kiểm tra tính toàn vẹn tham chiếu trực tiếp trong luồng biến đổi mặt hàng:
-- Tự động loại bỏ các mặt hàng bán ra có mã sản phẩm không tồn tại trong danh mục trước khi xuất kết quả.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.2.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.2.3:
-- Kỹ thuật tách nhánh kết quả (Branching Output) trong cùng 1 truy vấn:
-- Một nhánh trích xuất các bản ghi hợp lệ để nạp kho, một nhánh tập hợp các bản ghi vi phạm quy tắc nghiệp vụ
-- kèm theo lý do lỗi cụ thể để ghi vào bảng cách ly.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.2.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 3]: TÍCH HỢP KHỬ TRÙNG LẶP & ĐA TIÊU CHÍ VÀO LUỒNG BIẾN ĐỔI
-- ------------------------------------------------------------------------------------------

-- Câu 3.3.1:
-- Xây dựng chu trình hoàn chỉnh trong một câu truy vấn duy nhất:
-- Trích xuất đơn hàng thô $\rightarrow$ Chuẩn hóa định dạng $\rightarrow$ Gán số thứ tự phiên bản cập nhật $\rightarrow$
-- Lọc lấy bản ghi mới nhất của từng đơn $\rightarrow$ Chèn trực tiếp vào bảng đích.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.3.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.3.2:
-- Khử trùng lặp đa nguồn kết hợp trong một truy vấn:
-- Khử trùng bảng Geolocation đưa về một tọa độ đại diện cho từng mã bưu chính,
-- sau đó nối làm giàu thông tin cho hồ sơ khách hàng mà không làm phát sinh thêm dòng trùng lặp nào.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.3.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.3.3:
-- Áp dụng cơ chế ưu tiên chất lượng bản ghi (Quality Tie-Breaker) trực tiếp trong tầng CTE khử trùng
-- trước khi chuyển giao dữ liệu sang bước tính toán tiếp theo.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.3.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 4]: TẠO DATASET BÁN HÀNG TỔNG HỢP (SALES MART PIPELINE)
-- ------------------------------------------------------------------------------------------

-- Câu 3.4.1:
-- Viết một truy vấn liên hoàn biến đổi từ 4 bảng nguồn thô (Đơn hàng, Mặt hàng chi tiết, Thanh toán, Khách hàng)
-- để tạo ra một tập dữ liệu phân tích bán hàng sạch sẽ, bảo toàn đúng số lượng doanh thu và không bị nổ dòng.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.4.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.4.2:
-- Xử lý an toàn các phép tính tỷ trọng chi phí và phân bổ giá trị thanh toán
-- ngay trong tầng Transform của truy vấn bán hàng.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.4.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.4.3:
-- Tự động phân khúc quy mô đơn hàng (Order Tiering) và đánh giá cam kết thời gian giao hàng (SLA)
-- ngay tại tầng tính toán cuối cùng của pipeline bán hàng.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.4.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 5]: TẠO DATASET HỒ SƠ KHÁCH HÀNG TOÀN CẢNH (CUSTOMER 360 PIPELINE)
-- ------------------------------------------------------------------------------------------

-- Câu 3.5.1:
-- Viết truy vấn ELT một bước tổng hợp toàn bộ lịch sử của từng khách hàng:
-- Địa chỉ cập nhật mới nhất, ngày mua đầu, ngày mua cuối, tổng số đơn hàng đã hoàn tất và tổng giá trị chi tiêu trọn đời.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.5.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.5.2:
-- Tích hợp tầng phân nhóm RFM (Recency, Frequency, Monetary) trực tiếp trong truy vấn tổng hợp hồ sơ khách hàng.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.5.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.5.3:
-- Tính toán khoảng thời gian mua sắm trung bình giữa các đơn hàng và gắn nhãn phân loại khách hàng
-- (khách hàng mới, khách trung thành, hoặc khách có dấu hiệu rời bỏ).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.5.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 6]: CHUYỂN ĐỔI GIỮA BẢNG TẠM VÀ CTE KHI XỬ LÝ DỮ LIỆU LỚN
-- ------------------------------------------------------------------------------------------

-- Câu 3.6.1:
-- So sánh và chuyển đổi một truy vấn CTE phức tạp nhiều tầng sang chuỗi các bảng tạm (Temp Table Chaining)
-- có đánh Index hỗ trợ để tối ưu bộ nhớ và tránh nghẽn TempDB khi xử lý hàng triệu bản ghi.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.6.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.6.2:
-- Thực hiện kiểm toán số dòng (Row Count Audit) qua từng tầng biến đổi trung gian
-- để đảm bảo không bị rơi rụng dữ liệu ngoài ý muốn.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.6.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.6.3:
-- Áp dụng kỹ thuật đẩy sớm điều kiện lọc (Filter Pushdown) ngay tại tầng trích xuất đầu tiên
-- để giảm tải tối đa khối lượng dữ liệu truyền qua các bước sau.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.6.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P3 - NGÀY 7]: ĐÓNG GÓI TOÀN BỘ THÀNH SILVER VIEWS & STORED PROCEDURE ELT
-- ------------------------------------------------------------------------------------------

-- Câu 3.7.1:
-- Đóng gói toàn bộ câu truy vấn biến đổi dữ liệu đơn hàng thành một View tầng Silver `v_silver_orders`
-- chuẩn hóa để tái sử dụng xuyên suốt toàn bộ dự án.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.7.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.7.2:
-- Đóng gói truy vấn biến đổi hồ sơ khách hàng thành View tầng Silver `v_silver_customers`.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.7.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 3.7.3:
-- Viết Stored Procedure điều phối toàn bộ quy trình ELT:
-- Thực thi tuần tự các bước trích xuất, làm sạch, kiểm thử chất lượng, nạp dữ liệu đích và ghi nhật ký thời gian hoàn thành.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 3.7.3 TẠI ĐÂY:
