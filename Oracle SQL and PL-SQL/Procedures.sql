/*tested*/
create or replace procedure InsertPropertyRecord(
    pid in int,rent_per_month in int,no_of_floors in int,year_of_construction in int,available_start_date in date,available_end_date in date,hike in int,
    total_area in int,plinth_area in int,owner_id in int,tenant_id in int,manager_id in int,city in varchar,pincode in int,street in varchar,door_no in int,
    state in varchar,rflag in int,no_of_bedrooms in int,flat_flag in int,flat_maintenance_charge in int,independent_house_flag in int,amenities in varchar2,
    shop_flag in int,shop_type in varchar,warehouse_flag in int,capacity in int
)as 
begin
insert into property values (pid,rent_per_month,no_of_floors,year_of_construction,available_start_date,available_end_date,hike,
total_area,plinth_area,owner_id,tenant_id,manager_id,city,pincode,street,door_no,state);
if rflag = 1 then
insert into residential values(pid,no_of_bedrooms,flat_flag,flat_maintenance_charge,independent_house_flag,amenities);
else 
insert into commercial values(pid,shop_flag,shop_type,warehouse_flag,capacity);
end if;
end;
/ 
/*exec Insertpropertyrecord(7,2000,3,2010,'27-nov-2004','27-nov-2020',1000,10000,9000,3,5,6,'bom',600099,'stg',12,'la',1,3,1,200,0,null,0,null,0,null);*/

/*tba*/
/*exec Insertpropertyrecord(8,1000,4,2008,'17-sep-2009','23-aug-2020',1000,10000,9000,3,4,7,'bom',840629,'idk',66,'maha',0,null,0,null,0,null,1,'super market',0,null);*/

/*tested*/
create or replace procedure CreateNewUser(
    aid in int,name in varchar2,age in int,sex in varchar2,city in varchar2,pincode in int,street in varchar,door_no in int,
    state in varchar,login_id in varchar,password in varchar,t_flag in int,m_flag in int,o_flag in int,marital_status in varchar2,level in int,profession in varchar2,phone_no in varchar2
) as 
begin
Insert into ra_user values (aid,name,age,sex,city,pincode,street,door_no,state,login_id,password);
if t_flag=1 then
insert into tenant values(aid,marital_status);
end if;
if o_flag=1 then
insert into owner values(aid,profession);
end if;
if m_flag=1 then
insert into manager values(aid,level);
end if;
insert into user_contact values(aid,phone_no);
end;
/
/*exec createnewuser(10,'hun',67,'F','la',400069,'wallst',89,'awert','urugjar','jarurug',1,0,1,'S',null,'teacher',9090909090);*/
/*tba*/
/*exec createnewuser(11,'sam',24,'M','dc',540089,'dalalst',54,'Texas','viggu','123321',0,1,0,null,2,null,9127830941);*/

/*tested*/
create or replace procedure add_extra_contact(aid in int,phone_no in varchar2) as
begin
insert into user_contact values(aid,phone_no);
end;
/
/*exec add_extra_contact(1,1023456789);*/
/*exec add_extra_contact(11,9182736450);*/

/*tested*/
Create or replace procedure GetTenantDetails(property_id in number) as 
Aid number;Name varchar(20);Age number;Sex varchar(1);City varchar(20);Pincode number;
Street varchar(20);DoorNo number;State varchar(20);Marital_Status varchar(1);
Begin
Select t.aid,t.marital_status,u.name,u.age,u.sex,u.city,u.pincode,u.street,u.door_no,u.state into
Aid,Marital_Status,Name,Age,Sex,City,Pincode,Street,DoorNo,State from 
tenant t,ra_user u,property p
where p.tenant_id = t.aid and t.aid = u.aid and property_id=p.pid;
dbms_output.put_line('Aid: ' || Aid ||',Name: ' || Name || ',Age: ' || Age ||',Sex: ' || Sex ||',City: ' || City ||
',Pincode: ' || Pincode ||',Street: ' || Street ||',Door number: ' || DoorNo ||',State: ' || State ||',Marital status: ' || Marital_Status );
End;
/ 
/*exec gettenantdetails(1);*/

/*tested*/
create or replace procedure GetPropertyRecords(ownerid in int) as     
Proid int;rpm int;nof int;yoc int;asd date;aed date;Hik int;ta int;pa int;oi int;
ti int;mi int;Pc int;ci varchar(20);Stre varchar(20);dn int;st varchar(20);
nob int;ff int;fmc int;ihf int;aments varchar(20);
sf int;sty varchar(20);whf int;cap int;

cursor roc is select p.pid,p.rent_per_month,p.no_of_floors,p.year_of_construction,p.available_start_date,p.available_end_date,p.hike,p.total_area,
    p.plinth_area,p.owner_id,p.tenant_id,p.manager_id,p.city,p.pincode,p.street,p.door_no,p.state, r.no_of_bedrooms,r.flat_flag,r.flat_maintenance_charge,r.independent_house_flag,r.amenities from residential r,property p where 
    p.pid = r.pid and p.owner_id = ownerid;
cursor cor is select p.pid,p.rent_per_month,p.no_of_floors,p.year_of_construction,p.available_start_date,p.available_end_date,p.hike,p.total_area,
    p.plinth_area,p.owner_id,p.tenant_id,p.manager_id,p.city,p.pincode,p.street,p.door_no,p.state, c.shop_flag,c.shop_type,c.warehouse_flag,c.capacity from commercial c ,property p where 
    p.pid = c.pid and p.owner_id = ownerid;

begin
open roc;
loop
Fetch roc into proid,rpm,nof,yoc,asd,aed,Hik,ta,pa,oi,ti,mi,ci,pc,Stre,dn,St,nob,ff,fmc,ihf,aments;
Exit when roc % notfound;
dbms_output.put_line('Property is Residential');
dbms_output.put_line('City: ' || ci|| ',Pid: ' || Proid||',Rent_per_month: ' || rpm ||',No_of_floors:' || nof ||',Year_of_construction: ' || yoc
 ||',Available_start_date: ' || asd ||',Available_end_date: ' || aed || ',Hike: ' || Hik|| ',Total_area: ' || ta|| ',Plinth_area: ' || pa||
 ',Owner_id: ' || oi||',Tenant_id: ' || ti ||',Manager_id: ' || mi || ',Pincode: ' || Pc||',Street:' || Stre||',Door_no: ' || dn || ',State: ' || St);
dbms_output.put_line('No of bedrooms :'|| nob ||',Flat(1 if it is a flat else 0) :'||ff||',Flat maintenance charge :'||fmc||
',Independent house(1 if it is a Independent house else 0) :'||ihf||',amenities :'||aments);
End loop;
close roc;

open cor;
loop
Fetch cor into proid,rpm,nof,yoc,asd,aed,Hik,ta,pa,oi,ti,mi,ci,pc,Stre,dn,St,sf,sty,whf,cap;
Exit when cor % notfound;
dbms_output.put_line('Property is Commercial');
dbms_output.put_line('City: ' || ci|| ',Pid: ' || Proid||',Rent_per_month: ' || rpm ||',No_of_floors:' || nof ||',Year_of_construction: ' || yoc
 ||',Available_start_date: ' || asd ||',Available_end_date: ' || aed || ',Hike: ' || Hik|| ',Total_area: ' || ta|| ',Plinth_area: ' || pa||
 ',Owner_id: ' || oi||',Tenant_id: ' || ti ||',Manager_id: ' || mi || ',Pincode: ' || Pc||',Street:' || Stre||',Door_no: ' || dn || ',State: ' || St);
dbms_output.put_line('Shop(1 if it is a shop else 0) :'||sf||',shop type :'||sty||',Ware house(1 if it is a ware house else 0) :'||whf
||',capacity :'||cap);
End loop;
close cor;

end;
/
/*exec getpropertyrecords(2);*/
/*exec getpropertyrecords(1);*/

/*tested*/
create or replace procedure SearchPropertyForRent(cit in varchar2) as
pid1 int;rt int;no_floor int;yoc int;ta int;pa int;pin int;st varchar(20);dno int;state1 varchar(20);ci varchar(20);

cursor c is select Pid,Rent_per_month,No_of_floors,year_of_construction,total_area,plinth_area,pincode,street,door_no,state,city from property;

begin
open c;
loop
fetch c into pid1,rt,no_floor,yoc,ta,pa,pin,st,dno,state1,ci;
exit when c%notfound;
if cit = ci then
dbms_output.put_line('Property Id: '||pid1||', Number of floors: '||no_floor||', Year of Construction: '||yoc||', Rent per Month: '||rt||' Total Area: '||ta||', Plinth area: '||pa||', Pincode: '||pin||', Street: '||st||', Door number: '||dno||' State: '||state1);
end if;
end loop;
close c;
end;
/
/*exec searchpropertyforrent('bom');*/
/*exec searchpropertyforrent('Houston');*/
 
/*tested*/
create or replace procedure updaterent(oldtid in int,newtid in int,proid in int) as 
ai int;
pi int;
sd date;
ed date;
rpm int;
begin
select aid,pid,start_date,end_date,rent_per_month into ai,pi,sd,ed,rpm from rent where aid=oldtid and pid = proid;
update rent set aid = newtid where pid = proid;
update property set tenant_id = newtid where pid = proid;
insert into prev_rented values(ai,pi,sd,ed,rpm);
end;
/
/*exec updaterent(2,10,1)*/
/*tba*/
/*exec updaterent(5,3,4)*/

/*tested*/
Create or replace procedure GetRentHistory(Property_id in int) as 
name_user varchar(20);St_date date;End_date date;Rt number;
Cursor d is select c.Name,a.start_date,a.end_date,a.rent
from Prev_rented a,tenant b,ra_user c
where a.Aid = b.Aid and b.Aid = c.Aid and a.pid = Property_id;
Begin 
Open d;
loop 
Fetch d into name_user,St_date,End_date,Rt;
Exit when d % notfound;
dbms_output.put_line('Tenant name:  ' || name_user || ', Rent:  ' || Rt || ', Start date: ' || St_date || ', End date: ' || End_date);
End loop;
Close d;
End;
/ 
/* exec getrenthistory(4);*/