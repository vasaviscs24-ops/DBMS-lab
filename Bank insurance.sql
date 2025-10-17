create database bank1;
use bank1;
create table Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets DECIMAL(12,2)
);

create table BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);
create table BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(12,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
    
        
);

create table Deposit (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
	FOREIGN KEY (accno) REFERENCES BankAccount(accno)
    
        
);

create table Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(12,2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
        
);
insert into  Branch values
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 20000),
('SBI_Jantarmantar', 'Delhi', 20000);

insert into BankCustomer values
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

insert into  BankAccount values
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 5000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(7, 'SBI_ResidencyRoad', 4000),
(8, 'SBI_ParlimentRoad', 3000),
(9, 'SBI_ResidencyRoad', 5000),
(10, 'SBI_ParlimentRoad', 3000),
(11, 'SBI_Jantarmantar', 2000);

insert into Deposit values
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);

insert into Loan values
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);
select * from Branch;
select * from BankCustomer;
select * from BankAccount;
select * from Deposit;
select * from Loan;

alter table Branch rename column assets to assets_in_lakhs;
select * from Branch;

UPDATE BankAccount
SET branch_name = 'SBI_ParlimentRoad'
WHERE accno = 7;
UPDATE BankAccount
SET branch_name = 'SBI_ResidencyRoad'
WHERE accno = 8;
UPDATE BankAccount
SET branch_name = 'SBI_ParlimentRoad'
WHERE accno = 9;
UPDATE BankAccount
SET branch_name = 'SBI_ResidencyRoad'
WHERE accno = 10;
commit;
select * from BankAccount;



select Deposit.customer_name from Deposit,BankAccount
where Deposit.accno=BankAccount.accno and  BankAccount.branch_name='SBI_ResidencyRoad'
group by Deposit.customer_name having count(Deposit.accno)>=2;

create view loan_summary as select branch_name,sum(amount) from loan 
group by branch_name;
select * from loan_summary;

select  distinct BankCustomer.customer_name from BankCustomer,Branch,BankAccount,Deposit
where Branch.branch_city='Delhi' and BankAccount.accno=Deposit.accno and Branch.branch_name=BankAccount.branch_name
and Deposit.customer_name=BankCustomer.customer_name;

select distinct Deposit.customer_name from Deposit,BankAccount
where Deposit.accno=BankAccount.accno and BankAccount.branch_name IN(Select branch_name from Loan) and 

select distinct BankCustomer.customer_name
from BankCustomer, Deposit, BankAccount, Branch, Loan
where BankCustomer.customer_name = Deposit.customer_name  and Deposit.accno = BankAccount.accno
and BankAccount.branch_name = Branch.branch_name  and Branch.branch_name = Loan.branch_name   and Branch.branch_city = 'Bangalore';

select branch_name from Branch where assets_in_lakhs > ALL (select assets_in_lakhs from Branch where branch_city='Bangalore');

delete from BankAccount where BankAccount.branch_name IN (
select branch_name from Branch where branch_city = 'Bombay'
  );
commit;
select * from BankAccount;

update Loan set amount=1.5*(amount);
select * from Loan;

























