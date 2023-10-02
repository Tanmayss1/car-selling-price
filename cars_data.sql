select  * from  cars.car_data;

# EDA

1)# there are different 98 cars in the cars database
select count(distinct(Car_name)) from cars.car_data;


2)# this dataset is for 16 years from 2003 to 2018
select count(distinct(Year)), min(`Year`),max(`Year`)  from cars.car_data;


3)# Min Present Price found is 0.32 and Max is 92.6 (all in lakhs)
select min(Present_Price),max(Present_Price)  from cars.car_data;


4# Curios to know the about the lowest and highest present price cars
# land cruiser	92.6
# Bajaj  ct 100	0.32

(select `Car_Name`,max(Present_Price) max_pp from cars.car_data cd group by Car_Name order by max_pp desc limit 1)
union all 
(select `Car_Name`,min(Present_Price) min_pp from cars.car_data cd group by Car_Name order by min_pp asc limit 1);

5) # Min Selling Price found is 0.1 and Max is 35 (all in lakhs)
select min(Selling_Price),max(Selling_Price)  from cars.car_data;


6) # land cruiser				35.0
   # Bajaj Pulsar 150			0.1
(select `Car_Name`,max(Selling_Price) max_sp from cars.car_data cd group by Car_Name order by max_sp desc limit 1)
union all 
(select `Car_Name`,min(Selling_Price) min_sp from cars.car_data cd group by Car_Name order by min_sp asc limit 1);


7) # Min KM's Driven found is 500 and Max is 500,000 (All in Km's)
select min(Kms_Driven),max(Kms_Driven)  from cars.car_data;


8) #  Activa 3g							500000
   #  Bajaj Avenger 220					500
(select `Car_Name`,max(Kms_Driven) max_kd from cars.car_data cd group by Car_Name order by max_kd desc limit 1)
union all 
(select `Car_Name`,min(Kms_Driven) min_kd from cars.car_data cd group by Car_Name order by min_kd asc limit 1);


9) # Count of Fuel_Type
(select Fuel_Type,count(Fuel_Type) from cars.car_data cd where Fuel_Type ='Petrol')
union 
(select Fuel_Type,count(Fuel_Type) from cars.car_data cd where Fuel_Type ='Diesel')


10) # 		Manual		261
    # 		Automatic	40

select `Transmission`, count(`Transmission`) from cars.car_data cd group by `Transmission` ;


11) #	0	290
	# 	1	10
	#	3	1

select `Owner`, count(`Owner`) from cars.car_data cd group by `Owner` ;



12) # Which Car generated most sales value, write the query year wise, with name, selling price and fuel type

SELECT Year, Car_name, Selling_Price AS msp, Fuel_type
FROM (
    SELECT Year, Car_name, Selling_Price, Fuel_type,
           ROW_NUMBER() OVER(PARTITION BY Year ORDER BY Selling_Price DESC) AS rn
    FROM cars.car_data
) AS ranked
WHERE rn = 1;

13) # which car has maximum difference between current price and selling price, also which has kms driven over 100000

select Car_name,sum(Present_Price-Selling_Price) total_difference ,sum(Present_Price), sum(Selling_Price) ssp from cars.car_data cd where Kms_Driven > '100000' group  by Car_Name order by total_difference desc limit 3;


14) # sales of manual transmission vehicles vs automatic transmission vehicles


select  Year , sum(Selling_Price), count(Transmission) Total_Transmission_Vehicles 
from cars.car_data cd 
where Transmission = 'Manual' 
group by `Year` 
order by Total_Transmission_Vehicles desc;
--------------------------------------------------------------------------------------------------------------------------------
select  Year , sum(Selling_Price)  , count(Transmission) Total_Transmission_Vehicles 
from cars.car_data cd 
where Transmission = 'Automatic' 
group by `Year`  
order by Total_Transmission_Vehicles desc;


15) select Kms_driven,Seller_type from cars.car_data cd where Seller_Type = 'Dealer' AND Kms_Driven=max(Kms_driven);

select max(Kms_Driven),Seller_Type  from cars.car_data cd where Seller_Type ='Dealer';


select Seller_Type ,max(Kms_Driven) from innertable
	(select max(Kms_Driven),Seller_Type  from cars.car_data cd where Seller_Type ='Dealer') as innertable;
	
select Seller_Type ,max(Kms_Driven) froms
(
select Seller_Type, Kms_Driven  from cars.car_data cd where Seller_Type = 'Dealer'
) as temp;