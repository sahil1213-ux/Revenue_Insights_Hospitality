-- -- Descriptive Analytics

-- 1. Overall Booking Statistics
SELECT 
    COUNT(*) AS total_bookings,
    SUM(revenue_realized) AS total_revenue_realized,
    SUM(revenue_generated) AS total_revenue_generated,
    ROUND(SUM(revenue_realized) / SUM(revenue_generated) * 100, 2) AS realization_percentage,
    COUNT(DISTINCT property_id) AS total_properties
FROM fact_bookings;

-- 2. Booking Status Distribution
SELECT 
    booking_status,
    COUNT(*) AS number_of_bookings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_bookings), 2) AS percentage,
    SUM(revenue_realized) AS revenue_realized,
    ROUND(AVG(revenue_realized), 2) AS avg_revenue_per_booking
FROM fact_bookings
GROUP BY booking_status
ORDER BY number_of_bookings DESC;

--3. Booking Platform Performance
SELECT 
    booking_platform,
    COUNT(*) AS number_of_bookings,
    SUM(revenue_realized) AS total_revenue,
    ROUND(AVG(revenue_realized), 2) AS avg_revenue_per_booking,
    COUNT(CASE WHEN booking_status = 'Checked Out' THEN 1 END) AS successful_bookings,
    ROUND(COUNT(CASE WHEN booking_status = 'Checked Out' THEN 1 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM fact_bookings
GROUP BY booking_platform
ORDER BY total_revenue DESC;

-- 4. Daily Booking Trends
SELECT 
    DATE(check_in_date) AS check_in_date,
    COUNT(*) AS number_of_bookings,
    SUM(revenue_realized) AS daily_revenue,
    SUM(no_guests) AS total_guests
FROM fact_bookings
GROUP BY DATE(check_in_date)
ORDER BY check_in_date;