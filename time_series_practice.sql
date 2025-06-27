-- all readings for one day
select timestamp
  , solar_generation_kw
  , battery_charge_level_percent
from solar_readings
where date(timestamp) = '2023-01-03';

-- find peak solar generation on a day
select date(timestamp) as reading_date
  , max(solar_generation_kw) as peak_solar_kw
  , time(timestamp) as peak_time
from solar_readings
where date(timestamp) = '2023-01-05'
group by reading_date;

-- calculate daily average
select date(timestamp) as reading_date
  , avg(solar_generation_kw) as average_daily_solar_kw
from solar_readings
group by reading_date
order by reading_date;

-- hourly average battery charges
select strftime('%H', timestamp) as hour_of_day
  , avg(solar_generation_kw) as average_solar_kw
  , avg(battery_charge_level_percent) as average_battery_percent
from solar_readings
group by hour_of_day
order by hour_of_day;

-- change in battery charge between consecutive readings (lag)
select timestamp
  , battery_charge_level_percent
  , (battery_charge_level_percent - lag(battery_charge_level_percent, 1, battery_charge_level_percent) over (order by timestamp)) as battery_change
from solar_readings
order by timestamp;
