
# VP Bank SQL test

## Part 1: Library data

__Library_table__

Date| User_name| Book_type
---|---|---
1/1/2021| Hoanv| History
1/1/2021| Tuanct| History
1/1/2021| Quynhmt| Comics
1/2/2021| Hoanv| History
1/2/2021| Lientt| Psychology
1/3/2021| Hainv| History
1/4/2021| Lientt| History
1/4/2021| Tuanct| Psychology
1/5/2021| Quynhmt| History

1. Tính số lượng User_name đã mượn sách.

2. Tìm các User_name có từ 2 lần mượn sách trở lên.

3. Tìm các User_name đã mượn sách Lịch sử (History) nhưng chưa từng mượn sách Tâm lý (Psychology).

4. Tìm các User_name mà có ít nhất 2 lần mượn sách Lịch sử (History) liên tiếp.

5. Tính khoảng thời gian (tính bằng ngày) giữa lần mượn sách đầu tiên và lần mượn sách cuối cùng của mỗi User_name.

## Part 2: Staff data 

__Staff_table__

Staff_id| Staff_name| Salary| Department_Id
---|---|---|---
1| Hien| 100| 1
2| Long| 500| 2
3| Tuan| 400| 3
4| Hai| 900| 1
5| Quang| 700| 2
7| Linh| 600| 1
8| Hoa| 300| 3
9| Khanh| 800|1
10| Tung| 600| 3

6. Tìm nhân viên có mức lương cao nhất ở mỗi phòng/ban.

Kết quả trả về gồm các cột như sau:
Staff_id| Staff_name| Department_name| Salary
---|---|---|---
 | | | | |		

7. Tìm nhân viên có mức lương cao thứ 5 trong bảng nhân viên.

## Part 3: Grab Data

__Order_table__

Order_Id| Client_Id| Driver_Id| City_Id| Status | Request_date
---|---|---|---|---|---
1|  1|	10|	1|	 completed|           	 2013-10-01 
2|	2|	11|	1|	 cancelled_by_driver| 	 2013-10-01 
3|	3|	12|	6|	 completed|           	 2013-10-01 
4|	4|	13|	6|	 cancelled_by_client| 	 2013-10-01 
5|	1|	10|	1|	 completed|           	 2013-10-02 
6|	2|	11|	6|	 completed|           	 2013-10-02 
7|	3|	12|	6|	 completed|           	 2013-10-02 
8|	2|	12|	12|	 completed|          	 2013-10-03 
9|	3|	10|	12|	 completed|          	 2013-10-03 
10|	4|	13|	12|	 cancelled_by_driver| 	 2013-10-03 

__User_table__

User_Id|Banned|User_type
---|---|---
1|	 No|     	 client 
2|	 Yes|    	 client 
3|	 No|     	 client 
4|	 No|     	 client 
10|	 No|     	 driver 
11|	 No|     	 driver 
12|	 No|     	 driver 
13|	 No|     	 driver 	

8. Tính tỷ lệ hủy đơn hàng của người dùng không bị cấm (cả khách hàng và tài xế đều không bị cấm) mỗi ngày.
- Tỷ lệ hủy đơn hàng được tính bằng cách chia số lượng đơn hàng bị hủy (do khách hàng hoặc tài xế) của người dùng không bị cấm cho tổng số đơn hàng của người dùng không bị cấm vào ngày hôm đó.
- Kết quả trả về làm tròn đến số thập phân thứ 2 (nếu ngày nào tỷ lệ hủy đơn = 0, trả về 0.00)

## Part 4: Contact Data

__Contact_table__
ID| Phone
---|---
1|	0123456789
2|	0123456789a
3|	0123
4|	012345678
5|	180012345678
6|	84987654321
7|	051234567
8|	09876543210
9|	0123456789123
10|	041234567

9. Kiểm tra tính hợp lệ của các số điện thoại (Valid_phone: 1 nếu hợp lệ, 0 nếu không hợp lệ):
- Phải là định dạng số
- Độ dài từ 9-->11 ký tự 
- Không được là các đầu số tổng đài (1800,1900,1080)
- Nếu độ dài = 9 thì phải là đầu số 04,08

Kết quả trả về bao gồm các cột như sau:
ID|Phone|Valid_phone
---|---|--- 
|||||

## Part 4: Visitor Data

__Visitor_table__

Visit_date| No_of_visitors
---|---:
1/1/2017|	10
1/2/2017|	124
1/3/2017|	164
1/4/2017|	62
1/5/2017|	58
1/6/2017|	125
1/8/2017|	136
1/9/2017|	235
1/10/2017|	265
1/11/2017|	25
1/12/2017|	214
1/13/2017|	215
1/15/2017|	145
1/16/2017|	21

10. Trả về tất cả các bản ghi mà thuộc chuỗi ít nhất 3 ngày liên tiếp số lượng khách tham quan bằng hoặc trên 100 người:
- Kết quả trả về sắp xếp theo ngày thăm quan theo thứ tự tăng dần
- Kết quả trả về không tính ngày nghỉ, ngày nghỉ là ngày mà không xuất hiện trong bảng
VD: Kết quả trả về sẽ bao gồm cả các bản ghi ngày 6, 8, 9, 10 do đây là 4 ngày liên tiếp mà số lượng khách thăm quan >=100. Ngày 7 không có trong bảng dữ liệu nên được coi là ngày nghỉ.











