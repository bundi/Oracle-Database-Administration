-- Range partitioning

create table sales1
(
customer_id number,
sales_date date,
order_amount number,
region varchar2(10)
)
partition by range(sales_date)
(
partition p1506 values less than (to_date('01-jan-2015', 'dd-mon-yyyy')),
partition p1507 values less than (to_date('01-feb-2015', 'dd-mon-yyyy')),
partition p1508 values less than (to_date('01-mar-2015', 'dd-mon-yyyy')),
partition p1509 values less than (to_date('01-apr-2015', 'dd-mon-yyyy')),
partition p1510 values less than (to_date('01-may-2015', 'dd-mon-yyyy')),
partition p1511 values less than (to_date('01-jun-2015', 'dd-mon-yyyy')),
partition p1512 values less than (to_date('01-jul-2015', 'dd-mon-yyyy')),
partition p1513 values less than (to_date('01-aug-2015', 'dd-mon-yyyy')),
partition p1514 values less than (to_date('01-sep-2015', 'dd-mon-yyyy')),
partition p1515 values less than (to_date('01-oct-2015', 'dd-mon-yyyy')),
partition p1516 values less than (to_date('01-nov-2015', 'dd-mon-yyyy')),
partition p1517 values less than (to_date('01-dec-2015', 'dd-mon-yyyy')),
partition p1518 values less than (maxvalue)
);


insert into sales1 values(1, '12-jan-2015',10,'east');
insert into sales1 values(1, '12-feb-2015',10,'east');
insert into sales1 values(1, '12-mar-2015',10,'east');
insert into sales1 values(2, '12-mar-2016',10,'east');

select * from sales1;

select * from sales1 partition (p1508);

select * from sales1 where sales_date='12-jan-2015';


-- List partitioning

create table sales2
(
customer_id number,
sales_date date,
sales_amount number,
region varchar2(10)
)
partition by list (region)
(
partition pe values ('east'),
partition pw values ('west'),
partition psn values ('south', 'north')
);

insert into sales2 values (1, '12-jan-2015',10,'east');
insert into sales2 values (2, '12-jan-2015',10,'east');
insert into sales2 values (3, '12-jan-2015',10,'west');
insert into sales2 values (4, '12-jan-2015',10,'south');
insert into sales2 values (5, '12-jan-2015',10,'north');

commit;


select * from sales2 partition (psn);
select * from sales2 partition (pe);


--HASH Partitioning

create table sales3
(
customer_id number,
sales_date date,
sales_amount number,
region varchar2(10)
)
partition by hash (customer_id)
(
partition c1,
partition c2,
partition c3,
partition c4
);

insert into sales3 values (1, '12-jan-2015',10,'east');
insert into sales3 values (2, '12-jan-2015',10,'east');
insert into sales3 values (3, '12-jan-2015',10,'west');
insert into sales3 values (4, '12-jan-2015',10,'south');
insert into sales3 values (5, '12-jan-2015',10,'north');

select * from sales3 partition (c4);

-- Composite partitioning
create table sales4
(
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by range(order_date)
subpartition by hash(customer_id) subpartitions 4
(partition sales_p1507 values less than (to_date('2015-07-01', 'yyyy-mm-dd')),
partition sales_p1508 values less than (to_date('2015-08-01', 'yyyy-mm-dd')),
partition sales_p1509 values less than (to_date('2015-09-01', 'yyyy-mm-dd')),
partition sales_pmax values less than (maxvalue)
);

insert into sales4 values (1, '07-jul-2015',100,'east');
insert into sales4 values (2, '08-aug-2015',100,'east');
insert into sales4 values (3, '08-sep-2015',100,'west');

select * from sales4 partition (sales_pmax);


-- Interval Partition
create table sales5
(
customer_id number,
order_date date,
order_amount number,
region varchar2(10)
)
partition by range(order_date)
interval (numtoyminterval(1, 'month'))
(
partition sales_p1507 values less than (to_date('2015-07-01', 'yyyy-mm-dd')),
partition sales_p1508 values less than (to_date('2015-08-01', 'yyyy-mm-dd')),
partition sales_p1509 values less than (to_date('2015-09-01', 'yyyy-mm-dd'))
);

insert into sales5 values (1, '12-jan-2015',100,'east');
insert into sales5 values (2, '12-oct-2015',100,'east');
insert into sales5 values (3, '08-sep-2015',100,'west');


select * from all_tab_partitions where table_name = 'SALES5';

insert into sales5 values (6, '12-nov-2016', 100, 'east');



Partition without max
create table sales11
(
customer_id number,
sales_date date,
order_amount number,
region varchar2(10)
)
partition by range(sales_date)
(
partition p1506 values less than (to_date('01-jan-2015', 'dd-mon-yyyy')),
partition p1507 values less than (to_date('01-feb-2015', 'dd-mon-yyyy')),
partition p1508 values less than (to_date('01-mar-2015', 'dd-mon-yyyy')),
partition p1509 values less than (to_date('01-apr-2015', 'dd-mon-yyyy')),
partition p1510 values less than (to_date('01-may-2015', 'dd-mon-yyyy')),
partition p1511 values less than (to_date('01-jun-2015', 'dd-mon-yyyy')),
partition p1512 values less than (to_date('01-jul-2015', 'dd-mon-yyyy')),
partition p1513 values less than (to_date('01-aug-2015', 'dd-mon-yyyy')),
partition p1514 values less than (to_date('01-sep-2015', 'dd-mon-yyyy')),
partition p1515 values less than (to_date('01-oct-2015', 'dd-mon-yyyy')),
partition p1516 values less than (to_date('01-nov-2015', 'dd-mon-yyyy')),
partition p1517 values less than (to_date('01-dec-2015', 'dd-mon-yyyy'))

);

insert into sales11 values(1, '12-jan-2015',10,'east');
insert into sales11 values(1, '12-feb-2015',10,'east');
insert into sales11 values(1, '12-mar-2015',10,'east');
insert into sales11 values(2, '12-mar-2016',10,'east');
