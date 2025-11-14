create database supplier;
create table supplier (
    sid int primary key,
    sname varchar(50)
);

create table parts (
    pid int primary key,
    pname varchar(50),
    color varchar(20)
);

create table catalog (
    sid int,
    pid int,
    cost int,
    primary key (sid, pid),
    foreign key (sid) references supplier(sid),
    foreign key (pid) references parts(pid)
);
insert into supplier values
(1, 'Acme Widget Suppliers'),
(2, 'Super Tools Ltd'),
(3, 'Global Traders'),
(4, 'Metal World');
insert into parts values
(10, 'Bolt',  'red'),
(20, 'Nut',   'blue'),
(30, 'Pin',   'red'),
(40, 'Rod',   'green'),
(50, 'Screw', 'red');
insert into catalog values
(1, 10, 50),
(1, 20, 40),
(1, 30, 70),
(1, 40, 65),
(1, 50, 55),

(2, 10, 45),
(2, 20, 38),
(2, 30, 72),
(2, 50, 51),

(3, 10, 52),
(3, 30, 60),
(3, 40, 68),
(3, 50, 58),

(4, 20, 42),
(4, 40, 63);

select pname
from parts
where pid in (
    select pid
    from catalog
);

select sname
from supplier
where sid in (
    select sid
    from catalog
    group by sid
    having count(pid) = (
        select count(pid)
        from parts
    )
);

select s.sname
from supplier s
where not exists (
    select 1
    from parts p
    where p.color = 'red'
      and not exists (
            select 1
            from catalog c
            where c.sid = s.sid
              and c.pid = p.pid
      )
);

SELECT p.pname
FROM Parts p
WHERE EXISTS (
  SELECT 1
  FROM Catalog c
  WHERE c.pid = p.pid
    AND c.sid IN (SELECT s.sid FROM Supplier s WHERE s.sname = 'Acme Widget Suppliers')
)
AND NOT EXISTS (
  SELECT 1
  FROM Catalog c2
  WHERE c2.pid = p.pid
    AND c2.sid IN (SELECT s2.sid FROM Supplier s2 WHERE s2.sname <> 'Acme Widget Suppliers')
);

SELECT DISTINCT C.sid
FROM Catalog C
WHERE C.cost > (
    SELECT AVG(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C.pid
);

SELECT S.sid, S.sname, C.pid, C.cost
FROM Supplier S, Catalog C
WHERE S.sid = C.sid
  AND C.cost = (
        SELECT MAX(C2.cost)
        FROM Catalog C2
        WHERE C2.pid = C.pid
  );





