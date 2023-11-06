with saouzelong_stop as (
    select 
        stop_id,
        stop_name

    from raw.stops
    where stop_name = 'Saouzelong'
),

stop_times as (
    select
        st.arrival_time,
        st.departure_time,
        st.stop_id,
        st.trip_id,
        st.stop_headsign,
        saou.stop_name

    from raw.stop_times as st
    right join saouzelong_stop as saou on st.stop_id = saou.stop_id
),

route_name as (
    select
        t.trip_id,
        r.route_short_name
    from raw.trips as t
    right join raw.routes as r on r.route_id = t.route_id
),

horaires as (
    select
        st.arrival_time,
        st.departure_time,
        rn.route_short_name
    from stop_times as st
    left join route_name as rn on st.trip_id = rn.trip_id
)


select * from horaires
