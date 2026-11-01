-- ==========================================================================================
-- ████████████████████████████████████████████████████████████████████████████████████████
-- TẦNG 3: KIẾN TRÚC DATA PIPELINE & DATA WAREHOUSING (END-TO-END DATA ENGINEERING)
-- Database thực hành: E_commerse (Olist Brazilian E-Commerce)
-- ████████████████████████████████████████████████████████████████████████████████████████
-- ==========================================================================================

-- ==========================================================================================
-- ████████████████████████████████████████████████████████████████████████████████████████
-- PHẦN 4: DATA WAREHOUSE PIPELINE: STAGING → DIMENSION → FACT
-- Kiến trúc chuẩn: RAW → STAGING → DIMENSION → FACT
-- Áp dụng cho Project Olist E-Commerce
-- ████████████████████████████████████████████████████████████████████████████████████████
-- ==========================================================================================

-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 1]: THIẾT KẾ & NẠP TẦNG STAGING (STAGING LAYER)
-- ------------------------------------------------------------------------------------------

-- Câu 4.1.1:
-- Thiết kế bảng Staging đơn hàng `stg_orders` và viết câu lệnh nạp làm sạch từ bảng nguồn thô:
-- Chuẩn hóa trạng thái đơn, định dạng ngày giờ chuẩn ISO, và loại bỏ các bản ghi không hợp lệ.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.1.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.1.2:
-- Thiết kế bảng Staging khách hàng `stg_customers` và viết câu lệnh nạp:
-- Chuẩn hóa tên thành phố, mã bang, mã bưu chính và khử trùng lặp đưa về 1 dòng cho mỗi khách hàng duy nhất.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.1.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.1.3:
-- Thiết kế bảng Staging sản phẩm `stg_products`:
-- Chuẩn hóa tên ngành hàng, quy đổi trọng lượng sang kg và kích thước sang m3, gán giá trị mặc định cho dữ liệu thiếu.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.1.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 2]: XÂY DỰNG BẢNG CHIỀU KHÁCH HÀNG (DIM_CUSTOMER)
-- ------------------------------------------------------------------------------------------

-- Câu 4.2.1:
-- Thiết kế cấu trúc bảng `dim_customer` chuẩn Data Warehouse:
-- Bao gồm khóa đại diện tự tăng (`customer_key INT IDENTITY(1,1)` làm Primary Key),
-- khóa tự nhiên nghiệp vụ (`customer_unique_id`), và các thuộc tính địa bàn đã chuẩn hóa.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.2.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.2.2:
-- Viết câu lệnh nạp dữ liệu từ `stg_customers` vào `dim_customer`:
-- Đảm bảo có thêm bản ghi đại diện mặc định mang khóa `customer_key = -1` ('Unknown Customer')
-- để dự phòng cho các đơn hàng mồ côi không tìm thấy thông tin khách.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.2.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.2.3:
-- Áp dụng cơ chế cập nhật thông tin địa chỉ mới nhất cho khách hàng trong bảng Dimension (SCD Type 1).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.2.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 3]: XÂY DỰNG DIMENSION SẢN PHẨM & ĐỊA ĐIỂM (DIM_PRODUCT & DIM_LOCATION)
-- ------------------------------------------------------------------------------------------

-- Câu 4.3.1:
-- Thiết kế và viết câu lệnh nạp dữ liệu cho bảng `dim_product`:
-- Tạo khóa đại diện `product_key`, lưu mã sản phẩm, ngành hàng, phân khúc trọng lượng và phân khúc thể tích.
-- Bổ sung bản ghi mặc định `product_key = -1` ('Unknown Product').
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.3.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.3.2:
-- Thiết kế và nạp bảng danh mục địa điểm `dim_location`:
-- Khử trùng lặp bảng Geolocation để tạo danh mục địa bàn duy nhất theo mã bưu chính kèm tọa độ trung bình đại diện.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.3.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.3.3:
-- Bổ sung bản ghi mặc định `location_key = -1` ('Unknown Location') vào bảng địa điểm.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.3.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 4]: XÂY DỰNG BẢNG CHIỀU THỜI GIAN (DIM_DATE)
-- ------------------------------------------------------------------------------------------

-- Câu 4.4.1:
-- Thiết kế bảng chiều thời gian `dim_date` hoàn chỉnh:
-- Khóa chính `date_key INT` (dạng số nguyên YYYYMMDD), ngày chuẩn ISO, năm, quý, tháng, tuần trong năm,
-- tên thứ và cờ phân biệt ngày cuối tuần (`is_weekend`).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.4.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.4.2:
-- Viết câu lệnh SQL tự động sinh toàn bộ danh mục ngày tháng từ ngày 2016-01-01 đến 2020-12-31
-- để nạp sẵn dữ liệu cho bảng `dim_date`.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.4.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.4.3:
-- Viết câu lệnh tra cứu (Lookup) chuyển đổi từ mốc thời gian timestamp của đơn hàng
-- sang khóa ngoại `date_key` tương ứng trong bảng `dim_date`.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.4.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 5]: XÂY DỰNG BẢNG FACT BÁN HÀNG CHI TIẾT (FACT_SALES)
-- ------------------------------------------------------------------------------------------

-- Câu 4.5.1:
-- Xác định Grain hạt nhân của bảng Fact:
-- Thiết kế bảng `fact_sales` ở cấp độ: 1 dòng tương ứng với 1 mặt hàng bán ra trong đơn hàng (`order_id, order_item_id`).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.5.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.5.2:
-- Viết câu lệnh nạp dữ liệu vào `fact_sales` thực hiện tra cứu khóa ngoại (Dimension Key Lookup):
-- Nối dữ liệu mặt hàng với các bảng Dimension (`DimCustomer`, `DimProduct`, `DimLocation`, `DimDate`)
-- để lấy các Surrogate Key tương ứng (gán khóa -1 nếu không tìm thấy Dimension khớp).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.5.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.5.3:
-- Nạp các chỉ số tài chính cộng dồn được (Additive Measures) vào `fact_sales`:
-- Số lượng, đơn giá, tiền cước vận chuyển và tổng giá trị thanh toán của từng mặt hàng.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.5.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 6]: XÂY DỰNG BẢNG FACT ĐƠN HÀNG TỔNG QUÁT (FACT_ORDERS)
-- ------------------------------------------------------------------------------------------

-- Câu 4.6.1:
-- Thiết kế bảng Fact thứ hai `fact_orders` ở cấp độ Grain: 1 dòng tương ứng với 1 đơn hàng nguyên vẹn (`order_id`).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.6.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.6.2:
-- Nạp dữ liệu vào `fact_orders` từ tầng Staging:
-- Tính tổng số món hàng, tổng tiền hàng, tổng cước phí, hình thức thanh toán chính,
-- và số ngày hoàn tất giao hàng của từng đơn.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.6.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.6.3:
-- Đối soát tính toàn vẹn giữa hai bảng Fact:
-- So sánh tổng doanh thu tính từ `fact_sales` (cấp mặt hàng) và `fact_orders` (cấp đơn hàng)
-- để đảm bảo hai bảng Fact hoàn toàn khớp nhau về số liệu tài chính.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.6.3 TẠI ĐÂY:





-- ------------------------------------------------------------------------------------------
-- [P4 - NGÀY 7]: ĐIỀU PHỐI TOÀN BỘ QUY TRÌNH DATA WAREHOUSE (END-TO-END ORCHESTRATION)
-- ------------------------------------------------------------------------------------------

-- Câu 4.7.1:
-- Xây dựng kịch bản điều phối thực thi trọn vẹn theo đúng trình tự phụ thuộc:
-- Bước 1: Nạp Staging $\rightarrow$ Bước 2: Nạp các Dimension $\rightarrow$ Bước 3: Nạp các Fact Table.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.7.1 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.7.2:
-- Bổ sung các bài kiểm tra toàn vẹn tự động sau khi nạp kho (DW Quality Assertions):
-- Kiểm tra không có bất kỳ dòng Fact nào mang khóa ngoại bị NULL (phải trỏ tới khóa hợp lệ hoặc khóa -1).
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.7.2 TẠI ĐÂY:




-- ------------------------------------------------------------------------------------------
-- Câu 4.7.3:
-- Đóng gói toàn bộ quy trình xây dựng Data Warehouse thành một Master Stored Procedure:
-- `usp_Build_Olist_DataWarehouse`:
-- Tự động vận hành toàn bộ từ Staging đến Fact, ghi nhận lịch sử thực thi và số bản ghi của từng bảng vào bảng nhật ký.
-- ------------------------------------------------------------------------------------------
-- VIẾT QUERY CÂU 4.7.3 TẠI ĐÂY:



