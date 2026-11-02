TRUNCATE booking_events, hotel_bookings RESTART IDENTITY;

SELECT setseed(0.42);  

INSERT INTO hotel_bookings (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT gen_random_uuid(), org_id, hotel_id, city, checkin, checkin + nights, amount, status, created_at
FROM (
    SELECT
        (ARRAY[
            'a1111111-1111-4111-8111-111111111111',
            'a2222222-2222-4222-8222-222222222222',
            'a3333333-3333-4333-8333-333333333333',
            'a4444444-4444-4444-8444-444444444444',
            'a5555555-5555-4555-8555-555555555555'
        ]::uuid[])[1 + floor(random() * 5)::int]                             AS org_id,
        'HTL-' || lpad((1 + floor(random() * 30))::int::text, 3, '0')        AS hotel_id,
        (ARRAY['delhi','delhi','delhi','mumbai','bengaluru','dubai','london','singapore'])
            [1 + floor(random() * 8)::int]                                   AS city,
        (CURRENT_DATE + (floor(random() * 45) - 15)::int)                    AS checkin,
        (1 + floor(random() * 6))::int                                       AS nights,
        round((60 + random() * 940)::numeric, 2)                             AS amount,
        (ARRAY['confirmed','confirmed','pending','cancelled','completed'])
            [1 + floor(random() * 5)::int]                                   AS status,
        (NOW() - random() * INTERVAL '60 days')::timestamp                   AS created_at
    FROM generate_series(1, 300)
) s;


INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT id, 'booking_created',
       jsonb_build_object('source', (ARRAY['web','mobile','api'])[1 + floor(random() * 3)::int],
                          'amount', amount),
       created_at
FROM hotel_bookings
WHERE random() < 0.7;


INSERT INTO booking_events (booking_id, event_type, payload, created_at)
SELECT id,
       'booking_' || status,
       jsonb_build_object('previous_status', 'pending', 'new_status', status),
       created_at + INTERVAL '5 minutes'
FROM hotel_bookings
WHERE status <> 'pending' AND random() < 0.8;

ANALYZE hotel_bookings;
ANALYZE booking_events;
