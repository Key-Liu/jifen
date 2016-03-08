-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: scoring2
-- Source Schemata: scoring
-- Created: Wed Nov  5 23:36:11 2014
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;;

-- ----------------------------------------------------------------------------
-- Schema scoring2
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `scoring2` ;
CREATE SCHEMA IF NOT EXISTS `scoring2` ;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_group
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_group` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_group_permissions
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_group_permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `group_id` INT(11) NOT NULL,
  `permission_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `group_id` (`group_id` ASC, `permission_id` ASC),
  INDEX `auth_group_permissions_0e939a4f` (`group_id` ASC),
  INDEX `auth_group_permissions_8373b171` (`permission_id` ASC),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id`
    FOREIGN KEY (`permission_id`)
    REFERENCES `scoring2`.`auth_permission` (`id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `scoring2`.`auth_group` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_permission
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_permission` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `content_type_id` INT(11) NOT NULL,
  `codename` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `content_type_id` (`content_type_id` ASC, `codename` ASC),
  INDEX `auth_permission_417f1b1c` (`content_type_id` ASC),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `scoring2`.`django_content_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.django_content_type
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`django_content_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `app_label` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label` ASC, `model` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_user
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME NOT NULL,
  `is_superuser` TINYINT(1) NOT NULL,
  `username` VARCHAR(30) NOT NULL,
  `first_name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(75) NOT NULL,
  `is_staff` TINYINT(1) NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  `date_joined` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_user_groups
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_user_groups` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `group_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id` (`user_id` ASC, `group_id` ASC),
  INDEX `auth_user_groups_e8701ad4` (`user_id` ASC),
  INDEX `auth_user_groups_0e939a4f` (`group_id` ASC),
  CONSTRAINT `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `scoring2`.`auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `scoring2`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.auth_user_user_permissions
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`auth_user_user_permissions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `permission_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_id` (`user_id` ASC, `permission_id` ASC),
  INDEX `auth_user_user_permissions_e8701ad4` (`user_id` ASC),
  INDEX `auth_user_user_permissions_8373b171` (`permission_id` ASC),
  CONSTRAINT `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id`
    FOREIGN KEY (`permission_id`)
    REFERENCES `scoring2`.`auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissi_user_id_7f0938558328534a_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `scoring2`.`auth_user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.demo_athlete
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`demo_athlete` (
  `athlete_id` VARCHAR(12) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `classObject_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`athlete_id`),
  INDEX `demo_athlete_468acf72` (`classObject_id` ASC),
  CONSTRAINT `demo_athl_classObject_id_48ab87e3765f90d5_fk_demo_class_class_id`
    FOREIGN KEY (`classObject_id`)
    REFERENCES `scoring2`.`demo_class` (`class_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.demo_class
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`demo_class` (
  `class_id` INT(11) NOT NULL,
  `grade` VARCHAR(4) NOT NULL,
  `major` VARCHAR(30) NOT NULL,
  `num` INT(11) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.demo_key
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`demo_key` (
  `Key` VARCHAR(20) NOT NULL,
  `key_name` VARCHAR(30) NOT NULL,
  `value` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.demo_score
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`demo_score` (
  `score_id` INT(11) NOT NULL,
  `result` VARCHAR(15) NULL DEFAULT NULL,
  `mark` INT(11) NULL DEFAULT NULL,
  `ext_mark` INT(11) NULL DEFAULT NULL,
  `rank` INT(11) NULL DEFAULT NULL,
  `group` INT(11) NOT NULL,
  `athleteObject_id` VARCHAR(12) NULL DEFAULT NULL,
  `classObject_id` INT(11) NULL DEFAULT NULL,
  `sportObject_id` INT(11) NULL DEFAULT NULL,
  `final` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`score_id`),
  UNIQUE INDEX `demo_score_sportObject_id_6a96664086af784f_uniq` (`sportObject_id` ASC, `classObject_id` ASC, `athleteObject_id` ASC, `final` ASC),
  INDEX `demo_score_3f887f38` (`athleteObject_id` ASC),
  INDEX `demo_score_468acf72` (`classObject_id` ASC),
  INDEX `demo_score_c9b94a46` (`sportObject_id` ASC),
  CONSTRAINT `demo_scor_classObject_id_274f9b1c2c847e7c_fk_demo_class_class_id`
    FOREIGN KEY (`classObject_id`)
    REFERENCES `scoring2`.`demo_class` (`class_id`),
  CONSTRAINT `demo_scor_sportObject_id_4740e2457a448986_fk_demo_sport_sport_id`
    FOREIGN KEY (`sportObject_id`)
    REFERENCES `scoring2`.`demo_sport` (`sport_id`),
  CONSTRAINT `dem_athleteObject_id_41500bb8c508514d_fk_demo_athlete_athlete_id`
    FOREIGN KEY (`athleteObject_id`)
    REFERENCES `scoring2`.`demo_athlete` (`athlete_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.demo_sport
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`demo_sport` (
  `sport_id` INT(11) NOT NULL,
  `sport_name` VARCHAR(30) NOT NULL,
  `campus_rec` VARCHAR(20) NOT NULL,
  `college_rec` VARCHAR(20) NOT NULL,
  `sort` VARCHAR(1) NOT NULL,
  `format` VARCHAR(1) NOT NULL,
  `preliminary` VARCHAR(1) NOT NULL,
  `score_add` VARCHAR(30) NOT NULL,
  `group_num` INT(11) NOT NULL,
  `rise` INT(11) NOT NULL,
  PRIMARY KEY (`sport_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.django_admin_log
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`django_admin_log` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `action_time` DATETIME NOT NULL,
  `object_id` LONGTEXT NULL DEFAULT NULL,
  `object_repr` VARCHAR(200) NOT NULL,
  `action_flag` SMALLINT(5) UNSIGNED NOT NULL,
  `change_message` LONGTEXT NOT NULL,
  `content_type_id` INT(11) NULL DEFAULT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `django_admin_log_417f1b1c` (`content_type_id` ASC),
  INDEX `django_admin_log_e8701ad4` (`user_id` ASC),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `scoring2`.`auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id`
    FOREIGN KEY (`content_type_id`)
    REFERENCES `scoring2`.`django_content_type` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.django_migrations
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`django_migrations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `app` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `applied` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8;

-- ----------------------------------------------------------------------------
-- Table scoring2.django_session
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `scoring2`.`django_session` (
  `session_key` VARCHAR(40) NOT NULL,
  `session_data` LONGTEXT NOT NULL,
  `expire_date` DATETIME NOT NULL,
  PRIMARY KEY (`session_key`),
  INDEX `django_session_de54fa62` (`expire_date` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
SET FOREIGN_KEY_CHECKS = 1;;
