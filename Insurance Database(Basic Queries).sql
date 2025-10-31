create database employee2
use employee2;
create table dept (
  deptno int primary key,
  dname varchar(50),
  dloc varchar(50)
);
create table project (
  pno int primary key,
  pname varchar(50),
  ploc varchar(50)
);
create table employee (
  empno int primary key,
  ename varchar(50),
  mgr_no int,
  hiredate date,
  sal decimal(10,2),
  deptno int,
  foreign key (deptno) references dept(deptno)
);
create table assigned_to (
  empno int,
  pno int,
  job_role varchar(50),
  primary key (empno, pno),
  foreign key (empno) references employee(empno),
  foreign key (pno) references project(pno)
);
create table incentives (
  empno int,
  incentive_date date,
  incentive_amount decimal(10,2),
  primary key (empno, incentive_date),
  foreign key (empno) references employee(empno)
);
insert into dept (deptno, dname, dloc) values
(10, 'hr', 'bengaluru'),
(20, 'it', 'hyderabad'),
(30, 'rnd', 'mysuru'),
(40, 'finance', 'chennai'),
(50, 'operations', 'pune'),
(60, 'ecommerce', 'delhi'),
(70, 'design', 'mumbai');
insert into project (pno, pname, ploc) values
(101, 'alpha migration', 'bengaluru'),
(102, 'mobile app', 'hyderabad'),
(103, 'cloud computing', 'mysuru'),
(104, 'erp portal', 'chennai'),
(105, 'logistics revamp', 'pune'),
(106, 'customer review portal', 'bengaluru'),
(107, 'data analytics', 'delhi'),
(108, 'support automation', 'mumbai');
insert into employee (empno, ename, mgr_no, hiredate, sal, deptno) values
(1001, 'alice', null, '2016-02-10', 120000.00, 20),
(1002, 'bob', 1001, '2017-05-21', 90000.00, 20),
(1003, 'carol', 1001, '2018-08-01', 85000.00, 10),
(1004, 'dave', 1002, '2019-11-15', 72000.00, 30),
(1005, 'eve', 1002, '2020-03-03', 68000.00, 20),
(1006, 'frank', 1003, '2021-07-20', 65000.00, 30),
(1007, 'grace', 1001, '2015-12-01', 110000.00, 40),
(1008, 'hari', 1002, '2022-04-10', 60000.00, 50),
(1009, 'isha', 1001, '2021-08-15', 70000.00, 60),
(1010, 'john', 1002, '2022-12-05', 58000.00, 70);
insert into assigned_to (empno, pno, job_role) values
(1001, 101, 'manager'),
(1002, 101, 'lead developer'),
(1002, 102, 'mobile lead'),
(1003, 103, 'researcher'),
(1004, 103, 'data engineer'),
(1005, 102, 'qa engineer'),
(1006, 105, 'operations analyst'),
(1007, 104, 'finance manager'),
(1008, 106, 'marketing associate'),
(1009, 107, 'marketing analyst'),
(1010, 108, 'support engineer'),
(1005, 106, 'integration lead');
insert into incentives (empno, incentive_date, incentive_amount) values
(1001, '2024-02-20', 7000.00),
(1002, '2023-03-31', 5000.00),
(1002, '2024-03-31', 6000.00),
(1003, '2023-06-15', 4000.00),
(1004, '2023-12-15', 3000.00),
(1005, '2024-01-10', 2500.00),
(1007, '2023-11-30', 4500.00),
(1009, '2024-04-05', 3500.00);
select * from dept;
select * from project;
select * from employee;
select * from assigned_to;
select * from incentives;
select distinct empno from assigned_to where pno in(select pno from project where ploc in('bengaluru','hyderabad','mysuru'));
                                                                                     
select distinct empno,ename from employee where not exists(select 1 from incentives where employee.empno=incentives.empno);

select employee.empno,employee.ename,employee.deptno, assigned_to.job_role,dept.dloc,project.ploc
from employee,dept,project,assigned_to
where employee.empno=assigned_to.empno
and employee.deptno=dept.deptno
and project.pno=assigned_to.pno
and dept.dloc=project.ploc;

select e2.ename as mgr_name
from employee e1,employee e2 where
e1.mgr_no=e2.empno
group by e2.ename
having count(e1.empno) =(select max(emp_count) from (select count(empno) as emp_count from employee where mgr_no is not null group by mgr_no) as c);

select * from employee where empno in(select empno from incentives where incentive_amount=(select MAX(incentive_amount) from incentives where incentive_amount<(select max(incentive_amount) from incentives where incentive_date like '2024-%')
and incentive_date like '2024-%')
and incentive_date like '2024-%');

select e.ename from
employee e,employee m
where e.mgr_no=m.empno
and e.deptno=m.deptno;
