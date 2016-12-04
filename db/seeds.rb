# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#DriverStatus.create([{id:1, status: 'Available'}, {id:2, status: 'OnHold' }, {id:3, status: 'ONADelivery' },  {id:4, status: 'OffDuty' }])
#DeliveryStatus.create([{id:1, status: 'WaitingForAccept' },{id:2, status: 'EnRouteToPickUp' }, {id:3, status: 'PickedUp' },  {id:4, status: 'EnRouteToDelivery' },  {id:5, status: 'Delivered' }])
#Promocode.create([{id:1, code: 'wr23'},{id:2, code: '4y6s'}])
DeliveryVehicle.create([{id:1, name:'Push Bike', cost_per_km:2.79, vehicle_type_id:3, payload:'Less than 5Kgs', load_space:'No larger than A3'}, {id:2, name:'Push Bike Solo', cost_per_km:5.06, vehicle_type_id:3, payload:'Less than 5Kgs', load_space:'No larger than A3'}, {id:3, name:'Bike', cost_per_km:3.60, vehicle_type_id:3, payload:'Less than 5Kgs', load_space:'No larger than A3'},{id:4, name:'Solo Bike', cost_per_km:6.44, vehicle_type_id:3, payload:'Less than 5Kgs', load_space:'No larger than A3'}, {id:5, name:'GDS Car', cost_per_km:6.44, vehicle_type_id:1, payload:'Max 400Kgs', load_space:'32 A4 Boxes'}, {id:6, name:'Solo GDS', cost_per_km:12.11, vehicle_type_id:1, payload:'Max 400Kgs', load_space:'32 A4 Boxes'}, {id:7, name:'Small Van', cost_per_km:6.44, vehicle_type_id:2, payload:'Max 1200Kgs', load_space:'130 A4 Boxes'}, {id:8, name:'Solo Small Van', cost_per_km:13.73, vehicle_type_id:2, payload:'Max 1200Kgs', load_space:'130 A4 Boxes'}, {id:9, name:'Transit', cost_per_km:14.56, vehicle_type_id:2, payload:'Max 1200Kgs', load_space:'130 A4 Boxes'}, {id:10, name:'LWB Transit', cost_per_km:18.37, vehicle_type_id:2, payload:'Max 1200Kgs', load_space:'130 A4 Boxes'}])


VehicleType.create([{id:1, name:'car'}, {id:2, name:'van'}, {id:3, name:'motor_bike'}])
