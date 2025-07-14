-- 1. Cancellation Analysis by Factors
SELECT 
    room_category,
    booking_platform,
    COUNT(*) AS total_bookings,
    COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) AS cancelled_bookings,
    ROUND(COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancellation_rate,
    ROUND(AVG(CASE WHEN booking_status = 'Cancelled' THEN revenue_realized / revenue_generated * 100 END), 2) AS avg_recovery_rate
FROM fact_bookings
GROUP BY room_category, booking_platform
HAVING COUNT(*) > 10
ORDER BY cancellation_rate DESC;

-- 2. Revenue Loss Analysis
SELECT 
    property_id,
    room_category,
    SUM(revenue_generated) AS potential_revenue,
    SUM(revenue_realized) AS actual_revenue,
    SUM(revenue_generated - revenue_realized) AS revenue_loss,
    ROUND(SUM(revenue_generated - revenue_realized) * 100.0 / SUM(revenue_generated), 2) AS percentage_loss
FROM fact_bookings
GROUP BY property_id, room_category
ORDER BY percentage_loss DESC;

--3. Booking Time Impact on Cancellations
SELECT 
    TO_CHAR(booking_date, 'YYYY-MM') AS booking_month,
    COUNT(*) AS total_bookings,
    COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) AS cancelled_bookings,
    ROUND(COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancellation_rate,
    ROUND(AVG((check_in_date - booking_date)::numeric), 1) AS avg_booking_window
FROM fact_bookings
GROUP BY booking_month
ORDER BY booking_month;

--4. Platform Performance by Property
SELECT 
    property_id,
    booking_platform,
    COUNT(*) AS total_bookings,
    SUM(revenue_realized) AS total_revenue,
    ROUND(AVG(revenue_realized), 2) AS avg_revenue_per_booking,
    COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) AS cancellations,
    ROUND(COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancellation_rate,
    ROUND(AVG(CASE WHEN ratings_given IS NOT NULL THEN ratings_given END), 2) AS avg_rating
FROM fact_bookings
GROUP BY property_id, booking_platform
HAVING count(*) > 5
ORDER BY property_id, total_revenue DESC; 