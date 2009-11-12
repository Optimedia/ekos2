/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     12/11/2009 11:22:53                          */
/*==============================================================*/


/*==============================================================*/
/* Table: eko_account                                           */
/*==============================================================*/
create table eko_account
(
   account_id           bigint not null auto_increment,
   email                varchar(200) not null,
   name                 varchar(128) not null,
   status               smallint not null comment '1-Temporário
            2-Ativo
            3-Desativado
            4-Bloqueado
            5-Apagado',
   primary key (account_id)
);

/*==============================================================*/
/* Index: uk_account_email                                      */
/*==============================================================*/
create unique index uk_account_email on eko_account
(
   email
);

/*==============================================================*/
/* Index: uk_account_name                                       */
/*==============================================================*/
create unique index uk_account_name on eko_account
(
   name
);

/*==============================================================*/
/* Table: eko_bookmark                                          */
/*==============================================================*/
create table eko_bookmark
(
   bookmark_id          bigint not null,
   bookmark_url_id      bigint,
   url_typed            varchar(200),
   primary key (bookmark_id)
);

/*==============================================================*/
/* Table: eko_bookmark_url                                      */
/*==============================================================*/
create table eko_bookmark_url
(
   bookmark_url_id      bigint not null auto_increment,
   url                  varchar(200) not null,
   count                bigint not null,
   primary key (bookmark_url_id)
);

/*==============================================================*/
/* Index: uk_bookmark_url                                       */
/*==============================================================*/
create unique index uk_bookmark_url on eko_bookmark_url
(
   url
);

/*==============================================================*/
/* Table: eko_comment                                           */
/*==============================================================*/
create table eko_comment
(
   comment_id           bigint not null,
   primary key (comment_id)
);

/*==============================================================*/
/* Table: eko_comment_reply                                     */
/*==============================================================*/
create table eko_comment_reply
(
   comment_id           bigint not null,
   reply_id             bigint not null,
   primary key (comment_id, reply_id)
);

/*==============================================================*/
/* Table: eko_content                                           */
/*==============================================================*/
create table eko_content
(
   content_id           bigint not null auto_increment,
   content_type_id      bigint,
   title                char(10),
   uri                  char(10),
   tags_typeds          char(10),
   text_content         char(10),
   creation_date        char(10),
   last_change_date     char(10),
   ranking              char(10),
   primary key (content_id)
);

/*==============================================================*/
/* Table: eko_content_tag                                       */
/*==============================================================*/
create table eko_content_tag
(
   content_id           bigint,
   tag_id               bigint,
   tag_name             varchar(128) not null
);

/*==============================================================*/
/* Table: eko_content_type                                      */
/*==============================================================*/
create table eko_content_type
(
   content_type_id      bigint not null auto_increment,
   name                 varchar(128) not null,
   primary key (content_type_id)
);

/*==============================================================*/
/* Table: eko_detail_address                                    */
/*==============================================================*/
create table eko_detail_address
(
   detail_address_id    bigint not null auto_increment,
   profile_id           bigint,
   detail_address_type_id bigint,
   country_name         varchar(128),
   state_name           varchar(128),
   city_name            varchar(128),
   town_name            varchar(128),
   address_part1        char(10),
   address_part2        char(10),
   zipcode              char(10),
   primary key (detail_address_id)
);

/*==============================================================*/
/* Table: eko_detail_address_type                               */
/*==============================================================*/
create table eko_detail_address_type
(
   detail_address_type_id bigint not null auto_increment,
   name                 varchar(50) not null,
   primary key (detail_address_type_id)
);

/*==============================================================*/
/* Table: eko_detail_education                                  */
/*==============================================================*/
create table eko_detail_education
(
   detail_education_id  bigint not null auto_increment,
   profile_id           bigint,
   detail_education_level_id bigint,
   institution          varchar(128),
   year                 smallint,
   status               smallint,
   course               varchar(128),
   title                varchar(128),
   primary key (detail_education_id)
);

/*==============================================================*/
/* Table: eko_detail_education_level                            */
/*==============================================================*/
create table eko_detail_education_level
(
   detail_education_level_id bigint not null auto_increment,
   name                 varchar(128) not null,
   primary key (detail_education_level_id)
);

/*==============================================================*/
/* Table: eko_detail_language                                   */
/*==============================================================*/
create table eko_detail_language
(
   detail_language_id   bigint not null auto_increment,
   profile_id           bigint,
   language_name        varchar(128),
   speech               smallint,
   writing              smallint,
   reading              smallint,
   primary key (detail_language_id)
);

/*==============================================================*/
/* Table: eko_detail_professional                               */
/*==============================================================*/
create table eko_detail_professional
(
   detail_professional_id bigint not null auto_increment,
   profile_id           bigint,
   company              varchar(128),
   position             varchar(128),
   description          text,
   country_name         varchar(128),
   state_name           varchar(128),
   city_name            varchar(128),
   beginDate            date,
   endDate              date,
   primary key (detail_professional_id)
);

/*==============================================================*/
/* Table: eko_forum                                             */
/*==============================================================*/
create table eko_forum
(
   forum_id             bigint not null auto_increment,
   name                 varchar(128) not null,
   description          text,
   primary key (forum_id)
);

/*==============================================================*/
/* Table: eko_friend                                            */
/*==============================================================*/
create table eko_friend
(
   profile_id_i         bigint,
   profile_id_you       bigint
);

/*==============================================================*/
/* Table: eko_group                                             */
/*==============================================================*/
create table eko_group
(
   group_id             bigint not null,
   primary key (group_id)
);

/*==============================================================*/
/* Table: eko_increment                                         */
/*==============================================================*/
create table eko_increment
(
   increment_id         bigint not null auto_increment,
   increment_type_id    bigint not null,
   author_id            bigint,
   content_id           bigint,
   date                 datetime,
   primary key (increment_id)
);

/*==============================================================*/
/* Table: eko_increment_type                                    */
/*==============================================================*/
create table eko_increment_type
(
   increment_type_id    bigint not null auto_increment,
   name                 varchar(128),
   search_path          varchar(200),
   primary key (increment_type_id)
);

/*==============================================================*/
/* Table: eko_membership                                        */
/*==============================================================*/
create table eko_membership
(
   membership_id        bigint not null auto_increment,
   id_node              bigint not null,
   group_id             bigint not null,
   user_id              bigint not null,
   status               smallint not null,
   primary key (membership_id)
);

/*==============================================================*/
/* Index: uk_membership                                         */
/*==============================================================*/
create unique index uk_membership on eko_membership
(
   id_node,
   group_id,
   user_id
);

/*==============================================================*/
/* Table: eko_message                                           */
/*==============================================================*/
create table eko_message
(
   message_id           bigint not null auto_increment,
   sender_profile_id    bigint not null,
   receiver_profile_id  bigint not null,
   sender_status        smallint not null,
   receiver_status      smallint not null,
   sent_date            date not null,
   subject              varchar(140) not null,
   text                 char(10) not null,
   primary key (message_id)
);

/*==============================================================*/
/* Table: eko_node                                              */
/*==============================================================*/
create table eko_node
(
   id_node              bigint not null auto_increment,
   name                 varchar(128) not null,
   private_content      char(10),
   primary key (id_node)
);

/*==============================================================*/
/* Table: eko_node_content                                      */
/*==============================================================*/
create table eko_node_content
(
   content_id           bigint not null,
   id_node              bigint not null,
   primary key (content_id, id_node)
);

/*==============================================================*/
/* Table: eko_poll                                              */
/*==============================================================*/
create table eko_poll
(
   poll_id              bigint not null,
   primary key (poll_id)
);

/*==============================================================*/
/* Table: eko_poll_alternative                                  */
/*==============================================================*/
create table eko_poll_alternative
(
   poll_alternative_id  bigint not null auto_increment,
   poll_id              bigint,
   `label`              char(10),
   primary key (poll_alternative_id)
);

/*==============================================================*/
/* Table: eko_poll_choose                                       */
/*==============================================================*/
create table eko_poll_choose
(
   user_id              bigint,
   poll_alternative_id  bigint
);

/*==============================================================*/
/* Table: eko_profile                                           */
/*==============================================================*/
create table eko_profile
(
   profile_id           bigint not null,
   alias                varchar(50),
   small_avatar         char(10),
   large_avatar         char(10),
   sex                  varchar(150),
   birthday             date,
   primary key (profile_id)
);

/*==============================================================*/
/* Table: eko_recomendation                                     */
/*==============================================================*/
create table eko_recomendation
(
   recomendation_id     bigint not null,
   emails               char(10),
   primary key (recomendation_id)
);

/*==============================================================*/
/* Table: eko_role                                              */
/*==============================================================*/
create table eko_role
(
   role_id              bigint not null auto_increment,
   name                 varchar(50) not null,
   primary key (role_id)
);

/*==============================================================*/
/* Table: eko_room                                              */
/*==============================================================*/
create table eko_room
(
   room_id              bigint not null auto_increment,
   forum_id             bigint not null,
   name                 varchar(128) not null,
   description          text,
   primary key (room_id)
);

/*==============================================================*/
/* Table: eko_survey                                            */
/*==============================================================*/
create table eko_survey
(
   survey_id            bigint not null,
   title                varchar(140),
   description          text,
   primary key (survey_id)
);

/*==============================================================*/
/* Table: eko_survey_alternative                                */
/*==============================================================*/
create table eko_survey_alternative
(
   survey_alternative_id bigint not null auto_increment,
   survey_question_id   bigint,
   `order`              char(10),
   caption              char(10),
   primary key (survey_alternative_id)
);

/*==============================================================*/
/* Table: eko_survey_answer                                     */
/*==============================================================*/
create table eko_survey_answer
(
   survey_alternative_id bigint not null,
   user_id              bigint not null,
   comment              char(10),
   primary key (survey_alternative_id, user_id)
);

/*==============================================================*/
/* Table: eko_survey_element                                    */
/*==============================================================*/
create table eko_survey_element
(
   survey_element_id    bigint not null auto_increment,
   survey_element_type_id bigint,
   survey_id            bigint,
   `order`              char(10),
   caption              char(10),
   primary key (survey_element_id)
);

/*==============================================================*/
/* Table: eko_survey_element_type                               */
/*==============================================================*/
create table eko_survey_element_type
(
   survey_element_type_id bigint not null auto_increment,
   name                 varchar(50) not null,
   primary key (survey_element_type_id)
);

alter table eko_survey_element_type comment '1 - Label
2 - Question';

/*==============================================================*/
/* Table: eko_survey_label                                      */
/*==============================================================*/
create table eko_survey_label
(
   survey_label_id      bigint not null,
   primary key (survey_label_id)
);

/*==============================================================*/
/* Table: eko_survey_question                                   */
/*==============================================================*/
create table eko_survey_question
(
   survey_question_id   bigint not null,
   primary key (survey_question_id)
);

/*==============================================================*/
/* Table: eko_tag                                               */
/*==============================================================*/
create table eko_tag
(
   tag_id               bigint not null auto_increment,
   tag                  varchar(128) not null,
   count                bigint not null,
   primary key (tag_id)
);

/*==============================================================*/
/* Index: uk_tag                                                */
/*==============================================================*/
create unique index uk_tag on eko_tag
(
   tag
);

/*==============================================================*/
/* Table: eko_topic                                             */
/*==============================================================*/
create table eko_topic
(
   room_id              bigint not null,
   topic_id             bigint not null,
   primary key (room_id, topic_id)
);

/*==============================================================*/
/* Table: eko_user                                              */
/*==============================================================*/
create table eko_user
(
   user_id              bigint not null,
   role_id              bigint not null,
   first_name           varchar(50) not null,
   last_name            varchar(50) not null,
   password             varchar(150) not null,
   primary key (user_id)
);

/*==============================================================*/
/* Table: eko_user_tag                                          */
/*==============================================================*/
create table eko_user_tag
(
   user_tag_id          bigint not null auto_increment,
   user_id              bigint not null,
   tag_id               bigint not null,
   preferred_name       varchar(128) not null,
   count                bigint not null,
   primary key (user_tag_id)
);

/*==============================================================*/
/* Index: uk_user_tag                                           */
/*==============================================================*/
create unique index uk_user_tag on eko_user_tag
(
   user_id,
   tag_id
);

/*==============================================================*/
/* Table: eko_user_voting                                       */
/*==============================================================*/
create table eko_user_voting
(
   user_voting_id       bigint not null,
   vote                 char(10),
   date                 date,
   primary key (user_voting_id)
);

alter table eko_bookmark add constraint FK_Reference_29 foreign key (bookmark_id)
      references eko_content (content_id) on delete restrict on update restrict;

alter table eko_bookmark add constraint FK_Reference_30 foreign key (bookmark_url_id)
      references eko_bookmark_url (bookmark_url_id) on delete restrict on update restrict;

alter table eko_comment add constraint FK_Reference_26 foreign key (comment_id)
      references eko_content (content_id) on delete restrict on update restrict;

alter table eko_comment add constraint FK_Reference_36 foreign key (comment_id)
      references eko_increment (increment_id) on delete restrict on update restrict;

alter table eko_comment_reply add constraint FK_Reference_27 foreign key (comment_id)
      references eko_comment (comment_id) on delete restrict on update restrict;

alter table eko_comment_reply add constraint FK_Reference_28 foreign key (reply_id)
      references eko_comment (comment_id) on delete restrict on update restrict;

alter table eko_content add constraint FK_Reference_22 foreign key (content_type_id)
      references eko_content_type (content_type_id) on delete restrict on update restrict;

alter table eko_content_tag add constraint FK_Reference_20 foreign key (content_id)
      references eko_content (content_id) on delete restrict on update restrict;

alter table eko_content_tag add constraint FK_Reference_21 foreign key (tag_id)
      references eko_tag (tag_id) on delete restrict on update restrict;

alter table eko_detail_address add constraint FK_Reference_13 foreign key (profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_detail_address add constraint FK_Reference_18 foreign key (detail_address_type_id)
      references eko_detail_address_type (detail_address_type_id) on delete restrict on update restrict;

alter table eko_detail_education add constraint FK_Reference_10 foreign key (profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_detail_education add constraint FK_Reference_19 foreign key (detail_education_level_id)
      references eko_detail_education_level (detail_education_level_id) on delete restrict on update restrict;

alter table eko_detail_language add constraint FK_Reference_12 foreign key (profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_detail_professional add constraint FK_Reference_11 foreign key (profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_friend add constraint FK_Reference_16 foreign key (profile_id_i)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_friend add constraint FK_Reference_17 foreign key (profile_id_you)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_group add constraint FK_Reference_1 foreign key (group_id)
      references eko_account (account_id) on delete restrict on update restrict;

alter table eko_increment add constraint FK_Reference_31 foreign key (increment_type_id)
      references eko_increment_type (increment_type_id) on delete restrict on update restrict;

alter table eko_increment add constraint FK_Reference_37 foreign key (author_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_increment add constraint FK_Reference_52 foreign key (content_id)
      references eko_content (content_id) on delete restrict on update restrict;

alter table eko_membership add constraint FK_Reference_4 foreign key (id_node)
      references eko_node (id_node) on delete restrict on update restrict;

alter table eko_membership add constraint FK_Reference_5 foreign key (group_id)
      references eko_group (group_id) on delete restrict on update restrict;

alter table eko_membership add constraint FK_Reference_6 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_message add constraint FK_Reference_14 foreign key (sender_profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_message add constraint FK_Reference_15 foreign key (receiver_profile_id)
      references eko_profile (profile_id) on delete restrict on update restrict;

alter table eko_node_content add constraint FK_Reference_53 foreign key (content_id)
      references eko_content (content_id) on delete restrict on update restrict;

alter table eko_node_content add constraint FK_Reference_54 foreign key (id_node)
      references eko_node (id_node) on delete restrict on update restrict;

alter table eko_poll add constraint FK_Reference_35 foreign key (poll_id)
      references eko_increment (increment_id) on delete restrict on update restrict;

alter table eko_poll_alternative add constraint FK_Reference_40 foreign key (poll_id)
      references eko_poll (poll_id) on delete restrict on update restrict;

alter table eko_poll_choose add constraint FK_Reference_41 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_poll_choose add constraint FK_Reference_42 foreign key (poll_alternative_id)
      references eko_poll_alternative (poll_alternative_id) on delete restrict on update restrict;

alter table eko_profile add constraint FK_Reference_9 foreign key (profile_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_recomendation add constraint FK_Reference_33 foreign key (recomendation_id)
      references eko_increment (increment_id) on delete restrict on update restrict;

alter table eko_room add constraint FK_Reference_23 foreign key (forum_id)
      references eko_forum (forum_id) on delete restrict on update restrict;

alter table eko_survey add constraint FK_Reference_44 foreign key (survey_id)
      references eko_increment (increment_id) on delete restrict on update restrict;

alter table eko_survey_alternative add constraint FK_Reference_49 foreign key (survey_question_id)
      references eko_survey_question (survey_question_id) on delete restrict on update restrict;

alter table eko_survey_answer add constraint FK_Reference_50 foreign key (survey_alternative_id)
      references eko_survey_alternative (survey_alternative_id) on delete restrict on update restrict;

alter table eko_survey_answer add constraint FK_Reference_51 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_survey_element add constraint FK_Reference_45 foreign key (survey_id)
      references eko_survey (survey_id) on delete restrict on update restrict;

alter table eko_survey_element add constraint FK_Reference_46 foreign key (survey_element_type_id)
      references eko_survey_element_type (survey_element_type_id) on delete restrict on update restrict;

alter table eko_survey_label add constraint FK_Reference_47 foreign key (survey_label_id)
      references eko_survey_element (survey_element_id) on delete restrict on update restrict;

alter table eko_survey_question add constraint FK_Reference_48 foreign key (survey_question_id)
      references eko_survey_element (survey_element_id) on delete restrict on update restrict;

alter table eko_topic add constraint FK_Reference_24 foreign key (room_id)
      references eko_room (room_id) on delete restrict on update restrict;

alter table eko_topic add constraint FK_Reference_25 foreign key (topic_id)
      references eko_comment (comment_id) on delete restrict on update restrict;

alter table eko_user add constraint FK_Reference_2 foreign key (user_id)
      references eko_account (account_id) on delete restrict on update restrict;

alter table eko_user add constraint FK_Reference_3 foreign key (role_id)
      references eko_role (role_id) on delete restrict on update restrict;

alter table eko_user_tag add constraint FK_Reference_7 foreign key (user_id)
      references eko_user (user_id) on delete restrict on update restrict;

alter table eko_user_tag add constraint FK_Reference_8 foreign key (tag_id)
      references eko_tag (tag_id) on delete restrict on update restrict;

alter table eko_user_voting add constraint FK_Reference_34 foreign key (user_voting_id)
      references eko_increment (increment_id) on delete restrict on update restrict;

