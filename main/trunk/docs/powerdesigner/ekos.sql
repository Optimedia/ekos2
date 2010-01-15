create sequence S_eko_account;

create sequence S_eko_content;

create sequence S_eko_detail_address;

create sequence S_eko_detail_address_type;

create sequence S_eko_detail_education;

create sequence S_eko_detail_education_level;

create sequence S_eko_detail_language;

create sequence S_eko_detail_professional;

create sequence S_eko_membership;

create sequence S_eko_node;

create sequence S_eko_role;

create sequence S_eko_tag;

create sequence S_eko_user_tag;

create table eko_account (
   account_id           SERIAL not null,
   email                VARCHAR(200)         not null,
   name                 VARCHAR(128)         not null,
   status               INT2                 not null
      constraint CKC_STATUS_EKO_ACCO check (status in (1,2,3,4,5)),
   constraint PK_EKO_ACCOUNT primary key (account_id)
);

comment on column eko_account.status is
'1-Temporário
2-Ativo
3-Desativado
4-Bloqueado
5-Apagado';

create unique index uk_account_email on eko_account (
email
);

create unique index uk_account_name on eko_account (
name
);

create table eko_detail_address (
   detail_address_id    SERIAL not null,
   profile_id           INT8                 null,
   detail_address_type_id INT8                 null,
   country_name         VARCHAR(128)         null,
   state_name           VARCHAR(128)         null,
   city_name            VARCHAR(128)         null,
   town_name            VARCHAR(128)         null,
   address_part1        CHAR(10)             null,
   address_part2        CHAR(10)             null,
   zipcode              CHAR(10)             null,
   constraint PK_EKO_DETAIL_ADDRESS primary key (detail_address_id)
);

create table eko_detail_address_type (
   detail_address_type_id SERIAL not null,
   name                 VARCHAR(50)          not null,
   constraint PK_EKO_DETAIL_ADDRESS_TYPE primary key (detail_address_type_id)
);

create table eko_detail_education (
   detail_education_id  SERIAL not null,
   profile_id           INT8                 null,
   detail_education_level_id INT8                 null,
   institution          VARCHAR(128)         null,
   year                 INT2                 null,
   status               INT2                 null,
   course               VARCHAR(128)         null,
   title                VARCHAR(128)         null,
   constraint PK_EKO_DETAIL_EDUCATION primary key (detail_education_id)
);

create table eko_detail_education_level (
   detail_education_level_id SERIAL not null,
   name                 VARCHAR(128)         not null,
   constraint PK_EKO_DETAIL_EDUCATION_LEVEL primary key (detail_education_level_id)
);

create table eko_detail_language (
   detail_language_id   SERIAL not null,
   profile_id           INT8                 null,
   language_name        VARCHAR(128)         null,
   speech               INT2                 null,
   writing              INT2                 null,
   reading              INT2                 null,
   constraint PK_EKO_DETAIL_LANGUAGE primary key (detail_language_id)
);

create table eko_detail_professional (
   detail_professional_id SERIAL not null,
   profile_id           INT8                 null,
   company              VARCHAR(128)         null,
   "position"           VARCHAR(128)         null,
   description          TEXT                 null,
   country_name         VARCHAR(128)         null,
   state_name           VARCHAR(128)         null,
   city_name            VARCHAR(128)         null,
   beginDate            DATE                 null,
   endDate              DATE                 null,
   constraint PK_EKO_DETAIL_PROFESSIONAL primary key (detail_professional_id)
);

create table eko_friend (
   profile_id_i         INT8                 not null,
   profile_id_you       INT8                 not null,
   constraint PK_EKO_FRIEND primary key (profile_id_i, profile_id_you)
);

create table eko_group (
   group_id             INT8                 not null,
   constraint PK_EKO_GROUP primary key (group_id)
);

create table eko_ignore (
   profile_id_i         INT8                 not null,
   profile_id_you       INT8                 not null,
   constraint PK_EKO_IGNORE primary key (profile_id_i, profile_id_you)
);

create table eko_membership (
   membership_id        SERIAL not null,
   node_id              INT8                 not null,
   group_id             INT8                 not null,
   user_id              INT8                 not null,
   status               INT2                 not null,
   constraint PK_EKO_MEMBERSHIP primary key (membership_id)
);

create unique index uk_membership on eko_membership (
node_id,
group_id,
user_id
);

create table eko_node (
   node_id              SERIAL not null,
   name                 VARCHAR(128)         not null,
   private_content      INT2                 not null,
   constraint PK_EKO_NODE primary key (node_id)
);

create table eko_profile (
   profile_id           INT8                 not null,
   alias                VARCHAR(50)          null,
   small_avatar         CHAR(10)             null,
   large_avatar         CHAR(10)             null,
   sex                  VARCHAR(150)         null,
   birthday             DATE                 null,
   constraint PK_EKO_PROFILE primary key (profile_id)
);

create table eko_recomendation (
   recomendation_id     INT8                 not null,
   emails               CHAR(10)             null,
   constraint PK_EKO_RECOMENDATION primary key (recomendation_id)
);

create table eko_role (
   role_id              SERIAL not null,
   name                 VARCHAR(50)          not null,
   constraint PK_EKO_ROLE primary key (role_id)
);

create table eko_tag (
   tag_id               SERIAL not null,
   tag                  VARCHAR(128)         not null,
   count                INT8                 not null,
   constraint PK_EKO_TAG primary key (tag_id)
);

create unique index uk_tag on eko_tag (
tag
);

create table eko_user (
   user_id              INT8                 not null,
   role_id              INT8                 not null,
   first_name           VARCHAR(50)          not null,
   last_name            VARCHAR(50)          not null,
   password             VARCHAR(150)         not null,
   constraint PK_EKO_USER primary key (user_id)
);

create table eko_user_tag (
   user_tag_id          SERIAL not null,
   user_id              INT8                 not null,
   tag_id               INT8                 not null,
   preferred_name       VARCHAR(128)         not null,
   count                INT8                 not null,
   constraint PK_EKO_USER_TAG primary key (user_tag_id)
);

create unique index uk_user_tag on eko_user_tag (
user_id,
tag_id
);

alter table eko_detail_address
   add constraint FK_EKO_DETA_REFERENCE_EKO_PROF foreign key (profile_id)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_detail_address
   add constraint FK_EKO_DETA_REFERENCE_EKO_DETA foreign key (detail_address_type_id)
      references eko_detail_address_type (detail_address_type_id)
      on delete restrict on update restrict;

alter table eko_detail_education
   add constraint FK_EKO_DETA_REFERENCE_EKO_PROF foreign key (profile_id)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_detail_education
   add constraint FK_EKO_DETA_REFERENCE_EKO_DETA foreign key (detail_education_level_id)
      references eko_detail_education_level (detail_education_level_id)
      on delete restrict on update restrict;

alter table eko_detail_language
   add constraint FK_EKO_DETA_REFERENCE_EKO_PROF foreign key (profile_id)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_detail_professional
   add constraint FK_EKO_DETA_REFERENCE_EKO_PROF foreign key (profile_id)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_friend
   add constraint FK_EKO_FRIE_REFERENCE_EKO_PROF2 foreign key (profile_id_i)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_friend
   add constraint FK_EKO_FRIE_REFERENCE_EKO_PROF foreign key (profile_id_you)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_group
   add constraint FK_EKO_GROU_REFERENCE_EKO_ACCO foreign key (group_id)
      references eko_account (account_id)
      on delete restrict on update restrict;

alter table eko_ignore
   add constraint FK_EKO_IGNO_REFERENCE_EKO_PROF foreign key (profile_id_i)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_ignore
   add constraint FK_EKO_IGNO_REFERENCE_EKO_PROF2 foreign key (profile_id_you)
      references eko_profile (profile_id)
      on delete restrict on update restrict;

alter table eko_membership
   add constraint FK_EKO_MEMB_REFERENCE_EKO_NODE foreign key (node_id)
      references eko_node (node_id)
      on delete restrict on update restrict;

alter table eko_membership
   add constraint FK_EKO_MEMB_REFERENCE_EKO_GROU foreign key (group_id)
      references eko_group (group_id)
      on delete restrict on update restrict;

alter table eko_membership
   add constraint FK_EKO_MEMB_REFERENCE_EKO_USER foreign key (user_id)
      references eko_user (user_id)
      on delete restrict on update restrict;

alter table eko_profile
   add constraint FK_EKO_PROF_REFERENCE_EKO_USER foreign key (profile_id)
      references eko_user (user_id)
      on delete restrict on update restrict;

alter table eko_recomendation
   add constraint FK_EKO_RECO_REFERENCE_EKO_INCR foreign key (recomendation_id)
      references eko_increment (increment_id)
      on delete restrict on update restrict;

alter table eko_user
   add constraint FK_EKO_USER_REFERENCE_EKO_ACCO foreign key (user_id)
      references eko_account (account_id)
      on delete restrict on update restrict;

alter table eko_user
   add constraint FK_EKO_USER_REFERENCE_EKO_ROLE foreign key (role_id)
      references eko_role (role_id)
      on delete restrict on update restrict;

alter table eko_user_tag
   add constraint FK_EKO_USER_REFERENCE_EKO_USER foreign key (user_id)
      references eko_user (user_id)
      on delete restrict on update restrict;

alter table eko_user_tag
   add constraint FK_EKO_USER_REFERENCE_EKO_TAG foreign key (tag_id)
      references eko_tag (tag_id)
      on delete restrict on update restrict;

