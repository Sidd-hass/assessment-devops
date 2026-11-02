-- Optional: 200k extra rows so the planner clearly prefers the index.
-- Run:  docker compose exec -T db psql -U app -d hotel < db/seed/seed_large.sql
INSERT INTO hotel_bookings (org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
SELECT
    (ARRAY[
        'a1111111-1111-4111-8111-111111111111',
        'a2222222-2222-4222-8222-222222222222',
        'a3333333-3333-4333-8333-333333333333',
        'a4444444-4444-4444-8444-444444444444',
        'a5555555-5555-4555-8555-555555555555'
    ]::uuid[])[1 + (g % 5)],
    'HTL-' || lpad((g % 200)::text, 3, '0'),
    (ARRAY['delhi','mumbai','bengaluru','dubai','london','singapore','paris','tokyo'])[1 + (g % 8)],
    CURRENT_DATE + (g % 30),
    CURRENT_DATE + (g % 30) + 1 + (g % 5),
    round((50 + (g % 950))::numeric, 2),
    (ARRAY['confirmed','pending','cancelled','completed'])[1 + (g % 4)],
    NOW() - ((g % 365) || ' days')::interval - ((g % 1440) || ' minutes')::interval
FROM generate_series(1, 200000) g;
VACUUM (ANALYZE) hotel_bookings;
