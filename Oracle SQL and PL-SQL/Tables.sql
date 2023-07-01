Create table ra_user (
    aid int primary key,
    name varchar(20) not null,
    age int,
    sex varchar(1),
    city varchar(20),
    pincode int,
    street varchar(20),
    door_no int,
    state varchar(20),
    login_id varchar(20) not null,
    password varchar(20) not null
);

Create table user_contact (
    aid int not null,
    phone_no varchar(10) not null,
    primary key(aid, phone_no),
    foreign key(aid) references ra_user(aid)
);

Create table owner (
    aid int primary key,
    profession varchar(20),
    Foreign key(aid) references ra_user(aid)
);

Create table tenant (
    aid int primary key,
    marital_status varchar(1),
    Foreign key(aid) references ra_user(aid)
);

Create table manager (
    aid int primary key,
    lvl int,
    Foreign key(aid) references ra_user(aid)
);

Create table property (
    pid int primary key,
    rent_per_month int not null,
    no_of_floors int not null,
    year_of_construction int not null,
    available_start_date date not null,
    available_end_date date not null,
    hike int not null,
    total_area int not null,
    plinth_area int not null,
    owner_id int,
    tenant_id int,
    manager_id int,
    city varchar(20) not null,
    pincode int not null,
    street varchar(20) not null,
    door_no int not null,
    state varchar(20) not null,
    foreign key(owner_id) references owner(aid),
    foreign key(tenant_id) references tenant(aid),
    foreign key(manager_id) references manager(aid)
);

Create table residential (
    pid int primary key,
    no_of_bedrooms int not null,
    flat_flag int not null,
    flat_maintenance_charge int,
    independent_house_flag int not null,
    amenities varchar(20),
    foreign key (pid) references property(pid),
    check(flat_flag>=0 and flat_flag<=1)
);

Create table rent (
    aid int not null,
    pid int not null,
    start_date date not null,
    end_date date not null,
    rent_per_month int not null,
    agency_commission varchar(20) not null,
    hike int not null,
    Primary key(aid, pid, start_date),
    foreign key(pid) references property(pid),
    foreign key(aid) references ra_user(aid)
);

Create table prev_rented (
    aid int not null,
    pid int not null,
    start_date date not null,
    end_date date not null,
    rent int not null,
    Primary key(aid, pid, start_date),
    foreign key (pid) references property(pid),
    foreign key(aid) references tenant(aid)
);

Create table commercial (
    pid int primary key,
    shop_flag int not null,
    shop_type varchar(20),
    warehouse_flag int not null,
    capacity int,
    foreign key (pid) references property(pid),
    check(shop_flag>=0 and shop_flag<=1),
    check(warehouse_flag>=0 and warehouse_flag<=1)
);