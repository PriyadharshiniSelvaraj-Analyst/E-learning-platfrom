create database E_Learning_Platform;
use E_Learning_Platform;

create table learners (
learner_id int primary key,
full_name varchar(20) not null,
country varchar(20) not null
 );
 
 create table courses (
 course_id int primary key,
 course_name varchar(20) not null,
 category varchar(20) not null,
 unite_price int not null
 );
 
 create table purchases (
 puchase_id int primary key auto_increment,
 learner_id int,
 course_id int,
 quantity int not null,
 purchase_date date not null,
 foreign key (learner_id) references learners(learner_id),
 foreign key (course_id) references courses(course_id)
 );
 
 
 insert into learners (learner_id, full_name, country)
 value (0001, 'shanthi', 'usa'),
 (0002, 'angel', 'india'),
 (0003, 'mehala', 'srilanka'),
 (0004, 'shanthosh', 'africa'),
 (0005, 'nivetha', 'uk'),
 (0006, 'ramya', 'india');
 
 insert into courses (course_id, course_name, category, unite_price)
 values(01, 'data_analytics', 'ai', 45000),
 (02, 'java', 'programming', 50000),
 (03, 'machine_learning', 'data_science', 50000),
 (04, 'auto_cad', 'design', 60000),
 (05, 'seo', 'marketing', 55000),
 (06, 'de', 'programming', 65000);
 

 insert into purchases (learner_id, course_id, quantity, purchase_date)
 values(0001, 05, 1, '2026-06-03'),
 (0002, 03, 1, '2026-06-26'),
 (0003, 04, 1, '2026-07-14'),
 (0003, 03, 1, '2026-06-08'),
 (0004, 01, 1, '2026-08-20'),
 (0001, 02, 1, '2026-07-26'),
 (0005, 02, 1, '2026-07-26'),
 (0005, 04, 1, '2026-07-20');
 
-- format currency with two decimal --
 alter table courses
 modify column unite_price decimal(10,2);
 select unite_price from courses;
 
 -- alises unite price as tptal revenue --
 select p.quantity, c.unite_price, (p.quantity * c.unite_price) as total_revenue from courses c
 join purchases p 
 on p.course_id = c.course_id ;
 
 -- sorting highest_total and spent first --
 select c.course_name, c.unite_price as highest_total, p.purchase_date as spent_first from courses c
 join purchases p
 on c.course_id = p.course_id
 order by highest_total desc, purchase_date asc;
 
 -- inner joins --
 select l.full_name as leaner_name, l.country as country,
 c.course_name as course_name, c.category as course_category, 
 p.quantity as quantity, p.purchase_date as purchase_date
 from purchases p
 inner join learners l on l.learner_id = p.learner_id
 inner join courses c on p.course_id = c.course_id
 order by country;
 
 -- left join --
select l.learner_id as leaner_id, l.full_name as leaner_name, 
c.course_name as course_name,
p.quantity as quantity, p.purchase_date as purchase_date from learners l
left join purchases p on l.learner_id = p.learner_id
left join courses c on p.course_id = c.course_id
order by leaner_id;
 
 -- right join --
select c.course_name as course_name, c.unite_price as price,
p.purchase_date as date from courses c 
right join purchases p on p.course_id = c.course_id;

-- Analytical Queries --
select l.full_name as leaner_name, l.country as country, 
sum(p.quantity * c.unite_price) as total_spending from learners l
join purchases p on l.learner_id = p.learner_id 
join courses c on c. course_id = p.course_id
group by leaner_name, country;

select c.course_name, sum(p.quantity * unite_price) as total_qsold from courses c
join purchases p on c.course_id = p.course_id
group by course_name
order by total_qsold desc
limit 3;

select count(distinct(l.learner_id)) as unique_learner, 
c.course_name as courses, c.category as category,
sum(p.quantity * c.unite_price) as total_revenue
from learners l join purchases p on l.learner_id = p.learner_id
join courses c on c.course_id = p.course_id
group by c.course_name, c.category;


select l.full_name as learner_name,
count(distinct c.category) as category_purchased
from learners as l
join purchases p on l.learner_id = p.learner_id
join courses c on c.course_id = p.course_id
group by l.learner_id, l.full_name
having count(distinct c.category) > 1
order by category_purchased desc;


select c.course_id, c.course_name from courses as c
left join purchases p 
on c.course_id = p.course_id
where p.puchase_id is null;