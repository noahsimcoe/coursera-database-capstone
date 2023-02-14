CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(Quantity)
FROM Orders;

PREPARE ManageBooking FROM
"SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE CustomerID = ?";
SET @id = 1;
EXECUTE ManageBooking using @id;

delimiter //
CREATE PROCEDURE AddBooking(bookingdate date, tablenumber int, customerid int)
BEGIN
INSERT INTO Bookings (BookingDate, TableNumber, CustomerID) VALUES (bookingdate, tablenumber, customerid);
END //
delimiter ;

delimiter //
CREATE PROCEDURE UpdateBooking(bookingid int, bookingdate date)
BEGIN
UPDATE Bookings SET BookingDate = bookingdate WHERE BookingID = bookingid;
SELECT CONCAT("Booking ", bookingid, " updated") AS "Confirmation";
END //
delimiter ;

delimiter //
CREATE PROCEDURE CancelBooking (bookingid int)
BEGIN
DELETE FROM Bookings WHERE BookingID = bookingid;
SELECT CONCAT ("Booking ", bookingid, " canceled") AS "Confirmation";
END
delimiter ;
