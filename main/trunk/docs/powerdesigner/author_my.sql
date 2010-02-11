/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11/02/2010 14:51:04                          */
/*==============================================================*/


/*==============================================================*/
/* Table: ath_header                                            */
/*==============================================================*/
create table ath_header
(
   id_header            int not null auto_increment,
   title                varchar(140) not null,
   fg_image             varchar(250) not null,
   status               tinyint,
   primary key (id_header)
);

/*==============================================================*/
/* Table: ath_link                                              */
/*==============================================================*/
create table ath_link
(
   id_page              int not null,
   id_media             int not null,
   primary key (id_page, id_media)
);

/*==============================================================*/
/* Table: ath_log_header                                        */
/*==============================================================*/
create table ath_log_header
(
   id_user              int,
   date_event           datetime,
   version              tinyint not null,
   id_header            int not null,
   title                varchar(140) not null,
   fg_image             varchar(250) not null,
   status               tinyint,
   primary key (version, id_header)
);

/*==============================================================*/
/* Table: ath_log_presentation                                  */
/*==============================================================*/
create table ath_log_presentation
(
   id_user              int,
   date_event           datetime,
   version              tinyint not null,
   id_presentation      int not null,
   id_subject           int not null,
   id_skin              int not null,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (id_presentation, version)
);

/*==============================================================*/
/* Table: ath_log_skin                                          */
/*==============================================================*/
create table ath_log_skin
(
   id_user              int,
   date_event           datetime,
   version              tinyint not null,
   id_skin              int not null,
   title                varchar(140) not null,
   bg_image             varchar(250) not null,
   fg_title             varchar(8) not null,
   fg_text              varchar(8) not null,
   status               tinyint not null,
   primary key (version, id_skin)
);

/*==============================================================*/
/* Table: ath_log_slide                                         */
/*==============================================================*/
create table ath_log_slide
(
   id_user              int,
   date_event           datetime,
   version              tinyint not null,
   id_page              int not null,
   id_type_slide        int not null,
   id_header            int not null,
   id_presentation      int not null,
   page_order           smallint not null,
   title                varchar(140) not null,
   title_menu           varchar(140) not null,
   text_body            text,
   status               tinyint not null,
   primary key (version, id_page)
);

/*==============================================================*/
/* Table: ath_log_subject                                       */
/*==============================================================*/
create table ath_log_subject
(
   id_user              int,
   date_event           datetime,
   version              tinyint not null,
   id_subject           int not null,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (id_subject, version)
);

/*==============================================================*/
/* Table: ath_presentation                                      */
/*==============================================================*/
create table ath_presentation
(
   id_presentation      int not null auto_increment,
   id_subject           int not null,
   id_skin              int not null,
   user_id              int8,
   locked_at            datetime,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (id_presentation)
);

/*==============================================================*/
/* Table: ath_skin                                              */
/*==============================================================*/
create table ath_skin
(
   id_skin              int not null auto_increment,
   title                varchar(140) not null,
   bg_image             varchar(250) not null,
   fg_title             varchar(8) not null,
   fg_text              varchar(8) not null,
   status               tinyint not null,
   primary key (id_skin)
);

/*==============================================================*/
/* Table: ath_slide                                             */
/*==============================================================*/
create table ath_slide
(
   id_page              int not null auto_increment,
   id_type_slide        int not null,
   id_presentation      int not null,
   id_header            int not null,
   page_order           smallint not null,
   title                varchar(140) not null,
   title_menu           varchar(140) not null,
   text_body            text,
   status               tinyint not null,
   primary key (id_page)
);

/*==============================================================*/
/* Table: ath_subject                                           */
/*==============================================================*/
create table ath_subject
(
   id_subject           int not null auto_increment,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (id_subject)
);

/*==============================================================*/
/* Table: ath_type_slide                                        */
/*==============================================================*/
create table ath_type_slide
(
   id_type_slide        int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint,
   primary key (id_type_slide)
);

/*==============================================================*/
/* Table: ath_user_subject                                      */
/*==============================================================*/
create table ath_user_subject
(
   user_id              int not null,
   id_subject           int not null,
   primary key (user_id, id_subject)
);

alter table ath_link add constraint fk_reference_10 foreign key (id_media)
      references mda_media (id_media) on delete restrict on update restrict;

alter table ath_link add constraint fk_reference_9 foreign key (id_page)
      references ath_slide (id_page) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_1 foreign key (id_subject)
      references ath_subject (id_subject) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_3 foreign key (id_skin)
      references ath_skin (id_skin) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_7 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_2 foreign key (id_presentation)
      references ath_presentation (id_presentation) on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_4 foreign key (id_header)
      references ath_header (id_header) on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_5 foreign key (id_type_slide)
      references ath_type_slide (id_type_slide) on delete restrict on update restrict;

alter table ath_user_subject add constraint fk_reference_12 foreign key (id_subject)
      references ath_subject (id_subject) on delete restrict on update restrict;

alter table ath_user_subject add constraint fk_reference_8 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

