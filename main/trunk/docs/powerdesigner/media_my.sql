/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11/02/2010 14:48:45                          */
/*==============================================================*/


/*==============================================================*/
/* Table: mda_category                                          */
/*==============================================================*/
create table mda_category
(
   id_category          int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint not null,
   primary key (id_category)
);

alter table mda_category comment 'Internal File
  Flash paper
  Flash Movie
';

/*==============================================================*/
/* Table: mda_file                                              */
/*==============================================================*/
create table mda_file
(
   id_file              int not null,
   location             varchar(250) not null,
   primary key (id_file)
);

/*==============================================================*/
/* Table: mda_link                                              */
/*==============================================================*/
create table mda_link
(
   id_link              int not null,
   url                  varchar(200) not null,
   primary key (id_link)
);

/*==============================================================*/
/* Table: mda_media                                             */
/*==============================================================*/
create table mda_media
(
   id_media             int not null auto_increment,
   id_type_media        int,
   id_category          int,
   title                varchar(140) not null,
   description          text,
   creation             datetime,
   last_change          datetime,
   status               tinyint not null,
   primary key (id_media)
);

/*==============================================================*/
/* Table: mda_object                                            */
/*==============================================================*/
create table mda_object
(
   id_object            int not null,
   primary key (id_object)
);

/*==============================================================*/
/* Table: mda_poll                                              */
/*==============================================================*/
create table mda_poll
(
   id_object            int not null,
   poll_id              int not null,
   status               tinyint not null,
   primary key (id_object, poll_id)
);

/*==============================================================*/
/* Table: mda_survey                                            */
/*==============================================================*/
create table mda_survey
(
   id_object            int not null,
   survey_id            int not null,
   status               tinyint not null,
   primary key (id_object, survey_id)
);

/*==============================================================*/
/* Table: mda_text                                              */
/*==============================================================*/
create table mda_text
(
   id_text              int not null,
   full_text            text not null,
   primary key (id_text)
);

/*==============================================================*/
/* Table: mda_type_media                                        */
/*==============================================================*/
create table mda_type_media
(
   id_type_media        int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint not null,
   primary key (id_type_media)
);

alter table mda_type_media comment 'Internal File
  Flash paper
  Flash Movie
';

alter table mda_file add constraint fk_reference_2 foreign key (id_file)
      references mda_media (id_media) on delete restrict on update restrict;

alter table mda_link add constraint fk_reference_3 foreign key (id_link)
      references mda_media (id_media) on delete restrict on update restrict;

alter table mda_media add constraint fk_reference_1 foreign key (id_type_media)
      references mda_type_media (id_type_media) on delete restrict on update restrict;

alter table mda_media add constraint fk_reference_6 foreign key (id_category)
      references mda_category (id_category) on delete restrict on update restrict;

alter table mda_object add constraint fk_reference_5 foreign key (id_object)
      references mda_media (id_media) on delete restrict on update restrict;

alter table mda_poll add constraint fk_reference_10 foreign key (poll_id)
      references eko_poll (poll_id) on delete restrict on update restrict;

alter table mda_poll add constraint fk_reference_8 foreign key (id_object)
      references mda_object (id_object) on delete restrict on update restrict;

alter table mda_survey add constraint fk_reference_7 foreign key (id_object)
      references mda_object (id_object) on delete restrict on update restrict;

alter table mda_survey add constraint fk_reference_9 foreign key (survey_id)
      references eko_survey (survey_id) on delete restrict on update restrict;

alter table mda_text add constraint fk_reference_4 foreign key (id_text)
      references mda_media (id_media) on delete restrict on update restrict;

