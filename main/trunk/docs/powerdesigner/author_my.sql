/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     18/02/2010 16:08:17                          */
/*==============================================================*/


/*==============================================================*/
/* Table: ath_header                                            */
/*==============================================================*/
create table ath_header
(
   header_id            int not null auto_increment,
   title                varchar(140) not null,
   fg_image             varchar(250) not null,
   status               tinyint,
   primary key (header_id)
);

/*==============================================================*/
/* Table: ath_link                                              */
/*==============================================================*/
create table ath_link
(
   slide_id             int not null,
   media_id             int not null,
   primary key (slide_id, media_id)
);

/*==============================================================*/
/* Table: ath_log_header                                        */
/*==============================================================*/
create table ath_log_header
(
   user_id              int,
   date_event           datetime,
   version              tinyint not null,
   header_id            int not null,
   title                varchar(140) not null,
   fg_image             varchar(250) not null,
   status               tinyint,
   primary key (version, header_id)
);

/*==============================================================*/
/* Table: ath_log_presentation                                  */
/*==============================================================*/
create table ath_log_presentation
(
   user_id              int,
   date_event           datetime,
   version              tinyint not null,
   presentation_id      int not null,
   subject_id           int not null,
   skin_id              int not null,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (presentation_id, version)
);

/*==============================================================*/
/* Table: ath_log_skin                                          */
/*==============================================================*/
create table ath_log_skin
(
   user_id              int,
   date_event           datetime,
   version              tinyint not null,
   skin_id              int not null,
   title                varchar(140) not null,
   bg_image             varchar(250) not null,
   fg_title             varchar(8) not null,
   fg_text              varchar(8) not null,
   status               tinyint not null,
   primary key (version, skin_id)
);

/*==============================================================*/
/* Table: ath_log_slide                                         */
/*==============================================================*/
create table ath_log_slide
(
   user_id              int,
   date_event           datetime,
   version              tinyint not null,
   slide_id             int not null,
   type_slide_id        int not null,
   header_id            int not null,
   presentation_id      int not null,
   page_order           smallint not null,
   title                varchar(140) not null,
   title_menu           varchar(140) not null,
   text_body            text,
   status               tinyint not null,
   primary key (version, slide_id)
);

/*==============================================================*/
/* Table: ath_log_subject                                       */
/*==============================================================*/
create table ath_log_subject
(
   user_id              int,
   date_event           datetime,
   version              tinyint not null,
   subject_id           int not null,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (subject_id, version)
);

/*==============================================================*/
/* Table: ath_media                                             */
/*==============================================================*/
create table ath_media
(
   media_id             int not null,
   presentation_id      int not null,
   primary key (media_id)
);

/*==============================================================*/
/* Table: ath_presentation                                      */
/*==============================================================*/
create table ath_presentation
(
   presentation_id      int not null auto_increment,
   subject_id           int not null,
   skin_id              int not null,
   locked_by            int8,
   locked_at            datetime,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (presentation_id)
);

/*==============================================================*/
/* Table: ath_skin                                              */
/*==============================================================*/
create table ath_skin
(
   skin_id              int not null auto_increment,
   title                varchar(140) not null,
   bg_image             varchar(250) not null,
   fg_title             varchar(8) not null,
   fg_text              varchar(8) not null,
   status               tinyint not null,
   primary key (skin_id)
);

/*==============================================================*/
/* Table: ath_slide                                             */
/*==============================================================*/
create table ath_slide
(
   slide_id             int not null auto_increment,
   type_slide_id        int not null,
   presentation_id      int not null,
   header_id            int not null,
   page_order           smallint not null,
   title                varchar(140) not null,
   title_menu           varchar(140) not null,
   text_body            text,
   status               tinyint not null,
   primary key (slide_id)
);

/*==============================================================*/
/* Table: ath_subject                                           */
/*==============================================================*/
create table ath_subject
(
   subject_id           int not null auto_increment,
   title                varchar(140) not null,
   description          text,
   status               tinyint not null,
   primary key (subject_id)
);

/*==============================================================*/
/* Table: ath_type_slide                                        */
/*==============================================================*/
create table ath_type_slide
(
   type_slide_id        int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint,
   primary key (type_slide_id)
);

/*==============================================================*/
/* Table: ath_user_subject                                      */
/*==============================================================*/
create table ath_user_subject
(
   user_id              int not null,
   subject_id           int not null,
   primary key (user_id, subject_id)
);

alter table ath_link add constraint fk_reference_14 foreign key (media_id)
      references ath_media (media_id) on delete restrict on update restrict;

alter table ath_link add constraint fk_reference_9 foreign key (slide_id)
      references ath_slide (slide_id) on delete restrict on update restrict;

alter table ath_media add constraint fk_reference_11 foreign key (presentation_id)
      references ath_presentation (presentation_id) on delete restrict on update restrict;

alter table ath_media add constraint fk_reference_13 foreign key (media_id)
      references mda_media (media_id) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_1 foreign key (subject_id)
      references ath_subject (subject_id) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_3 foreign key (skin_id)
      references ath_skin (skin_id) on delete restrict on update restrict;

alter table ath_presentation add constraint fk_reference_7 foreign key (locked_by)
      references eko_user on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_2 foreign key (presentation_id)
      references ath_presentation (presentation_id) on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_4 foreign key (header_id)
      references ath_header (header_id) on delete restrict on update restrict;

alter table ath_slide add constraint fk_reference_5 foreign key (type_slide_id)
      references ath_type_slide (type_slide_id) on delete restrict on update restrict;

alter table ath_user_subject add constraint fk_reference_12 foreign key (subject_id)
      references ath_subject (subject_id) on delete restrict on update restrict;

alter table ath_user_subject add constraint fk_reference_8 foreign key (user_id)
      references eko_user on delete restrict on update restrict;

