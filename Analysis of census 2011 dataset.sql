/*
TITLE -Analysis of Census 2011 dataset 

overview :- Analyis of Cenus 2011 dataset using SQL
*/





select * from project.dbo.data1;

select * from project.dbo.data2;

--1)number of rows into our dataset

select count(*) from project..data1
select count(*) from project..data2

-- 2)dataset for jharkhand and bihar

select * from project..data1 where state in ('Jharkhand' ,'Bihar')

--3) population of India

select sum(population) as Population from project..data2
--result-1210854977

-- 4)avg growth statewise

select state,avg(growth)*100 avg_growth from project..data1 group by state ;

--5) avg sex ratio statewise

select state,round(avg(sex_ratio),0) avg_sex_ratio from project..data1 group by state order by avg_sex_ratio desc;
-- Result- Kerala has the highest sex ratio with score 1080, followed by puducherry with score 1075.

-- 6) avg literacy rate statewise
 
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1 
group by state having round(avg(literacy),0)>90 order by avg_literacy_ratio desc ;


-- 7) top 3 state showing highest growth ratio


select top 3 state,avg(growth)*100 avg_growth from project..data1 group by state order by avg_growth desc ;
--Result- states with highest sex ratio are nagaland with score 82.28 , followed by dadara nagar haveli with score 55.88 and daman with score 42.74.

--8) bottom 3 state showing lowest sex ratio

select top 3 state,round(avg(sex_ratio),0) avg_sex_ratio from project..data1 group by state order by avg_sex_ratio asc;
--Result- states with lowest sex ratio are dadra nagar haveli with score 774, followed by daman with score 783 and chandigarh with score 818.

-- 9)top and bottom 3 states in literacy state

drop table if exists #topstates;
create table #topstates
( state nvarchar(255),
  topstate float

  )

insert into #topstates
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1 
group by state order by avg_literacy_ratio desc;

select top 3 * from #topstates order by #topstates.topstate desc;

drop table if exists #bottomstates;
create table #bottomstates
( state nvarchar(255),
  bottomstate float

  )

insert into #bottomstates
select state,round(avg(literacy),0) avg_literacy_ratio from project..data1 
group by state order by avg_literacy_ratio desc;

select top 3 * from #bottomstates order by #bottomstates.bottomstate asc;


--10) union opertor

select * from (
select top 3 * from #topstates order by #topstates.topstate desc) a

union

select * from (
select top 3 * from #bottomstates order by #bottomstates.bottomstate asc) b;

-- 11) states starting with letter a

select distinct state from project..data1 where lower(state) like 'a%' or lower(state) like 'b%';
--Result-Andaman And Nicobar Islands,Andhra Pradesh,Arunachal Pradesh,Assam,Bihar

select distinct state from project..data1 where lower(state) like 'a%' and lower(state) like '%m' ;
--Result- Assam

/* Conclusion
- population of India - 1210854977
- Kerala has the highest sex ratio with score 1080, followed by puducherry with score 1075.
- Top 3 states with highest sex ratio are nagaland with score 82.28 , followed by dadara nagar haveli with score 55.88 and daman with score 42.74.
- Top 3 states with lowest sex ratio are dadra nagar haveli with score 774, followed by daman with score 783 and chandigarh with score 818.
*/