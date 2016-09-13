drop table loyalty_transactions;

commit work;


CREATE TABLE loyalty_transactions (
		id					VARCHAR(32)			not null,
		amount				INTEGER				null,
		description			LONG VARCHAR		null,
		transaction_date	TIMESTAMP			null,
		profile_id			VARCHAR(32)			null,
		primary key(id)		
);

CREATE TABLE loyalty_user_transactions (
		user_id                 VARCHAR(32)     not null references dps_user(id),
        loyalty_trans_id		VARCHAR(32)     not null references loyalty_transactions(id),
        sequence_num  			INTEGER,
        primary key(user_id, loyalty_trans_id)
);

commit work;