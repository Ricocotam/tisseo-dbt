with stops as (
    select
        s.stop_id,
        s.stop_name
    from raw.stops s
    where 
        s.wheelchair_boarding = 2 -- 1 = inaccessible, 2 = accessible
),

stop_times as (
    select
        distinct
            trip_id,
            stop_id
    from raw.stop_times
),

trips as (
    select
        distinct
            route_id,
            trip_id
        
    from raw.trips
),

routes as (
    select
        route_id,
        route_short_name,
        route_long_name
    from raw.routes
),

routes_trips as (
    select
        r.*,
        t.trip_id
    from 
        routes as r
    inner join trips as t on r.route_id = t.route_id
),

trips_stoptimes as (
    select
        t.*,
        st.stop_id
    from trips as t
    left join stop_times as st on t.trip_id = st.trip_id
),

tst_stops as (
    select
        tst.*,
        s.stop_name
    from trips_stoptimes as tst
    inner join stops as s on s.stop_id = tst.stop_id
),

correspondances as (
    select
        rt.route_short_name,
        rt.route_long_name,
        tsts.stop_name
    from routes_trips as rt    
    left join tst_stops as tsts on rt.trip_id = tsts.trip_id
)

select * from correspondances

