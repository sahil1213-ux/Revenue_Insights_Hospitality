-- Create the table with ratings_given allowing NULLs
CREATE TABLE fact_bookings (
    booking_id VARCHAR(255) PRIMARY KEY,
    property_id INTEGER,
    booking_date DATE,
    check_in_date DATE,
    checkout_date DATE,
    no_guests INTEGER,
    room_category VARCHAR(10),
    booking_platform VARCHAR(50),
    ratings_given NUMERIC(3,1) NULL,  -- Explicitly allowing NULL
    booking_status VARCHAR(20),
    revenue_generated NUMERIC(10,2),
    revenue_realized NUMERIC(10,2)
);
