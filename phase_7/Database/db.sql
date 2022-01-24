create table categories
(
    id   serial
        constraint categories_pkey
            primary key,
    name varchar(255) not null
);

alter table categories
    owner to postgres;

create table feature_types
(
    id    serial
        constraint feature_types_pkey
            primary key,
    title varchar(255) not null,
    price integer      not null
);

alter table feature_types
    owner to postgres;

create table info_detail
(
    id    serial
        constraint info_detail_pkey
            primary key,
    title varchar(255) not null
);

alter table info_detail
    owner to postgres;

create table payments
(
    id         serial
        constraint payments_pkey
            primary key,
    amount     integer   not null,
    created_at timestamp not null
);

alter table payments
    owner to postgres;

create table provinces
(
    id   serial
        constraint provinces_pkey
            primary key,
    name varchar(255) not null
);

alter table provinces
    owner to postgres;

create table cities
(
    id          serial
        constraint cities_pkey
            primary key,
    name        varchar(255) not null,
    province_id integer
        constraint cities_province_id_fkey
            references provinces
);

alter table cities
    owner to postgres;

create table districts
(
    id      serial
        constraint districts_pkey
            primary key,
    name    varchar(255) not null,
    city_id integer
        constraint districts_city_id_fkey
            references cities
);

alter table districts
    owner to postgres;

create table users
(
    id          serial
        constraint users_pkey
            primary key,
    first_name  varchar(255) not null,
    last_name   varchar(255) not null,
    birth_date  date         not null,
    register_at timestamp    not null,
    password    varchar(512) not null,
    city_id     integer
        constraint users_city_id_fkey
            references cities
);

alter table users
    owner to postgres;

create table admins
(
    user_id     integer not null
        constraint admins_pkey
            primary key
        constraint admins_user_id_fkey
            references users,
    admin_level adminlevelenum
);

alter table admins
    owner to postgres;

create table emails
(
    id          serial
        constraint emails_pkey
            primary key,
    email       varchar(255) not null,
    user_id     integer
        constraint emails_user_id_fkey
            references users,
    token       varchar(100),
    is_verified boolean      not null,
    verified_at timestamp    not null
);

alter table emails
    owner to postgres;

create table phones
(
    id          serial
        constraint phones_pkey
            primary key,
    number      varchar(10)          not null,
    user_id     integer
        constraint phones_user_id_fkey
            references users,
    otp         varchar(6),
    is_verified boolean default true not null,
    verified_at timestamp
);

alter table phones
    owner to postgres;

create table ads
(
    id                   serial
        constraint ads_pkey
            primary key,
    title                varchar(255)  not null,
    description          varchar(1024) not null,
    created_at           timestamp     not null,
    expired_at           timestamp     not null,
    user_id              integer
        constraint ads_user_id_fkey
            references users,
    accepted_by_admin_id integer
        constraint ads_accepted_by_admin_id_fkey
            references admins,
    district_id          integer
        constraint ads_district_id_fkey
            references districts,
    category_id          integer
        constraint ads_category_id_fkey
            references categories
);

alter table ads
    owner to postgres;

create table features
(
    id              serial
        constraint features_pkey
            primary key,
    name            varchar(255) not null,
    advertising_id  integer
        constraint features_advertising_id_fkey
            references ads,
    feature_type_id integer
        constraint features_feature_type_id_fkey
            references feature_types,
    payment_id      integer
        constraint features_payment_id_key
            unique
        constraint features_payment_id_fkey
            references payments
);

alter table features
    owner to postgres;

create table info
(
    info_value     varchar(255) not null,
    info_detail_id integer      not null
        constraint info_info_detail_id_fkey
            references info_detail,
    advertising_id integer      not null
        constraint info_advertising_id_fkey
            references ads,
    constraint info_pkey
        primary key (info_detail_id, advertising_id)
);

alter table info
    owner to postgres;

create table photos
(
    id             serial
        constraint photos_pkey
            primary key,
    url            varchar(512) not null,
    advertising_id integer
        constraint photos_advertising_id_fkey
            references ads
);

alter table photos
    owner to postgres;

create table reports
(
    id             serial
        constraint reports_pkey
            primary key,
    description    varchar(255) not null,
    user_id        integer
        constraint reports_user_id_fkey
            references users,
    advertising_id integer
        constraint reports_advertising_id_fkey
            references ads
);

alter table reports
    owner to postgres;


