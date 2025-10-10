show databases;

create database insurance2;
use insurance2;
create table person (driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
create table car(reg_num varchar(10),model varchar(10),year int, primary key(reg_num));
create table accident(report_num int, accident_date date, location varchar(20),primary
key(report_num));
create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int,
primary key(driver_id, reg_num, report_num),foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),foreign key(report_num) references
accident(report_num));
insert into person values('A01', 'Richard', 'Srinivas nagar');
insert into person values('A02', 'Pradeep', 'Rajaji nagar');
insert into person values('A03', 'Smith', 'Ashok nagar');
insert into person values('A04', 'Venu', 'N R Colony');
insert into person values('A05', 'Jhon', 'Hanumanth nagar');
select * from persons;
select * from person;
insert into car values('KA052250', 'Indica', 1990);
insert into car values('KA031181', 'Lancer', 1957);
insert into car values('KA095477', 'Toyota', 1998);
insert into car values('KA053408', 'Honda', 2008);
insert into car values('KA041702', 'Audi', 2005);
select * from car;
insert into owns values('A01', 'KA052250');
insert into owns values('A02', 'KA053408');
insert into owns values('A03', 'KA031181');
insert into owns values('A04', 'KA095477');
insert into owns values('A05', 'KA041702');
select * from owns;
insert into accident values(11, '2003-01-01', 'Mysore Road');
insert into accident values(12, '2004-02-02', 'South end Circle');
insert into accident values(13, '2003-01-21', 'Bull temple Road');
insert into accident values(14, '2008-02-17', 'Mysore Road');
insert into accident values(15, '2005-03-04', 'Kanakapura Road');
select * from accident;
insert into participated values('A01', 'KA052250', 11, 10000);
insert into participated values('A02', 'KA053408', 12, 50000);
insert into participated values('A03', 'KA031181', 13, 25000);
insert into participated values('A04', 'KA095477', 14, 3000);
insert into participated values('A05', 'KA041702', 15, 5000);
select * from participated;
select * from accident;
select p.driver_id,p.name,pa.damage_amount from participated pa,person p where  pa.driver_id=p.driver_id and damage_amount>=25000;
select person.name,car.model,
from person,car,owns where car.reg_num=owns.reg_num and person.driver_id=owns.driver_id;
select person.name, car.model
from person, car, owns
where car.reg_num = owns.reg_num
  and person.driver_id = owns.driver_id;
select person.name,accident.report_num,participated.damage_amount,accident.accident_date
from person,accident,participated
where person.driver_id=participated.driver_id
and accident.report_num=participated.report_num;
select report_num,damage_amount from participated;
SELECT p.name
FROM person p 
WHERE (
    SELECT COUNT(pa.driver_id)
    FROM participated pa
    WHERE p.driver_id = pa.driver_id
) > 1 ;

SELECT *
FROM accident
WHERE accident_date = (
    SELECT MAX(accident_date)
    FROM accident
);
select person.name,person.driver_id,AVG(participated.damage_amount)
from person,participated
where person.driver_id=participated.driver_id
group by person.driver_id,person.name;
UPDATE participated
SET damage_amount = 25000

WHERE reg_num = 'KA053408' AND report_num = 12;
select * from participated;
SELECT p.driver_id, p.name,pa.damage_amount
FROM person p,participated pa
WHERE p.driver_id=pa.driver_id and pa.damage_amount = (select MAX(damage_amount) from participated)
select car.model,sum(participated.damage_amount) as total_damage_amount
from car,participated
where car.reg_num=participated.reg_num
group by car.model
having sum(participated.damage_amount)>20000; 
create view summary_accidents as select count(distinct driver_id) as total_count,sum(damage_amount) as total_damage_amount from participated;    
select * from summary_accidents;
SELECT * FROM PARTICIPATED ORDER BY DAMAGE_AMOUNT DESC;
SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND DAMAGE_AMOUNT>(SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED);


