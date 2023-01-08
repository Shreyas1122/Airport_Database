/*creating database called airport*/
create database airport;
use airport;
/*Creating table called passenger_info*/
create table passenger_info(cust_id int,cust_name text(20) not null,Gender,Age,primary key(cust_id));
/*inserting values in the passenger_info table.*/
insert into passenger_info values(1,"ram","male",23);
insert into passenger_info values(2,"ramesh","male",63);
insert into passenger_info values(3,"ritika","female",86);
insert into passenger_info values(4,"swati","female",23);
insert into passenger_info values(5,"kamlesh","male",60);
insert into passenger_info values(6,"ram","female",50);
insert into passenger_info values(7,"ram","male",82);
insert into passenger_info values(8,"ram","male",67);
insert into passenger_info values(9,"gikita","female",23);
insert into passenger_info values(10,"kajol","female",45);
insert into passenger_info values(11,"samarth","male",34);
insert into passenger_info values(12,"bahubal","female",14);
insert into passenger_info values(13,"rajesh","male",13);
insert into passenger_info values(14,"paresh","male",56);
insert into passenger_info values(15,"payal","female",34);

/*creating table plane_info*/
create table plane_info (p_id int,company varchar(20) not null,class text(10),cust_id int,primary key(p_id),foreign key(cust_id) references passenger_info(cust_id));
/*inserting values in plane_info.*/
insert into plane_info values(1,"vistara","economy",1);
insert into plane_info values(2,"air india","economy",2);
insert into plane_info values(3,"emirates","economy",3);
insert into plane_info values(4,"Indigo","business",4);
insert into plane_info values(5,"vistara","premium",5);
insert into plane_info values(6,"us airways","business",6);
insert into plane_info values(7,"qatar airways","first",7);
insert into plane_info values(8,"british airways","first",8);
insert into plane_info values(9,"vistara","economy",9);
insert into plane_info values(10,"lufthasa","economy",10);
insert into plane_info values(11,"air france","business",11);
insert into plane_info values(12,"air canada","economy",12);
insert into plane_info values(13,"klm","first",13);
insert into plane_info values(14,"oman air","business",14);
insert into plane_info values(15,"vistara","economy",15);

/*creating table ticket_info*/
create table ticket_info (t_id int,t_date date not null,amt bigint,cust_id int);
/*inserting values in ticket_info.*/
insert into ticket_info values(1,"2022-04-08",12000,1);
insert into ticket_info values(2,"2022-04-12",10000,2);
insert into ticket_info values(3,"2022-04-12",15000,3);
insert into ticket_info values(4,"2022-04-15",45000,4);
insert into ticket_info values(5,"2022-04-15",35000,5);
insert into ticket_info values(6,"2022-04-23",38000,6);
insert into ticket_info values(7,"2022-04-25",45000,7);
insert into ticket_info values(8,"2022-04-26",54000,8);
insert into ticket_info values(9,"2022-04-28",12000,9);
insert into ticket_info values(10,"2022-04-29",35000,10);
insert into ticket_info values(11,"2022-04-29",45000,11);
insert into ticket_info values(12,"2022-04-29",12000,12);
insert into ticket_info values(13,"2022-04-30",76000,13);
insert into ticket_info values(14,"2022-04-30",54000,14);
insert into ticket_info values(15,"2022-04-31",12000,15);


/*creating table passport_info*/
create table passport_info (pass_id int,issue_date date not null,expire_date date not null,cust_id int,primary key(pass_id),foreign key(cust_id) references passenger_info(cust_id));
/*inserting values in passport_info.*/
insert into passport_info values(1,"2016-02-12","2026-12-23",1);
insert into passport_info values(2,"2014-04-12","2027-03-14",2);
insert into passport_info values(3,"2015-06-16","2027-02-12",3);
insert into passport_info values(4,"2016-02-12","2026-12-23",4);
insert into passport_info values(5,"2013-12-02","2027-02-13",5);
insert into passport_info values(6,"2017-08-13","2029-06-23",6);
insert into passport_info values(7,"2015-03-12","2023-04-13",7);
insert into passport_info values(8,"2013-12-12","2026-03-13",8);
insert into passport_info values(9,"2016-08-18","2027-11-12",9);
insert into passport_info values(10,"2014-06-11","2027-10-22",10);
insert into passport_info values(11,"2016-07-22","2026-11-13",11);
insert into passport_info values(12,"2018-02-17","2027-09-13",12);
insert into passport_info values(13,"2012-05-12","2025-10-22",13);
insert into passport_info values(14,"2013-12-12","2027-11-20",14);
insert into passport_info values(15,"2018-11-13","2026-04-13",15);

/*creating table country_info*/
create table country_info (c_code int ,c_name text(20),pass_id int,primary key(c_code),foreign key(pass_id) references passport_info(pass_id));
/*inserting values in country_info.*/
insert into country_info values(971,"UAE",1);
insert into country_info values(91,"india",2);
insert into country_info values(966,"saudi arabia",3);
insert into country_info values(974,"Qatar",4);
insert into country_info values(968,"oman",5);
insert into country_info values(20,"egypt",6);
 insert into country_info values(98,"iran",7);
  insert into country_info values(93,"afghanistan",8);
insert into country_info values(01,"canada",9);
 insert into country_info values(49,"germany",10);
insert into country_info values(62,"indonesia",11);
insert into country_info values(39,"italy",12);
insert into country_info values(81,"japan",13);
insert into country_info values(52,"mexico",14);
insert into country_info values(92,"pakistan",15);


/*trigger for passenger_info */
/*1)after insert for passenger_info.*/
create table pass_audit_insert(information varchar(100));
delimiter //
create trigger passenger_audit_insert after insert on passenger_info for each row begin
declare id int;
set id=new.cust_id;
insert into pass_audit_insert values(concat("the new row of passenger is inserted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;
/*2)after delete for passenger*/
create table pass_audit_delete(information varchar(100));
delimiter //
create trigger passenger_audit_delete after delete on passenger_info for each row begin
declare id int;
set id=old.cust_id;
insert into pass_audit_delete values(concat("the new row of passenger is deleted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;
/*3)after delete for plane_info*/
create table plane_audit_delete(information varchar(100));
delimiter //
create trigger aero_audit_delete after delete on plane_info  for each row begin
declare id int;
set id=old.p_id;
insert into plane_audit_delete values(concat("the new row of plane is deleted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;
/*4)after dlete for tickewt_info*/
create table ty_audit_delete(information varchar(100));
delimiter //
create trigger ticket_audit_delete after delete on ticket_info  for each row begin
declare id int;
set id=old.t_id;
insert into ty_audit_delete values(concat("the new row of ticket is deleted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;
/*5)after delete for passport_info*/
create table pp_audit_delete(information varchar(100));
delimiter //
create trigger passport_audit_delete after delete on passport_info  for each row begin
declare id int;
set id=old.pass_id;
insert into pp_audit_delete values(concat("the new row of passport is deleted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;
/*6)after delete for country*/ 
create table cotry_audit_delete(information varchar(100));
delimiter //
create trigger country_audit_delete after delete on country_info  for each row begin
declare id int;
set id=old.c_code;
insert into cotry_audit_delete values(concat("the new row of country is deleted with id ",id," at ",date_format(now(), '%d-%m-%y %h:%i:%s %p')));
end //
delimiter ;