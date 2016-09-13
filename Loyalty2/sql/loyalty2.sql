drop table dcspp_loyalty_points_payment_group;

commit work;

CREATE TABLE loyalty_points_payment_group (
		id					VARCHAR(32)				NOT NULL,
		user_id             VARCHAR(32)     		not null references dps_user(id),
		loyalty_points		INTEGER					null,
		primary key(id)	
);

CREATE TABLE loyalty_users_payment_groups (
		id							VARCHAR(32)				NOT NULL,
		loyalty_points_group_id   	VARCHAR(32)     		not null references loyalty_points_payment_group(id),
		primary key(id)	
);

CREATE TABLE loyalty_status (
		status_id			VARCHAR(32)				NOT NULL references dcspp_pay_status(status_id),
		auth_expiration     TIMESTAMP	     		null,
		primary key(status_id)	
);


commit work;