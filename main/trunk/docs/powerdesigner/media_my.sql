/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     18/02/2010 16:08:25                          */
/*==============================================================*/


/*==============================================================*/
/* Table: mda_category                                          */
/*==============================================================*/
create table mda_category
(
   category_id          int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint not null,
   primary key (category_id)
);

alter table mda_category comment 'Table
Chart
Image
Movie
Web Link
                                 -&';

/*==============================================================*/
/* Table: mda_media                                             */
/*==============================================================*/
create table mda_media
(
   media_id             int not null auto_increment,
   type_media_id        int,
   category_id          int,
   title                varchar(140) not null,
   description          text,
   creation             datetime,
   last_change          datetime,
   location             varchar(250),
   url                  varchar(200),
   full_text            text,
   status               tinyint not null,
   primary key (media_id)
);

alter table mda_media comment 'Category				Type		Extentions
Table				Internal File (I';

/*==============================================================*/
/* Table: mda_poll                                              */
/*==============================================================*/
create table mda_poll
(
   poll_id              int not null,
   media_id             int not null,
   primary key (poll_id, media_id)
);

/*==============================================================*/
/* Table: mda_survey                                            */
/*==============================================================*/
create table mda_survey
(
   survey_id            int not null,
   media_id             int not null,
   primary key (survey_id, media_id)
);

/*==============================================================*/
/* Table: mda_type_media                                        */
/*==============================================================*/
create table mda_type_media
(
   type_media_id        int not null auto_increment,
   title                varchar(140) not null,
   status               tinyint not null,
   primary key (type_media_id)
);

alter table mda_type_media comment 'Link
Image
Movie
File
Object';

alter table mda_media add constraint fk_reference_1 foreign key (type_media_id)
      references mda_type_media (type_media_id) on delete restrict on update restrict;

alter table mda_media add constraint fk_reference_6 foreign key (category_id)
      references mda_category (category_id) on delete restrict on update restrict;

alter table mda_poll add constraint fk_reference_10 foreign key (poll_id)
      references eko_poll on delete restrict on update restrict;

alter table mda_poll add constraint fk_reference_7 foreign key (media_id)
      references mda_media (media_id) on delete restrict on update restrict;

alter table mda_survey add constraint fk_reference_5 foreign key (media_id)
      references mda_media (media_id) on delete restrict on update restrict;

alter table mda_survey add constraint fk_reference_9 foreign key (survey_id)
      references eko_survey on delete restrict on update restrict;

