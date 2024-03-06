--Part 1: Library data

---Q1: Tính số lượng User_name đã mượn sách.
SELECT
    COUNT(DISTINCT User_name) AS Num_of_cus
FROM Library_table

---Q2: Tìm các User_name có từ 2 lần mượn sách trở lên.
SELECT
    User_name,
    COUNT(User_name) AS Num_of_purchase
FROM Library_table
GROUP BY  User_name
HAVING COUNT(User_name) >= 2

---Q3: Tìm các User_name đã mượn sách Lịch sử (History) nhưng chưa từng mượn sách Tâm lý (Psychology).
SELECT
    DISTINCT User_name
FROM Library_table
WHERE Book_type = 'History' AND
      User_name NOT IN (SELECT
                            DISTINCT User_name
                        FROM Library_table
                        WHERE Book_type = 'Psychology')

---Q4: Tìm các User_name mà có ít nhất 2 lần mượn sách Lịch sử (History) liên tiếp.
WITH his_consecutive AS (
    SELECT
        User_name,
        Book_type,
        LAG(Book_type) OVER(PARTITION BY User_name ORDER BY Date) AS previous_book
    FROM Library_table
)
SELECT
    DISTINCT User_name
FROM his_consecutive
WHERE previous_book = 'History' AND Book_type = 'History'

---Q5: Tính khoảng thời gian (tính bằng ngày) giữa lần mượn sách đầu tiên và lần mượn sách cuối cùng của mỗi User_name.
SELECT
    User_name,
    DATEDIFF(day, MIN(date), MAX(date)) AS date_difference
FROM Library_table
GROUP BY User_name

--Part 2: Staff data

---Q6: Tìm nhân viên có mức lương cao nhất ở mỗi phòng/ban
WITH ranking AS (
    SELECT
        Staff_id,
        Staff_name,
        Department_id,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department_id ORDER BY Salary DESC) AS rank
    FROM Staff_table
)
SELECT
    r.Staff_id,
    r.Staff_name,
    d.Department_name,
    r.Salary
FROM ranking r
LEFT JOIN Department d
ON d.Departmant_id = r.Departmant_id
WHERE r.rank = 1

---Q7: Tìm nhân viên có mức lương cao thứ 5 trong bảng nhân viên.
WITH ranking AS (
    SELECT
        Staff_id,
        Staff_name,
        Department_id,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS rank
    FROM Staff_table
)
SELECT
    Staff_id,
    Staff_name,
    Department_id
    Salary,
FROM ranking
WHERE rank = 5

--Part 3: Grab Data

---Q8: Tính tỷ lệ hủy đơn hàng của người dùng không bị cấm (cả khách hàng và tài xế đều không bị cấm) mỗi ngày.
WITH unban AS (
    SELECT
        ot.Order_id,
        ot.Client_id,
        ot.Driver_id,
        ot.Status,
        ut1.Banned AS Cus_ban,
        ut2.Banned AS Driver_ban
    FROM Order_table ot
    LEFT JOIN user_table ut1 
    ON ut1.User_id = ot.Client_id
    LEFT JOIN user_table ut2
    ON ut2.User_id = ot.Driver_id
    WHERE Cus_ban = 'No' AND Driver_ban = 'No'
)
SELECT
    ROUND(COUNT(CASE WHEN Status IN ['cancelled_by_driver','cancelled_by_client'] THEN 1 END)/COUNT(Order_id), 2)
FROM unban

--Part 4: Contact Data

---Q9: Kiểm tra tính hợp lệ của các số điện thoại
SELECT
    ID,
    Phone,
    CASE
        WHEN ISNUMERIC(Phone) = 0 THEN 0
        WHEN ISNUMERIC(Phone) = 1 THEN
            CASE
                WHEN LEN(Phone) <9 OR LEN(Phone) > 11 THEN 0
                WHEN SUBSTRING(Phone,1,4) IN ['1800', '1900', '1080'] THEN 0
                WHEN len(Phone) = 9 AND SUBSTRING(Phone,1,2) NOT IN ['04', '08'] THEN 0
                ELSE 1
            END
    END AS Valid_phone
FROM Contact_table

--Part 4: Visitor Data

---Q10: Trả về tất cả các bản ghi mà thuộc chuỗi ít nhất 3 ngày liên tiếp số lượng khách tham quan bằng hoặc trên 100 người
WITH TMP AS (
    SELECT Visit_date AS CUR_DATE,
        LAG(Visit_date, 1) OVER (ORDER BY Visit_date) AS LAG1_DATE,
        LAG(Visit_date, 2) OVER (ORDER BY Visit_date) AS LAG2_DATE,
        No_of_visitors AS CUR_VISITORS,
        LAG(No_of_visitors, 1) OVER (ORDER BY Visit_date) AS LAG1_VISITORS,
        LAG(No_of_visitors, 2) OVER (ORDER BY Visit_date) AS LAG2_VISITORS
    SELECT Visit_date AS CUR_DATE,FROM Visitor_table
),
SASTIFIED_RECORDS AS (
    SELECT 
        CUR_DATE, 
        LAG1_DATE, 
        LAG2_DATE
    FROM TMP
    WHERE CUR_VISITORS >= 100 AND LAG1_VISITORS >= 100 AND LAG2_VISITORS >= 100
)
SELECT CUR_DATE FROM SASTIFIED_RECORDS
UNION
SELECT LAG1_DATE FROM SASTIFIED_RECORDS
UNION
SELECT LAG2_DATE FROM SASTIFIED_RECORDS
