/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : eva2014

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2014-10-12 15:55:58
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `ccategory`
-- ----------------------------
DROP TABLE IF EXISTS `ccategory`;
CREATE TABLE `ccategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '课程类别代码',
  `name` varchar(60) NOT NULL COMMENT '课程类别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ccategory
-- ----------------------------
INSERT INTO `ccategory` VALUES ('1', '0001', '公共课基础课');
INSERT INTO `ccategory` VALUES ('2', '0002', '学科基础课');
INSERT INTO `ccategory` VALUES ('3', '0003', '专业领域课');
INSERT INTO `ccategory` VALUES ('4', '0004', '实践课');
INSERT INTO `ccategory` VALUES ('6', '0005', '专业选修课');

-- ----------------------------
-- Table structure for `ceindex`
-- ----------------------------
DROP TABLE IF EXISTS `ceindex`;
CREATE TABLE `ceindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) NOT NULL COMMENT '指标代码',
  `ecategoryid` int(11) NOT NULL COMMENT '外键，所属指标类型：ecategory',
  `isfinal` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可评分项，0：不可评分，1：可评分',
  `fleindexid` int(11) NOT NULL COMMENT '外键，所属一级评价指标FLEIndex。NULL：不是一级评价指标',
  `sleindexid` int(11) DEFAULT NULL COMMENT '外键，所属二级评价指标SLEIndex。NULL：不是二级评价指标',
  `rlevel` tinyint(4) DEFAULT NULL COMMENT '关联程度[1、2和3级别]',
  `csettingid` int(11) NOT NULL COMMENT '外键，所属课程设置：csetting',
  PRIMARY KEY (`id`),
  KEY `fk_ceindex_ecategory` (`ecategoryid`),
  KEY `fk_ceindex_sleindex` (`sleindexid`),
  KEY `fk_ceindex_csetting` (`csettingid`),
  KEY `fk_ceindex_fleindexid` (`fleindexid`),
  CONSTRAINT `fk_ceindex_csetting` FOREIGN KEY (`csettingid`) REFERENCES `csetting` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ceindex_ecategory` FOREIGN KEY (`ecategoryid`) REFERENCES `ecategory` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ceindex_fleindexid` FOREIGN KEY (`fleindexid`) REFERENCES `fleindex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ceindex_sleindex` FOREIGN KEY (`sleindexid`) REFERENCES `sleindex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceindex
-- ----------------------------
INSERT INTO `ceindex` VALUES ('1', 'CC', '2', '0', '16', null, null, '228');
INSERT INTO `ceindex` VALUES ('2', 'CC6', '2', '1', '16', '14', '5', '228');
INSERT INTO `ceindex` VALUES ('3', 'CC7', '2', '1', '16', '38', '5', '228');
INSERT INTO `ceindex` VALUES ('4', 'CC2', '2', '1', '16', '10', '5', '228');
INSERT INTO `ceindex` VALUES ('5', 'CF', '2', '0', '19', null, null, '228');
INSERT INTO `ceindex` VALUES ('6', 'CF4', '2', '1', '19', '25', '5', '228');

-- ----------------------------
-- Table structure for `cevaluation`
-- ----------------------------
DROP TABLE IF EXISTS `cevaluation`;
CREATE TABLE `cevaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `credit` tinyint(4) DEFAULT NULL COMMENT '课程总评：[0-5]',
  `ceindexid` int(11) NOT NULL COMMENT '外键，课程指标：ceindex',
  `studentid` int(11) NOT NULL COMMENT '外键，选课学生：student',
  `courseid` int(11) NOT NULL COMMENT '外键，课程任务：course',
  PRIMARY KEY (`id`),
  KEY `fk_cevaluation_ceindex` (`ceindexid`),
  KEY `fk_cevaluation_student` (`studentid`),
  KEY `fk_cevaluation_course` (`courseid`),
  CONSTRAINT `fk_cevaluation_ceindex` FOREIGN KEY (`ceindexid`) REFERENCES `ceindex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cevaluation_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cevaluation_student` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cevaluation
-- ----------------------------

-- ----------------------------
-- Table structure for `cgroup`
-- ----------------------------
DROP TABLE IF EXISTS `cgroup`;
CREATE TABLE `cgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '分组编号',
  `name` varchar(30) NOT NULL COMMENT '分组名称',
  `count` smallint(6) NOT NULL DEFAULT '0' COMMENT '学生人数',
  `leaderid` int(11) DEFAULT NULL COMMENT '外键cstudent.id',
  `courseid` int(11) NOT NULL COMMENT '外键，所属开设课程：course',
  PRIMARY KEY (`id`),
  KEY `fk_cgroup_course` (`courseid`),
  KEY `fk_cgroup_leader` (`leaderid`),
  CONSTRAINT `fk_cgroup_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cgroup_leader` FOREIGN KEY (`leaderid`) REFERENCES `cstudent` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cgroup
-- ----------------------------
INSERT INTO `cgroup` VALUES ('1', 'a1', '一个人的分组', '1', null, '732');
INSERT INTO `cgroup` VALUES ('2', 'a2', '两个人小组', '2', null, '732');

-- ----------------------------
-- Table structure for `cigcgroup`
-- ----------------------------
DROP TABLE IF EXISTS `cigcgroup`;
CREATE TABLE `cigcgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(60) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT '0',
  `isinvolved` tinyint(1) NOT NULL DEFAULT '1',
  `ismarked` tinyint(1) NOT NULL DEFAULT '0',
  `leaderid` int(11) DEFAULT NULL,
  `cigroupcreditid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cigcgroup_cigroupcredit` (`cigroupcreditid`),
  KEY `fk_cigcgroup_leader` (`leaderid`),
  CONSTRAINT `fk_cigcgroup_cigroupcredit` FOREIGN KEY (`cigroupcreditid`) REFERENCES `cigroupcredit` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcgroup_leader` FOREIGN KEY (`leaderid`) REFERENCES `cigcstudent` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cigcgroup
-- ----------------------------

-- ----------------------------
-- Table structure for `cigcitem`
-- ----------------------------
DROP TABLE IF EXISTS `cigcitem`;
CREATE TABLE `cigcitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `cigroupcreditid` int(11) NOT NULL,
  `creditsum` tinyint(4) NOT NULL DEFAULT '100' COMMENT '项该的总分',
  PRIMARY KEY (`id`),
  KEY `fk_cigcitem_cigroupcredit` (`cigroupcreditid`),
  CONSTRAINT `fk_cigcitem_cigroupcredit` FOREIGN KEY (`cigroupcreditid`) REFERENCES `cigroupcredit` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cigcitem
-- ----------------------------

-- ----------------------------
-- Table structure for `cigcstdcredit`
-- ----------------------------
DROP TABLE IF EXISTS `cigcstdcredit`;
CREATE TABLE `cigcstdcredit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `credit` tinyint(4) DEFAULT NULL COMMENT '该项得分[0-100]，该组中所有成员的得分之和要等于100',
  `cigcitemid` int(11) NOT NULL COMMENT '外键，该得分对应的评分项:cigcitem',
  `cigroupcreditid` int(11) NOT NULL COMMENT '外键，该得分所属的组内评分:',
  `cigcgroupid` int(11) NOT NULL COMMENT '外键，该学生所属的评分小组:cigcgroup',
  `cigcstudentid` int(11) NOT NULL COMMENT '外键，获得评分的学生：student',
  PRIMARY KEY (`id`),
  KEY `fk_cigcstdcredit_cigcitem` (`cigcitemid`),
  KEY `fk_cigcstdcredit_cigcgroup` (`cigcgroupid`),
  KEY `fk_cigcstdcredit_cigroupcredit` (`cigroupcreditid`),
  KEY `fk_cigcstdcredit_cigcstudentid` (`cigcstudentid`) USING BTREE,
  CONSTRAINT `fk_cigcstdcredit_cigcgroupid` FOREIGN KEY (`cigcgroupid`) REFERENCES `cigcgroup` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcstdcredit_cigcitemid` FOREIGN KEY (`cigcitemid`) REFERENCES `cigcitem` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcstdcredit_cigroupcreditid` FOREIGN KEY (`cigroupcreditid`) REFERENCES `cigroupcredit` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcstucredit_cigcstudent` FOREIGN KEY (`cigcstudentid`) REFERENCES `cigcgroup` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cigcstdcredit
-- ----------------------------

-- ----------------------------
-- Table structure for `cigcstudent`
-- ----------------------------
DROP TABLE IF EXISTS `cigcstudent`;
CREATE TABLE `cigcstudent` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '增自主键',
  `isgrouped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标识是否已分组0：未 1：已',
  `cigroupcreditid` int(11) NOT NULL COMMENT '外键，该得分所属的组内评分:',
  `cigcgroupid` int(11) DEFAULT NULL COMMENT '外键，该学生所属的评分小组:cigcgroup',
  `cstudentid` int(11) NOT NULL COMMENT '外键，参与评分的学生：cstudent',
  PRIMARY KEY (`id`),
  KEY `fk_cigcstudent_cigcgroup` (`cigcgroupid`),
  KEY `fk_cigcstudent_cigroupcredit` (`cigroupcreditid`),
  KEY `fk_cigcstudent_student` (`cstudentid`),
  CONSTRAINT `fk_cigcstudent_cigcgroup` FOREIGN KEY (`cigcgroupid`) REFERENCES `cigcgroup` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcstudent_cigroupcredit` FOREIGN KEY (`cigroupcreditid`) REFERENCES `cigroupcredit` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigcstudent_cstudent` FOREIGN KEY (`cstudentid`) REFERENCES `cstudent` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cigcstudent
-- ----------------------------

-- ----------------------------
-- Table structure for `cigroupcredit`
-- ----------------------------
DROP TABLE IF EXISTS `cigroupcredit`;
CREATE TABLE `cigroupcredit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(60) NOT NULL COMMENT '评分名称',
  `teacherid` int(11) NOT NULL COMMENT '外键,发布该评分的老师teacher.id',
  `courseid` int(11) NOT NULL COMMENT '外键，开设课程：course',
  `cmissionid` int(11) DEFAULT NULL COMMENT '外键cmission.id',
  `iscgroup` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否使用课程分组，0：不使用课程分组，1：使用课程分组',
  `iscmgroup` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用任务分组，',
  `iseditable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可修改，0：不可修改，1：可修改',
  `isdeletable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可删除',
  `ismarked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已完成评分',
  PRIMARY KEY (`id`),
  KEY `fk_cigroupcredit_teacher` (`teacherid`),
  KEY `fk_cigroupcredit_cmission` (`cmissionid`),
  KEY `fk_cigroupcredit_course` (`courseid`),
  CONSTRAINT `fk_cigroupcredit_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cigroupcredit_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cigroupcredit
-- ----------------------------

-- ----------------------------
-- Table structure for `cmcredit`
-- ----------------------------
DROP TABLE IF EXISTS `cmcredit`;
CREATE TABLE `cmcredit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `credit` tinyint(4) NOT NULL COMMENT '任务评分，[0-100]',
  `description` varchar(90) NOT NULL COMMENT '评分备注',
  `cstudentid` int(11) NOT NULL COMMENT '外键，选课学生：student',
  `cmissionid` int(11) NOT NULL COMMENT '外键，课程任务：cmission',
  PRIMARY KEY (`id`),
  KEY `fk_cmcredit_student` (`cstudentid`),
  KEY `fk_cmcredit_cmission` (`cmissionid`),
  CONSTRAINT `fk_cmcredit_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmcredit_cstudent` FOREIGN KEY (`cstudentid`) REFERENCES `cstudent` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmcredit
-- ----------------------------

-- ----------------------------
-- Table structure for `cmgroup`
-- ----------------------------
DROP TABLE IF EXISTS `cmgroup`;
CREATE TABLE `cmgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '分组编号',
  `name` varchar(30) NOT NULL COMMENT '分组名称',
  `count` smallint(6) NOT NULL DEFAULT '0' COMMENT '学生人数',
  `isinvolved` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否参与任务，1：参与任务，0：不参与任务',
  `leaderid` int(11) DEFAULT NULL,
  `cmissionid` int(11) NOT NULL COMMENT '外键，所属课程任务，cmission',
  PRIMARY KEY (`id`),
  KEY `fk_cmgroup_cmission` (`cmissionid`),
  KEY `fk_cmgroup_leader` (`leaderid`),
  CONSTRAINT `fk_cmgroup_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cmgroup_leader` FOREIGN KEY (`leaderid`) REFERENCES `cmstudent` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmgroup
-- ----------------------------

-- ----------------------------
-- Table structure for `cmission`
-- ----------------------------
DROP TABLE IF EXISTS `cmission`;
CREATE TABLE `cmission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(60) NOT NULL COMMENT '任务名称',
  `requirement` varchar(900) NOT NULL COMMENT '任务要求',
  `oldname` varchar(90) DEFAULT NULL,
  `apath` varchar(90) DEFAULT NULL COMMENT '附件路径，Attachment Path',
  `scount` smallint(6) DEFAULT '0' COMMENT '学生人数',
  `mtype` varchar(30) NOT NULL DEFAULT '个人任务' COMMENT '任务类型，个人任务，分组任务，mission type',
  `stype` varchar(30) NOT NULL DEFAULT '按个人提交' COMMENT '提交方式，按个人提交，按小组提交，submit type',
  `ismarked` varchar(20) NOT NULL DEFAULT '未评分' COMMENT '是否评分完毕，0：未评分，1：已评分',
  `isdeletable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可删除，0：不可删除，1：可删除',
  `iseditable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可修改，0：不可修改，1：可修改',
  `isactive` varchar(20) NOT NULL DEFAULT '可提交' COMMENT '是否可提交，0：不可提交，1：可提交',
  `courseid` int(11) NOT NULL COMMENT '外键，所属开设课程：course',
  `teacherid` int(11) DEFAULT NULL COMMENT '外键，授课教师：cteacher',
  `deadline` datetime DEFAULT NULL COMMENT '提交任务的截止时间，null的话就是无期限',
  `randomname` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cmission_course` (`courseid`),
  KEY `fk_cmission_teacher` (`teacherid`) USING BTREE,
  CONSTRAINT `fk_cmission_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmission_teacher` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmission
-- ----------------------------
INSERT INTO `cmission` VALUES ('1', '任务1', '无', '无', '无', '1', '1', '1', '0', '0', '1', '1', '732', '1', '2014-09-21 16:42:10', null);

-- ----------------------------
-- Table structure for `cmreport`
-- ----------------------------
DROP TABLE IF EXISTS `cmreport`;
CREATE TABLE `cmreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(60) NOT NULL COMMENT '任务报告名称',
  `description` varchar(900) NOT NULL COMMENT '任务报告说明',
  `viewablefilename` varchar(90) DEFAULT NULL COMMENT '可在线预览的文件名称',
  `viewablefilepath` varchar(60) DEFAULT NULL COMMENT '可在线预览的文件包路径',
  `isunzip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已解压到cmreportItem，默认为0。1：正在解压，0未解压，2：已解压',
  `unviewablefilename` varchar(90) DEFAULT NULL COMMENT '不可预览的文件名称',
  `unviewablefilepath` varchar(60) DEFAULT NULL COMMENT '不可预览的文件路径',
  `isgroup` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否小组报告，0：个人报告，1：小组报告',
  `isread` tinyint(1) NOT NULL DEFAULT '0' COMMENT '报告是否已阅，0：未阅，1：已阅',
  `cstudentid` int(11) NOT NULL COMMENT '外键，提交学生：student',
  `cmgroupid` int(11) DEFAULT NULL COMMENT '外键，提交小组：cmgroup',
  `cmissionid` int(11) NOT NULL COMMENT '外键，课程任务：cmission',
  PRIMARY KEY (`id`),
  KEY `fk_cmreport_student` (`cstudentid`),
  KEY `fk_cmreport_cmgroup` (`cmgroupid`),
  KEY `fk_cmreport_cmission` (`cmissionid`),
  CONSTRAINT `fk_cmreport_cmgroupid` FOREIGN KEY (`cmgroupid`) REFERENCES `cmgroup` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmreport_cmissionid` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cmreport_cstudentid` FOREIGN KEY (`cstudentid`) REFERENCES `cstudent` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmreport
-- ----------------------------

-- ----------------------------
-- Table structure for `cmreportitem`
-- ----------------------------
DROP TABLE IF EXISTS `cmreportitem`;
CREATE TABLE `cmreportitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `filename` varchar(60) NOT NULL COMMENT '任务报告项文件名',
  `mripath` varchar(90) DEFAULT NULL COMMENT '任务报告项路径',
  `mripdfpath` varchar(90) DEFAULT NULL COMMENT '任务报告项pdf路径',
  `mriswfpath` varchar(90) DEFAULT NULL COMMENT '任务报告项swf路径',
  `isconverted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经转换，1：正在转换，0：未转换，2：已转换',
  `cmreportid` int(11) NOT NULL COMMENT '外键，任务报告：cmreport',
  PRIMARY KEY (`id`),
  KEY `fk_cmreportitem_cmreport` (`cmreportid`),
  CONSTRAINT `fk_cmreportitem_cmreport` FOREIGN KEY (`cmreportid`) REFERENCES `cmreport` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmreportitem
-- ----------------------------

-- ----------------------------
-- Table structure for `cmstudent`
-- ----------------------------
DROP TABLE IF EXISTS `cmstudent`;
CREATE TABLE `cmstudent` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(60) NOT NULL,
  `ismarked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务是否已评分，0：未评分，1：已评分',
  `isgrouped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标识是否已分组，0未，1已',
  `isinvolved` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否参与任务，1：参与任务，0：不参与任务',
  `cstudentid` int(11) NOT NULL COMMENT '外键，选课学生：cstudent',
  `cmgroupid` int(11) DEFAULT NULL COMMENT '外键，任务分组：cmgroup',
  `cmissionid` int(11) NOT NULL COMMENT '外键，任务分组：cmgroup',
  PRIMARY KEY (`id`),
  KEY `fk_cmstudent_student` (`cstudentid`),
  KEY `fk_cmstudent_cmgroup` (`cmgroupid`),
  KEY `fk_cmstudent_cmission` (`cmissionid`),
  CONSTRAINT `fk_cmstudent_cmgroup` FOREIGN KEY (`cmgroupid`) REFERENCES `cmgroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cmstudent_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cmstudent_cstudent` FOREIGN KEY (`cstudentid`) REFERENCES `cstudent` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmstudent
-- ----------------------------

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(60) NOT NULL COMMENT '开设课程代码',
  `name` varchar(60) NOT NULL,
  `year` varchar(30) NOT NULL COMMENT '学年',
  `term` varchar(18) NOT NULL COMMENT '学期',
  `tnum` tinyint(4) DEFAULT NULL COMMENT '教师人数[0,127]',
  `snum` smallint(6) DEFAULT NULL COMMENT '学生人数[0,32767]',
  `isgrouped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否设置课程分组，0：未设置课程分组，1：已设置课程分组',
  `isevaluated` tinyint(1) NOT NULL DEFAULT '0',
  `isdeletale` tinyint(1) NOT NULL DEFAULT '1' COMMENT '标志是否可删除，0：不可删除，1：可删除',
  `teacherid` int(11) DEFAULT NULL COMMENT '主导教师',
  `foreignteacherid` int(11) DEFAULT NULL COMMENT '暂时不用',
  `csettingid` int(11) NOT NULL COMMENT '外键，所属课程设置：csetting',
  `description` varchar(600) DEFAULT NULL COMMENT '课程描述',
  `oldname` varchar(90) DEFAULT NULL COMMENT '课程描述的附件原名',
  `attachlocation` varchar(90) DEFAULT NULL COMMENT '课程描述附件的位置',
  `cclass` varchar(60) DEFAULT NULL,
  `randomname` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_code_unique` (`code`),
  KEY `fk_course_csetting` (`csettingid`),
  KEY `fk_course_teacher` (`teacherid`),
  KEY `fk_course_foreignteacher` (`foreignteacherid`),
  CONSTRAINT `fk_course_csetting` FOREIGN KEY (`csettingid`) REFERENCES `csetting` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_course_foreignteacher` FOREIGN KEY (`foreignteacherid`) REFERENCES `teacher` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_teacher` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=773 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('732', '(2014-2015-1)-155327-G03045-1', 'WEB服务与面向服务的体系结构', '2014-2015', '1', '2', '75', '0', '0', '1', '1016', null, '260', null, null, null, '2011', null);
INSERT INTO `course` VALUES ('733', '(2014-2015-1)-155174-G03047-1', '编译技术', '2014-2015', '1', null, '75', '0', '0', '1', '978', null, '240', null, null, null, '2班、卓越班班', null);
INSERT INTO `course` VALUES ('734', '(2014-2015-1)-155174-G03045-1', '编译技术', '2014-2015', '1', null, null, '0', '0', '1', '1016', null, '240', null, null, null, null, null);
INSERT INTO `course` VALUES ('735', '(2014-2015-1)-155174-G03064-1', '编译技术', '2014-2015', '1', null, null, '0', '0', '1', '1026', null, '240', null, null, null, null, null);
INSERT INTO `course` VALUES ('736', '(2014-2015-1)-155011-G03059-1', '高级语言程序设计（C++) Ⅰ', '2014-2015', '1', null, null, '0', '0', '1', '1022', null, '228', null, null, null, null, null);
INSERT INTO `course` VALUES ('737', '(2014-2015-1)-155011-G03022-1', '高级语言程序设计（C++) Ⅰ', '2014-2015', '1', null, null, '0', '0', '1', '1030', null, '228', null, null, null, null, null);
INSERT INTO `course` VALUES ('738', '(2014-2015-1)-155011-G03005-1', '高级语言程序设计（C++) Ⅰ', '2014-2015', '1', null, null, '0', '0', '1', '985', null, '228', null, null, null, null, null);
INSERT INTO `course` VALUES ('739', '(2014-2015-1)-155011-G03064-1', '高级语言程序设计（C++) Ⅰ', '2014-2015', '1', null, null, '0', '0', '1', '1026', null, '228', null, null, null, null, null);
INSERT INTO `course` VALUES ('740', '(2014-2015-1)-155152-G03001-1', '计算机图形学', '2014-2015', '1', null, null, '0', '0', '1', '983', null, '262', null, null, null, null, null);
INSERT INTO `course` VALUES ('741', '(2014-2015-1)-155290-G03007-1', '计算机与软件工程概论', '2014-2015', '1', null, null, '0', '0', '1', '1001', null, '230', null, null, null, null, null);
INSERT INTO `course` VALUES ('742', '(2014-2015-1)-155290-G03015-1', '计算机与软件工程概论', '2014-2015', '1', null, null, '0', '0', '1', '991', null, '230', null, null, null, null, null);
INSERT INTO `course` VALUES ('743', '(2014-2015-1)-155290-B07043-1', '计算机与软件工程概论', '2014-2015', '1', null, null, '0', '0', '1', '972', null, '230', null, null, null, null, null);
INSERT INTO `course` VALUES ('744', '(2014-2015-1)-155290-G03007-2', '计算机与软件工程概论', '2014-2015', '1', null, null, '0', '0', '1', '1001', null, '230', null, null, null, null, null);
INSERT INTO `course` VALUES ('745', '(2014-2015-1)-155141-G03009-1', '计算机组成与体系结构', '2014-2015', '1', null, null, '0', '0', '1', '988', null, '237', null, null, null, null, null);
INSERT INTO `course` VALUES ('746', '(2014-2015-1)-155141-G03013-1', '计算机组成与体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1003', null, '237', null, null, null, null, null);
INSERT INTO `course` VALUES ('747', '(2014-2015-1)-155141-G03013-2', '计算机组成与体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1003', null, '237', null, null, null, null, null);
INSERT INTO `course` VALUES ('748', '(2014-2015-1)-155141-G03019-1', '计算机组成与体系结构', '2014-2015', '1', null, null, '0', '0', '1', '992', null, '237', null, null, null, null, null);
INSERT INTO `course` VALUES ('749', '(2014-2015-1)-155354-G03007-1', '金融信息系统基础', '2014-2015', '1', null, null, '0', '0', '1', '1001', null, '272', null, null, null, null, null);
INSERT INTO `course` VALUES ('750', '(2014-2015-1)-155353-G03007-1', '金融业务实务', '2014-2015', '1', null, null, '0', '0', '1', '1001', null, '271', null, null, null, null, null);
INSERT INTO `course` VALUES ('751', '(2014-2015-1)-155231-G03043-1', '离散数学', '2014-2015', '1', null, null, '0', '0', '1', '980', null, '235', null, null, null, null, null);
INSERT INTO `course` VALUES ('752', '(2014-2015-1)-155231-G03043-3', '离散数学', '2014-2015', '1', null, null, '0', '0', '1', '980', null, '235', null, null, null, null, null);
INSERT INTO `course` VALUES ('753', '(2014-2015-1)-155231-G03043-4', '离散数学', '2014-2015', '1', null, null, '0', '0', '1', '980', null, '235', null, null, null, null, null);
INSERT INTO `course` VALUES ('754', '(2014-2015-1)-155231-G03043-2', '离散数学', '2014-2015', '1', null, null, '0', '0', '1', '980', null, '235', null, null, null, null, null);
INSERT INTO `course` VALUES ('755', '(2014-2015-1)-155351-G03030-1', '嵌入式软件原理', '2014-2015', '1', null, null, '0', '0', '1', '1005', null, '255', null, null, null, null, null);
INSERT INTO `course` VALUES ('756', '(2014-2015-1)-155326-G03056-1', '人工智能', '2014-2015', '1', null, null, '0', '0', '1', '1029', null, '252', null, null, null, null, null);
INSERT INTO `course` VALUES ('757', '(2014-2015-1)-155306-G03044-1', '软件体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1015', null, '243', null, null, null, null, null);
INSERT INTO `course` VALUES ('758', '(2014-2015-1)-155306-G03044-2', '软件体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1015', null, '243', null, null, null, null, null);
INSERT INTO `course` VALUES ('759', '(2014-2015-1)-155306-G03018-1', '软件体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1014', null, '243', null, null, null, null, null);
INSERT INTO `course` VALUES ('760', '(2014-2015-1)-155306-G03018-2', '软件体系结构', '2014-2015', '1', null, null, '0', '0', '1', '1014', null, '243', null, null, null, null, null);
INSERT INTO `course` VALUES ('761', '(2014-2015-1)-155325-G03024-1', '软件项目管理和质量工程', '2014-2015', '1', null, null, '0', '0', '1', '1007', null, '249', null, null, null, null, null);
INSERT INTO `course` VALUES ('762', '(2014-2015-1)-155325-G03020-1', '软件项目管理和质量工程', '2014-2015', '1', null, null, '0', '0', '1', '1021', null, '249', null, null, null, null, null);
INSERT INTO `course` VALUES ('763', '(2014-2015-1)-155325-G03024-2', '软件项目管理和质量工程', '2014-2015', '1', null, null, '0', '0', '1', '1007', null, '249', null, null, null, null, null);
INSERT INTO `course` VALUES ('764', '(2014-2015-1)-155165-G03059-1', '数据仓库与数据挖掘', '2014-2015', '1', null, null, '0', '0', '1', '1022', null, '258', null, null, null, null, null);
INSERT INTO `course` VALUES ('765', '(2014-2015-1)-155016-G03026-2', '数据结构与算法', '2014-2015', '1', null, null, '0', '0', '1', '981', null, '238', null, null, null, null, null);
INSERT INTO `course` VALUES ('766', '(2014-2015-1)-155016-G03026-3', '数据结构与算法', '2014-2015', '1', null, null, '0', '0', '1', '981', null, '238', null, null, null, null, null);
INSERT INTO `course` VALUES ('767', '(2014-2015-1)-155016-G03026-1', '数据结构与算法', '2014-2015', '1', null, null, '0', '0', '1', '981', null, '238', null, null, null, null, null);
INSERT INTO `course` VALUES ('768', '(2014-2015-1)-155016-G03026-4', '数据结构与算法', '2014-2015', '1', null, null, '0', '0', '1', '981', null, '238', null, null, null, null, null);
INSERT INTO `course` VALUES ('769', '(2014-2015-1)-155328-G03047-1', '数字媒体处理技术', '2014-2015', '1', null, null, '0', '0', '1', '978', null, '264', null, null, null, null, null);
INSERT INTO `course` VALUES ('770', '(2014-2015-1)-155331-G03004-1', '移动计算导论', '2014-2015', '1', null, null, '0', '0', '1', '984', null, '267', null, null, null, null, null);
INSERT INTO `course` VALUES ('771', '(2014-2015-1)-155339-G03002-1', '移动平台开发技术', '2014-2015', '1', null, null, '0', '0', '1', '976', null, '268', null, null, null, null, null);
INSERT INTO `course` VALUES ('772', '(2014-2015-1)-155342-G03044-1', '智能人机交互技术', '2014-2015', '1', null, null, '0', '0', '1', '1015', null, '253', null, null, null, null, null);

-- ----------------------------
-- Table structure for `csetting`
-- ----------------------------
DROP TABLE IF EXISTS `csetting`;
CREATE TABLE `csetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) NOT NULL COMMENT '课程设置代码',
  `name` varchar(60) NOT NULL COMMENT '课程设置名称',
  `type` varchar(2) NOT NULL COMMENT '课程设置类型，0：必修，1：选修',
  `description` varchar(600) DEFAULT NULL COMMENT '课程设置简介，不超过200个中文字符',
  `attachname` varchar(90) DEFAULT NULL COMMENT '附件名称，不超过30个中文字符/90个英文字符 （暂时没啥用）',
  `attachlocation` varchar(90) DEFAULT NULL COMMENT '附件目录，不超过90个英文字符（暂时没啥用）',
  `level` varchar(20) NOT NULL DEFAULT '本科' COMMENT '层级（如本科、硕士）',
  `ccategoryid` int(11) NOT NULL COMMENT '外键，所属课程类别：ccategory',
  `majorid` int(11) NOT NULL COMMENT '外键，所属专业：major',
  PRIMARY KEY (`id`),
  KEY `fk_csetting_ccategory` (`ccategoryid`) USING BTREE,
  KEY `fk_csetting_major` (`majorid`) USING BTREE,
  CONSTRAINT `fk_csetting_ccategory` FOREIGN KEY (`ccategoryid`) REFERENCES `ccategory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_csetting_major` FOREIGN KEY (`majorid`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of csetting
-- ----------------------------
INSERT INTO `csetting` VALUES ('228', '155011', '高级语言程序设计（C++) Ⅰ', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('229', '155013', '高级语言程序设计（C++) Ⅱ', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('230', '155290', '计算机与软件工程概论', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('231', '155357', '数字系统创意设计', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('232', '135002', '电路与电子技术', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('233', '155320', 'C/C++/C#语言实训', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('234', '135037', '电路与电子技术实验', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('235', '155231', '离散数学', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('236', '155172', '数字逻辑', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('237', '155141', '计算机组成与体系结构', '必修', null, null, null, '本科', '1', '120');
INSERT INTO `csetting` VALUES ('238', '155016', '数据结构与算法', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('239', '155189', '操作系统', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('240', '155174', '编译技术', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('241', '155021', '计算机网络', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('242', '155147', '数据库系统', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('243', '155306', '软件体系结构', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('244', '155009', 'Java语言程序设计', '必修', null, null, null, '本科', '2', '120');
INSERT INTO `csetting` VALUES ('245', '155321', '软件需求分析设计与建模', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('246', '155053', 'XML技术与应用', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('247', '155319', '数据库实训', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('248', '155349', '软件开发综合实训', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('249', '155325', '软件项目管理和质量工程', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('250', '155324', '软件测试与维护', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('251', '155344', '计算机与算法技术', '必修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('252', '155326', '人工智能', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('253', '155342', '智能人机交互技术', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('254', '155350', '智能软件项目实训', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('255', '155351', '嵌入式软件原理', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('256', '155329', '嵌入式系统软件设计', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('257', '155352', '嵌入式软件项目实训', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('258', '155165', '数据仓库与数据挖掘', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('259', '155343', '分布式智能软件', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('260', '155327', 'WEB服务与面向服务的体系结构', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('261', '155338', 'J2EE软件开发项目实训', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('262', '155152', '计算机图形学', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('263', '155336', '计算机视觉', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('264', '155328', '数字媒体处理技术', '选修', null, null, null, '本科', '3', '120');
INSERT INTO `csetting` VALUES ('265', '155341', '3D动画游戏设计算法', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('266', '155345', '数字媒体实训', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('267', '155331', '移动计算导论', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('268', '155339', '移动平台开发技术', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('269', '155340', '无线传感器网络', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('270', '155346', '3G手机开发实训', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('271', '155353', '金融业务实务', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('272', '155354', '金融信息系统基础', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('273', '155360', '金融软件系统开发技术', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('274', '155361', '金融软件实训', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('275', '155335', '.NET架构与应用', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('276', '155334', 'J2EE架构与应用', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('277', '155160', '电子商务', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('278', '145042', '信息系统安全', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('279', '155288', 'IBM主机系统和操作系统导论', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('280', '155289', 'cobol语言', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('281', '145201', 'IBM zSeries DB2', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('282', '155284', '主机事务处理系统CICS', '选修', null, null, null, '本科', '4', '120');
INSERT INTO `csetting` VALUES ('283', '155362', '企业软件项目实训', '选修', null, null, null, '本科', '4', '120');

-- ----------------------------
-- Table structure for `cstudent`
-- ----------------------------
DROP TABLE IF EXISTS `cstudent`;
CREATE TABLE `cstudent` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(60) NOT NULL,
  `isevaluated` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标志是否已被评价，0：未完成，1：已完成',
  `isgrouped` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标识是否已分组 0：未 1：已',
  `studentid` int(11) NOT NULL COMMENT '外键，选课学生：student',
  `courseid` int(11) NOT NULL COMMENT '外键，所属开设课程: course',
  `cgroupid` int(11) DEFAULT NULL,
  `description` varchar(600) DEFAULT NULL COMMENT '学生备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_cstudent_studentid&courseid` (`studentid`,`courseid`) USING BTREE,
  KEY `fk_cstudent_student` (`studentid`),
  KEY `fk_cstudent_course` (`courseid`),
  KEY `fk_cstudent_cgroup` (`cgroupid`),
  KEY `unique_studentid` (`studentid`) USING BTREE,
  CONSTRAINT `fk_cstudent_cgroup` FOREIGN KEY (`cgroupid`) REFERENCES `cgroup` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_cstudent_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cstudent_student` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1046 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cstudent
-- ----------------------------
INSERT INTO `cstudent` VALUES ('896', '牟波', '0', '0', '156453', '732', null, null);
INSERT INTO `cstudent` VALUES ('897', '彭章', '0', '0', '156447', '732', null, null);
INSERT INTO `cstudent` VALUES ('898', '饶峰', '0', '0', '156333', '732', null, null);
INSERT INTO `cstudent` VALUES ('899', '杨琦琦', '0', '0', '156361', '732', null, null);
INSERT INTO `cstudent` VALUES ('900', '余锦德', '0', '0', '156450', '732', null, null);
INSERT INTO `cstudent` VALUES ('901', '罗刚', '0', '0', '156285', '732', null, null);
INSERT INTO `cstudent` VALUES ('902', '肖勇', '0', '0', '156281', '732', null, null);
INSERT INTO `cstudent` VALUES ('903', '谢卓航', '0', '0', '156267', '732', null, null);
INSERT INTO `cstudent` VALUES ('904', '蔡东荣', '0', '0', '156740', '732', null, null);
INSERT INTO `cstudent` VALUES ('905', '陈海齐', '0', '0', '156727', '732', null, null);
INSERT INTO `cstudent` VALUES ('906', '陈震鸿', '0', '0', '156729', '732', null, null);
INSERT INTO `cstudent` VALUES ('907', '冯振飞', '0', '0', '156715', '732', null, null);
INSERT INTO `cstudent` VALUES ('908', '郭贵鑫', '0', '0', '156720', '732', null, null);
INSERT INTO `cstudent` VALUES ('909', '贺智超', '0', '0', '156706', '732', null, null);
INSERT INTO `cstudent` VALUES ('910', '林丹丹', '0', '0', '156746', '732', null, null);
INSERT INTO `cstudent` VALUES ('911', '林绵程', '0', '0', '156739', '732', null, null);
INSERT INTO `cstudent` VALUES ('912', '林悦邦', '0', '0', '156737', '732', null, null);
INSERT INTO `cstudent` VALUES ('913', '林钊生', '0', '0', '156736', '732', null, null);
INSERT INTO `cstudent` VALUES ('914', '潘杉', '0', '0', '156704', '732', null, null);
INSERT INTO `cstudent` VALUES ('915', '张广怡', '0', '0', '156741', '732', null, null);
INSERT INTO `cstudent` VALUES ('916', '王腾云', '0', '0', '156711', '732', null, null);
INSERT INTO `cstudent` VALUES ('917', '何俊昊', '0', '0', '156627', '732', null, null);
INSERT INTO `cstudent` VALUES ('918', '洪浩贤', '0', '0', '156637', '732', null, null);
INSERT INTO `cstudent` VALUES ('919', '黎思聪', '0', '0', '156688', '732', null, null);
INSERT INTO `cstudent` VALUES ('920', '吴桂城', '0', '0', '156693', '732', null, null);
INSERT INTO `cstudent` VALUES ('921', '严炜', '0', '0', '156697', '732', null, null);
INSERT INTO `cstudent` VALUES ('922', '于晓飞', '0', '0', '156642', '732', null, null);
INSERT INTO `cstudent` VALUES ('923', '袁志江', '0', '0', '156701', '732', null, null);
INSERT INTO `cstudent` VALUES ('924', '张睿', '0', '0', '156631', '732', null, null);
INSERT INTO `cstudent` VALUES ('925', '周叙凯', '0', '0', '156638', '732', null, null);
INSERT INTO `cstudent` VALUES ('926', '陈键', '0', '0', '156676', '732', null, null);
INSERT INTO `cstudent` VALUES ('927', '陈琪杰', '0', '0', '156667', '732', null, null);
INSERT INTO `cstudent` VALUES ('928', '程家颖', '0', '0', '156557', '732', null, null);
INSERT INTO `cstudent` VALUES ('929', '何志澎', '0', '0', '156665', '732', null, null);
INSERT INTO `cstudent` VALUES ('930', '黄佳祥', '0', '0', '156644', '732', null, null);
INSERT INTO `cstudent` VALUES ('931', '金能令', '0', '0', '156673', '732', null, null);
INSERT INTO `cstudent` VALUES ('932', '雷国丽', '0', '0', '156647', '732', null, null);
INSERT INTO `cstudent` VALUES ('933', '李仁鸿', '0', '0', '156657', '732', null, null);
INSERT INTO `cstudent` VALUES ('934', '林标标', '0', '0', '156658', '732', null, null);
INSERT INTO `cstudent` VALUES ('935', '宋永潘', '0', '0', '156679', '732', null, null);
INSERT INTO `cstudent` VALUES ('936', '王泽强', '0', '0', '156675', '732', null, null);
INSERT INTO `cstudent` VALUES ('937', '谢郑逸', '0', '0', '156662', '732', null, null);
INSERT INTO `cstudent` VALUES ('938', '杨伟均', '0', '0', '156646', '732', null, null);
INSERT INTO `cstudent` VALUES ('939', '詹昊恂', '0', '0', '156659', '732', null, null);
INSERT INTO `cstudent` VALUES ('940', '钟霄楠', '0', '0', '156674', '732', null, null);
INSERT INTO `cstudent` VALUES ('941', '李天伦', '0', '0', '156654', '732', null, null);
INSERT INTO `cstudent` VALUES ('942', '戴瑾如', '0', '0', '156564', '732', null, null);
INSERT INTO `cstudent` VALUES ('943', '高世华', '0', '0', '156592', '732', null, null);
INSERT INTO `cstudent` VALUES ('944', '郭泽豪', '0', '0', '156560', '732', null, null);
INSERT INTO `cstudent` VALUES ('945', '何一鸣', '0', '0', '156566', '732', null, null);
INSERT INTO `cstudent` VALUES ('946', '黄国锴', '0', '0', '156578', '732', null, null);
INSERT INTO `cstudent` VALUES ('947', '欧阳佳宾', '0', '0', '156587', '732', null, null);
INSERT INTO `cstudent` VALUES ('948', '邱丹耀', '0', '0', '156559', '732', null, null);
INSERT INTO `cstudent` VALUES ('949', '陈竹天', '0', '0', '156615', '732', null, null);
INSERT INTO `cstudent` VALUES ('950', '胡友成', '0', '0', '156497', '732', null, null);
INSERT INTO `cstudent` VALUES ('951', '黎灿', '0', '0', '156503', '732', null, null);
INSERT INTO `cstudent` VALUES ('952', '罗佳妮', '0', '0', '156504', '732', null, null);
INSERT INTO `cstudent` VALUES ('953', '罗伟昂', '0', '0', '156606', '732', null, null);
INSERT INTO `cstudent` VALUES ('954', '曹梓宏', '0', '0', '156537', '732', null, null);
INSERT INTO `cstudent` VALUES ('955', '陈俊生', '0', '0', '156531', '732', null, null);
INSERT INTO `cstudent` VALUES ('956', '韩蕊', '0', '0', '156533', '732', null, null);
INSERT INTO `cstudent` VALUES ('957', '梁淼荣', '0', '0', '156547', '732', null, null);
INSERT INTO `cstudent` VALUES ('958', '陆荣扬', '0', '0', '156538', '732', null, null);
INSERT INTO `cstudent` VALUES ('959', '彭成墙', '0', '0', '156520', '732', null, null);
INSERT INTO `cstudent` VALUES ('960', '苏莹子', '0', '0', '156516', '732', null, null);
INSERT INTO `cstudent` VALUES ('961', '朱未翔', '0', '0', '156544', '732', null, null);
INSERT INTO `cstudent` VALUES ('962', '曹丽杰', '0', '0', '156553', '732', null, null);
INSERT INTO `cstudent` VALUES ('963', '陈丹旎', '0', '0', '156469', '732', null, null);
INSERT INTO `cstudent` VALUES ('964', '陈诗云', '0', '0', '156475', '732', null, null);
INSERT INTO `cstudent` VALUES ('965', '顾润丰', '0', '0', '156458', '732', null, null);
INSERT INTO `cstudent` VALUES ('966', '胡舒悦', '0', '0', '156466', '732', null, null);
INSERT INTO `cstudent` VALUES ('967', '黎矿维', '0', '0', '156554', '732', null, null);
INSERT INTO `cstudent` VALUES ('968', '李家健', '0', '0', '156465', '732', null, null);
INSERT INTO `cstudent` VALUES ('969', '苏裕贤', '0', '0', '156481', '732', null, null);
INSERT INTO `cstudent` VALUES ('970', '翁耿森', '0', '0', '156478', '732', null, null);
INSERT INTO `cstudent` VALUES ('971', '牟波', '0', '0', '156453', '733', null, null);
INSERT INTO `cstudent` VALUES ('972', '彭章', '0', '0', '156447', '733', null, null);
INSERT INTO `cstudent` VALUES ('973', '饶峰', '0', '0', '156333', '733', null, null);
INSERT INTO `cstudent` VALUES ('974', '杨琦琦', '0', '0', '156361', '733', null, null);
INSERT INTO `cstudent` VALUES ('975', '余锦德', '0', '0', '156450', '733', null, null);
INSERT INTO `cstudent` VALUES ('976', '罗刚', '0', '0', '156285', '733', null, null);
INSERT INTO `cstudent` VALUES ('977', '肖勇', '0', '0', '156281', '733', null, null);
INSERT INTO `cstudent` VALUES ('978', '谢卓航', '0', '0', '156267', '733', null, null);
INSERT INTO `cstudent` VALUES ('979', '蔡东荣', '0', '0', '156740', '733', null, null);
INSERT INTO `cstudent` VALUES ('980', '陈海齐', '0', '0', '156727', '733', null, null);
INSERT INTO `cstudent` VALUES ('981', '陈震鸿', '0', '0', '156729', '733', null, null);
INSERT INTO `cstudent` VALUES ('982', '冯振飞', '0', '0', '156715', '733', null, null);
INSERT INTO `cstudent` VALUES ('983', '郭贵鑫', '0', '0', '156720', '733', null, null);
INSERT INTO `cstudent` VALUES ('984', '贺智超', '0', '0', '156706', '733', null, null);
INSERT INTO `cstudent` VALUES ('985', '林丹丹', '0', '0', '156746', '733', null, null);
INSERT INTO `cstudent` VALUES ('986', '林绵程', '0', '0', '156739', '733', null, null);
INSERT INTO `cstudent` VALUES ('987', '林悦邦', '0', '0', '156737', '733', null, null);
INSERT INTO `cstudent` VALUES ('988', '林钊生', '0', '0', '156736', '733', null, null);
INSERT INTO `cstudent` VALUES ('989', '潘杉', '0', '0', '156704', '733', null, null);
INSERT INTO `cstudent` VALUES ('990', '张广怡', '0', '0', '156741', '733', null, null);
INSERT INTO `cstudent` VALUES ('991', '王腾云', '0', '0', '156711', '733', null, null);
INSERT INTO `cstudent` VALUES ('992', '何俊昊', '0', '0', '156627', '733', null, null);
INSERT INTO `cstudent` VALUES ('993', '洪浩贤', '0', '0', '156637', '733', null, null);
INSERT INTO `cstudent` VALUES ('994', '黎思聪', '0', '0', '156688', '733', null, null);
INSERT INTO `cstudent` VALUES ('995', '吴桂城', '0', '0', '156693', '733', null, null);
INSERT INTO `cstudent` VALUES ('996', '严炜', '0', '0', '156697', '733', null, null);
INSERT INTO `cstudent` VALUES ('997', '于晓飞', '0', '0', '156642', '733', null, null);
INSERT INTO `cstudent` VALUES ('998', '袁志江', '0', '0', '156701', '733', null, null);
INSERT INTO `cstudent` VALUES ('999', '张睿', '0', '0', '156631', '733', null, null);
INSERT INTO `cstudent` VALUES ('1000', '周叙凯', '0', '0', '156638', '733', null, null);
INSERT INTO `cstudent` VALUES ('1001', '陈键', '0', '0', '156676', '733', null, null);
INSERT INTO `cstudent` VALUES ('1002', '陈琪杰', '0', '0', '156667', '733', null, null);
INSERT INTO `cstudent` VALUES ('1003', '程家颖', '0', '0', '156557', '733', null, null);
INSERT INTO `cstudent` VALUES ('1004', '何志澎', '0', '0', '156665', '733', null, null);
INSERT INTO `cstudent` VALUES ('1005', '黄佳祥', '0', '0', '156644', '733', null, null);
INSERT INTO `cstudent` VALUES ('1006', '金能令', '0', '0', '156673', '733', null, null);
INSERT INTO `cstudent` VALUES ('1007', '雷国丽', '0', '0', '156647', '733', null, null);
INSERT INTO `cstudent` VALUES ('1008', '李仁鸿', '0', '0', '156657', '733', null, null);
INSERT INTO `cstudent` VALUES ('1009', '林标标', '0', '0', '156658', '733', null, null);
INSERT INTO `cstudent` VALUES ('1010', '宋永潘', '0', '0', '156679', '733', null, null);
INSERT INTO `cstudent` VALUES ('1011', '王泽强', '0', '0', '156675', '733', null, null);
INSERT INTO `cstudent` VALUES ('1012', '谢郑逸', '0', '0', '156662', '733', null, null);
INSERT INTO `cstudent` VALUES ('1013', '杨伟均', '0', '0', '156646', '733', null, null);
INSERT INTO `cstudent` VALUES ('1014', '詹昊恂', '0', '0', '156659', '733', null, null);
INSERT INTO `cstudent` VALUES ('1015', '钟霄楠', '0', '0', '156674', '733', null, null);
INSERT INTO `cstudent` VALUES ('1016', '李天伦', '0', '0', '156654', '733', null, null);
INSERT INTO `cstudent` VALUES ('1017', '戴瑾如', '0', '0', '156564', '733', null, null);
INSERT INTO `cstudent` VALUES ('1018', '高世华', '0', '0', '156592', '733', null, null);
INSERT INTO `cstudent` VALUES ('1019', '郭泽豪', '0', '0', '156560', '733', null, null);
INSERT INTO `cstudent` VALUES ('1020', '何一鸣', '0', '0', '156566', '733', null, null);
INSERT INTO `cstudent` VALUES ('1021', '黄国锴', '0', '0', '156578', '733', null, null);
INSERT INTO `cstudent` VALUES ('1022', '欧阳佳宾', '0', '0', '156587', '733', null, null);
INSERT INTO `cstudent` VALUES ('1023', '邱丹耀', '0', '0', '156559', '733', null, null);
INSERT INTO `cstudent` VALUES ('1024', '陈竹天', '0', '0', '156615', '733', null, null);
INSERT INTO `cstudent` VALUES ('1025', '胡友成', '0', '0', '156497', '733', null, null);
INSERT INTO `cstudent` VALUES ('1026', '黎灿', '0', '0', '156503', '733', null, null);
INSERT INTO `cstudent` VALUES ('1027', '罗佳妮', '0', '0', '156504', '733', null, null);
INSERT INTO `cstudent` VALUES ('1028', '罗伟昂', '0', '0', '156606', '733', null, null);
INSERT INTO `cstudent` VALUES ('1029', '曹梓宏', '0', '0', '156537', '733', null, null);
INSERT INTO `cstudent` VALUES ('1030', '陈俊生', '0', '0', '156531', '733', null, null);
INSERT INTO `cstudent` VALUES ('1031', '韩蕊', '0', '0', '156533', '733', null, null);
INSERT INTO `cstudent` VALUES ('1032', '梁淼荣', '0', '0', '156547', '733', null, null);
INSERT INTO `cstudent` VALUES ('1033', '陆荣扬', '0', '0', '156538', '733', null, null);
INSERT INTO `cstudent` VALUES ('1034', '彭成墙', '0', '0', '156520', '733', null, null);
INSERT INTO `cstudent` VALUES ('1035', '苏莹子', '0', '0', '156516', '733', null, null);
INSERT INTO `cstudent` VALUES ('1036', '朱未翔', '0', '0', '156544', '733', null, null);
INSERT INTO `cstudent` VALUES ('1037', '曹丽杰', '0', '0', '156553', '733', null, null);
INSERT INTO `cstudent` VALUES ('1038', '陈丹旎', '0', '0', '156469', '733', null, null);
INSERT INTO `cstudent` VALUES ('1039', '陈诗云', '0', '0', '156475', '733', null, null);
INSERT INTO `cstudent` VALUES ('1040', '顾润丰', '0', '0', '156458', '733', null, null);
INSERT INTO `cstudent` VALUES ('1041', '胡舒悦', '0', '0', '156466', '733', null, null);
INSERT INTO `cstudent` VALUES ('1042', '黎矿维', '0', '0', '156554', '733', null, null);
INSERT INTO `cstudent` VALUES ('1043', '李家健', '0', '0', '156465', '733', null, null);
INSERT INTO `cstudent` VALUES ('1044', '苏裕贤', '0', '0', '156481', '733', null, null);
INSERT INTO `cstudent` VALUES ('1045', '翁耿森', '0', '0', '156478', '733', null, null);

-- ----------------------------
-- Table structure for `cteacher`
-- ----------------------------
DROP TABLE IF EXISTS `cteacher`;
CREATE TABLE `cteacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `teacherid` int(11) NOT NULL COMMENT '外键，教师：teacher',
  `courseid` int(11) NOT NULL COMMENT '外键，开设课程: course',
  `isdominate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为主导老师，只有一个为1',
  PRIMARY KEY (`id`,`teacherid`,`courseid`),
  KEY `fk_cteacher_teacher` (`teacherid`),
  KEY `fk_cteacher_course` (`courseid`),
  CONSTRAINT `fk_cteacher_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cteacher_teacher` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=619 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cteacher
-- ----------------------------
INSERT INTO `cteacher` VALUES ('577', '978', '733', '1');
INSERT INTO `cteacher` VALUES ('578', '1016', '734', '1');
INSERT INTO `cteacher` VALUES ('579', '1026', '735', '1');
INSERT INTO `cteacher` VALUES ('580', '1022', '736', '1');
INSERT INTO `cteacher` VALUES ('581', '1030', '737', '1');
INSERT INTO `cteacher` VALUES ('582', '985', '738', '1');
INSERT INTO `cteacher` VALUES ('583', '1026', '739', '1');
INSERT INTO `cteacher` VALUES ('584', '983', '740', '1');
INSERT INTO `cteacher` VALUES ('585', '1001', '741', '1');
INSERT INTO `cteacher` VALUES ('586', '991', '742', '1');
INSERT INTO `cteacher` VALUES ('587', '972', '743', '1');
INSERT INTO `cteacher` VALUES ('588', '1001', '744', '1');
INSERT INTO `cteacher` VALUES ('589', '988', '745', '1');
INSERT INTO `cteacher` VALUES ('590', '1003', '746', '1');
INSERT INTO `cteacher` VALUES ('591', '1003', '747', '1');
INSERT INTO `cteacher` VALUES ('592', '992', '748', '1');
INSERT INTO `cteacher` VALUES ('593', '1001', '749', '1');
INSERT INTO `cteacher` VALUES ('594', '1001', '750', '1');
INSERT INTO `cteacher` VALUES ('595', '980', '751', '1');
INSERT INTO `cteacher` VALUES ('596', '980', '752', '1');
INSERT INTO `cteacher` VALUES ('597', '980', '753', '1');
INSERT INTO `cteacher` VALUES ('598', '980', '754', '1');
INSERT INTO `cteacher` VALUES ('599', '1005', '755', '1');
INSERT INTO `cteacher` VALUES ('600', '1029', '756', '1');
INSERT INTO `cteacher` VALUES ('601', '1015', '757', '1');
INSERT INTO `cteacher` VALUES ('602', '1015', '758', '1');
INSERT INTO `cteacher` VALUES ('603', '1014', '759', '1');
INSERT INTO `cteacher` VALUES ('604', '1014', '760', '1');
INSERT INTO `cteacher` VALUES ('605', '1007', '761', '1');
INSERT INTO `cteacher` VALUES ('606', '1021', '762', '1');
INSERT INTO `cteacher` VALUES ('607', '1007', '763', '1');
INSERT INTO `cteacher` VALUES ('608', '1022', '764', '1');
INSERT INTO `cteacher` VALUES ('609', '981', '765', '1');
INSERT INTO `cteacher` VALUES ('610', '981', '766', '1');
INSERT INTO `cteacher` VALUES ('611', '981', '767', '1');
INSERT INTO `cteacher` VALUES ('612', '981', '768', '1');
INSERT INTO `cteacher` VALUES ('613', '978', '769', '1');
INSERT INTO `cteacher` VALUES ('614', '984', '770', '1');
INSERT INTO `cteacher` VALUES ('615', '976', '771', '1');
INSERT INTO `cteacher` VALUES ('616', '1015', '772', '1');
INSERT INTO `cteacher` VALUES ('617', '1016', '732', '1');
INSERT INTO `cteacher` VALUES ('618', '1', '732', '0');

-- ----------------------------
-- Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '院系代码',
  `name` varchar(60) NOT NULL COMMENT '院系名称',
  `universityid` int(11) NOT NULL COMMENT '外键：所属学校，university',
  PRIMARY KEY (`id`),
  KEY `fk_department_university` (`universityid`) USING BTREE,
  CONSTRAINT `fk_department_university` FOREIGN KEY (`universityid`) REFERENCES `university` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '001', '机械与汽车工程学院', '1');
INSERT INTO `department` VALUES ('2', '003', '建筑学院', '1');
INSERT INTO `department` VALUES ('3', '005', '土木与交通学院', '1');
INSERT INTO `department` VALUES ('4', '006', '电子与信息学院', '1');
INSERT INTO `department` VALUES ('5', '007', '电力学院', '1');
INSERT INTO `department` VALUES ('6', '008', '计算机科学与工程学院', '1');
INSERT INTO `department` VALUES ('7', '009', '自动化科学与工程学院', '1');
INSERT INTO `department` VALUES ('8', '011', '材料科学与工程学院', '1');
INSERT INTO `department` VALUES ('9', '012', '环境与能源学院', '1');
INSERT INTO `department` VALUES ('10', '013', '化学与化工学院', '1');
INSERT INTO `department` VALUES ('11', '014', '轻工与食品学院', '1');
INSERT INTO `department` VALUES ('12', '016', '理学院数学系', '1');
INSERT INTO `department` VALUES ('13', '017', '生物科学与工程学院', '1');
INSERT INTO `department` VALUES ('14', '018', '理学院物理系', '1');
INSERT INTO `department` VALUES ('15', '019', '思想政治学院', '1');
INSERT INTO `department` VALUES ('16', '020', '工商管理学院', '1');
INSERT INTO `department` VALUES ('17', '021', '外国语学院', '1');
INSERT INTO `department` VALUES ('18', '022', '公共管理学院', '1');
INSERT INTO `department` VALUES ('19', '023', '软件学院', '1');
INSERT INTO `department` VALUES ('20', '204', '经济与贸易学院', '1');
INSERT INTO `department` VALUES ('21', '025', '新闻与传播学院', '1');
INSERT INTO `department` VALUES ('22', '026', '艺术学院', '1');
INSERT INTO `department` VALUES ('23', '027', '法学院', '1');
INSERT INTO `department` VALUES ('24', '028', '设计学院', '1');
INSERT INTO `department` VALUES ('25', '029', '体育学院', '1');

-- ----------------------------
-- Table structure for `ecategory`
-- ----------------------------
DROP TABLE IF EXISTS `ecategory`;
CREATE TABLE `ecategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '评价指标类型代码',
  `name` varchar(60) NOT NULL COMMENT '评价指标类型名称',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 标记该指标类型是否可用，0：不可用，1：可用，默认为1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ecategory
-- ----------------------------
INSERT INTO `ecategory` VALUES ('1', 'K', '知识架构', '1');
INSERT INTO `ecategory` VALUES ('2', 'C', '能力要求', '1');
INSERT INTO `ecategory` VALUES ('3', 'Q', '素质要求', '1');

-- ----------------------------
-- Table structure for `fleindex`
-- ----------------------------
DROP TABLE IF EXISTS `fleindex`;
CREATE TABLE `fleindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '一级评价指标代码',
  `name` varchar(150) NOT NULL COMMENT '一级评价指标名称',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 标记该1级指标是否可用，0：不可用，1：可用，默认为1',
  `isfinal` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可评分项，0：不可评分，1：可评分。默认为：1',
  `ecategoryid` int(11) NOT NULL COMMENT '外键，所属指标类别：ecategory',
  `majorid` int(11) NOT NULL COMMENT '外键，所属专业：major',
  PRIMARY KEY (`id`),
  KEY `fk_fleindex_ecategory` (`ecategoryid`) USING BTREE,
  KEY `fk_fleindex_major` (`majorid`) USING BTREE,
  CONSTRAINT `fk_fleindex_ecategory` FOREIGN KEY (`ecategoryid`) REFERENCES `ecategory` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fleindex_major` FOREIGN KEY (`majorid`) REFERENCES `major` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fleindex
-- ----------------------------
INSERT INTO `fleindex` VALUES ('1', 'KA', '具有良好的人文科学素质、强烈的社会责任感和良好的工程职业道德', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('2', 'KB', '具有良好的软件项目质量控制和计算机安全意识，注重环境保护、生态平衡和可持续发展', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('3', 'KC', '掌握从事软件设计和开发所需的相关数学、物理、电子、经济管理以及人文科', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('4', 'KD', '掌握扎实的软件基础理论、软件技术和软件项目管理知识，了解软件专业的前沿发展现状和趋势', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('5', 'KE', '具有创新性思维和系统性思维', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('6', 'KF', '具有综合运用软件理论、方法和技术手段独立地分析和设计软件项目的能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('7', 'KG', '具有开拓创新意识和进行软件项目设计开发的能力，以及软件系统集成的基本能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('8', 'KH', '具有新软件技术应用和开发的基本能力，能够处理软件系统与社会和自然和谐的基本能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('9', 'KI', '熟悉软件领域技术标准，以及相关行业的政策、法律和法规', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('10', 'KJ', '具有良好的软件项目组织管理能力、较强的交流沟通和团队合作能力，具备一定的领袖潜质', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('11', 'KK', '具有应对软件系统危机与突发事件的基本能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('12', 'KL', '具有国际实业和跨文化环境下的交流、竞争与合作的基本能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('13', 'KM', '具有信息获取、知识更新和终身学习的能力', '1', '1', '1', '120');
INSERT INTO `fleindex` VALUES ('14', 'CA', '自然科学基础与问题求解能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('15', 'CB', '计算机基础知识', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('16', 'CC', '软件工程基础技术与能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('17', 'CD', '专业领域放心知识与研发能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('18', 'CE', '企业项目实训实战能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('19', 'CF', '软件技术创新与创业能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('20', 'CG', '领袖潜质与沟通交流能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('21', 'CH', '创新与终身学习能力', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('22', 'CI', '人文和环境保护意识', '1', '0', '2', '120');
INSERT INTO `fleindex` VALUES ('23', 'QA', '志存高远、意志坚强--以传承文明、探求真理、振兴中华、造福人类为己任，矢志不渝', '1', '1', '3', '120');
INSERT INTO `fleindex` VALUES ('24', 'QB', '刻苦务实、精勤进取——脚踏实地，不慕虚名；勤奋努力，追求卓越', '1', '1', '3', '120');
INSERT INTO `fleindex` VALUES ('25', 'QC', '身心和谐、视野开阔——具有良好的身体和心理素质；具有对多元文化的包容心态和宽阔的国际化视野', '1', '1', '3', '120');
INSERT INTO `fleindex` VALUES ('26', 'QD', '思维敏捷、乐于创新——勤于思考，善于钻研，对于推陈出新怀有浓厚的兴趣，富有探索精神并渴望解决问题', '1', '1', '3', '120');
INSERT INTO `fleindex` VALUES ('27', 'QE', '崇高价值观念--具有正确的法律意识、职业道德及很强的社会责任感，具有较强的主动性、责任感与合作性', '1', '1', '3', '120');

-- ----------------------------
-- Table structure for `major`
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) NOT NULL COMMENT '专业代码',
  `name` varchar(60) NOT NULL COMMENT '专业名称',
  `departmentid` int(11) NOT NULL COMMENT '外键：所属院系，department',
  `isdefault` tinyint(1) DEFAULT '0' COMMENT '是否默认专业',
  PRIMARY KEY (`id`,`code`),
  KEY `fk_major_department` (`departmentid`) USING BTREE,
  KEY `id` (`id`),
  CONSTRAINT `fk_major_department` FOREIGN KEY (`departmentid`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('1', '080503', '材料加工工程', '8', '0');
INSERT INTO `major` VALUES ('2', '080501', '材料物理与化学', '8', '0');
INSERT INTO `major` VALUES ('3', '080502', '材料学', '8', '0');
INSERT INTO `major` VALUES ('4', '080903', '微电子学与固体电子学', '8', '0');
INSERT INTO `major` VALUES ('5', '070305', '高分子化学与物理', '8', '0');
INSERT INTO `major` VALUES ('6', '083100', '生物医学工程', '8', '0');
INSERT INTO `major` VALUES ('7', '080801', '电机与电器', '5', '0');
INSERT INTO `major` VALUES ('8', '080802', '电力系统及其自动化', '5', '0');
INSERT INTO `major` VALUES ('9', '080803', '高电压与绝缘技术', '5', '0');
INSERT INTO `major` VALUES ('10', '080804', '电力电子与电力传动', '5', '0');
INSERT INTO `major` VALUES ('11', '080805', '电工理论与新技术', '5', '0');
INSERT INTO `major` VALUES ('12', '0808Z1', '电站系统及控制', '5', '0');
INSERT INTO `major` VALUES ('13', '080701', '工程热物理', '5', '0');
INSERT INTO `major` VALUES ('14', '080702', '热能工程', '5', '0');
INSERT INTO `major` VALUES ('15', '080704', '流体机械及工程', '5', '0');
INSERT INTO `major` VALUES ('16', '080705', '制冷及低温工程', '5', '0');
INSERT INTO `major` VALUES ('17', '080903', '微电子学与固体电子学', '4', '0');
INSERT INTO `major` VALUES ('18', '080901', '物理电子学', '4', '0');
INSERT INTO `major` VALUES ('19', '080902', '电路与系统', '4', '0');
INSERT INTO `major` VALUES ('20', '080904', '电磁场与微波技术', '4', '0');
INSERT INTO `major` VALUES ('21', '081001', '通信与信息系统', '4', '0');
INSERT INTO `major` VALUES ('22', '081002', '信号与信息处理', '4', '0');
INSERT INTO `major` VALUES ('23', '030101', '法学理论', '23', '0');
INSERT INTO `major` VALUES ('24', '030102', '法律史', '23', '0');
INSERT INTO `major` VALUES ('25', '030103', '宪法学与行政法学', '23', '0');
INSERT INTO `major` VALUES ('26', '030104', '刑法学', '23', '0');
INSERT INTO `major` VALUES ('27', '030105', '民商法学', '23', '0');
INSERT INTO `major` VALUES ('28', '030106', '诉讼法学', '23', '0');
INSERT INTO `major` VALUES ('29', '030107', '经济法学', '23', '0');
INSERT INTO `major` VALUES ('30', '030108', '环境与资源保护法学', '23', '0');
INSERT INTO `major` VALUES ('31', '030109', '国际法学', '23', '0');
INSERT INTO `major` VALUES ('32', '030110', '军事法学', '23', '0');
INSERT INTO `major` VALUES ('33', '0301Z1', '知识产权', '23', '0');
INSERT INTO `major` VALUES ('34', '120201', '会计学', '16', '0');
INSERT INTO `major` VALUES ('35', '120202', '企业管理', '16', '0');
INSERT INTO `major` VALUES ('36', '120204', '技术经济及管理', '16', '0');
INSERT INTO `major` VALUES ('37', '120100', '管理科学与工程', '16', '0');
INSERT INTO `major` VALUES ('38', '120401', '行政管理', '18', '0');
INSERT INTO `major` VALUES ('39', '120402', '社会医学与卫生事业管理', '18', '0');
INSERT INTO `major` VALUES ('40', '120403', '教育经济与管理', '18', '0');
INSERT INTO `major` VALUES ('41', '120404', '社会保障', '18', '0');
INSERT INTO `major` VALUES ('42', '120405', '土地资源管理', '18', '0');
INSERT INTO `major` VALUES ('43', '040101', '教育学原理', '18', '0');
INSERT INTO `major` VALUES ('44', '040102', '课程与教学论', '18', '0');
INSERT INTO `major` VALUES ('45', '040103', '教育史', '18', '0');
INSERT INTO `major` VALUES ('46', '040104', '比较教育学', '18', '0');
INSERT INTO `major` VALUES ('47', '040105', '学前教育学', '18', '0');
INSERT INTO `major` VALUES ('48', '040106', '高等教育学', '18', '0');
INSERT INTO `major` VALUES ('49', '040107', '成人教育学', '18', '0');
INSERT INTO `major` VALUES ('50', '040108', '职业技术教育学', '18', '0');
INSERT INTO `major` VALUES ('51', '040109', '特殊教育学', '18', '0');
INSERT INTO `major` VALUES ('52', '040110', '教育技术学', '18', '0');
INSERT INTO `major` VALUES ('53', '070301', '无机化学', '10', '0');
INSERT INTO `major` VALUES ('54', '070302', '分析化学', '10', '0');
INSERT INTO `major` VALUES ('55', '070303', '有机化学', '10', '0');
INSERT INTO `major` VALUES ('56', '070304', '物理化学', '10', '0');
INSERT INTO `major` VALUES ('57', '081701', '化学工程', '10', '0');
INSERT INTO `major` VALUES ('58', '081702', '化学工艺', '10', '0');
INSERT INTO `major` VALUES ('59', '081703', '生物化工', '10', '0');
INSERT INTO `major` VALUES ('60', '081704', '应用化学', '10', '0');
INSERT INTO `major` VALUES ('61', '081705', '工业催化', '10', '0');
INSERT INTO `major` VALUES ('62', '0817Z1', '能源化学工程', '10', '0');
INSERT INTO `major` VALUES ('63', '083001', '环境科学', '9', '0');
INSERT INTO `major` VALUES ('64', '083002', '环境工程', '9', '0');
INSERT INTO `major` VALUES ('65', '083700', '安全科学与工程', '1', '0');
INSERT INTO `major` VALUES ('66', '080503', '材料加工工程', '1', '0');
INSERT INTO `major` VALUES ('67', '080703', '动力机械及工程', '1', '0');
INSERT INTO `major` VALUES ('68', '080706', '化工过程机械', '1', '0');
INSERT INTO `major` VALUES ('69', '080201', '机械制造及其自动化', '1', '0');
INSERT INTO `major` VALUES ('70', '080202', '机械电子工程', '1', '0');
INSERT INTO `major` VALUES ('71', '080203', '机械设计及理论', '1', '0');
INSERT INTO `major` VALUES ('72', '080204', '车辆工程', '1', '0');
INSERT INTO `major` VALUES ('73', '0802Z1', '制造工程智能化检测及仪器', '1', '0');
INSERT INTO `major` VALUES ('74', '082003', '油气储运工程', '1', '0');
INSERT INTO `major` VALUES ('75', '080402', '测试计量技术及仪器', '1', '0');
INSERT INTO `major` VALUES ('76', '081201', '计算机系统结构', '6', '0');
INSERT INTO `major` VALUES ('77', '081202', '计算机软件与理论', '6', '0');
INSERT INTO `major` VALUES ('78', '081203', '计算机应用技术', '6', '0');
INSERT INTO `major` VALUES ('79', '083301', '城市规划与设计', '2', '0');
INSERT INTO `major` VALUES ('80', '083400', '风景园林学', '2', '0');
INSERT INTO `major` VALUES ('81', '081301', '建筑历史与理论', '2', '0');
INSERT INTO `major` VALUES ('82', '081302', '建筑设计及其理论', '2', '0');
INSERT INTO `major` VALUES ('83', '081303', '建筑技术科学', '2', '0');
INSERT INTO `major` VALUES ('84', '120203', '旅游管理', '20', '0');
INSERT INTO `major` VALUES ('85', '120100', '管理科学与工程', '20', '0');
INSERT INTO `major` VALUES ('86', '027000', '统计学', '20', '0');
INSERT INTO `major` VALUES ('87', '020201', '国民经济学', '20', '0');
INSERT INTO `major` VALUES ('88', '020202', '区域经济学', '20', '0');
INSERT INTO `major` VALUES ('89', '020203', '财政学（含税收学）', '20', '0');
INSERT INTO `major` VALUES ('90', '020204', '金融学', '20', '0');
INSERT INTO `major` VALUES ('91', '020205', '产业经济学', '20', '0');
INSERT INTO `major` VALUES ('92', '020206', '国际贸易学', '20', '0');
INSERT INTO `major` VALUES ('93', '020207', '劳动经济学', '20', '0');
INSERT INTO `major` VALUES ('94', '020209', '数量经济学', '20', '0');
INSERT INTO `major` VALUES ('95', '020210', '国防经济学', '20', '0');
INSERT INTO `major` VALUES ('96', '070101', '基础数学', '12', '0');
INSERT INTO `major` VALUES ('97', '070102', '计算数学', '12', '0');
INSERT INTO `major` VALUES ('98', '070103', '概率论与数理统计', '12', '0');
INSERT INTO `major` VALUES ('99', '070104', '应用数学', '12', '0');
INSERT INTO `major` VALUES ('100', '070105', '运筹学与控制论', '12', '0');
INSERT INTO `major` VALUES ('101', '070201', '理论物理', '14', '0');
INSERT INTO `major` VALUES ('102', '070202', '粒子物理与原子核物理', '14', '0');
INSERT INTO `major` VALUES ('103', '070203', '原子与分子物理', '14', '0');
INSERT INTO `major` VALUES ('104', '070204', '等离子体物理', '14', '0');
INSERT INTO `major` VALUES ('105', '070205', '凝聚态物理', '14', '0');
INSERT INTO `major` VALUES ('106', '070206', '声学', '14', '0');
INSERT INTO `major` VALUES ('107', '070207', '光学', '14', '0');
INSERT INTO `major` VALUES ('108', '070208', '无线电物理', '14', '0');
INSERT INTO `major` VALUES ('109', '082201', '制浆造纸工程', '11', '0');
INSERT INTO `major` VALUES ('110', '082202', '制糖工程', '11', '0');
INSERT INTO `major` VALUES ('111', '082204', '皮革化学与工程', '11', '0');
INSERT INTO `major` VALUES ('112', '0822Z1', '淀粉资源科学与工程', '11', '0');
INSERT INTO `major` VALUES ('113', '0822Z2', '生物质科学与工程', '11', '0');
INSERT INTO `major` VALUES ('114', '083201', '食品科学', '11', '0');
INSERT INTO `major` VALUES ('115', '083202', '粮食、油脂及植物蛋白工程', '11', '0');
INSERT INTO `major` VALUES ('116', '083203', '农产品加工及贮藏工程', '11', '0');
INSERT INTO `major` VALUES ('117', '083204', '水产品加工及贮藏工程', '11', '0');
INSERT INTO `major` VALUES ('118', '0832Z1', '食品质量与安全', '11', '0');
INSERT INTO `major` VALUES ('120', '083500', '软件工程', '19', '0');
INSERT INTO `major` VALUES ('121', '082203', '发酵工程', '13', '0');
INSERT INTO `major` VALUES ('122', '071001', '植物学', '13', '0');
INSERT INTO `major` VALUES ('123', '071002', '动物学', '13', '0');
INSERT INTO `major` VALUES ('124', '071003', '生理学', '13', '0');
INSERT INTO `major` VALUES ('125', '071004', '水生生物学', '13', '0');
INSERT INTO `major` VALUES ('126', '071005', '微生物学', '13', '0');
INSERT INTO `major` VALUES ('127', '071006', '神经生物学', '13', '0');
INSERT INTO `major` VALUES ('128', '071007', '遗传学', '13', '0');
INSERT INTO `major` VALUES ('129', '071008', '发育生物学', '13', '0');
INSERT INTO `major` VALUES ('130', '071009', '细胞生物学', '13', '0');
INSERT INTO `major` VALUES ('131', '071010', '生物化学与分子生物学', '13', '0');
INSERT INTO `major` VALUES ('132', '071011', '生物物理学', '13', '0');
INSERT INTO `major` VALUES ('133', '071012', '生态学', '13', '0');
INSERT INTO `major` VALUES ('134', '0710Z1', '医药生物学', '13', '0');
INSERT INTO `major` VALUES ('135', '030501', '马克思主义基本原理', '15', '0');
INSERT INTO `major` VALUES ('136', '030502', '马克思主义发展史', '15', '0');
INSERT INTO `major` VALUES ('137', '030503', '马克思主义中国化研究', '15', '0');
INSERT INTO `major` VALUES ('138', '030504', '国外马克思主义研究', '15', '0');
INSERT INTO `major` VALUES ('139', '030505', '思想政治教育', '15', '0');
INSERT INTO `major` VALUES ('140', '030506', '中国近现代史基本问题研究', '15', '0');
INSERT INTO `major` VALUES ('141', '010101', '马克思主义哲学', '15', '0');
INSERT INTO `major` VALUES ('142', '010103', '外国哲学', '15', '0');
INSERT INTO `major` VALUES ('143', '010104', '逻辑学', '15', '0');
INSERT INTO `major` VALUES ('144', '010105', '伦理学', '15', '0');
INSERT INTO `major` VALUES ('145', '010107', '宗教学', '15', '0');
INSERT INTO `major` VALUES ('146', '010108', '科学技术哲学', '15', '0');
INSERT INTO `major` VALUES ('147', '040301', '体育人文社会学', '25', '0');
INSERT INTO `major` VALUES ('148', '040302', '运动人体科学', '25', '0');
INSERT INTO `major` VALUES ('149', '040303', '体育教育训练学', '25', '0');
INSERT INTO `major` VALUES ('150', '040304', '民族传统体育学', '25', '0');
INSERT INTO `major` VALUES ('151', '082401', '船舶与海洋结构物设计制造', '3', '0');
INSERT INTO `major` VALUES ('152', '082402', '轮机工程', '3', '0');
INSERT INTO `major` VALUES ('153', '082403', '水声工程', '3', '0');
INSERT INTO `major` VALUES ('154', '082301', '道路与铁道工程', '3', '0');
INSERT INTO `major` VALUES ('155', '082302', '交通信息工程及控制', '3', '0');
INSERT INTO `major` VALUES ('156', '082303', '交通运输规划与管理', '3', '0');
INSERT INTO `major` VALUES ('157', '082304', '载运工具运用工程', '3', '0');
INSERT INTO `major` VALUES ('158', '080101', '一般力学与力学基础', '3', '0');
INSERT INTO `major` VALUES ('159', '080102', '固体力学', '3', '0');
INSERT INTO `major` VALUES ('160', '080103', '流体力学', '3', '0');
INSERT INTO `major` VALUES ('161', '080104', '工程力学', '3', '0');
INSERT INTO `major` VALUES ('162', '081501', '水文学及水资源', '3', '0');
INSERT INTO `major` VALUES ('163', '081502', '水力学及河流动力学', '3', '0');
INSERT INTO `major` VALUES ('164', '081503', '水工结构工程', '3', '0');
INSERT INTO `major` VALUES ('165', '081504', '水利水电工程', '3', '0');
INSERT INTO `major` VALUES ('166', '081505', '港口、海岸及近海工程', '3', '0');
INSERT INTO `major` VALUES ('167', '081401', '岩土工程', '3', '0');
INSERT INTO `major` VALUES ('168', '081402', '结构工程', '3', '0');
INSERT INTO `major` VALUES ('169', '081403', '市政工程', '3', '0');
INSERT INTO `major` VALUES ('170', '081404', '供热、供燃气、通风及空调工程', '3', '0');
INSERT INTO `major` VALUES ('171', '081405', '防灾减灾工程及防护工程', '3', '0');
INSERT INTO `major` VALUES ('172', '081406', '桥梁与隧道工程', '3', '0');
INSERT INTO `major` VALUES ('173', '050201', '英语语言文学', '17', '0');
INSERT INTO `major` VALUES ('174', '050202', '俄语语言文学', '17', '0');
INSERT INTO `major` VALUES ('175', '050203', '法语语言文学', '17', '0');
INSERT INTO `major` VALUES ('176', '050204', '德语语言文学', '17', '0');
INSERT INTO `major` VALUES ('177', '050205', '日语语言文学', '17', '0');
INSERT INTO `major` VALUES ('178', '050206', '印度语言文学', '17', '0');
INSERT INTO `major` VALUES ('179', '050207', '西班牙语语言文学', '17', '0');
INSERT INTO `major` VALUES ('180', '050208', '阿拉伯语语言文学', '17', '0');
INSERT INTO `major` VALUES ('181', '050209', '欧洲语言文学', '17', '0');
INSERT INTO `major` VALUES ('182', '050210', '亚非语言文学', '17', '0');
INSERT INTO `major` VALUES ('183', '050211', '外国语言学及应用语言学', '17', '0');
INSERT INTO `major` VALUES ('184', '050301', '新闻学', '21', '0');
INSERT INTO `major` VALUES ('185', '050302', '传播学', '21', '0');
INSERT INTO `major` VALUES ('186', '010102', '中国哲学', '21', '0');
INSERT INTO `major` VALUES ('187', '010106', '美学', '21', '0');
INSERT INTO `major` VALUES ('188', '130201', '音乐学', '22', '0');
INSERT INTO `major` VALUES ('189', '130202', '舞蹈学', '22', '0');
INSERT INTO `major` VALUES ('190', '081101', '控制理论与控制工程', '7', '0');
INSERT INTO `major` VALUES ('191', '081102', '检测技术与自动化装置', '7', '0');
INSERT INTO `major` VALUES ('192', '081103', '系统工程', '7', '0');
INSERT INTO `major` VALUES ('193', '081104', '模式识别与智能系统', '7', '0');
INSERT INTO `major` VALUES ('194', '081105', '导航、制导与控制', '7', '0');
INSERT INTO `major` VALUES ('195', '0811Z1', '电气与计算机工程', '7', '0');
INSERT INTO `major` VALUES ('196', '071101', '系统理论', '7', '0');
INSERT INTO `major` VALUES ('197', '071102', '系统分析与集成', '7', '0');
INSERT INTO `major` VALUES ('198', '082203', '发酵工程', '11', '0');
INSERT INTO `major` VALUES ('199', '81000', '信息与通信工程', '4', '0');
INSERT INTO `major` VALUES ('200', '81200', '计算机科学与技术 ', '6', '0');
INSERT INTO `major` VALUES ('201', '83000', '环境科学与工程', '9', '0');
INSERT INTO `major` VALUES ('202', '30100', '法学', '23', '0');
INSERT INTO `major` VALUES ('203', '81300', '建筑学', '2', '0');
INSERT INTO `major` VALUES ('204', '83300', '城乡规划学', '2', '0');
INSERT INTO `major` VALUES ('205', '80221', '制造工程智能化检测及仪器', '1', '0');
INSERT INTO `major` VALUES ('206', '0808Z1', '电站系统及控制', '5', '0');
INSERT INTO `major` VALUES ('207', '20208', '统计学', '20', '0');
INSERT INTO `major` VALUES ('208', '81304', '建筑技术科学', '2', '0');
INSERT INTO `major` VALUES ('209', '83220', '食品质量与安全', '11', '0');
INSERT INTO `major` VALUES ('210', '81721', '制药工程', '10', '0');
INSERT INTO `major` VALUES ('211', '82221', '淀粉资源科学与工程', '11', '0');
INSERT INTO `major` VALUES ('212', '120120', '管理决策与系统理论', '16', '0');
INSERT INTO `major` VALUES ('213', '120121', '工业工程与管理工程', '16', '0');
INSERT INTO `major` VALUES ('214', '120122', '金融工程与经济发展', '16', '0');
INSERT INTO `major` VALUES ('215', '120123', '物流工程与管理', '16', '0');
INSERT INTO `major` VALUES ('216', '120125', '物流与供应链管理', '16', '0');
INSERT INTO `major` VALUES ('217', '50402', '音乐学', '22', '0');
INSERT INTO `major` VALUES ('218', '50404', '设计艺术学', '22', '0');
INSERT INTO `major` VALUES ('219', '130500', '设计学', '24', '0');
INSERT INTO `major` VALUES ('220', '120124', '电子商务工程与应用', '16', '0');
INSERT INTO `major` VALUES ('221', '81903', '安全技术及工程', '1', '0');
INSERT INTO `major` VALUES ('222', '81500', '水利工程', '3', '0');
INSERT INTO `major` VALUES ('223', '130200', '音乐与舞蹈学', '22', '0');
INSERT INTO `major` VALUES ('224', '77600', '生物医学工程', '8', '0');
INSERT INTO `major` VALUES ('225', '80100', '力学', '3', '0');
INSERT INTO `major` VALUES ('226', '81020', '数字影视技术', '4', '0');
INSERT INTO `major` VALUES ('227', '81021', '集成电路设计', '4', '0');
INSERT INTO `major` VALUES ('228', '81022', '通信电磁学', '4', '0');
INSERT INTO `major` VALUES ('229', '81720', '能源环境材料及技术', '10', '0');
INSERT INTO `major` VALUES ('230', '81320', '景观建筑学', '2', '0');
INSERT INTO `major` VALUES ('231', '135101', '音乐', '22', '0');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `content` varchar(600) NOT NULL COMMENT '问题内容',
  `ispublic` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否公开，0：私密，1：公开',
  `isread` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已阅读；0：未阅读，1：已阅读',
  `isreplied` tinyint(1) DEFAULT '0' COMMENT '是否已回复；0：未回复，1：已回复',
  `studentid` int(11) DEFAULT NULL COMMENT '外键，选课学生：student',
  `teacherid` int(11) DEFAULT NULL COMMENT '外键，授课教师：teacher',
  `courseid` int(11) DEFAULT NULL COMMENT '外键，所属开设课程：course',
  `cmissionid` int(11) DEFAULT NULL COMMENT '外键，课程任务：cmission',
  PRIMARY KEY (`id`),
  KEY `fk_squestion_student` (`studentid`),
  KEY `fk_squestion_cmission` (`cmissionid`),
  KEY `fk_squestion_teacher` (`teacherid`),
  KEY `fk_message_course` (`courseid`),
  CONSTRAINT `fk_message_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_course` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_student` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_teacher` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `publisherid` int(11) NOT NULL COMMENT '发布人id 外键 关联user.id',
  `name` varchar(20) NOT NULL COMMENT '发布人姓名',
  `title` varchar(200) NOT NULL COMMENT '通知标题',
  `content` varchar(600) DEFAULT NULL COMMENT '通知内容',
  `releasetime` datetime NOT NULL COMMENT '发布时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `filename` varchar(50) NOT NULL COMMENT '附件名称',
  `filepath` varchar(90) DEFAULT NULL COMMENT '附件路径|暂不使用',
  `universityid` int(11) DEFAULT NULL COMMENT '该通知对应的学校',
  `officeid` int(11) DEFAULT NULL COMMENT '该通知对应的职能部门',
  `departmentid` int(11) DEFAULT NULL COMMENT '这个通知对应的学院id',
  `majorid` int(11) DEFAULT NULL COMMENT '与该通知相关的专业',
  `courseid` int(11) DEFAULT NULL COMMENT '该通知相关的课程',
  `isoffice` tinyint(1) DEFAULT '0' COMMENT '是否职能部门人员可见',
  `isacamgr` tinyint(1) DEFAULT '0' COMMENT '是否院级管理人员可见',
  `isteacher` tinyint(1) DEFAULT '0' COMMENT '是否教师可见',
  `isstudent` tinyint(1) DEFAULT '0' COMMENT '是否学生可见',
  PRIMARY KEY (`id`),
  KEY `fk_notice_publisher` (`publisherid`),
  KEY `departmentid` (`departmentid`),
  KEY `universityid` (`universityid`),
  KEY `courseid` (`courseid`),
  KEY `officeid` (`officeid`),
  CONSTRAINT `fk_notice_publisher` FOREIGN KEY (`publisherid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `kf_notice_courseid` FOREIGN KEY (`courseid`) REFERENCES `course` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `kf_notice_departmentid` FOREIGN KEY (`departmentid`) REFERENCES `department` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `kf_notice_officeid` FOREIGN KEY (`officeid`) REFERENCES `office` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `kf_notice_universityid` FOREIGN KEY (`universityid`) REFERENCES `university` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for `office`
-- ----------------------------
DROP TABLE IF EXISTS `office`;
CREATE TABLE `office` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学校职能部门-主键',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of office
-- ----------------------------
INSERT INTO `office` VALUES ('1', '教务处');

-- ----------------------------
-- Table structure for `reply`
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `content` varchar(600) NOT NULL COMMENT '问题内容',
  `ispublic` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否公开，0：私密，1：公开',
  `isread` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已阅读；0：未阅读，1：已阅读',
  `studentid` int(11) DEFAULT NULL COMMENT '外键，选课学生：student',
  `teacherid` int(11) DEFAULT NULL COMMENT '外键，授课教师：teacher',
  `messageid` int(11) NOT NULL COMMENT '外键-所属留言',
  `cmissionid` int(11) DEFAULT NULL COMMENT '外键，课程任务：cmission',
  PRIMARY KEY (`id`),
  KEY `fk_tanswer_cmission` (`cmissionid`),
  KEY `fk_tanswer_student` (`studentid`),
  KEY `fk_tanswer_teacher` (`teacherid`),
  KEY `fk_reply_message` (`messageid`),
  CONSTRAINT `fk_reply_cmission` FOREIGN KEY (`cmissionid`) REFERENCES `cmission` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_message` FOREIGN KEY (`messageid`) REFERENCES `message` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_student` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_teacher` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------

-- ----------------------------
-- Table structure for `sleindex`
-- ----------------------------
DROP TABLE IF EXISTS `sleindex`;
CREATE TABLE `sleindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '二级评价指标代码',
  `name` varchar(150) NOT NULL COMMENT '二级评价指标名称',
  `enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT ' 标记该2级指标是否可用，0：不可用，1：可用，默认为1',
  `isfinal` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可评分项，0：不可评分，1：可评分，默认为：1',
  `fleindexid` int(11) NOT NULL COMMENT '外键，所属一级评价指标：FLEIndex',
  PRIMARY KEY (`id`),
  KEY `fk_sleindex_fleindex` (`fleindexid`),
  CONSTRAINT `fk_sleindex_fleindex` FOREIGN KEY (`fleindexid`) REFERENCES `fleindex` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sleindex
-- ----------------------------
INSERT INTO `sleindex` VALUES ('1', 'CA1', '自然科学基础知识', '1', '1', '14');
INSERT INTO `sleindex` VALUES ('2', 'CA2', '数学方法及工具运用能力', '1', '1', '14');
INSERT INTO `sleindex` VALUES ('3', 'CA3', '客观问题分析与求解能力', '1', '1', '14');
INSERT INTO `sleindex` VALUES ('4', 'CA4', '人文科学知识', '1', '1', '14');
INSERT INTO `sleindex` VALUES ('5', 'CA5', '软件基础理论', '1', '1', '14');
INSERT INTO `sleindex` VALUES ('6', 'CB1', '计算机基础理论', '1', '1', '15');
INSERT INTO `sleindex` VALUES ('7', 'CB2', '软件开发编程能力', '1', '1', '15');
INSERT INTO `sleindex` VALUES ('8', 'CB3', '计算机技术综合运用能力', '1', '1', '15');
INSERT INTO `sleindex` VALUES ('9', 'CC1', '软件项目分析设计能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('10', 'CC2', '软件项目开发能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('11', 'CC3', '软件项目管理能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('12', 'CC4', '软件项目过程控制能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('13', 'CC5', '软件项目测试能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('14', 'CC6', '软件系统集成能力', '1', '1', '16');
INSERT INTO `sleindex` VALUES ('15', 'CD1', '专业领域分向基础知识', '1', '1', '17');
INSERT INTO `sleindex` VALUES ('16', 'CD2', '专业领域分向现状及发展趋势', '1', '1', '17');
INSERT INTO `sleindex` VALUES ('17', 'CD3', '专业领域分向开发能力', '1', '1', '17');
INSERT INTO `sleindex` VALUES ('18', 'CD4', '专业领域分向问题提出与求解', '1', '1', '17');
INSERT INTO `sleindex` VALUES ('19', 'CE1', '实战项目开发能力', '1', '1', '18');
INSERT INTO `sleindex` VALUES ('20', 'CE2', '实战项目过程管理能力', '1', '1', '18');
INSERT INTO `sleindex` VALUES ('21', 'CE3', '实战项目沟通与评价能力', '1', '1', '18');
INSERT INTO `sleindex` VALUES ('22', 'CF1', '软件技术更新跟踪能力', '1', '1', '19');
INSERT INTO `sleindex` VALUES ('23', 'CF2', '具有创新思维和创新能力', '1', '1', '19');
INSERT INTO `sleindex` VALUES ('24', 'CF3', '软件成果展示能力（学术论文和竞赛）', '1', '1', '19');
INSERT INTO `sleindex` VALUES ('25', 'CF4', '自主产品研发与推广能力', '1', '1', '19');
INSERT INTO `sleindex` VALUES ('26', 'CG1', '交流沟通和团队合作能力', '1', '1', '20');
INSERT INTO `sleindex` VALUES ('27', 'CG2', '项目管理能力、具备领袖潜质', '1', '1', '20');
INSERT INTO `sleindex` VALUES ('28', 'CG3', '新软件技术应用和开发能力', '1', '1', '20');
INSERT INTO `sleindex` VALUES ('29', 'CG4', '国际交流与合作能力', '1', '1', '20');
INSERT INTO `sleindex` VALUES ('30', 'CG5', '文档写作能力', '1', '1', '20');
INSERT INTO `sleindex` VALUES ('31', 'CH1', '具有创新性思维和系统性细微的能力', '1', '1', '21');
INSERT INTO `sleindex` VALUES ('32', 'CH2', '具有信息获取、知识更新和终身学习的能力', '1', '1', '21');
INSERT INTO `sleindex` VALUES ('33', 'CH3', '了解软件技术前沿发展趋势', '1', '1', '21');
INSERT INTO `sleindex` VALUES ('34', 'CH4', '熟悉软件领域技术标准，行业相关的政策、法律和法规', '1', '1', '21');
INSERT INTO `sleindex` VALUES ('35', 'CI1', '具备人文素养、社会责任感和职业道德', '1', '1', '22');
INSERT INTO `sleindex` VALUES ('36', 'CI2', '具备安全意识，强调环境保护、生态平衡和可持续发展', '1', '1', '22');
INSERT INTO `sleindex` VALUES ('37', 'CI3', '具有应对软件系统危机与突发事件的基本能力', '1', '1', '22');
INSERT INTO `sleindex` VALUES ('38', 'CC7', '??软件项目??能力（测试添加，书里面没有）', '1', '1', '16');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(20) NOT NULL COMMENT '学生学号',
  `name` varchar(60) NOT NULL COMMENT '学生姓名',
  `grade` varchar(18) NOT NULL COMMENT '学生年级',
  `stuclass` varchar(60) NOT NULL COMMENT '学生班级',
  `majorid` int(11) NOT NULL COMMENT '外键，所属专业：major',
  `sex` varchar(10) NOT NULL DEFAULT '男' COMMENT '性别，默认为男',
  `gdate` date DEFAULT NULL COMMENT '学生毕业日期',
  `level` varchar(20) DEFAULT '本科' COMMENT '层级（如本科，硕士等）',
  PRIMARY KEY (`id`,`code`),
  UNIQUE KEY `index_code_unique` (`code`) USING BTREE,
  KEY `fk_student_major` (`majorid`),
  KEY `id` (`id`),
  CONSTRAINT `fk_student_major` FOREIGN KEY (`majorid`) REFERENCES `major` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157338 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('156174', '201030630087', '陈柏豪', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156175', '201030631893', '汪婉璐', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156176', '201030631510', '马宇锋', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156177', '201030631268', '林燕群', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156178', '201030630797', '李博轩', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156179', '201030632708', '尹茜霞', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156180', '201030633132', '郑天然', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156181', '201030632791', '曾健', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156182', '201030631749', '孙伟然', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156183', '201030633149', '郑文育', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156184', '201030630605', '黄仁达', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156185', '201030630520', '黄东平', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156186', '201030632630', '杨祎帆', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156187', '201030632517', '许志鹏', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156188', '201030633040', '张羊左', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156189', '201030630735', '蒋俊翔', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156190', '201030631305', '刘宏林', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156191', '201030632753', '袁立宪', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156192', '201030633293', '邹梓耀', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156193', '201030631176', '梁为涛', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156194', '201030630179', '陈荣强', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156195', '201030632050', '王翔宇', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156196', '201030633156', '郑兴杰', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156197', '201030632685', '姚健伦', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156198', '201030631794', '唐本泽', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156199', '201030631824', '唐沃源', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156200', '201030632739', '余知昊', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156201', '200830630273', '何瑞康', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156202', '201030633187', '钟逸', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156203', '201030630230', '陈昭辉', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156204', '201030630261', '戴颖毅', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156205', '201030630049', '蔡小翡', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156206', '200830633267', '朱文涛', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156207', '201030633248', '周展坤', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156208', '201030631787', '谭赞君', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156209', '201030632333', '萧名谦', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156210', '201030630131', '陈乐华', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156211', '201030630339', '冯子琪', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156212', '201030631343', '刘如旎', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156213', '201030630278', '单博', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156214', '201030632302', '吴泽森', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156215', '201030630445', '洪泽钦', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156216', '201030632784', '岳时雨', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156217', '201030631541', '穆妮', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156218', '201030630285', '单菲', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156219', '201030632463', '徐光', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156220', '201030630391', '何民宠', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156221', '201030630193', '陈宣亦', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156222', '201030631312', '刘菁', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156223', '201030630469', '胡音文', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156224', '201030630629', '黄伟铎', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156225', '201030632395', '谢文浩', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156226', '201030630773', '冷明强', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156227', '201030632326', '夏泓基', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156228', '201030632654', '杨奕洋', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156229', '201030632845', '张劲峰', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156230', '201030630315', '邓泽航', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156231', '201030632838', '张杰全', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156232', '201030630353', '韩冰', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156233', '201030633019', '张爽', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156234', '201030630438', '何浥尘', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156235', '201030631046', '李厦仕舜', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156236', '201030632340', '萧晓彬', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156237', '201030631183', '梁晓健', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156238', '201030630452', '侯嘉宁', '2010', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156239', '201030633323', '李伟', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156240', '201030633071', '张泽耀', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156241', '201030630155', '陈立豪', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156242', '201030630292', '邓昌隆', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156243', '201030632319', '吴志钦', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156244', '201030632661', '杨永川', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156245', '201030630384', '何陆遥', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156246', '201030630636', '黄武财', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156247', '201030630841', '李弘勋', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156248', '201030630476', '胡宇阳', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156249', '201030632364', '谢凯森', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156250', '201030631015', '李松', '2010', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156251', '201030632203', '吴浩旋', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156252', '201030631817', '唐炜莉', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156253', '201030630667', '黄一浩', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156254', '201030631282', '林志强', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156255', '201030632524', '薛瑀', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156256', '201030631725', '苏章盛', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156257', '201030631329', '刘利强', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156258', '201030631091', '李志鹏', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156259', '201030632012', '王璟星', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156260', '201030631084', '李志南', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156261', '201030631336', '刘敏', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156262', '201030632692', '尹超', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156263', '201030632418', '谢逸凡', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156264', '201030630650', '黄信尧', '2010', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156265', '201030632456', '邢隽缤', '2010', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156266', '201030631565', '宁日欣', '2010', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156267', '201030632449', '谢卓航', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156268', '201030632210', '吴华亮', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156269', '201030631367', '刘威', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156270', '201030632135', '魏星宇', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156271', '201030632609', '杨伟宏', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156272', '201030632494', '许海忠', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156273', '201030631732', '孙蓉蓉', '2010', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156274', '201030632067', '王鑫', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156275', '201030632258', '吴敏', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156276', '201030630834', '李浩源', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156277', '201030632173', '翁智腾', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156278', '201030630186', '陈舒瑶', '2010', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156279', '201030633224', '周希骏', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156280', '200930635116', '蔡创佳', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156281', '200930632313', '肖勇', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156282', '200930631125', '许兆博', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156283', '200830630068', '陈炯', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156284', '200830634127', '李金桥', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156285', '200830634325', '罗刚', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156286', '201030633255', '周展鹏', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156287', '201030630582', '黄宁', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156288', '201030630032', '蔡锐涛', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156289', '201030632890', '张山', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156290', '201030633217', '周唯伟', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156291', '201030631350', '刘汝甜', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156292', '201030630889', '李雳', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156293', '201030632814', '曾昭婷', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156294', '201030633262', '朱鹏', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156295', '201030630872', '李凯', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156296', '201030631473', '罗嘉浚', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156297', '201030631848', '陶超前', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156298', '201030630063', '常永耘', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156299', '201030631572', '潘恬怡', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156300', '201030631053', '李旭冉', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156301', '201030633170', '钟学强', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156302', '201030630018', '柏杨', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156303', '201030633194', '周高昌', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156304', '201030633033', '张伟豪', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156305', '201030630896', '李明东', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156306', '201030631855', '陶升奇', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156307', '201030630674', '黄一君', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156308', '201030631169', '梁澍', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156309', '201030631428', '卢剑锋', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156310', '201030631770', '谭宇飞', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156311', '201030631718', '苏恺淇', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156312', '201030633026', '张顺', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156313', '201030632807', '曾越凡', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156314', '201030631831', '唐智炜', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156315', '201030630070', '车鹏云', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156316', '201030630865', '李靖楠', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156317', '201030630025', '蔡礼权', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156318', '201030631763', '谭德昆', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156319', '201030631299', '刘冠圣', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156320', '201030630254', '程凯', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156321', '201030633118', '郑立柯', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156322', '201030632562', '杨金沣', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156323', '201030633279', '庄灿杰', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156324', '201030630247', '陈哲', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156325', '201030633163', '郑子木', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156326', '201030630100', '陈垂耿', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156327', '201030630599', '黄沛聪', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156328', '201030630322', '冯敏丽', '2010', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156329', '201030633101', '郑凯匀', '2010', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156330', '201030631138', '梁恩浩', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156331', '201030632647', '杨易', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156332', '201030630780', '李拔飞', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156333', '201030631633', '饶峰', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156334', '201030631589', '庞博', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156335', '201030632579', '杨俊江', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156336', '201030632722', '余丽雅', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156337', '201030631558', '聂四品', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156338', '201030631657', '沈建祥', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156339', '201030631534', '牟帅', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156340', '201030632678', '姚浩荣', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156341', '201030630223', '陈远龙', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156342', '201030631077', '李昭玥', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156343', '201030631497', '马楚海', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156344', '201030630360', '韩兵兵', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156345', '201030631886', '涂雅媞', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156346', '201030632487', '徐永咏', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156347', '201030630407', '何清', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156348', '201030632876', '张启华', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156349', '201030630544', '黄华超', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156350', '201030631480', '罗伟', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156351', '201030630537', '黄海韵', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156352', '201030631503', '马棉凯', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156353', '201030632593', '杨涛', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156354', '201030631220', '林成果', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156355', '201030630681', '黄奕霖', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156356', '201030630810', '李聃', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156357', '201030630216', '陈奕燊', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156358', '201030631206', '廖永行', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156359', '201030630148', '陈磊光', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156360', '200930635017', '丁亮宇', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156361', '201030632586', '杨琦琦', '2010', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156362', '201030633125', '郑鹏', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156363', '201030630551', '黄健彬', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156364', '201030630506', '黄达彬', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156365', '201030632159', '文力', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156366', '201030630117', '陈迪豪', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156367', '201030632821', '张国庆', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156368', '201030632081', '王永杰', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156369', '201030632616', '杨彦鑫', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156370', '201030633095', '郑灿标', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156371', '201030633088', '张柱安', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156372', '201030630346', '付志能', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156373', '201030632265', '吴铭荃', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156374', '201030630575', '黄凯波', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156375', '201030632234', '吴健松', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156376', '201030633057', '张宇乾', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156377', '201030632142', '温文希', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156378', '201030632425', '谢悦鸿', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156379', '201030630209', '陈奕男', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156380', '201030632401', '谢晓超', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156381', '201030633064', '张云帆', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156382', '201030630568', '黄俊坤', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156383', '201030632111', '王臻', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156384', '201030632388', '谢盼', '2010', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156385', '201030632104', '王泽林', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156386', '201030630308', '邓超', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156387', '201030632296', '吴永健', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156388', '201030630421', '何武勋', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156389', '201030631121', '梁楚华', '2010', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156390', '201030630827', '李翰林', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156391', '201030632432', '谢泽勇', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156392', '201030630858', '李宏飞', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156393', '201030632128', '王振强', '2010', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156394', '201030630162', '陈骞', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156395', '201030631114', '利广杰', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156396', '201069992279', 'chui chiang vitor', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156397', '201030631022', '李伟', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156398', '201030630759', '揭勍', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156399', '201030633200', '周宏宇', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156400', '201030631404', '龙鹏飞', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156401', '201030631442', '路程', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156402', '201030630711', '黄卓健', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156403', '201030633231', '周泽栩', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156404', '201030632883', '张三华', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156405', '201030630742', '焦晴阳', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156406', '201030631275', '林泽腾', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156407', '201030631398', '刘子星', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156408', '201030632500', '许威', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156409', '201030631190', '梁振宇', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156410', '201030630704', '黄智广', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156411', '201030631466', '罗辑', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156412', '201030631411', '卢宝龙', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156413', '201030631039', '李文文', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156414', '201030632241', '吴金炮', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156415', '201030632289', '吴锡霖', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156416', '201030630490', '胡月', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156417', '201030632166', '翁海琴', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156418', '201030630094', '陈波祺', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156419', '201030632906', '张双燕', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156420', '201030632760', '袁阳', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156421', '201030631756', '覃嘉敏', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156422', '201030631152', '梁国超', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156423', '201030630414', '何伟滔', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156424', '201030630643', '黄鑫龙', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156425', '201030631435', '陆海杰', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156426', '201030630766', '孔令南', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156427', '201030632470', '徐威迪', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156428', '201030631879', '田立慧', '2010', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156429', '201030632227', '吴佳祥', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156430', '201030630698', '黄振华', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156431', '201030631459', '吕俊毅', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156432', '201030632548', '杨波尼', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156433', '201030631800', '唐纳文', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156434', '201030632357', '萧远秀', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156435', '201030631688', '双嘉岐', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156436', '201030630728', '霍志权', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156437', '201030631145', '梁桂著', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156438', '201030632272', '吴荣鑫', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156439', '201030632555', '杨辉', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156440', '201030632043', '王希', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156441', '200930636342', '孟俊宇', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156442', '200930632283', '徐一川', '2010', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156443', '201030632036', '王文杰', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156444', '201030631909', '王传鹏', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156445', '201030631701', '苏汉霖', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156446', '201030631619', '邱旭东', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156447', '201030631596', '彭章', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156448', '201030632777', '袁永匡', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156449', '201030631381', '刘宇', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156450', '201030632715', '余锦德', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156451', '201030631237', '林浩楠', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156452', '201030631213', '林斌', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156453', '201030631527', '牟波', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156454', '201030631244', '林世杭', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156455', '201030631671', '史焕强', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156456', '201030631664', '石锐', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156457', '201030631640', '邵冠云', '2010', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156458', '201130631038', '顾润丰', '2011', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156459', '201130634381', '谢伟锋', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156460', '201130630369', '陈梓豪', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156461', '201130631441', '姜宝杰', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156462', '201130631083', '韩建桥', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156463', '201130634169', '王智强', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156464', '201136631391', '黄译萱', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156465', '201130632110', '李家健', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156466', '201130631298', '胡舒悦', '2011', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156467', '201130633407', '邱先科', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156468', '201130630321', '陈志誉', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156469', '201130630116', '陈丹旎', '2011', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156470', '201130633148', '卢杨威', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156471', '201130634282', '吴苏智', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156472', '201130635364', '周建衡', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156473', '201130631380', '黄涛', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156474', '201130633421', '史斌心', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156475', '201130630239', '陈诗云', '2011', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156476', '201130634251', '吴方杰', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156477', '201130633131', '龙泉', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156478', '201130634213', '翁耿森', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156479', '201130635289', '郑俊伟', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156480', '201130635159', '张浩扬', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156481', '201130633483', '苏裕贤', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156482', '201130631182', '何玉宇', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156483', '201130630260', '陈雄', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156484', '201130635463', '冼业强', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156485', '201130630048', '蔡文强', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156486', '201130633230', '马浩斌', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156487', '201130635326', '钟帝送', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156488', '201130632264', '李奕森', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156489', '201130631045', '关帝超', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156490', '201130632288', '梁海伦', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156491', '201130631113', '何俊朗', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156492', '201130631458', '江先毅', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156493', '201130632301', '梁文华', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156494', '201130631496', '赖金明', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156495', '201130630413', '邓高翔', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156496', '201130633360', '乔健', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156497', '201130631304', '胡友成', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156498', '201130631465', '江小洁', '2011', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156499', '201130633261', '马松添', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156500', '201130634367', '肖凡杰', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156501', '201130631274', '胡东风', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156502', '201130633124', '刘子豪', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156503', '201130632028', '黎灿', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156504', '201130633193', '罗佳妮', '2011', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156505', '201130633087', '刘迅源', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156506', '201130632189', '李炎', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156507', '201130633278', '麦海潮', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156508', '201130630420', '邓坤力', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156509', '201130635098', '曾荣基', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156510', '201130634398', '谢晓佳', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156511', '201130634237', '吴炳伸', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156512', '201130630161', '陈航', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156513', '201130634336', '夏磊', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156514', '201130634084', '王海彬', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156515', '201130634060', '田卓俊', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156516', '201130633476', '苏莹子', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156517', '201130631427', '纪嘉祥', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156518', '201130630017', '毕俊彦', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156519', '201130630277', '陈雅琳', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156520', '201130633346', '彭成墙', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156521', '201130634015', '谭柏康', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156522', '201130632271', '梁海滨', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156523', '201130632356', '廖仲鑫', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156524', '201130634428', '徐维业', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156525', '201130632325', '廖飞', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156526', '201130632080', '李成凤', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156527', '201136633104', '刘泳安', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156528', '201130635494', '栾昊原', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156529', '201130631281', '胡梦非', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156530', '201130635036', '叶喜', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156531', '201130630192', '陈俊生', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156532', '201130630086', '巢启聪', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156533', '201130631090', '韩蕊', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156534', '201130632424', '林若谷', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156535', '201130635319', '郑鑫', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156536', '201130632127', '李可夫', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156537', '201130630079', '曹梓宏', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156538', '201130633162', '陆荣扬', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156539', '201130635388', '周泉', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156540', '201130632462', '林正平', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156541', '201130630253', '陈晓颖', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156542', '201130631052', '郭聪颖', '2011', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156543', '201130635128', '张弛', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156544', '201130635449', '朱未翔', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156545', '201130634275', '吴孟灿', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156546', '201130634350', '萧伟杰', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156547', '201130632318', '梁淼荣', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156548', '201130634459', '许文艺', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156549', '201030632623', '杨洋', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156550', '201030630377', '何杰', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156551', '201130630406', '邓德荣', '2011', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156552', '201130633049', '刘钧鸿', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156553', '201130630062', '曹丽杰', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156554', '201130632035', '黎矿维', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156555', '201130635500', '覃宇韬', '2011', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156556', '201130630437', '邓荣欣', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156557', '201130630383', '程家颖', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156558', '201130635432', '朱丽叶', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156559', '201130633384', '邱丹耀', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156560', '201130631076', '郭泽豪', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156561', '201130633025', '刘光忠', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156562', '201130635470', '闫仕伟', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156563', '201136632091', '李迪勤', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156564', '201130630390', '戴瑾如', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156565', '201130635234', '张钊', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156566', '201130631175', '何一鸣', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156567', '201136630103', '陈碧荷', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156568', '201136630288', '陈永鸿', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156569', '201136633036', '刘嘉伟', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156570', '201130635395', '周顺风', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156571', '201130632066', '李炳权', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156572', '201130631335', '黄海东', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156573', '201130631212', '何志远', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156574', '201130631168', '何欣燕', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156575', '201130633063', '刘立华', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156576', '201130632011', '雷宇晴', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156577', '201130631106', '何斌', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156578', '201130631328', '黄国锴', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156579', '201130631236', '贺理文', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156580', '201130635456', '邹子杰', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156581', '201130630246', '陈韦辰', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156582', '201130634091', '王嘉豪', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156583', '201130631120', '何俊威', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156584', '201130631403', '黄永生', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156585', '201130630222', '陈勉荣', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156586', '201130631151', '何伟鹏', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156587', '201130633322', '欧阳佳宾', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156588', '201130631366', '黄凯芬', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156589', '201130632332', '廖辉', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156590', '201130631229', '何子民', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156591', '201130632295', '梁莫柱', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156592', '201130630499', '高世华', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156593', '201130635180', '张莉', '2011', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156594', '201130630130', '陈贵明', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156595', '201130632073', '李灿光', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156596', '201130631267', '洪图', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156597', '201130632387', '林戈', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156598', '201130630147', '陈国宇', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156599', '201130633292', '莫茂杰', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156600', '201130635401', '周文彬', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156601', '201130632479', '林怡', '2011', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156602', '201130632417', '林锐强', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156603', '201130633117', '刘志寰', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156604', '201130633391', '邱俊凯', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156605', '201130630208', '陈俊挺', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156606', '201130633216', '罗伟昂', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156607', '201130633438', '史佳伟', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156608', '201130631014', '龚耀庭', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156609', '201130630123', '陈戈', '2011', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156610', '201130634343', '夏艳明', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156611', '201130635197', '张朔', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156612', '201130635067', '余志浩', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156613', '201130634503', '杨臻', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156614', '201130631410', '黄赟', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156615', '201130630338', '陈竹天', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156616', '201130633186', '罗国辉', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156617', '201130633018', '凌霄', '2011', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156618', '201130634220', '吴彬', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156619', '201130632103', '李国宝', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156620', '201130632165', '李熙龙', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156621', '201130632059', '李宝玲', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156622', '201130634299', '吴伟锋', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156623', '201130634374', '谢敏珊', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156624', '201130630031', '蔡俊彬', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156625', '201130630093', '车德邻', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156626', '201130635241', '招振荣', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156627', '201130631137', '何俊昊', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156628', '201130634206', '温文聪', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156629', '201130634046', '汤煜朗', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156630', '201130632448', '林宇航', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156631', '201130635227', '张睿', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156632', '201130634077', '王德勤', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156633', '201130634176', '王忠立', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156634', '201130634312', '吴益文', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156635', '201130632219', '李育乘', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156636', '201130632349', '廖文辉', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156637', '201130631250', '洪浩贤', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156638', '201130635418', '周叙凯', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156639', '201030632531', '杨波', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156640', '201030632029', '王瑞明', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156641', '201130635296', '郑文结', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156642', '201130635043', '于晓飞', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156643', '201130632226', '李悦', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156644', '201130631359', '黄佳祥', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156645', '201130632172', '李想', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156646', '201130634497', '杨伟均', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156647', '201130631502', '雷国丽', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156648', '201130631472', '蒋慧强', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156649', '201130633469', '苏俊屹', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156650', '201130635104', '曾晓东', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156651', '201130634442', '许瑞霖', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156652', '201136635429', '朱海旭', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156653', '201130630444', '丁东辉', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156654', '201136632152', '李天伦', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156655', '201136633074', '刘思源', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156656', '201130635135', '张广磊', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156657', '201130632141', '李仁鸿', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156658', '201130632363', '林标标', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156659', '201130635111', '詹昊恂', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156660', '201130634039', '汤雪', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156661', '201130635210', '张懿云', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156662', '201130634404', '谢郑逸', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156663', '201130633179', '吕亮', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156664', '201130631342', '黄嘉慧', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156665', '201130631205', '何志澎', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156666', '201130635050', '于盈威', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156667', '201130630352', '陈琪杰', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156668', '201130632394', '林辉滨', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156669', '201130631311', '黄东雄', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156670', '201130634114', '王齐轩', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156671', '201130633506', '孙正扬', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156672', '201130630055', '蔡耀冠', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156673', '201130631489', '金能令', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156674', '201130635340', '钟霄楠', '2011', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156675', '201130634152', '王泽强', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156676', '201130630178', '陈键', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156677', '201130632233', '李哲操', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156678', '201130635333', '钟浩', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156679', '201130633452', '宋永潘', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156680', '201130631144', '何锐奇', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156681', '201130635029', '杨灏', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156682', '201130630314', '陈志文', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156683', '201130630505', '龚名威', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156684', '201030631602', '普尘', '2011', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156685', '200930631071', '冯龙飞', '2011', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156686', '201030631862', '田东峰', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156687', '201030633286', '邹永传', '2011', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156688', '201130632042', '黎思聪', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156689', '201130635265', '甄淑仪', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156690', '201130632134', '李青山', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156691', '201169105111', '文锦珠', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156692', '201130633377', '秦赛赛', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156693', '201130634268', '吴桂城', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156694', '201130631373', '黄鹏', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156695', '201130560109', '丁鹏', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156696', '201130635166', '张俊茂', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156697', '201130634466', '严炜', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156698', '201130635272', '郑娇龙', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156699', '201130633223', '罗文兴', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156700', '201136634323', '夏嘉雯', '2011', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156701', '201130635081', '袁志江', '2011', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156702', '201130635074', '袁天宇', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156703', '201130633285', '麦斯玲', '2011', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156704', '201130633339', '潘杉', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156705', '201130633254', '马帅', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156706', '201130631243', '贺智超', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156707', '201130630291', '陈泽民', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156708', '201130634411', '熊智航', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156709', '201130635487', '闫亚同', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156710', '201130630482', '付雅晴', '2011', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156711', '201136634125', '王腾云', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156712', '201136635375', '周靖凯', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156713', '201130634022', '谭永健', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156714', '201130635173', '张凯华', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156715', '201130630475', '冯振飞', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156716', '201130633209', '罗启盛', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156717', '201130635012', '杨志鹏', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156718', '201130633308', '倪泽彬', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156719', '201130632493', '林梓越', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156720', '201130631069', '郭贵鑫', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156721', '201130633247', '马嘉霖', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156722', '201130632202', '李英晗', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156723', '201136632244', '李祖立', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156724', '201130635203', '张智东', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156725', '201130635302', '郑梓聪', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156726', '201130634435', '许昌建', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156727', '201130630154', '陈海齐', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156728', '201130634473', '杨金堂', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156729', '201130630307', '陈震鸿', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156730', '201130634107', '王佩', '2011', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156731', '201130632431', '林伟良', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156732', '201130633353', '彭飞', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156733', '201130630468', '方春林', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156734', '201130634480', '杨楷', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156735', '201130633315', '欧建荣', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156736', '201130632509', '林钊生', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156737', '201130632455', '林悦邦', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156738', '201130630345', '陈卓', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156739', '201130632400', '林绵程', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156740', '201130630024', '蔡东荣', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156741', '201130635142', '张广怡', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156742', '201130632257', '李作明', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156743', '201130634183', '王子元', '2011', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156744', '201130635258', '甄江杰', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156745', '201130630451', '范保林', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156746', '201130632370', '林丹丹', '2011', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156747', '201130633414', '石尧', '2011', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156748', '201230673280', '韦良宁', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156749', '201230673327', '翁僖骏', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156750', '201236674021', '杨城', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156751', '201236672287', '陆玎莹', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156752', '201237675096', '朱健聪', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156753', '201236671341', '劳铭枫', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156754', '201236671037', '郭正都', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156755', '201230672078', '梁智豪', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156756', '201230671323', '赖雍杰', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156757', '201230672351', '罗泽轩', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156758', '201230673051', '苏桐', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156759', '201230670487', '管健铭', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156760', '201230670111', '陈曼平', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156761', '201230670326', '邓嘉琪', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156762', '201230670265', '陈镇新', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156763', '201230671309', '孔少华', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156764', '201230674010', '阎佳', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156765', '201230672108', '林军', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156766', '201230674317', '张杰晖', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156767', '201230673143', '汪树文', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156768', '201230673457', '邢维帝', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156769', '201230672030', '李雨龙', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156770', '201230671200', '华航', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156771', '201230671101', '何子杰', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156772', '201230672467', '秦闻达', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156773', '201230670371', '丁同舟', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156774', '201230670159', '陈荣钊', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156775', '201230672399', '莫立恒', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156776', '201230673372', '吴子恒', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156777', '201230670241', '陈育彬', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156778', '201230674348', '张明龙', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156779', '201230671439', '李洁', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156780', '201230673075', '隋佳欣', '2012', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156781', '201230672207', '刘方青', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156782', '201230680189', '夏晗深', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156783', '201230670302', '程遥', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156784', '201230674058', '杨骏宇', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156785', '201230680158', '刘翊宸', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156786', '201230673136', '涂友军', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156787', '201230674355', '张明晗', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156788', '201230674201', '袁星', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156789', '201230680059', '黄树茂', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156790', '201230671293', '黄丕臻', '2012', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156791', '201230670470', '关鑫裕', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156792', '201230673105', '谭帅', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156793', '201230670180', '陈文花', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156794', '201230673259', '王绮媛', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156795', '201230674218', '袁雄峰', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156796', '201230674195', '袁嘉樑', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156797', '201230670173', '陈伟亮', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156798', '201230672276', '卢启棠', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156799', '201230671163', '胡鹏辉', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156800', '201230671125', '侯书航', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156801', '201230672320', '罗俊鹏', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156802', '201230673099', '谭铭晖', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156803', '201230674461', '郑泽丹', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156804', '201230673334', '巫斌', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156805', '201230670029', '蔡家勋', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156806', '201230670104', '陈俊建', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156807', '201230672177', '林焯俊', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156808', '201230670135', '陈琼雯', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156809', '201230673068', '苏奕嘉', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156810', '201230672061', '李钟浩', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156811', '201230674324', '张凯', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156812', '201230672139', '林群堡', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156813', '201230672344', '罗斯尹', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156814', '201230672375', '马啸', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156815', '201230672184', '林钊', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156816', '201230673303', '魏日龙', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156817', '201230671095', '何文杰', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156818', '201230670388', '杜亚超', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156819', '201230673273', '韦迪程', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156820', '201230673464', '修治平', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156821', '201230670166', '陈童', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156822', '201230675024', '周科汀', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156823', '201230673426', '谢明鹏', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156824', '201230674164', '余田', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156825', '201230675147', '邹龙坤', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156826', '201230673198', '王将兴', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156827', '201230671460', '李绍华', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156828', '201230671156', '胡命慧', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156829', '201230672498', '桑泽西', '2012', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156830', '201130634053', '唐谦', '2012', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156831', '201230672023', '李永锋', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156832', '201230670074', '陈楚昭', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156833', '201230672054', '李志毅', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156834', '201230670425', '冯伟俊', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156835', '201230674430', '郑鸿昇', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156836', '201230672269', '龙钏', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156837', '201230670234', '陈玉龙', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156838', '201230673365', '吴兆峰', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156839', '201230671088', '何文锋', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156840', '201230670098', '陈君锐', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156841', '201230671248', '黄德麟', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156842', '201230670197', '陈延桐', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156843', '201230672504', '沈加运', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156844', '201230670296', '陈奕楷', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156845', '201230672085', '林堉楠', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156846', '201230670081', '陈锦辉', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156847', '201230670210', '陈颖', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156848', '201230674096', '杨茵荫', '2012', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156849', '201230673488', '许汉彬', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156850', '201230670128', '陈铭铮', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156851', '201230670012', '蔡东旭', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156852', '201230671279', '黄思民', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156853', '201230672429', '庞赵龙', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156854', '201230672122', '林钦宝', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156855', '201230674225', '曾坤鹏', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156856', '201230671255', '黄河', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156857', '201230673341', '吴华雄', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156858', '201230673204', '王杰', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156859', '201230672306', '吕雅雯', '2012', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156860', '201230674300', '张杰', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156861', '201230675062', '周增羽', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156862', '201230671132', '胡成豪', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156863', '201230672191', '刘丁铭', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156864', '201230675161', '邹姣', '2012', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156865', '201230674126', '叶丽衡', '2012', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156866', '201230790321', '吴亚辉', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156867', '201230673235', '王艺杰', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156868', '201230671187', '胡越项', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156869', '201230670401', '范旭', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156870', '201230810272', '汪宇', '2012', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156871', '201230674294', '张佳旭', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156872', '201230672481', '屈天浩', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156873', '201230672252', '龙逊敏', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156874', '201230671316', '赖瑶瑶', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156875', '201230673297', '韦文嵚', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156876', '201230672238', '刘之辉', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156877', '201230673266', '王昕远', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156878', '201230670449', '傅俊彬', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156879', '201230674362', '张宁', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156880', '201230674034', '杨海志', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156881', '201230674508', '钟益权', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156882', '201230673044', '苏圣凯', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156883', '201230674119', '姚佳伟', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156884', '201230671170', '胡双星', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156885', '201230674249', '曾兴', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156886', '201230670333', '邓佳鸣', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156887', '201230673471', '徐露', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156888', '201230680271', '朱晓江', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156889', '201230670463', '龚翔', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156890', '201230674171', '余钊锴', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156891', '201230672047', '李植梓', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156892', '201230674232', '曾庆淼', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156893', '201230670340', '邓伟超', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156894', '201230670456', '甘文彬', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156895', '201230674140', '殷宇周', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156896', '201230672443', '彭诗', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156897', '201230671354', '劳智锟', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156898', '201230673419', '肖毅钊', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156899', '201230673013', '沈桐', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156900', '201230673242', '王永华', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156901', '201230680196', '谢威', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156902', '201230675086', '朱承荣', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156903', '201230671057', '韩笑', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156904', '201230672313', '吕雯楚', '2012', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156905', '201230672146', '林袖伦', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156906', '201230674478', '郑栩燊', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156907', '201230670258', '陈泽锋', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156908', '201230672368', '马凯', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156909', '201230674454', '郑一锐', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156910', '201230673402', '肖建恩', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156911', '201230673358', '吴泽彬', '2012', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156912', '201230671149', '胡杰彬', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156913', '201230670432', '奉慕海', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156914', '201230671408', '李朝晖', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156915', '201230674379', '张亚卓', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156916', '201230674393', '赵劲松', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156917', '201230671064', '郝一休', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156918', '201230674133', '易振', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156919', '201236675059', '周彦', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156920', '201230671453', '李俊泽', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156921', '201236674380', '张逸韬', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156922', '201230675154', '邹哲鹏', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156923', '201230671378', '李焙坚', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156924', '201230671446', '李俊康', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156925', '201230672337', '罗侨友', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156926', '201230673396', '肖凡', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156927', '201230674485', '钟沃文', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156928', '201230674447', '郑威狄', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156929', '201230671019', '郭力克', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156930', '201230674423', '郑东佳', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156931', '201230673440', '谢永盛', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156932', '201230675109', '朱振鹏', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156933', '201230673129', '童昌泰', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156934', '201230670418', '方冬晖', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156935', '201230671415', '李聪', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156936', '201230670364', '翟泽南', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156937', '201230673501', '许雄龙', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156938', '201230672214', '刘奇鹏', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156939', '201230671286', '黄伟鑫', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156940', '201230675079', '周滋楷', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156941', '201230673495', '许杰涛', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156942', '201230670036', '蔡进坤', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156943', '201230674492', '钟小梅', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156944', '201230671422', '李关梅', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156945', '201230674270', '张晨', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156946', '201230671118', '洪屿', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156947', '201230673228', '王苏飞', '2012', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156948', '201230670227', '陈宇', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156949', '201230670067', '曹宇栋', '2012', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156950', '201230673211', '王蕊', '2012', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156951', '201230671194', '胡玮昱', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156952', '201230671262', '黄华庚', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156953', '201230671231', '黄超洋', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156954', '201230674102', '杨颖文', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156955', '201230671071', '何俊鹏', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156956', '201230675017', '钟尹琳', '2012', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156957', '201230674416', '赵英博', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156958', '201230671361', '黎春朝', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156959', '201230672290', '吕超庆', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156960', '201230671491', '李晓刚', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156961', '201230674089', '杨扬', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156962', '201230674157', '尹太兵', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156963', '201230674287', '张鹤', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156964', '201230670395', '樊佳琦', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156965', '201230670043', '蔡敏敏', '2012', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156966', '201230672153', '林宇鹏', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156967', '201230671507', '李小龙', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156968', '201230671484', '李文彬', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156969', '201230673433', '谢维', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156970', '201230671392', '李冰', '2012', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156971', '201230672245', '龙泉', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156972', '201230670319', '邓洪宇', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156973', '201230672092', '林桂鸿', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156974', '201230670357', '邓玉健', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156975', '201230670272', '陈志东', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156976', '201230672160', '林振翔', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156977', '201230672221', '刘象星', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156978', '201230672412', '宁海清', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156979', '201230672405', '慕军隆', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156980', '201230673112', '唐铭舜', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156981', '201230674263', '章浩', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156982', '201230675116', '朱紫洁', '2012', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156983', '201230675048', '周文童', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156984', '201230671330', '兰阳', '2012', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156985', '201230673389', '萧永乐', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156986', '201230670050', '曹峻许', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156987', '201236673314', '文雨轩', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156988', '201236680121', '刘绍能', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156989', '201236680084', '黄倩颖', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156990', '201230674331', '张蒙蒙', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('156991', '201230674072', '杨轩', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156992', '201236674403', '赵文哲', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156993', '201236674045', '杨建辉', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156994', '201230671040', '国雍', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156995', '201230672016', '李印真', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156996', '201230673082', '孙阔', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156997', '201230673150', '王晨光', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156998', '201230674065', '杨天雄', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('156999', '201230671217', '华健', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157000', '201230673020', '史嘉帅', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157001', '201230673181', '王健宇', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157002', '201230680165', '陆晓丹', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157003', '201230680202', '徐树乔', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157004', '201230680134', '刘晔嘉', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157005', '201230680219', '张驰', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157006', '201230680035', '傅琚柏', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157007', '201230680073', '黄泽宇', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157008', '201230672382', '马哲家昱', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157009', '201230674256', '湛伟健', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157010', '201230680110', '林城源', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157011', '201230680042', '侯福先', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157012', '201230680011', '陈汉龙', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157013', '201230680028', '邓泳笙', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157014', '201230680066', '黄伟燃', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157015', '201230680172', '吴杰楚', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157016', '201230670494', '桂旭宇', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157017', '201230800327', '王逊', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157018', '201230670142', '陈仁洁', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157019', '201230680240', '郑灶旭', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157020', '201230680097', '李培杰', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157021', '201230680257', '钟晓玲', '2012', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157022', '201230680233', '张毅', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157023', '201230680141', '刘钊锋', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157024', '201230680103', '李树良', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157025', '201230680226', '张宁', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157026', '201230680264', '周子程', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157027', '201236670504', '郭俊嘉', '2012', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157028', '201330612219', '刘睿', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157029', '201330614046', '谢宜洛', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157030', '201330612394', '邱伟健', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157031', '201330615050', '张琪琦', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157032', '201330610413', '傅莘', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157033', '201330614107', '许金键', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157034', '201330610130', '陈梦川', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157035', '201330610338', '邓兆鹏', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157036', '201330614060', '谢永雄', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157037', '201330614121', '薛德钊', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157038', '201330611397', '李清宇', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157039', '201330613322', '温爱卿', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157040', '201330610093', '陈佳德', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157041', '201330613070', '唐小丽', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157042', '201330611427', '李文基', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157043', '201330613346', '翁灿标', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157044', '201336615184', '朱文俊', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157045', '201330611502', '李尊聪', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157046', '201330612042', '梁振中', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157047', '201330612080', '列镇荣', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157048', '201330612103', '林达浩', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157049', '201330612158', '林芊芊', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157050', '201330612141', '林威航', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157051', '201330612165', '刘璟', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157052', '201330612349', '潘冠昌', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157053', '201330612370', '潘兴焕', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157054', '201330612387', '秦瑞潮', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157055', '201330613292', '王煜飞', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157056', '201330613384', '吴炯', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157057', '201330610178', '陈文发', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157058', '201330611212', '黄泽钦', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157059', '201330611335', '黎晓键', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157060', '201330612356', '潘伟强', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157061', '201330611021', '郭亦楠', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157062', '201330610239', '陈妍淳', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157063', '201330614367', '袁婉珊', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157064', '201330614336', '余洋', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157065', '201336614477', '张梦茜', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157066', '201336613265', '王子杰', '2013', '6', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157067', '201330613391', '吴树杰', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157068', '201330613421', '吴志域', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157069', '201330614404', '詹金钊', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157070', '201330611274', '纪程远', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157071', '201330613483', '肖文浩', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157072', '201330615067', '赵孝智', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157073', '201330612363', '潘先杰', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157074', '201330611250', '黄奕君', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157075', '201330612295', '马熙钧', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157076', '201330614169', '杨超', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157077', '201330614411', '詹凯', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157078', '201330613353', '翁东涛', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157079', '201330612172', '刘良华', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157080', '201330610314', '戴亨祝', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157081', '201330614398', '曾仕元', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157082', '201330613117', '王德超', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157083', '201330614435', '张恒铭', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157084', '201330614459', '张镜忠', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157085', '201330615029', '张志峰', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157086', '201330615081', '郑嘉', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157087', '201330615210', '庄卓鑫', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157088', '201330611137', '黄宏伟', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157089', '201330611168', '黄宁源', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157090', '201330611236', '黄志龙', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157091', '201330612011', '李铖', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157092', '201330611380', '李俊锋', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157093', '201330611243', '黄毓盛', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157094', '201330614497', '张伟', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157095', '201330614381', '曾九添', '2013', '6', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157096', '201330614282', '叶增广', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157097', '201336615153', '周子健', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157098', '201369990517', 'NTOLO MPUTU GIRESSE', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157099', '201330612134', '林顺涛', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157100', '201330613490', '肖欣', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157101', '201330611090', '洪少佳', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157102', '201330610215', '陈泽伶', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157103', '201330611175', '黄旺', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157104', '201330613193', '王帅', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157105', '201330612196', '刘瑶', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157106', '201330612462', '宋定坤', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157107', '201330612486', '宋秋原', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157108', '201330613025', '苏家荣', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157109', '201330613032', '苏景强', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157110', '201330613124', '王尔丞', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157111', '201330613148', '王宏法', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157112', '201330613223', '王亚楠', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157113', '201330610192', '陈旋', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157114', '201330614039', '谢雅博', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157115', '201330615098', '郑杰辰', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157116', '201330615104', '郑逸涵', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157117', '201330615227', '邹江南', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157118', '201330611472', '李忠成', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157119', '201330612066', '梁昊雨', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157120', '201330613018', '苏航', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157121', '201330613278', '王玺', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157122', '201330612271', '罗妙音', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157123', '201330613315', '魏育恒', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157124', '201330612479', '宋立奋', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157125', '201330613049', '孙浩斌', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157126', '201330610437', '甘镇伟', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157127', '201330610468', '高桢', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157128', '201330611434', '李晓兴', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157129', '201330612059', '梁珩琳', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157130', '201330612097', '林超', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157131', '201330612264', '罗钧如', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157132', '201330612332', '欧伟坚', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157133', '201330613186', '王述浩', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157134', '201330613339', '文生雁', '2013', '4', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157135', '201330610116', '陈俊康', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157136', '201330613377', '吴嘉伟', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157137', '201330613414', '吴泽艺', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157138', '201330614350', '袁江超', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157139', '201330614374', '袁文锦', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157140', '201330613100', '汪靖武', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157141', '201330612288', '罗延瀚', '2013', '4', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157142', '201369990500', 'CAO MINSHEN', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157143', '201330612127', '林江淼', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157144', '201330610260', '陈炫锦', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157145', '201330610246', '陈昱成', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157146', '201330612493', '宋宜心', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157147', '201330613254', '王泽昊', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157148', '201330610017', '敖海珊', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157149', '201330612325', '欧豪哲', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157150', '201330613445', '萧锐杰', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157151', '201330614152', '颜凡亨', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157152', '201330612233', '龙行', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157153', '201330611458', '李耀松', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157154', '201330610185', '陈文平', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157155', '201330610345', '杜舒明', '2013', '5', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157156', '201330611342', '李超', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157157', '201330612226', '龙贤哲', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157158', '201330610024', '蔡利航', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157159', '201330612240', '路洲', '2013', '5', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157160', '201330614077', '谢镇涛', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157161', '201330614114', '许金龙', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157162', '201330614251', '叶超林', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157163', '201330612110', '林沪', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157164', '201330614268', '叶汇镓', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157165', '201330614275', '叶宇飞', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157166', '201330614299', '叶志欣', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157167', '201330614329', '游耀祖', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157168', '201330614480', '张庭玮', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157169', '201330615197', '庄磊', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157170', '201330615203', '庄志强', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157171', '201330610420', '甘迎涛', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157172', '201330611441', '李雪颖', '2013', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157173', '201330615166', '朱成昊', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157174', '201330611328', '雷宏婧', '2013', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157175', '201330612417', '任百晓', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157176', '201330610284', '程挚', '2013', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157177', '201330613094', '田应发', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157178', '201330610277', '程帅', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157179', '201330614176', '杨航', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157180', '201330611304', '兰昕艺', '2013', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157181', '201330615173', '朱涵泊', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157182', '201330610482', '郭欢', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157183', '201330612035', '梁碧文', '2013', '2', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157184', '201369990494', 'SHAIEA JAMAL JAMIL HUSSEIN', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157185', '201330610499', '郭佳哲', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157186', '201330610321', '戴熹', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157187', '201330610208', '陈永洪', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157188', '201330611151', '黄嘉焕', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157189', '201330611267', '黄麒龙', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157190', '201330612257', '陆乾昱', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157191', '201330610376', '范朝华', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157192', '201330610390', '方美斌', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157193', '201330610444', '甘子成', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157194', '201330610451', '高朗峰', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157195', '201330610505', '郭俊葆', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157196', '201330611038', '韩海生', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157197', '201330611182', '黄文锋', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157198', '201330611205', '黄泽湧', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157199', '201330611229', '黄志纯', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157200', '201330611359', '李冬', '2013', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157201', '201330613209', '王拓', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157202', '201330615234', '邹帅', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157203', '201330613087', '陶方舟', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157204', '201330613247', '王依桐', '2013', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157205', '201330613308', '魏华晓', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157206', '201330610147', '陈奇', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157207', '201330610154', '陈书成', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157208', '201330610161', '陈伟钊', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157209', '201330612448', '施涵', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157210', '201330610475', '郭航宇', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157211', '201330613230', '王一君', '2013', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157212', '201330614220', '杨涛', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157213', '201330614053', '谢永康', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157214', '201330614138', '严佳勋', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157215', '201330610048', '曹志航', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157216', '201330615074', '赵啸秋', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157217', '201330610291', '丛士钧', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157218', '201330611496', '李子龙', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157219', '201330611465', '李云飘', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157220', '201330614312', '游海军', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157221', '201330615142', '周展皓', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157222', '201330610307', '崔勇带', '2013', '3', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157223', '201330613063', '谭傜月', '2013', '3', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157224', '201330614213', '杨民皓', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157225', '201369990470', 'TOICHIBAYEV AKMAL', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157226', '201369990487', 'KHASSEN TOGZHAN', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157227', '201330615111', '钟华帅', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157228', '201330613155', '王嘉璇', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157229', '201330610383', '范世杰', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157230', '201330612189', '刘晓晗', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157231', '201330611298', '金悦媛', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157232', '201330613469', '肖航', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157233', '201330615128', '钟龙文', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157234', '201330614428', '詹宇坤', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157235', '201330613131', '王非洲', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157236', '201330612318', '聂强', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157237', '201330612073', '廖明辉', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157238', '201330613506', '肖鑫恺', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157239', '201330613285', '王炜恒', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157240', '201330611014', '郭思辰', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157241', '201330610031', '曹瑞秋', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157242', '201330615241', '岑允业', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157243', '201330610079', '陈海龙', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157244', '201330610086', '陈嘉良', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157245', '201330610109', '陈健昌', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157246', '201330610123', '陈凯龙', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157247', '201330611106', '胡浩', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157248', '201336610363', '敦天伦', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157249', '201336610356', '段刘昌', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157250', '201330611052', '何隆飞', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157251', '201336611414', '李述彧', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157252', '201330613452', '肖汉松', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157253', '201330613476', '肖劲', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157254', '201330614466', '张力', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157255', '201330614503', '张文聪', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157256', '201330615012', '张信', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157257', '201330615036', '张志伟', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157258', '201330615043', '张宗瀚', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157259', '201330611076', '何睿', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157260', '201330613407', '吴涛宇', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157261', '201330614206', '杨克龙', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157262', '201330614305', '易川焜', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157263', '201330612455', '司加豪', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157264', '201330611069', '何威锐', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157265', '201330614183', '杨浩雁', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157266', '201330613056', '孙思雨', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157267', '201330610222', '陈子豪', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157268', '201330613438', '夏欢欢', '2013', '1', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157269', '201330612301', '莫创彪', '2013', '1', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157270', '201369990258', 'SUFIAN FRANCOS', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157271', '201330611489', '李壮', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157272', '201330611144', '黄济明', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157273', '201330610406', '冯清泉', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157274', '201330611281', '江龙威', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157275', '201330611113', '黄国裕', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157276', '201330611120', '黄悍', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157277', '201335611378', '李嘉正', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157278', '201330615135', '钟卓良', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157279', '201330614145', '严家伟', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157280', '201330611366', '李冠霄', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157281', '201330611403', '李荣林', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157282', '201330614190', '杨佳豪', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157283', '201330613360', '吴晨航', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157284', '201330611311', '雷璟', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157285', '201330610062', '陈丰', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157286', '201330612424', '沈楚彦', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157287', '201330614022', '谢华', '2013', '2', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157288', '201330620153', '李志奎', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157289', '201336612206', '刘忆宁', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157290', '201330620177', '梁世宇', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157291', '201330611045', '何俊鹏', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157292', '201330614343', '禹盼', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157293', '201330612028', '利润', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157294', '201330614084', '熊慧', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157295', '201330611083', '何锴丽', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157296', '201336980404', '张永斌', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157297', '201330612400', '邱沐坡', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157298', '201330620184', '廖晨', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157299', '201330620191', '林汤山', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157300', '201330620221', '邱桂柱', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157301', '201330620245', '王尚桐', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157302', '201330620252', '王志豪', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157303', '201330620276', '杨柳杰', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157304', '201330620290', '姚立洋', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157305', '201330620030', '陈逸风', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157306', '201330620054', '邓鹏', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157307', '201330620115', '贾赛奇', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157308', '201330620214', '罗忆', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157309', '201330620092', '胡长铼', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157310', '201330614442', '张健', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157311', '201330620306', '周志上', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157312', '201336620010', '陈杰通', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157313', '201330614091', '徐凌杰', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157314', '201336610059', '常诚', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157315', '201330620122', '荆姝曼', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157316', '201330620023', '陈秋鑫', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157317', '201330620047', '戴政', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157318', '201330620108', '黄指标', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157319', '201330620139', '赖道宽', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157320', '201330612509', '苏传宇', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157321', '201330613216', '王亚坤', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157322', '201330613179', '王韶辉', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157323', '201336620287', '杨琛璟', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157324', '201330612431', '盛逸辰', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157325', '201330620085', '郝俊楠', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157326', '201330620269', '徐悦', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157327', '201330610253', '陈炜炜', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157328', '201330614244', '阳昊', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157329', '201330420111', '葛星辰', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157330', '201335620066', '甘芷翘', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157331', '201330620160', '李宓静', '2013', '卓越班', '120', '女', null, '本科');
INSERT INTO `student` VALUES ('157332', '201330620078', '葛桂宏', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157333', '201330620238', '田欢', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157334', '201330614237', '杨宇', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157335', '201330620207', '林泳光', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157336', '201336620140', '李昭宏', '2013', '卓越班', '120', '男', null, '本科');
INSERT INTO `student` VALUES ('157337', '201330160123', '黄黎龙', '2013', '卓越班', '120', '男', null, '本科');

-- ----------------------------
-- Table structure for `suggestion`
-- ----------------------------
DROP TABLE IF EXISTS `suggestion`;
CREATE TABLE `suggestion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `userid` int(11) DEFAULT NULL COMMENT '提议人的id',
  `name` varchar(20) DEFAULT NULL COMMENT '提议人的姓名',
  `content` varchar(600) NOT NULL COMMENT '建议内容',
  `email` varchar(60) NOT NULL COMMENT '提议人邮箱地址',
  `isread` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已阅读；0：未阅读，1：已阅读',
  `issend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已发送邮件；0：未发送，1：已发送',
  `isnotice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已反馈；0：未反馈，1：已反馈',
  PRIMARY KEY (`id`),
  KEY `fk_suggestion_user` (`userid`),
  CONSTRAINT `fk_suggestion_user` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of suggestion
-- ----------------------------
INSERT INTO `suggestion` VALUES ('4', null, '冯真真', '建议测试N次了', 'chuhua@scut.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('5', null, '冯真真', '整理路径问题', 'cut@sct.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('6', null, '冯真真', 'fdsfsdfs', 'cdf@sct.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('7', null, '冯真真', 'asgdss', 'dsfds@scut.edu.cn', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('8', null, '冯真真', ' fsfsafsaf', 'fdf@fdaf.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('9', '1', '冯真真', 'tryy', '940711227@qq.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('10', '1', '冯真真', 'jjjjjj', 'ss@qq.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('11', '1', '冯真真', 'hello', '535676766@qq.com', '0', '0', '0');
INSERT INTO `suggestion` VALUES ('12', '1', '冯真真', '123', '123@qq.com', '0', '0', '0');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) NOT NULL COMMENT '教师编号',
  `name` varchar(60) NOT NULL COMMENT '教师姓名',
  `isexternal` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否外聘教师，0：否|1：是',
  `departmentid` int(11) DEFAULT NULL COMMENT '外键，所属院系：department 允许为空',
  `email` varchar(60) DEFAULT '' COMMENT '老师的电子邮箱地址',
  `sex` varchar(10) NOT NULL DEFAULT '男' COMMENT '性别',
  PRIMARY KEY (`id`,`code`),
  UNIQUE KEY `index_code_unique` (`code`) USING BTREE,
  KEY `fk_teacher_department` (`departmentid`),
  KEY `id` (`id`),
  CONSTRAINT `fk_teacher_department` FOREIGN KEY (`departmentid`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1036 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', 'G03031', '冯真真', '0', '19', 'zhzhf@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('969', 'G03028', '杨捷', '0', '19', 'yjclear@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('970', 'H03002', '郭芬', '0', '19', '', '女');
INSERT INTO `teacher` VALUES ('971', 'B15053', '许国民', '0', '19', 'adgmxu@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('972', 'B07043', '闵华清', '0', '19', 'hqmin@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('973', 'B07052', '王振宇', '0', '19', 'wangzy@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('974', 'G03023', '陈琼', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('975', 'Z99001', '饶宇琼', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('976', 'G03002', '程兴国', '0', '19', 'chengjacky@163.com', '男');
INSERT INTO `teacher` VALUES ('977', 'G03049', '张海义', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('978', 'G03047', '彭绍武', '0', '19', 'swpeng@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('979', 'XB0003', '彭新一', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('980', 'G03043', '黄翰', '0', '19', 'hhan@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('981', 'G03026', '黄敏', '0', '19', 'minh@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('982', 'G03053', '郑凤妮', '0', '19', '', '女');
INSERT INTO `teacher` VALUES ('983', 'G03001', '陈泽琳', '0', '19', 'cszlchen@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('984', 'G03004', '冯玉翔', '0', '19', 'yxfeng@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('985', 'G03005', '黄小兵', '0', '19', 'cshxb@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('986', 'G03006', '李东', '0', '19', 'cslidong@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('987', 'G03008', '刘艳霞', '0', '19', 'cslyx@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('988', 'G03009', '刘志', '0', '19', 'liuzhi@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('989', 'G03010', '欧国华', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('990', 'G03014', '吴涛', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('991', 'G03015', '奚建清', '0', '19', 'csjtang@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('992', 'G03019', '张杨', '0', '19', 'cszyang@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('993', 'G04009', '刘俊', '0', '19', 'liujun@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('994', 'G03039', '刘琼', '0', '19', 'liuqiong@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('995', 'G03036', '李彦彬', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('996', 'G03051', '陈跃文', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('997', 'G03054', '道炜', '0', '19', '', '女');
INSERT INTO `teacher` VALUES ('998', 'G03034', '肖鹍', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('999', 'G03035', '张安定', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('1001', 'G03007', '刘桂喜', '0', '19', 'gxliu@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1002', 'G03012', '商海燕', '0', '19', '', '女');
INSERT INTO `teacher` VALUES ('1003', 'G03013', '王国华', '0', '19', 'ghwang@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1004', 'G03048', '王健雄', '0', '19', 'wangx@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1005', 'G03030', '陈虎', '0', '19', 'chenhu@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1006', 'G03016', '徐跃东', '0', '19', 'steven_xu2000@163.com', '男');
INSERT INTO `teacher` VALUES ('1007', 'G03024', '李红', '0', '19', 'lihong_369@126.com', '女');
INSERT INTO `teacher` VALUES ('1008', 'G03052', '罗钧', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('1009', 'G03050', '王子骏', '0', '19', 'jzwang@cs.clemson.edu', '男');
INSERT INTO `teacher` VALUES ('1010', 'G03025', '陈健', '0', '19', 'ellachen@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1011', 'G04029', '杨怀玉', '0', '19', 'yanghy@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1012', 'G04030', '罗婵', '0', '19', 'luochan@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1013', 'G03021', '陈天', '0', '19', 'spam@chentian.com', '男');
INSERT INTO `teacher` VALUES ('1014', 'G03018', '张平健', '0', '19', 'pjzhang@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1015', 'G03044', '林连南', '0', '19', 'lnlin@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1016', 'G03045', '徐杨', '0', '19', 'xuyang@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1017', 'G03046', '汤德佑', '0', '19', 'dytang@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1018', 'Z99065', '黄小平', '0', '19', 'huangxp99@163.com', '男');
INSERT INTO `teacher` VALUES ('1019', 'G03055', '吕书哲', '0', '19', '', '男');
INSERT INTO `teacher` VALUES ('1020', 'G03068', '陈俊颖', '0', '19', 'jychense@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1021', 'G03020', '左保河', '0', '19', 'zuobh@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1022', 'G03059', '蔡毅', '0', '19', 'ycai@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1023', 'G03060', '申旻旻', '0', '19', 'shenminmin1002@hotmail.com', '女');
INSERT INTO `teacher` VALUES ('1024', 'G03061', '曾庆醒', '0', '19', '819262450@qq.com', '男');
INSERT INTO `teacher` VALUES ('1025', 'G03063', '戴一菲', '0', '19', 'seyfdai@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1026', 'G03064', '金龙存', '0', '19', 'lcjin@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1027', 'G03057', '刘孜文', '0', '19', 'sophyhare@163.com', '男');
INSERT INTO `teacher` VALUES ('1028', 'G03058', '李静锴', '0', '19', 'jkli@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1029', 'G03056', '应伟勤', '0', '19', 'yingweiqin@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1030', 'G03022', '杜卿', '0', '19', 'duqing@scut.edu.cn', '女');
INSERT INTO `teacher` VALUES ('1031', 'G03065', 'Rick Giles', '0', '19', 'rick.giles@acadiau.ca', '男');
INSERT INTO `teacher` VALUES ('1032', 'G03066', '曾兵', '0', '19', 'zbing@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1033', 'G03067', '陈春华', '0', '19', 'chunhuachen@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1034', 'G03062', '王文敏', '0', '19', 'wenminw@scut.edu.cn', '男');
INSERT INTO `teacher` VALUES ('1035', 'G03069', 'Andre Trudel', '0', '19', 'Andre.Trudel@acadian.ca', '男');

-- ----------------------------
-- Table structure for `university`
-- ----------------------------
DROP TABLE IF EXISTS `university`;
CREATE TABLE `university` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `code` varchar(10) DEFAULT NULL COMMENT '学校代码',
  `name` varchar(60) NOT NULL COMMENT '学校名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of university
-- ----------------------------
INSERT INTO `university` VALUES ('1', '10561', '华南理工大学');
INSERT INTO `university` VALUES ('2', '10558', '中山大学');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(30) NOT NULL COMMENT '登录名',
  `showname` varchar(90) DEFAULT NULL COMMENT '显示名',
  `password` varchar(200) NOT NULL COMMENT '密码-SHA1哈希值',
  `question` varchar(45) DEFAULT NULL COMMENT '提问',
  `answer` varchar(45) DEFAULT NULL COMMENT '回答',
  `rolecode` varchar(20) NOT NULL COMMENT '用户类型{ROLE_ACAMGR|ROLE_TCH:|ROLE_STD}',
  `universityid` int(11) unsigned DEFAULT NULL COMMENT '所属学校ID-外键-适用所有用户类型',
  `departmentid` int(11) DEFAULT NULL COMMENT '所属院系ID-外键-适用所有用户类型',
  `majorid` int(11) DEFAULT NULL COMMENT '所属专业ID-外键-适用用户类型为“学生”',
  `teacherid` int(11) DEFAULT NULL COMMENT '所属教师ID-外键-适用用户类型为“教师”',
  `studentid` int(11) DEFAULT NULL COMMENT '所属学生ID-外键-适用用户类型为“学生”',
  `officeid` int(11) DEFAULT NULL COMMENT '所属职能部门ID-适用用户类型为“学校职能部门”等|暂时不使用',
  `description` varchar(150) DEFAULT NULL COMMENT '备注',
  `lastlogintime` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用，“0-否”，“1-是，启用” 默认：1',
  `accountNonExpired` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否过期，“0-否”，“1-是，未过期” 默认：1',
  `credentialsNonExpired` tinyint(1) NOT NULL DEFAULT '1' COMMENT '密码是否失效，“0-否”，“1-是，未失效” 默认：1',
  `accountNonLocked` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否被锁定-“0-否”，“1-是，未被锁定” 默认：1',
  PRIMARY KEY (`id`),
  KEY `fk_teacher_teacherid` (`teacherid`),
  KEY `fk_student_studentid` (`studentid`),
  KEY `fk_department_departmentid` (`departmentid`),
  KEY `fk_major_majorid` (`majorid`),
  CONSTRAINT `fk_department_departmentid` FOREIGN KEY (`departmentid`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_major_majorid` FOREIGN KEY (`majorid`) REFERENCES `major` (`id`),
  CONSTRAINT `fk_student_studentid` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_teacher_teacherid` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4727 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'G03031', '冯真真', '3826943d6603c9da03436e46b196822f87496de3', null, null, 'ROLE_ACAMGR', '1', '19', null, '1', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3497', 'G03028', '杨捷', '306ae1104b9f7f38cfee89cd67944bdc88bda57d', null, null, 'ROLE_TCH', '1', '19', null, '969', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3498', 'H03002', '郭芬', '03eeed04dbab099c066483150d645abadfd754cf', null, null, 'ROLE_TCH', '1', '19', null, '970', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3499', 'B15053', '许国民', '2095c47b2534a2617330d25d80ab6cb0350d3457', null, null, 'ROLE_TCH', '1', '19', null, '971', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3500', 'B07043', '闵华清', 'c1f3484d577a61b9ce4088e7250f9743fcf677c0', null, null, 'ROLE_TCH', '1', '19', null, '972', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3501', 'B07052', '王振宇', '794fecccf634a535a9a0c5c69636de497f721437', null, null, 'ROLE_TCH', '1', '19', null, '973', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3502', 'G03023', '陈琼', 'f6de467b868f86e7995a0d99d0c3a34b49692190', null, null, 'ROLE_TCH', '1', '19', null, '974', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3503', 'Z99001', '饶宇琼', '972ee5d81260fdb19567d1290adf470c219bca8c', null, null, 'ROLE_TCH', '1', '19', null, '975', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3504', 'G03002', '程兴国', '67f533faaba9905f9c0feb3d9d0b498cc5fabb1a', null, null, 'ROLE_TCH', '1', '19', null, '976', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3505', 'G03049', '张海义', 'df631d5fe5d5120449f91e032989348993975318', null, null, 'ROLE_TCH', '1', '19', null, '977', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3506', 'G03047', '彭绍武', '0cd39655d7d3de0fa177eb210f5580c4b550dca7', null, null, 'ROLE_TCH', '1', '19', null, '978', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3507', 'XB0003', '彭新一', 'd44c5cda104ba7cfd135c2da6d582d4f40ff3ca1', null, null, 'ROLE_TCH', '1', '19', null, '979', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3508', 'G03043', '黄翰', '6971b7a65e830e4801c215f4456250458ac9c3a4', null, null, 'ROLE_TCH', '1', '19', null, '980', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3509', 'G03026', '黄敏', '40b13edba8b38e3ad75a9a78831df14ceb1bd54c', null, null, 'ROLE_TCH', '1', '19', null, '981', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3510', 'G03053', '郑凤妮', '4cdc83ed4e136669fd288948969f80bf85ede8ad', null, null, 'ROLE_TCH', '1', '19', null, '982', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3511', 'G03001', '陈泽琳', 'a9cd5cde86bb0c0ebd81044a6bf66e5b5eb9cb9b', null, null, 'ROLE_TCH', '1', '19', null, '983', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3512', 'G03004', '冯玉翔', 'c2b9ee135a3932a9cc96fd3c237d08eca29b6562', null, null, 'ROLE_TCH', '1', '19', null, '984', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3513', 'G03005', '黄小兵', 'e0ef53343de3acc39298f4be9bd7e3408397a89b', null, null, 'ROLE_TCH', '1', '19', null, '985', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3514', 'G03006', '李东', 'f611c15a3db30af1b321f206ba55c012e9fdc841', null, null, 'ROLE_TCH', '1', '19', null, '986', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3515', 'G03008', '刘艳霞', 'c4cb77c954ddf1541e2074b73a7421362d29c8ea', null, null, 'ROLE_TCH', '1', '19', null, '987', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3516', 'G03009', '刘志', '992a7b7cedfdf8d35506a0fd2132ddc5cb6d3b62', null, null, 'ROLE_TCH', '1', '19', null, '988', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3517', 'G03010', '欧国华', '5254ee2949409c06f37f5672d597d20a8547fab0', null, null, 'ROLE_TCH', '1', '19', null, '989', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3518', 'G03014', '吴涛', '92d78ccfdac6fb17572710814cbb94f44091ff1c', null, null, 'ROLE_TCH', '1', '19', null, '990', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3519', 'G03015', '奚建清', '877ae3010aaa34ad1a2d531873cc0ef84600b1fc', null, null, 'ROLE_TCH', '1', '19', null, '991', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3520', 'G03019', '张杨', '4ae16bdbb064f016b3dc2b2dc3120a7d4c95ca04', null, null, 'ROLE_TCH', '1', '19', null, '992', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3521', 'G04009', '刘俊', '56741a8b78434a0477a6a6401ba0ca3cb76fef22', null, null, 'ROLE_TCH', '1', '19', null, '993', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3522', 'G03039', '刘琼', '32d5fe8ec5747e3af287a84aea6e012f458f81e2', null, null, 'ROLE_TCH', '1', '19', null, '994', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3523', 'G03036', '李彦彬', '0782d85988b9166ed47e2237944a950c91c7147f', null, null, 'ROLE_TCH', '1', '19', null, '995', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3524', 'G03051', '陈跃文', '49720b0706c4f05baa433311da846a793cef36c6', null, null, 'ROLE_TCH', '1', '19', null, '996', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3525', 'G03054', '道炜', '0de9e5a08a771992a55e8a8efc61b46676a44aa1', null, null, 'ROLE_TCH', '1', '19', null, '997', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3526', 'G03034', '肖鹍', '3bacd17715220c330946e0137d376dbdafa2fe80', null, null, 'ROLE_TCH', '1', '19', null, '998', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3527', 'G03035', '张安定', '5fd6746e8b42f0ba0f0cc111f7e7679b01eed9d4', null, null, 'ROLE_TCH', '1', '19', null, '999', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3528', 'G03007', '刘桂喜', '21869a0955ce411318bab21d40f5b2fbfffc763a', null, null, 'ROLE_TCH', '1', '19', null, '1001', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3529', 'G03012', '商海燕', '08fc490bddac0f3fa3fe47b3dd10d6efba339ebd', null, null, 'ROLE_TCH', '1', '19', null, '1002', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3530', 'G03013', '王国华', '2e7db870e36767d730d15eb6ffaae24db25ffdbb', null, null, 'ROLE_TCH', '1', '19', null, '1003', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3531', 'G03048', '王健雄', '7e32b013769cc9a868de96f03828fc9059ff0df6', null, null, 'ROLE_TCH', '1', '19', null, '1004', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3532', 'G03030', '陈虎', '76c7e11099d9d4c293e86e94281d84273206b321', null, null, 'ROLE_TCH', '1', '19', null, '1005', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3533', 'G03016', '徐跃东', '777ca42815a7c49005c393cdeaff6299d393fe3d', null, null, 'ROLE_TCH', '1', '19', null, '1006', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3534', 'G03024', '李红', '4ae14aec2e40866e6216c9c799ef46ba4a12f055', null, null, 'ROLE_TCH', '1', '19', null, '1007', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3535', 'G03052', '罗钧', 'b8e8577c9e455dd1665d3191362b741bcff98030', null, null, 'ROLE_TCH', '1', '19', null, '1008', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3536', 'G03050', '王子骏', 'fa25036a6064fddbe691dde9ed58b0384eea4f93', null, null, 'ROLE_TCH', '1', '19', null, '1009', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3537', 'G03025', '陈健', '34567dfcbb7d34c223d938c96b0fa413ad39469d', null, null, 'ROLE_TCH', '1', '19', null, '1010', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3538', 'G04029', '杨怀玉', '36c77b0f66f08612964a5faf3926d6a643ad68ea', null, null, 'ROLE_TCH', '1', '19', null, '1011', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3539', 'G04030', '罗婵', 'fad4ce5fbdfd107b67f0a40a22d118e23ea77359', null, null, 'ROLE_TCH', '1', '19', null, '1012', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3540', 'G03021', '陈天', '0638647c61ed6a1a088f9c25dca47fa4ce42ef27', null, null, 'ROLE_TCH', '1', '19', null, '1013', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3541', 'G03018', '张平健', '1dc3a1db95ba035355232322892342b589b1d2fd', null, null, 'ROLE_TCH', '1', '19', null, '1014', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3542', 'G03044', '林连南', '256c615f7cc1f2852b818f17899e66f84782f3fe', null, null, 'ROLE_TCH', '1', '19', null, '1015', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3543', 'G03045', '徐杨', '7ae97d5747a07f941454e1bbd3bb9541c157231d', null, null, 'ROLE_TCH', '1', '19', null, '1016', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3544', 'G03046', '汤德佑', '0a1107d418fa530d19e9c8a14bf8f8f0c2c28583', null, null, 'ROLE_TCH', '1', '19', null, '1017', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3545', 'Z99065', '黄小平', 'd15818758d15bbecba23f71cec1235746fdc36d3', null, null, 'ROLE_TCH', '1', '19', null, '1018', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3546', 'G03055', '吕书哲', 'cc2694e1841bc33c9d0d052d04879e8b27b73f6f', null, null, 'ROLE_TCH', '1', '19', null, '1019', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3547', 'G03068', '陈俊颖', 'd510f1b072dcdeaf9ac88a51d8efcc073732a4f7', null, null, 'ROLE_TCH', '1', '19', null, '1020', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3548', 'G03020', '左保河', 'dbee28b757270c88bceda7a5761a4f815c110ba2', null, null, 'ROLE_TCH', '1', '19', null, '1021', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3549', 'G03059', '蔡毅', '8219a6af94cd81f47e0888ec8040decc7d4aa4ec', null, null, 'ROLE_TCH', '1', '19', null, '1022', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3550', 'G03060', '申旻旻', '8ef5f58d8f6769816c315f1be18f53b781227ceb', null, null, 'ROLE_TCH', '1', '19', null, '1023', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3551', 'G03061', '曾庆醒', '7a86b99692ec291bf192fe7dd9db2c4e0ac7fee9', null, null, 'ROLE_TCH', '1', '19', null, '1024', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3552', 'G03063', '戴一菲', 'e95559da915464e6cc8c92ceab3901d27b6b904d', null, null, 'ROLE_TCH', '1', '19', null, '1025', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3553', 'G03064', '金龙存', '0fdae2b81edac8d299bd07440b7ec59377114a90', null, null, 'ROLE_TCH', '1', '19', null, '1026', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3554', 'G03057', '刘孜文', '24df18e994440f2224e72a4d592947c14c855540', null, null, 'ROLE_TCH', '1', '19', null, '1027', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3555', 'G03058', '李静锴', 'c6dfe4f7ea71cc43b7b26cba3f9419d3025d01dc', null, null, 'ROLE_TCH', '1', '19', null, '1028', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3556', 'G03056', '应伟勤', '56d1fb3c8290dd1ff632f71ee45c087e0e3f2707', null, null, 'ROLE_TCH', '1', '19', null, '1029', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3557', 'G03022', '杜卿', '2bc11f39341961893210e158d0725ca8a2ae6fb4', null, null, 'ROLE_TCH', '1', '19', null, '1030', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3558', 'G03065', 'Rick Giles', '13e9cba06a63a4c6975851e3588b13452a7924d8', null, null, 'ROLE_TCH', '1', '19', null, '1031', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3559', 'G03066', '曾兵', '0be47a81f3fe050ccc22198d277d7545b1d43362', null, null, 'ROLE_TCH', '1', '19', null, '1032', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3560', 'G03067', '陈春华', '795a6710a4647fb96a872610c69309eff8a80d4f', null, null, 'ROLE_TCH', '1', '19', null, '1033', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3561', 'G03062', '王文敏', '8a6418f712a036dcad7bdcedb92c6a2364075458', null, null, 'ROLE_TCH', '1', '19', null, '1034', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3562', 'G03069', 'Andre Trudel', '28ef7d1951dedbeee7babef4d01ac5e4645ce8df', null, null, 'ROLE_TCH', '1', '19', null, '1035', null, null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3563', '201030630087', '陈柏豪', 'ea0e14323d6414a009da6d838385ce4cf5a7fb8d', null, null, 'ROLE_STD', '1', '19', '120', null, '156174', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3564', '201030631893', '汪婉璐', 'c819c971349b384a9554b621495261684fd878da', null, null, 'ROLE_STD', '1', '19', '120', null, '156175', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3565', '201030631510', '马宇锋', 'b94586a18b082c742a0868adf7f6a88634945f1f', null, null, 'ROLE_STD', '1', '19', '120', null, '156176', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3566', '201030631268', '林燕群', '544f383526a63145d13f4495c6ae616e16e521fa', null, null, 'ROLE_STD', '1', '19', '120', null, '156177', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3567', '201030630797', '李博轩', '49c2d19b834b674775981d7b361a8ed276592d61', null, null, 'ROLE_STD', '1', '19', '120', null, '156178', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3568', '201030632708', '尹茜霞', '1d3844d854450e018f0425052e236c5e982b854e', null, null, 'ROLE_STD', '1', '19', '120', null, '156179', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3569', '201030633132', '郑天然', '574ff483d151aa5eb034b95ba50c81193e037ed6', null, null, 'ROLE_STD', '1', '19', '120', null, '156180', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3570', '201030632791', '曾健', '912a4019f8b2e70bcfb3ac134bc0e2fae38d790e', null, null, 'ROLE_STD', '1', '19', '120', null, '156181', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3571', '201030631749', '孙伟然', '5bc69cc344328130158bdffb18d558e5a26cb1c6', null, null, 'ROLE_STD', '1', '19', '120', null, '156182', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3572', '201030633149', '郑文育', 'beca45a67f0fb226b8ccd9b9da85b73ffa827980', null, null, 'ROLE_STD', '1', '19', '120', null, '156183', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3573', '201030630605', '黄仁达', '150c3ec7bb1587d8c8a4e6f09df7c12f43924a4e', null, null, 'ROLE_STD', '1', '19', '120', null, '156184', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3574', '201030630520', '黄东平', 'a596cd68ecd31f2b564bcb44041d0dd585e47767', null, null, 'ROLE_STD', '1', '19', '120', null, '156185', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3575', '201030632630', '杨祎帆', '410c0a0b75a1dd06ceb68fe9aec9e85300798fe5', null, null, 'ROLE_STD', '1', '19', '120', null, '156186', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3576', '201030632517', '许志鹏', 'd5e4f7d1705c3f0c330dddcd9b5852fc49bc4501', null, null, 'ROLE_STD', '1', '19', '120', null, '156187', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3577', '201030633040', '张羊左', '24b8e0db80faefbfd16d48b2027a5bd660c1002e', null, null, 'ROLE_STD', '1', '19', '120', null, '156188', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3578', '201030630735', '蒋俊翔', '3cf15d19248ee5b956fa8a389e603f40b105567f', null, null, 'ROLE_STD', '1', '19', '120', null, '156189', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3579', '201030631305', '刘宏林', '9f241605971a17364dc53403f0a980b0a1bf786c', null, null, 'ROLE_STD', '1', '19', '120', null, '156190', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3580', '201030632753', '袁立宪', 'b9c9772040102800c8cb098dd644b356a3a537db', null, null, 'ROLE_STD', '1', '19', '120', null, '156191', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3581', '201030633293', '邹梓耀', '573d0b486967781d865412f823971492e8b53fdc', null, null, 'ROLE_STD', '1', '19', '120', null, '156192', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3582', '201030631176', '梁为涛', '3edc364e3fa0f5fd4da9f4232d160a48c4968129', null, null, 'ROLE_STD', '1', '19', '120', null, '156193', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3583', '201030630179', '陈荣强', '0043bca3fbeccdaa1cfd1f3535b8224969f40be7', null, null, 'ROLE_STD', '1', '19', '120', null, '156194', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3584', '201030632050', '王翔宇', 'fdcb353969827d3a44a32415daf526e94103d522', null, null, 'ROLE_STD', '1', '19', '120', null, '156195', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3585', '201030633156', '郑兴杰', '75804f2e5db3eaaa986a46692f1e68b1e91248ed', null, null, 'ROLE_STD', '1', '19', '120', null, '156196', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3586', '201030632685', '姚健伦', '881f20d88446da4e37e6599283a3158f99aa0b5f', null, null, 'ROLE_STD', '1', '19', '120', null, '156197', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3587', '201030631794', '唐本泽', '5d1b113b01a39496785df1198ff83ce29713822b', null, null, 'ROLE_STD', '1', '19', '120', null, '156198', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3588', '201030631824', '唐沃源', '133a292151721fd801896e5af92f9846036132d4', null, null, 'ROLE_STD', '1', '19', '120', null, '156199', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3589', '201030632739', '余知昊', '0d42d3abfdc19c63df09e90aa111ba2ebc151510', null, null, 'ROLE_STD', '1', '19', '120', null, '156200', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3590', '200830630273', '何瑞康', 'f61308c59c27bb10106dd2bd63499571cb411401', null, null, 'ROLE_STD', '1', '19', '120', null, '156201', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3591', '201030633187', '钟逸', '09c415acca99d01d89b1e4841273373202064bc4', null, null, 'ROLE_STD', '1', '19', '120', null, '156202', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3592', '201030630230', '陈昭辉', '0e4b0c010b4c8e0283f8dcb8c5fe5cf6c3e42f0b', null, null, 'ROLE_STD', '1', '19', '120', null, '156203', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3593', '201030630261', '戴颖毅', '33a6c1a3ac544575f8bf9176ae3f063812dc317d', null, null, 'ROLE_STD', '1', '19', '120', null, '156204', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3594', '201030630049', '蔡小翡', 'c44c294c373b2f5c56bed9f27b797fc0f2774753', null, null, 'ROLE_STD', '1', '19', '120', null, '156205', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3595', '200830633267', '朱文涛', '12201c21b664b658e686be20a18c0edf4a7cb6a4', null, null, 'ROLE_STD', '1', '19', '120', null, '156206', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3596', '201030633248', '周展坤', 'dfa19f3671733533414cd1837e7573e61e23702f', null, null, 'ROLE_STD', '1', '19', '120', null, '156207', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3597', '201030631787', '谭赞君', '8328e61dc777978f7bd7d3e59459f4625efeaaba', null, null, 'ROLE_STD', '1', '19', '120', null, '156208', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3598', '201030632333', '萧名谦', 'ebf0c98b537038acdf2397454d0a184d798dcd0c', null, null, 'ROLE_STD', '1', '19', '120', null, '156209', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3599', '201030630131', '陈乐华', '84dbdffe6ec4e81d283028e28a1ad11572d27247', null, null, 'ROLE_STD', '1', '19', '120', null, '156210', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3600', '201030630339', '冯子琪', 'cc838a8579eef89c0d99740ac3a13dc6da082f11', null, null, 'ROLE_STD', '1', '19', '120', null, '156211', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3601', '201030631343', '刘如旎', 'fbe06878cef7436b2fc0b99c0ff6870d4406a94b', null, null, 'ROLE_STD', '1', '19', '120', null, '156212', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3602', '201030630278', '单博', 'b5953ede789a058ead7be8c9e6a3c8c81aff6b7a', null, null, 'ROLE_STD', '1', '19', '120', null, '156213', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3603', '201030632302', '吴泽森', 'd3f0fdd2721bfe9c4db1d2217f0c8d8b84e77cc4', null, null, 'ROLE_STD', '1', '19', '120', null, '156214', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3604', '201030630445', '洪泽钦', '920d084a0aabe3e5f0d5e8fb143a39111a901797', null, null, 'ROLE_STD', '1', '19', '120', null, '156215', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3605', '201030632784', '岳时雨', '1773cf83e3ffbe9c53062242e88be35ea1c983fe', null, null, 'ROLE_STD', '1', '19', '120', null, '156216', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3606', '201030631541', '穆妮', '9edbf07270c4e9ffda0de6c98e6a8849657a12c6', null, null, 'ROLE_STD', '1', '19', '120', null, '156217', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3607', '201030630285', '单菲', '95c9eb1b88a2843855bf33154561adc5c374c526', null, null, 'ROLE_STD', '1', '19', '120', null, '156218', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3608', '201030632463', '徐光', 'db780abb67dbd3212de95c852b9059401ae7d75f', null, null, 'ROLE_STD', '1', '19', '120', null, '156219', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3609', '201030630391', '何民宠', '19044873d61a5ce7fab02181e66c4a77702e12de', null, null, 'ROLE_STD', '1', '19', '120', null, '156220', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3610', '201030630193', '陈宣亦', '655cf375a6ebb7026a131e9346a36eb0fd49fb03', null, null, 'ROLE_STD', '1', '19', '120', null, '156221', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3611', '201030631312', '刘菁', '1c053d5568b3adfa0c839fc8661126a877be250e', null, null, 'ROLE_STD', '1', '19', '120', null, '156222', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3612', '201030630469', '胡音文', '70386976e53c3686ac923055e9f256e78068be5e', null, null, 'ROLE_STD', '1', '19', '120', null, '156223', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3613', '201030630629', '黄伟铎', '14fb91e7be0414464827e3be9e7aa207edb8b06d', null, null, 'ROLE_STD', '1', '19', '120', null, '156224', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3614', '201030632395', '谢文浩', 'fb2a2ce8f9d1c69e6364a9352736ac14df2329a5', null, null, 'ROLE_STD', '1', '19', '120', null, '156225', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3615', '201030630773', '冷明强', 'fd5c48caac31b5af1dabd30c193bed9d283d49ef', null, null, 'ROLE_STD', '1', '19', '120', null, '156226', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3616', '201030632326', '夏泓基', 'd8f031f481b0c545c01ef979b1f66eca061bea72', null, null, 'ROLE_STD', '1', '19', '120', null, '156227', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3617', '201030632654', '杨奕洋', '7dde6b02d7eca9651172f7111c280de914ca7fd8', null, null, 'ROLE_STD', '1', '19', '120', null, '156228', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3618', '201030632845', '张劲峰', '255c7b6edb5f2a86745ad3f5ced96bab019dcf3c', null, null, 'ROLE_STD', '1', '19', '120', null, '156229', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3619', '201030630315', '邓泽航', 'ccf3c981bccb7cb86b001fdd89b32e204d302b57', null, null, 'ROLE_STD', '1', '19', '120', null, '156230', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3620', '201030632838', '张杰全', '4a9b4a058a575871362de34eec3d6b7d6e115401', null, null, 'ROLE_STD', '1', '19', '120', null, '156231', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3621', '201030630353', '韩冰', '8c86adf21a4e9e71dfd3d28a5b93ee06a6255c9b', null, null, 'ROLE_STD', '1', '19', '120', null, '156232', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3622', '201030633019', '张爽', '22c410633c2b924a6720549d18e3cc296b6599a1', null, null, 'ROLE_STD', '1', '19', '120', null, '156233', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3623', '201030630438', '何浥尘', 'e700189f95dfaefa3866fed0a6d2eff1e8ae5632', null, null, 'ROLE_STD', '1', '19', '120', null, '156234', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3624', '201030631046', '李厦仕舜', 'cc8dc2c583b9416ff5754ef8f9caaf6681b07de7', null, null, 'ROLE_STD', '1', '19', '120', null, '156235', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3625', '201030632340', '萧晓彬', '582de870bd4240d024ac1c787be17abe318cc57f', null, null, 'ROLE_STD', '1', '19', '120', null, '156236', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3626', '201030631183', '梁晓健', '4814f5799db9cf562288ce7bae56c82ec9664e29', null, null, 'ROLE_STD', '1', '19', '120', null, '156237', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3627', '201030630452', '侯嘉宁', '03b868b53d3ae1a1ba692246356da82e63babce1', null, null, 'ROLE_STD', '1', '19', '120', null, '156238', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3628', '201030633323', '李伟', '57686f386708ad77914768cb1c76bcfb1b24bbe4', null, null, 'ROLE_STD', '1', '19', '120', null, '156239', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3629', '201030633071', '张泽耀', '72755d256b8cfccd0f1fb7840997c1c237965016', null, null, 'ROLE_STD', '1', '19', '120', null, '156240', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3630', '201030630155', '陈立豪', '65ecbbe658c5d1dcfc9663a0905328ccf524c978', null, null, 'ROLE_STD', '1', '19', '120', null, '156241', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3631', '201030630292', '邓昌隆', 'ba8459af08870119b6f607665da2f49ec2b2b691', null, null, 'ROLE_STD', '1', '19', '120', null, '156242', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3632', '201030632319', '吴志钦', '4d13a18e31949337e1c1ef3d51da8a67ed6fc0a5', null, null, 'ROLE_STD', '1', '19', '120', null, '156243', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3633', '201030632661', '杨永川', '233375bbde2375dead2a9c4004dace282127cd32', null, null, 'ROLE_STD', '1', '19', '120', null, '156244', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3634', '201030630384', '何陆遥', '88073f7a7c2660a437af156d0b247e1aa0cf8fe1', null, null, 'ROLE_STD', '1', '19', '120', null, '156245', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3635', '201030630636', '黄武财', 'b8699b6f3e5d358103b1888072ba15ab95561e2b', null, null, 'ROLE_STD', '1', '19', '120', null, '156246', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3636', '201030630841', '李弘勋', 'ccf96a1ca30a66b723700178ad4e999693f97c6b', null, null, 'ROLE_STD', '1', '19', '120', null, '156247', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3637', '201030630476', '胡宇阳', '3d27aba027d7ec23b0dea1152131b9efe413eaa7', null, null, 'ROLE_STD', '1', '19', '120', null, '156248', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3638', '201030632364', '谢凯森', '0aae0c47e395bbbed642cbdc452f14cc282fcfc0', null, null, 'ROLE_STD', '1', '19', '120', null, '156249', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3639', '201030631015', '李松', 'c33e61a19cd274a8dae416b77f5c38c15189c624', null, null, 'ROLE_STD', '1', '19', '120', null, '156250', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3640', '201030632203', '吴浩旋', 'e44110ce0cffc8f3be4a70395fd5271db6e6e55b', null, null, 'ROLE_STD', '1', '19', '120', null, '156251', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3641', '201030631817', '唐炜莉', '1e36bbc792841eccc11625cb40cca701f9613438', null, null, 'ROLE_STD', '1', '19', '120', null, '156252', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3642', '201030630667', '黄一浩', 'ac1dad26a03da75dbc96d147865c49ae0be52804', null, null, 'ROLE_STD', '1', '19', '120', null, '156253', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3643', '201030631282', '林志强', 'de425da0658dfdefeab4dca581f21b6da1713358', null, null, 'ROLE_STD', '1', '19', '120', null, '156254', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3644', '201030632524', '薛瑀', 'd88271e385abd460fc2d440876387ac39e41dcce', null, null, 'ROLE_STD', '1', '19', '120', null, '156255', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3645', '201030631725', '苏章盛', '4cfc1fa7620db8cf5384c6228b9ad13360debb2a', null, null, 'ROLE_STD', '1', '19', '120', null, '156256', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3646', '201030631329', '刘利强', '9f03f059c342032f7c856e686db82340d2bc550b', null, null, 'ROLE_STD', '1', '19', '120', null, '156257', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3647', '201030631091', '李志鹏', '419bfadd2bc028ae4de14c704f0e41fdbbb261cc', null, null, 'ROLE_STD', '1', '19', '120', null, '156258', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3648', '201030632012', '王璟星', 'c2f56b5f2265fddc8f2175fc90849b3f52adccad', null, null, 'ROLE_STD', '1', '19', '120', null, '156259', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3649', '201030631084', '李志南', '6af16d581d27a1dc8ababa6bd3fae2e15ab89e14', null, null, 'ROLE_STD', '1', '19', '120', null, '156260', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3650', '201030631336', '刘敏', '6a0aec7ee37f948a4eb8134eb86e98c03fef1559', null, null, 'ROLE_STD', '1', '19', '120', null, '156261', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3651', '201030632692', '尹超', 'de19ea94596b56098b3600c10f184a5f8c6bf771', null, null, 'ROLE_STD', '1', '19', '120', null, '156262', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3652', '201030632418', '谢逸凡', '3f956bccb0fcf1c6f008fe2dc847851dc6c3c345', null, null, 'ROLE_STD', '1', '19', '120', null, '156263', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3653', '201030630650', '黄信尧', '8b6bdf3d5044df6de5ed9b4164dc79ad347a2141', null, null, 'ROLE_STD', '1', '19', '120', null, '156264', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3654', '201030632456', '邢隽缤', 'c332eccf6bc14901cd5137b20cacead433db1918', null, null, 'ROLE_STD', '1', '19', '120', null, '156265', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3655', '201030631565', '宁日欣', '91283f41a02826b2d8d34bd731afbe59ebb3c71c', null, null, 'ROLE_STD', '1', '19', '120', null, '156266', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3656', '201030632449', '谢卓航', '9d20d151c44b39e2eae838c8303d4bd239c11c71', null, null, 'ROLE_STD', '1', '19', '120', null, '156267', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3657', '201030632210', '吴华亮', 'e089c9d70eb581cbbe754e836a05e6d221097209', null, null, 'ROLE_STD', '1', '19', '120', null, '156268', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3658', '201030631367', '刘威', '74197d238d0e666da84caa5e057fc0610651b042', null, null, 'ROLE_STD', '1', '19', '120', null, '156269', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3659', '201030632135', '魏星宇', '8f371df51d4f647995aa1b62b919df49a2b71216', null, null, 'ROLE_STD', '1', '19', '120', null, '156270', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3660', '201030632609', '杨伟宏', '9ef836c57995962c3fcfe60d037bf6e098603265', null, null, 'ROLE_STD', '1', '19', '120', null, '156271', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3661', '201030632494', '许海忠', '5a99af0c6847c25878e8fceabb9f5e9b2a8e3071', null, null, 'ROLE_STD', '1', '19', '120', null, '156272', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3662', '201030631732', '孙蓉蓉', '8ded63ed8e9d09f3f7ac8ce4e17015c861ea98fe', null, null, 'ROLE_STD', '1', '19', '120', null, '156273', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3663', '201030632067', '王鑫', '88aaade366d233aef7e5a1b26acdfb33c4393ca2', null, null, 'ROLE_STD', '1', '19', '120', null, '156274', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3664', '201030632258', '吴敏', 'c024ddad3fc9c586a9e9875401d725a5e03b897d', null, null, 'ROLE_STD', '1', '19', '120', null, '156275', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3665', '201030630834', '李浩源', 'bed772a08321cb640f9cd3ba4c9d5d1f9e2f9383', null, null, 'ROLE_STD', '1', '19', '120', null, '156276', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3666', '201030632173', '翁智腾', '5b7fe6b5bfec74dfb34f030530f84d68685db524', null, null, 'ROLE_STD', '1', '19', '120', null, '156277', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3667', '201030630186', '陈舒瑶', 'f8c1ad892f47aa3080ab386b36052b12f4ab2822', null, null, 'ROLE_STD', '1', '19', '120', null, '156278', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3668', '201030633224', '周希骏', '9460f6c8fb51b680dc6e86db44b81102f4256629', null, null, 'ROLE_STD', '1', '19', '120', null, '156279', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3669', '200930635116', '蔡创佳', 'b9445e0da9581cad40725ab68b43dab0014e3dd0', null, null, 'ROLE_STD', '1', '19', '120', null, '156280', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3670', '200930632313', '肖勇', '8c395959206a3a6d8a5ab33b9d3f598fc0dbb648', null, null, 'ROLE_STD', '1', '19', '120', null, '156281', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3671', '200930631125', '许兆博', '37873b5767bed698c401469481f39cf8822f1e81', null, null, 'ROLE_STD', '1', '19', '120', null, '156282', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3672', '200830630068', '陈炯', 'cdb965cc2481a9ef17e027921af222bad244fc41', null, null, 'ROLE_STD', '1', '19', '120', null, '156283', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3673', '200830634127', '李金桥', '2ca6ea8aac02490e7c659b80fa7ff6b4716f745a', null, null, 'ROLE_STD', '1', '19', '120', null, '156284', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3674', '200830634325', '罗刚', 'c85cc4e6161550460ba05f75a6309942bfc62bf0', null, null, 'ROLE_STD', '1', '19', '120', null, '156285', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3675', '201030633255', '周展鹏', 'e492cbdc3940c24d26110fab77c523b72903fcc3', null, null, 'ROLE_STD', '1', '19', '120', null, '156286', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3676', '201030630582', '黄宁', '0e032d4039c5765215e131c37a953342454a85d2', null, null, 'ROLE_STD', '1', '19', '120', null, '156287', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3677', '201030630032', '蔡锐涛', '6babf790aa76e23a60e3f8cdb8c1b543ebfa2e80', null, null, 'ROLE_STD', '1', '19', '120', null, '156288', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3678', '201030632890', '张山', '754a9f3b9a11543c3c059cf9f5099f4bf0dddd70', null, null, 'ROLE_STD', '1', '19', '120', null, '156289', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3679', '201030633217', '周唯伟', '211d55d0138d5892d42f21ff8d4beed71e9ab2cd', null, null, 'ROLE_STD', '1', '19', '120', null, '156290', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3680', '201030631350', '刘汝甜', '61bdc3efdd1acb30345719ddb6bf23f9579c46a2', null, null, 'ROLE_STD', '1', '19', '120', null, '156291', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3681', '201030630889', '李雳', '25a19fdf0152cfcc879d0d6303d0c51e89508fd9', null, null, 'ROLE_STD', '1', '19', '120', null, '156292', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3682', '201030632814', '曾昭婷', '310983bf808fcc7d3705a2773776ea140d75f4bc', null, null, 'ROLE_STD', '1', '19', '120', null, '156293', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3683', '201030633262', '朱鹏', '2fe0e0af4ba759528b2b225985013124f256283a', null, null, 'ROLE_STD', '1', '19', '120', null, '156294', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3684', '201030630872', '李凯', '877eb9c39543a78d4c4a9c9592387e0e96f0d646', null, null, 'ROLE_STD', '1', '19', '120', null, '156295', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3685', '201030631473', '罗嘉浚', 'f57bef9a81ae3c743b16a04e0d3f2f52fe6ae579', null, null, 'ROLE_STD', '1', '19', '120', null, '156296', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3686', '201030631848', '陶超前', '035ad3630b04d663e10337a0810ed337c27acf59', null, null, 'ROLE_STD', '1', '19', '120', null, '156297', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3687', '201030630063', '常永耘', '08cf4008b98a9ab6e276d119e6c3e02145c7bcfa', null, null, 'ROLE_STD', '1', '19', '120', null, '156298', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3688', '201030631572', '潘恬怡', '9b5a89bf6c3707e48f8476b90850913f90eaf0ef', null, null, 'ROLE_STD', '1', '19', '120', null, '156299', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3689', '201030631053', '李旭冉', 'd2b93046e8cf6ff70f5d445f32ec17e10c9863b0', null, null, 'ROLE_STD', '1', '19', '120', null, '156300', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3690', '201030633170', '钟学强', 'd74eaa490c09921ba7a65c839183705e3ada2470', null, null, 'ROLE_STD', '1', '19', '120', null, '156301', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3691', '201030630018', '柏杨', '0792ba157655b7fb13ca5c9defefdfa3d408223c', null, null, 'ROLE_STD', '1', '19', '120', null, '156302', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3692', '201030633194', '周高昌', '9bf3b3d72d74d357ae0597219d6d02e0fe7967e4', null, null, 'ROLE_STD', '1', '19', '120', null, '156303', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3693', '201030633033', '张伟豪', '88459f45c39458cfaba94ab2e1f9e4af5a425aec', null, null, 'ROLE_STD', '1', '19', '120', null, '156304', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3694', '201030630896', '李明东', 'cfc6a604905856337c201f7f4355d96872a1829b', null, null, 'ROLE_STD', '1', '19', '120', null, '156305', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3695', '201030631855', '陶升奇', '1b0622acda7685dbe23e18826cf78b60e70daf98', null, null, 'ROLE_STD', '1', '19', '120', null, '156306', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3696', '201030630674', '黄一君', '64cca010feb0911b2877def7aec8442c582acf91', null, null, 'ROLE_STD', '1', '19', '120', null, '156307', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3697', '201030631169', '梁澍', 'e1fcf9632631205884e709d2edb0c0ede51c2da2', null, null, 'ROLE_STD', '1', '19', '120', null, '156308', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3698', '201030631428', '卢剑锋', '38a75e24bc93e99526332556c30968b904165a6c', null, null, 'ROLE_STD', '1', '19', '120', null, '156309', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3699', '201030631770', '谭宇飞', '10b86feaf81b1dab515a7737c8c98e4cb224afe8', null, null, 'ROLE_STD', '1', '19', '120', null, '156310', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3700', '201030631718', '苏恺淇', '23bc84d9000f57a66285ade637e2bb0ca1ba15c9', null, null, 'ROLE_STD', '1', '19', '120', null, '156311', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3701', '201030633026', '张顺', '639621b011d31693ca8930ff0132486f1b85acb5', null, null, 'ROLE_STD', '1', '19', '120', null, '156312', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3702', '201030632807', '曾越凡', 'b835fb2cdaeae230fcf54f2c61738be90ff2205a', null, null, 'ROLE_STD', '1', '19', '120', null, '156313', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3703', '201030631831', '唐智炜', '04c98de51e58612948721c124b58c0ceef5a30ed', null, null, 'ROLE_STD', '1', '19', '120', null, '156314', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3704', '201030630070', '车鹏云', 'b3c5047914f467cc0211bd56b442b7df890fb40e', null, null, 'ROLE_STD', '1', '19', '120', null, '156315', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3705', '201030630865', '李靖楠', '56c884e7e9afadcde28fe3a3fc308c9c096b5abb', null, null, 'ROLE_STD', '1', '19', '120', null, '156316', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3706', '201030630025', '蔡礼权', '22e09d58d55558fd047fa91d83c3092e7acb8ce9', null, null, 'ROLE_STD', '1', '19', '120', null, '156317', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3707', '201030631763', '谭德昆', '4ee76da0ddd9f45d19bc7730bd1421e0b8ac1c8f', null, null, 'ROLE_STD', '1', '19', '120', null, '156318', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3708', '201030631299', '刘冠圣', '851196538ea9ab5c4522fbee0f92e5f6df390b97', null, null, 'ROLE_STD', '1', '19', '120', null, '156319', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3709', '201030630254', '程凯', '43c40ff049c6bccdf4a93f367e82ae6eedf1c095', null, null, 'ROLE_STD', '1', '19', '120', null, '156320', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3710', '201030633118', '郑立柯', '0e2141b5648283b8bb8c38e035a0d27244af5e27', null, null, 'ROLE_STD', '1', '19', '120', null, '156321', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3711', '201030632562', '杨金沣', '4c328b966587579338824fa11ab93385b21df96c', null, null, 'ROLE_STD', '1', '19', '120', null, '156322', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3712', '201030633279', '庄灿杰', '8280d240dff51a006512df2da973ce2f2becee22', null, null, 'ROLE_STD', '1', '19', '120', null, '156323', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3713', '201030630247', '陈哲', 'f9faa43cb52bc25e8b9c954a35a7ac8782767864', null, null, 'ROLE_STD', '1', '19', '120', null, '156324', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3714', '201030633163', '郑子木', 'c49215489f2b1b35d1ad43933b870a89a3785c85', null, null, 'ROLE_STD', '1', '19', '120', null, '156325', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3715', '201030630100', '陈垂耿', '094fe4ddad7e3ef58292644d1d707cd5611a3fdf', null, null, 'ROLE_STD', '1', '19', '120', null, '156326', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3716', '201030630599', '黄沛聪', '47bfeca0e5481f5a66ec110c308b9e8e30c0043f', null, null, 'ROLE_STD', '1', '19', '120', null, '156327', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3717', '201030630322', '冯敏丽', '03cc0d2b6abff273d4dc94acf302253fb71cc016', null, null, 'ROLE_STD', '1', '19', '120', null, '156328', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3718', '201030633101', '郑凯匀', '8a3692b0b8e312b1e203fa2107ca1adc6c435558', null, null, 'ROLE_STD', '1', '19', '120', null, '156329', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3719', '201030631138', '梁恩浩', 'b45dcdfcd2105760dbeb24bba1a61e0a96e66a3a', null, null, 'ROLE_STD', '1', '19', '120', null, '156330', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3720', '201030632647', '杨易', '44c4d6494184d1afb115610bcaa4daff77700a22', null, null, 'ROLE_STD', '1', '19', '120', null, '156331', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3721', '201030630780', '李拔飞', '090d674768ac8c8e3835071c353904a9b2d83a3a', null, null, 'ROLE_STD', '1', '19', '120', null, '156332', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3722', '201030631633', '饶峰', 'ed7883eb16b918f50d23ebbbb3d5ef86f7e25b81', null, null, 'ROLE_STD', '1', '19', '120', null, '156333', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3723', '201030631589', '庞博', '32c566834deb501aa8ea22c3928dd8245f470afc', null, null, 'ROLE_STD', '1', '19', '120', null, '156334', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3724', '201030632579', '杨俊江', 'fb32a1255af8c8df612d0ba84b2fa7fac451c6af', null, null, 'ROLE_STD', '1', '19', '120', null, '156335', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3725', '201030632722', '余丽雅', '30b4eb1685a312e3bf38caf053abba29e83c1605', null, null, 'ROLE_STD', '1', '19', '120', null, '156336', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3726', '201030631558', '聂四品', 'fc38c6543c50dcccac6a999d7fa284d35b43c4b4', null, null, 'ROLE_STD', '1', '19', '120', null, '156337', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3727', '201030631657', '沈建祥', '664206a0af2250d0fda94256217806af1975c609', null, null, 'ROLE_STD', '1', '19', '120', null, '156338', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3728', '201030631534', '牟帅', '665ec7f036d7ae979f64cdf1f9a4dacee9945b4e', null, null, 'ROLE_STD', '1', '19', '120', null, '156339', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3729', '201030632678', '姚浩荣', '300039e107c717cb84f88637df8854be1e5d3e23', null, null, 'ROLE_STD', '1', '19', '120', null, '156340', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3730', '201030630223', '陈远龙', '8db2ff8bbf3a5ea0f55ce53566dfb2e2f59ec86c', null, null, 'ROLE_STD', '1', '19', '120', null, '156341', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3731', '201030631077', '李昭玥', 'eb81dc746af5d818a915d47cc33a557fa90372b1', null, null, 'ROLE_STD', '1', '19', '120', null, '156342', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3732', '201030631497', '马楚海', '74f2d4eb2ee1760bd551e54312c795d7c713d586', null, null, 'ROLE_STD', '1', '19', '120', null, '156343', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3733', '201030630360', '韩兵兵', '5e82949ab7e5aedfdfa325a1a107055de9f4afa6', null, null, 'ROLE_STD', '1', '19', '120', null, '156344', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3734', '201030631886', '涂雅媞', 'bdf61728b718ce62aa3c834c839e54f0a5087fb4', null, null, 'ROLE_STD', '1', '19', '120', null, '156345', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3735', '201030632487', '徐永咏', '102ff524ef89834c7b00665e93d6e9cf6de44e50', null, null, 'ROLE_STD', '1', '19', '120', null, '156346', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3736', '201030630407', '何清', 'f8fcd35c1cab6e10c626ece47e2b037d81fbfb55', null, null, 'ROLE_STD', '1', '19', '120', null, '156347', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3737', '201030632876', '张启华', '36fcc11e8a3c6ec806888048633b6489d21c7d6f', null, null, 'ROLE_STD', '1', '19', '120', null, '156348', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3738', '201030630544', '黄华超', 'f385dc47dd769a40c493e98ba565e8822b0b39d1', null, null, 'ROLE_STD', '1', '19', '120', null, '156349', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3739', '201030631480', '罗伟', '73dbb2941efe87e00beef59d0b17b4523fd0b83e', null, null, 'ROLE_STD', '1', '19', '120', null, '156350', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3740', '201030630537', '黄海韵', '94511aeb226a0840415ff4f16b1e6ec561539299', null, null, 'ROLE_STD', '1', '19', '120', null, '156351', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3741', '201030631503', '马棉凯', 'd4c3e210958c8497f33b1e6e82ba41204e4a3199', null, null, 'ROLE_STD', '1', '19', '120', null, '156352', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3742', '201030632593', '杨涛', '5cb3660ea4d0094d57cc8c1da6cd14e75ab3bc9e', null, null, 'ROLE_STD', '1', '19', '120', null, '156353', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3743', '201030631220', '林成果', '9314c027798e4c79242c2aab7ab64c74c8a067c2', null, null, 'ROLE_STD', '1', '19', '120', null, '156354', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3744', '201030630681', '黄奕霖', '9d47ca0dd3cb3f78fa9caeb0bd5cdd105d0c3351', null, null, 'ROLE_STD', '1', '19', '120', null, '156355', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3745', '201030630810', '李聃', '3a49c86d539bec72e30d954404001c9ea5da8fec', null, null, 'ROLE_STD', '1', '19', '120', null, '156356', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3746', '201030630216', '陈奕燊', 'd3bbcea56482d0d2db9654e2a769db5e3bd0c377', null, null, 'ROLE_STD', '1', '19', '120', null, '156357', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3747', '201030631206', '廖永行', '84c531c9ac69b15f701b41f9d2aae0fbedde86af', null, null, 'ROLE_STD', '1', '19', '120', null, '156358', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3748', '201030630148', '陈磊光', '3f99816050a69d63c9acffc33fe72757c9fb4751', null, null, 'ROLE_STD', '1', '19', '120', null, '156359', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3749', '200930635017', '丁亮宇', 'd54f388f8bc4921555030f4746d15b8b01898d39', null, null, 'ROLE_STD', '1', '19', '120', null, '156360', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3750', '201030632586', '杨琦琦', 'ef7158d83b335eba311aa2ebb93ab860509a8c8e', null, null, 'ROLE_STD', '1', '19', '120', null, '156361', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3751', '201030633125', '郑鹏', '0a4cf9e5265fb18b6a965fbd30cb3fd58f4a4419', null, null, 'ROLE_STD', '1', '19', '120', null, '156362', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3752', '201030630551', '黄健彬', 'a22a8800bca1035a4aecdb3d1fc1e0e268375c0c', null, null, 'ROLE_STD', '1', '19', '120', null, '156363', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3753', '201030630506', '黄达彬', 'f28769e00857180cdde495787a79b8b93e490faf', null, null, 'ROLE_STD', '1', '19', '120', null, '156364', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3754', '201030632159', '文力', '2a63f7d5da0b054752c3e2d2577f64d8ca099192', null, null, 'ROLE_STD', '1', '19', '120', null, '156365', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3755', '201030630117', '陈迪豪', 'ea34ccdc0e82e25ab9a78daeab919ab79b9c3f5d', null, null, 'ROLE_STD', '1', '19', '120', null, '156366', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3756', '201030632821', '张国庆', 'e4ea30c80e5fe1ffe74943fb7785e6cb93a9848a', null, null, 'ROLE_STD', '1', '19', '120', null, '156367', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3757', '201030632081', '王永杰', 'cba7ae82130fe193be4117bd1c8b49994710156e', null, null, 'ROLE_STD', '1', '19', '120', null, '156368', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3758', '201030632616', '杨彦鑫', 'dc7687fbe4bb10bc6fd35eb0521d3ccc0b546df7', null, null, 'ROLE_STD', '1', '19', '120', null, '156369', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3759', '201030633095', '郑灿标', '0e4223343930b31ea77a402e8bbb6d0b5c60dfaa', null, null, 'ROLE_STD', '1', '19', '120', null, '156370', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3760', '201030633088', '张柱安', '8bdee28b8d0b711f878ccbdc00c7dbb28fe5578b', null, null, 'ROLE_STD', '1', '19', '120', null, '156371', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3761', '201030630346', '付志能', '6265c54a8edeca215d53681c56786320e6bd1739', null, null, 'ROLE_STD', '1', '19', '120', null, '156372', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3762', '201030632265', '吴铭荃', '032cf049ff34c47a07e091255fe52c7b1f8ef1ff', null, null, 'ROLE_STD', '1', '19', '120', null, '156373', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3763', '201030630575', '黄凯波', '5a8136af0666024b61c76f2e4735bad384a2dcff', null, null, 'ROLE_STD', '1', '19', '120', null, '156374', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3764', '201030632234', '吴健松', 'de16af11e87879f5c83405a593ce71ee8b8af87c', null, null, 'ROLE_STD', '1', '19', '120', null, '156375', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3765', '201030633057', '张宇乾', 'a483cc3802aba710ae13dfd24a310532f998fe8e', null, null, 'ROLE_STD', '1', '19', '120', null, '156376', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3766', '201030632142', '温文希', '25c02f526f7dddece17de941cfab4d04f265fd55', null, null, 'ROLE_STD', '1', '19', '120', null, '156377', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3767', '201030632425', '谢悦鸿', '3b7723f8466276ee607d9f0f12488aa311c95056', null, null, 'ROLE_STD', '1', '19', '120', null, '156378', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3768', '201030630209', '陈奕男', '974987d2dbd77e9d85ed7e2f9d34b62f5db62452', null, null, 'ROLE_STD', '1', '19', '120', null, '156379', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3769', '201030632401', '谢晓超', 'c2ed51d2a851d74e98735c3edf2dae3f2ffcda00', null, null, 'ROLE_STD', '1', '19', '120', null, '156380', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3770', '201030633064', '张云帆', 'adc7fc8415120b840db4d63609458e8eec33d4f2', null, null, 'ROLE_STD', '1', '19', '120', null, '156381', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3771', '201030630568', '黄俊坤', '2bf5a787b52aac0e2ea523a8d6d6d77f5ae14b5c', null, null, 'ROLE_STD', '1', '19', '120', null, '156382', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3772', '201030632111', '王臻', '3313214fa757b441c335cf911903e50e42100b47', null, null, 'ROLE_STD', '1', '19', '120', null, '156383', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3773', '201030632388', '谢盼', 'b604e112bbce50171576a4dcb664d841af15fa77', null, null, 'ROLE_STD', '1', '19', '120', null, '156384', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3774', '201030632104', '王泽林', '22ab34c39544885d9cf494cca8aea70075283cfb', null, null, 'ROLE_STD', '1', '19', '120', null, '156385', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3775', '201030630308', '邓超', '46437e55af0a0738088190005f07ffd60156d294', null, null, 'ROLE_STD', '1', '19', '120', null, '156386', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3776', '201030632296', '吴永健', '9def22e44138e836155dbd98367c0cfa8fe2be9f', null, null, 'ROLE_STD', '1', '19', '120', null, '156387', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3777', '201030630421', '何武勋', 'f75eefb2a733c8341029aa49ebb1667074ddeef4', null, null, 'ROLE_STD', '1', '19', '120', null, '156388', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3778', '201030631121', '梁楚华', '5364b407281e4f92d912f0339ca434dc188079f4', null, null, 'ROLE_STD', '1', '19', '120', null, '156389', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3779', '201030630827', '李翰林', '764274551ca67465fcbeb649baa7defb0ebb8564', null, null, 'ROLE_STD', '1', '19', '120', null, '156390', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3780', '201030632432', '谢泽勇', '871920359edf240a467efb681357b2a0c408d793', null, null, 'ROLE_STD', '1', '19', '120', null, '156391', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3781', '201030630858', '李宏飞', '6762d4a8d85bdad903929030bff415c64a690bf3', null, null, 'ROLE_STD', '1', '19', '120', null, '156392', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3782', '201030632128', '王振强', '24ac0b64e9fda5187fe5114311d843982a2c727b', null, null, 'ROLE_STD', '1', '19', '120', null, '156393', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3783', '201030630162', '陈骞', '561b86623efdbcd9aa1dad7b4f45acf338e46491', null, null, 'ROLE_STD', '1', '19', '120', null, '156394', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3784', '201030631114', '利广杰', 'de44f3b252cd8ef495357e1b2b57444c0840484d', null, null, 'ROLE_STD', '1', '19', '120', null, '156395', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3785', '201069992279', 'chui chiang vitor', '85ba93d50446445b237d3e812706904ba7dfa879', null, null, 'ROLE_STD', '1', '19', '120', null, '156396', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3786', '201030631022', '李伟', 'edd98615a9cf35bcee99ff0544d03b6df7ba4fb6', null, null, 'ROLE_STD', '1', '19', '120', null, '156397', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3787', '201030630759', '揭勍', 'd2225799e3c7b0943b5414714153819bc1b675ed', null, null, 'ROLE_STD', '1', '19', '120', null, '156398', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3788', '201030633200', '周宏宇', 'a82f4622d907dd1f62afeee4a40454ef1e8d06f4', null, null, 'ROLE_STD', '1', '19', '120', null, '156399', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3789', '201030631404', '龙鹏飞', 'fbf5b91cb66430ce66e37ba17fbe34120016be4b', null, null, 'ROLE_STD', '1', '19', '120', null, '156400', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3790', '201030631442', '路程', '71b446068255cebc21c37676e652d287de69fa32', null, null, 'ROLE_STD', '1', '19', '120', null, '156401', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3791', '201030630711', '黄卓健', '761454ff9a5978a02a04b9ff81f3b1596128eb73', null, null, 'ROLE_STD', '1', '19', '120', null, '156402', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3792', '201030633231', '周泽栩', '5f654f7d7feb4ae320176ee039f237a0787388e4', null, null, 'ROLE_STD', '1', '19', '120', null, '156403', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3793', '201030632883', '张三华', '0a73a07eac07e491dbd6f602940d3ca1507106d0', null, null, 'ROLE_STD', '1', '19', '120', null, '156404', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3794', '201030630742', '焦晴阳', 'd69ae68a4caa0307b6c2d7bb435ce2fbac81869e', null, null, 'ROLE_STD', '1', '19', '120', null, '156405', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3795', '201030631275', '林泽腾', '2d741433bca6271cfbfcea3bb7eacfddb57ab054', null, null, 'ROLE_STD', '1', '19', '120', null, '156406', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3796', '201030631398', '刘子星', '5a989541b88d932503c51987f635d0f5692e5858', null, null, 'ROLE_STD', '1', '19', '120', null, '156407', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3797', '201030632500', '许威', '9590414dbae62f3ee88c8fca4adb7870b2f457b6', null, null, 'ROLE_STD', '1', '19', '120', null, '156408', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3798', '201030631190', '梁振宇', 'ba72971f2e9251bb979328f0e051677e7d56eae7', null, null, 'ROLE_STD', '1', '19', '120', null, '156409', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3799', '201030630704', '黄智广', 'a47cf15b15d66e7c26fa0521933ebafdfd0857bd', null, null, 'ROLE_STD', '1', '19', '120', null, '156410', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3800', '201030631466', '罗辑', '8122ef711354b1898cdb8593199fd4f566a13fa2', null, null, 'ROLE_STD', '1', '19', '120', null, '156411', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3801', '201030631411', '卢宝龙', 'c78a1c9b72e2b07102a0137ee54dfa1c2ad3601e', null, null, 'ROLE_STD', '1', '19', '120', null, '156412', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3802', '201030631039', '李文文', 'cfc8f7d225e095899b41051107ced176134032f4', null, null, 'ROLE_STD', '1', '19', '120', null, '156413', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3803', '201030632241', '吴金炮', '374de35af0203e6c5b9f52aa25ef6ea905aa4b1b', null, null, 'ROLE_STD', '1', '19', '120', null, '156414', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3804', '201030632289', '吴锡霖', 'bc5e89c043d38d19cdb90b52ef847d486cb8b1d1', null, null, 'ROLE_STD', '1', '19', '120', null, '156415', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3805', '201030630490', '胡月', '4dc2a1ff614dca5cc827186cfed979a22021bf21', null, null, 'ROLE_STD', '1', '19', '120', null, '156416', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3806', '201030632166', '翁海琴', '83c777de53241e0cd958d9b862c67602939053ae', null, null, 'ROLE_STD', '1', '19', '120', null, '156417', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3807', '201030630094', '陈波祺', '7ad2f2a4aaa07f71b28060ebd1a000c766461c3e', null, null, 'ROLE_STD', '1', '19', '120', null, '156418', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3808', '201030632906', '张双燕', 'f6e3cf3d6c87ee504f84fc2054510465f4432452', null, null, 'ROLE_STD', '1', '19', '120', null, '156419', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3809', '201030632760', '袁阳', 'fe10d217ac66131cde8a3190dfe3dfc668415dc9', null, null, 'ROLE_STD', '1', '19', '120', null, '156420', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3810', '201030631756', '覃嘉敏', '15de15634938aa7d36ae0b8ca96c0003bfdcc086', null, null, 'ROLE_STD', '1', '19', '120', null, '156421', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3811', '201030631152', '梁国超', '08cc8238cf360fdcaefc0b2c74efa28f839318a4', null, null, 'ROLE_STD', '1', '19', '120', null, '156422', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3812', '201030630414', '何伟滔', '5035a8feb33764c8ef30a84a6d5504e773fcb3b3', null, null, 'ROLE_STD', '1', '19', '120', null, '156423', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3813', '201030630643', '黄鑫龙', '2955f0b2598518f45c3a260936671f6623c8743d', null, null, 'ROLE_STD', '1', '19', '120', null, '156424', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3814', '201030631435', '陆海杰', '5a319f98d7c0b76be816d4ec04a49654a3d81a94', null, null, 'ROLE_STD', '1', '19', '120', null, '156425', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3815', '201030630766', '孔令南', 'b8da4099e414c26c26bac11cec7289c3b895eda5', null, null, 'ROLE_STD', '1', '19', '120', null, '156426', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3816', '201030632470', '徐威迪', 'ba21dbacc3d0e53f399529cfeaad2221d8153df3', null, null, 'ROLE_STD', '1', '19', '120', null, '156427', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3817', '201030631879', '田立慧', '2da85791215dfa376faed05021a7aee4c6eb45e1', null, null, 'ROLE_STD', '1', '19', '120', null, '156428', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3818', '201030632227', '吴佳祥', 'b8c776085c9cf738fe7e2316e3fcd35f5dce87ec', null, null, 'ROLE_STD', '1', '19', '120', null, '156429', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3819', '201030630698', '黄振华', '597c0debabe2acd5909b86cd1f2b011a179fc15b', null, null, 'ROLE_STD', '1', '19', '120', null, '156430', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3820', '201030631459', '吕俊毅', '4cfb26b70cde3ac82c8d582f1661baf1b43d486c', null, null, 'ROLE_STD', '1', '19', '120', null, '156431', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3821', '201030632548', '杨波尼', 'c6cc5371f9cedad21fae92944d86f6a667fbad29', null, null, 'ROLE_STD', '1', '19', '120', null, '156432', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3822', '201030631800', '唐纳文', '2b71c54bea8ca0dc6823072a6c22be093399def9', null, null, 'ROLE_STD', '1', '19', '120', null, '156433', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3823', '201030632357', '萧远秀', 'a1287c7a3208ad23664647e5f944e613391a92bf', null, null, 'ROLE_STD', '1', '19', '120', null, '156434', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3824', '201030631688', '双嘉岐', '8f84653b7073806a9aa3fc73b2a087b8430c3b87', null, null, 'ROLE_STD', '1', '19', '120', null, '156435', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3825', '201030630728', '霍志权', 'f51c2ad6d7bfb34b1caf4912506d33839293dfca', null, null, 'ROLE_STD', '1', '19', '120', null, '156436', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3826', '201030631145', '梁桂著', '100c18724b3cc421811c0c21e18401e3de564fe5', null, null, 'ROLE_STD', '1', '19', '120', null, '156437', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3827', '201030632272', '吴荣鑫', '60a321036d61cc80aa57715fc8f072560121d8f3', null, null, 'ROLE_STD', '1', '19', '120', null, '156438', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3828', '201030632555', '杨辉', '1bcfeda9eb25257f2cfd9724296e636bceedde91', null, null, 'ROLE_STD', '1', '19', '120', null, '156439', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3829', '201030632043', '王希', 'f9487340e6f162577cfabb7316a23999a20511ec', null, null, 'ROLE_STD', '1', '19', '120', null, '156440', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3830', '200930636342', '孟俊宇', '7ec0d5966d34880962c6db131b9377eba2d84359', null, null, 'ROLE_STD', '1', '19', '120', null, '156441', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3831', '200930632283', '徐一川', 'a762416ea767d3a981082bac4e89e667e2418594', null, null, 'ROLE_STD', '1', '19', '120', null, '156442', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3832', '201030632036', '王文杰', 'fa9dd8f8be2e926c54d1764a7454105b1fe6b1b4', null, null, 'ROLE_STD', '1', '19', '120', null, '156443', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3833', '201030631909', '王传鹏', '7adcbd84be8dd8491a7fd21e66d899bc066c6920', null, null, 'ROLE_STD', '1', '19', '120', null, '156444', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3834', '201030631701', '苏汉霖', '66e878e4f67b055265a6e816850e7c1bc1d071ab', null, null, 'ROLE_STD', '1', '19', '120', null, '156445', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3835', '201030631619', '邱旭东', 'ae4594e82941b65ee307728dad95846c61f02f99', null, null, 'ROLE_STD', '1', '19', '120', null, '156446', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3836', '201030631596', '彭章', '80cf712f2a2a08f8416affd667693ac5f8a6dca6', null, null, 'ROLE_STD', '1', '19', '120', null, '156447', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3837', '201030632777', '袁永匡', 'c936387b744626ac7341fbeb83a14498fe5c2161', null, null, 'ROLE_STD', '1', '19', '120', null, '156448', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3838', '201030631381', '刘宇', '6709a28949fd4082e3feaf8f2026e0b15de701cb', null, null, 'ROLE_STD', '1', '19', '120', null, '156449', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3839', '201030632715', '余锦德', '452337aa0d4f462b639049fcd6cd19ccc2745785', null, null, 'ROLE_STD', '1', '19', '120', null, '156450', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3840', '201030631237', '林浩楠', '82b54037907c7bc7ce7b3d88aaeadc1161855262', null, null, 'ROLE_STD', '1', '19', '120', null, '156451', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3841', '201030631213', '林斌', '9cb63401d7642082dffce7c19baa8be8c93fab5c', null, null, 'ROLE_STD', '1', '19', '120', null, '156452', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3842', '201030631527', '牟波', 'dbdd863b2d7347353dd7764d76de0b515826dce9', null, null, 'ROLE_STD', '1', '19', '120', null, '156453', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3843', '201030631244', '林世杭', 'b18080f41074d2885bf8f563c1998203ebdfe408', null, null, 'ROLE_STD', '1', '19', '120', null, '156454', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3844', '201030631671', '史焕强', '30bf20e5327eac7ff4efaf7ad647f215ad877bdb', null, null, 'ROLE_STD', '1', '19', '120', null, '156455', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3845', '201030631664', '石锐', 'c8e1b83552e3f1094c9e66bd5e3e9d58bc3643f5', null, null, 'ROLE_STD', '1', '19', '120', null, '156456', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3846', '201030631640', '邵冠云', '6983cb6452d2b7ec54bef323ae715db1eef5e4f0', null, null, 'ROLE_STD', '1', '19', '120', null, '156457', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3847', '201130631038', '顾润丰', '7af0d8a8f446654fc1a8d3a2816485c05737f72a', null, null, 'ROLE_STD', '1', '19', '120', null, '156458', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3848', '201130634381', '谢伟锋', '2fe59e502add8d90d84760e2306636a74010b0b9', null, null, 'ROLE_STD', '1', '19', '120', null, '156459', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3849', '201130630369', '陈梓豪', '5aefea8084996f580c2f2291ee9e3eebc86b1c95', null, null, 'ROLE_STD', '1', '19', '120', null, '156460', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3850', '201130631441', '姜宝杰', '4d31e22f856e5b00447463b10e45164840220b30', null, null, 'ROLE_STD', '1', '19', '120', null, '156461', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3851', '201130631083', '韩建桥', 'f49ff9ffb2273e98f83a4437af57c67cd4459b65', null, null, 'ROLE_STD', '1', '19', '120', null, '156462', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3852', '201130634169', '王智强', 'b55f78d7f1817fdfdaaa90f3d1941239c4d49aec', null, null, 'ROLE_STD', '1', '19', '120', null, '156463', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3853', '201136631391', '黄译萱', 'ab28a9206a5f779c2d08aba71e7596436fde9f7b', null, null, 'ROLE_STD', '1', '19', '120', null, '156464', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3854', '201130632110', '李家健', '8f16e5a2c55bf4026d362cf27ee7a647768a8d6f', null, null, 'ROLE_STD', '1', '19', '120', null, '156465', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3855', '201130631298', '胡舒悦', '607d573c1c5ab239d9b765c902e5b9bfd2772d7c', null, null, 'ROLE_STD', '1', '19', '120', null, '156466', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3856', '201130633407', '邱先科', '42dde8a205f49273d38d98ec97f2e48c63d7ecad', null, null, 'ROLE_STD', '1', '19', '120', null, '156467', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3857', '201130630321', '陈志誉', '71a97a403e63475199d911f4656c4883a47041eb', null, null, 'ROLE_STD', '1', '19', '120', null, '156468', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3858', '201130630116', '陈丹旎', 'b4af8af614e7d178f991c0c4c08c2910aac42174', null, null, 'ROLE_STD', '1', '19', '120', null, '156469', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3859', '201130633148', '卢杨威', '73fb985049ca42936461b780fd22b6f6e4a411a8', null, null, 'ROLE_STD', '1', '19', '120', null, '156470', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3860', '201130634282', '吴苏智', '9939f9ec9e412c7f1b9eb8587a1d8c0cd92b2d32', null, null, 'ROLE_STD', '1', '19', '120', null, '156471', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3861', '201130635364', '周建衡', '8a7f8bcf9e4672c60919fa431879766480940399', null, null, 'ROLE_STD', '1', '19', '120', null, '156472', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3862', '201130631380', '黄涛', '929d0a92fe0b51726fffbc5027dcfd7e90a6230e', null, null, 'ROLE_STD', '1', '19', '120', null, '156473', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3863', '201130633421', '史斌心', '9d33b9b265c9c74ad3530ac436beaf160f510035', null, null, 'ROLE_STD', '1', '19', '120', null, '156474', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3864', '201130630239', '陈诗云', '0ae825f241d80408c60715de7f447cdab3e318e1', null, null, 'ROLE_STD', '1', '19', '120', null, '156475', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3865', '201130634251', '吴方杰', '0709ddeedee3c7bece7c1da981c6a63c364afd09', null, null, 'ROLE_STD', '1', '19', '120', null, '156476', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3866', '201130633131', '龙泉', 'a6400b8b57f962fb10a0345f0c4094bc68745d0a', null, null, 'ROLE_STD', '1', '19', '120', null, '156477', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3867', '201130634213', '翁耿森', 'e152fd6dd3de66ec95ba9cb183e3ca73b7fafb54', null, null, 'ROLE_STD', '1', '19', '120', null, '156478', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3868', '201130635289', '郑俊伟', 'eb03f1eeec99c13faedb360778d192b99f5be740', null, null, 'ROLE_STD', '1', '19', '120', null, '156479', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3869', '201130635159', '张浩扬', 'e973834ffb3477a8add438a59ee4dc4d2f3d31ac', null, null, 'ROLE_STD', '1', '19', '120', null, '156480', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3870', '201130633483', '苏裕贤', '95e46a527d50f04bdc0a0ed317924c0dbc52b585', null, null, 'ROLE_STD', '1', '19', '120', null, '156481', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3871', '201130631182', '何玉宇', 'be176cd5134cdc6b49cfe0e975bbbb81e6b446b8', null, null, 'ROLE_STD', '1', '19', '120', null, '156482', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3872', '201130630260', '陈雄', 'b56a560819611c0241ac028a461eca94ee45840c', null, null, 'ROLE_STD', '1', '19', '120', null, '156483', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3873', '201130635463', '冼业强', '1257b0fa124de2faf7b55c92c74c94c789205666', null, null, 'ROLE_STD', '1', '19', '120', null, '156484', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3874', '201130630048', '蔡文强', 'ff73bcd3bc0a423a014cb401f0ddc5765d2b51de', null, null, 'ROLE_STD', '1', '19', '120', null, '156485', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3875', '201130633230', '马浩斌', '94bc9b67820658477d629cad29f622929a897512', null, null, 'ROLE_STD', '1', '19', '120', null, '156486', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3876', '201130635326', '钟帝送', '4a5c1c2b2fee091bbfe90c02b606911cb40b07fc', null, null, 'ROLE_STD', '1', '19', '120', null, '156487', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3877', '201130632264', '李奕森', '598cc52daa1fc02afbd8779ebfa5cabbe877258c', null, null, 'ROLE_STD', '1', '19', '120', null, '156488', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3878', '201130631045', '关帝超', '492759910fc821deb719b9279e1a03f124c53194', null, null, 'ROLE_STD', '1', '19', '120', null, '156489', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3879', '201130632288', '梁海伦', '36301375d2bacb1adc7072d80520955da59db302', null, null, 'ROLE_STD', '1', '19', '120', null, '156490', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3880', '201130631113', '何俊朗', '17773e577cf9a610c6a581c5691e7df0db8115dc', null, null, 'ROLE_STD', '1', '19', '120', null, '156491', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3881', '201130631458', '江先毅', '08e3dadfa2f98118a161aa2f42dd38595e38455c', null, null, 'ROLE_STD', '1', '19', '120', null, '156492', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3882', '201130632301', '梁文华', 'cdc3581e37403bed5624e9d91af79e8479241ec9', null, null, 'ROLE_STD', '1', '19', '120', null, '156493', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3883', '201130631496', '赖金明', 'b0eac4228a247e0a278dbfb88c17e8d4bc9cb9e3', null, null, 'ROLE_STD', '1', '19', '120', null, '156494', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3884', '201130630413', '邓高翔', '7171773f81c41e6da79ce08fe25aa7ee4c1b5724', null, null, 'ROLE_STD', '1', '19', '120', null, '156495', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3885', '201130633360', '乔健', 'b52361984e2799f1f950505e77b6e549bb6a6dc9', null, null, 'ROLE_STD', '1', '19', '120', null, '156496', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3886', '201130631304', '胡友成', '03bfbd6626600e1583989158dce770f1caaf1603', null, null, 'ROLE_STD', '1', '19', '120', null, '156497', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3887', '201130631465', '江小洁', '26b174728b4e200ca3894b974f6b2fe7e0583dea', null, null, 'ROLE_STD', '1', '19', '120', null, '156498', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3888', '201130633261', '马松添', '0c3fc567d7125f91b86d319a6b6641eaf29603df', null, null, 'ROLE_STD', '1', '19', '120', null, '156499', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3889', '201130634367', '肖凡杰', '8b0919f26bc35f8e7345c4d1be91df9230edc3bc', null, null, 'ROLE_STD', '1', '19', '120', null, '156500', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3890', '201130631274', '胡东风', 'b8d3eec4d0612e5f78dba7b7ea652a0dbe065ac8', null, null, 'ROLE_STD', '1', '19', '120', null, '156501', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3891', '201130633124', '刘子豪', '4bf3e0b11d297e86d1e48a2244f83e9954f98095', null, null, 'ROLE_STD', '1', '19', '120', null, '156502', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3892', '201130632028', '黎灿', '0a07e7d4e4bec66c9c76aae2b5323a5de6d65809', null, null, 'ROLE_STD', '1', '19', '120', null, '156503', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3893', '201130633193', '罗佳妮', 'b0b8804d7c11d4283646b6fde37e5b9a429ec5d1', null, null, 'ROLE_STD', '1', '19', '120', null, '156504', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3894', '201130633087', '刘迅源', 'd6eb7a4ad92fd41c52f23bd853ab279b4c32a708', null, null, 'ROLE_STD', '1', '19', '120', null, '156505', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3895', '201130632189', '李炎', 'c9a496d171e667e0ee4f357b0b8b378042ea4b14', null, null, 'ROLE_STD', '1', '19', '120', null, '156506', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3896', '201130633278', '麦海潮', 'f6b8c0f6e147852126281c18c1d252f23695fe37', null, null, 'ROLE_STD', '1', '19', '120', null, '156507', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3897', '201130630420', '邓坤力', '736ed2c95884a7517cc005e2040d85feadb93b38', null, null, 'ROLE_STD', '1', '19', '120', null, '156508', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3898', '201130635098', '曾荣基', 'd49589568139395ca63bc8e4f56cd089054a6186', null, null, 'ROLE_STD', '1', '19', '120', null, '156509', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3899', '201130634398', '谢晓佳', 'ae14ae2a7e832726a8187bf1bb06aae3414a3a5b', null, null, 'ROLE_STD', '1', '19', '120', null, '156510', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3900', '201130634237', '吴炳伸', 'f319fd415b7f90909fdc7f77b02f2e8f3f89062d', null, null, 'ROLE_STD', '1', '19', '120', null, '156511', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3901', '201130630161', '陈航', '855644172049e07f19982e872fa97b38cb93f2b4', null, null, 'ROLE_STD', '1', '19', '120', null, '156512', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3902', '201130634336', '夏磊', '12db28d58b5da0b753d34f45fc264f9608b37524', null, null, 'ROLE_STD', '1', '19', '120', null, '156513', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3903', '201130634084', '王海彬', 'db811f800fb3c20c535f8f3a382b51c1cad3e7a6', null, null, 'ROLE_STD', '1', '19', '120', null, '156514', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3904', '201130634060', '田卓俊', 'f46d18ea34f3662745a12004acd30f3780d67318', null, null, 'ROLE_STD', '1', '19', '120', null, '156515', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3905', '201130633476', '苏莹子', '0c6e34e8376ca0ae793be2494b937bb9b090af84', null, null, 'ROLE_STD', '1', '19', '120', null, '156516', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3906', '201130631427', '纪嘉祥', 'cf5d4e7831d3e983f66cdcdfe8fd1557f318da00', null, null, 'ROLE_STD', '1', '19', '120', null, '156517', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3907', '201130630017', '毕俊彦', '2aabc0f8a366525c0e64daa7f9e63bc6c1cc9cf1', null, null, 'ROLE_STD', '1', '19', '120', null, '156518', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3908', '201130630277', '陈雅琳', '64986c87044aa9a13b743128a10d40cfff87f77b', null, null, 'ROLE_STD', '1', '19', '120', null, '156519', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3909', '201130633346', '彭成墙', '129246a2d895192467e771b14560f88260b04a6f', null, null, 'ROLE_STD', '1', '19', '120', null, '156520', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3910', '201130634015', '谭柏康', 'fa3e660001a4c0853964c8868ba2003787039434', null, null, 'ROLE_STD', '1', '19', '120', null, '156521', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3911', '201130632271', '梁海滨', '2012db8e0784e048415c5d38adb5ef5b9204c3ea', null, null, 'ROLE_STD', '1', '19', '120', null, '156522', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3912', '201130632356', '廖仲鑫', 'a3eeeaefa7de3c08dc37dfa644fa904abddc7f16', null, null, 'ROLE_STD', '1', '19', '120', null, '156523', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3913', '201130634428', '徐维业', 'f59b61653afae66fe10bcab5f8bd8dadbc272b08', null, null, 'ROLE_STD', '1', '19', '120', null, '156524', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3914', '201130632325', '廖飞', 'ad8cc8c7313e3de9fd819e7ceeb8bb98745629e9', null, null, 'ROLE_STD', '1', '19', '120', null, '156525', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3915', '201130632080', '李成凤', '997c958a189205a1854bccd84ea92caaecf13cf2', null, null, 'ROLE_STD', '1', '19', '120', null, '156526', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3916', '201136633104', '刘泳安', '7b8ea386834563ff7b61518128355c5d804df81e', null, null, 'ROLE_STD', '1', '19', '120', null, '156527', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3917', '201130635494', '栾昊原', '42a59eaedc046c008c1139f962195314c3414bd8', null, null, 'ROLE_STD', '1', '19', '120', null, '156528', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3918', '201130631281', '胡梦非', 'ec7ba732d69522a8a16137bce99a5776cf8954ab', null, null, 'ROLE_STD', '1', '19', '120', null, '156529', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3919', '201130635036', '叶喜', 'f41a96b5cfe8c8bab57a7a4b528a0a9d23075c22', null, null, 'ROLE_STD', '1', '19', '120', null, '156530', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3920', '201130630192', '陈俊生', '1002679f6a0ffa189d10ccea3becbd39b4ed0020', null, null, 'ROLE_STD', '1', '19', '120', null, '156531', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3921', '201130630086', '巢启聪', '666b58480b8325765c99e1d783ffe566571108bb', null, null, 'ROLE_STD', '1', '19', '120', null, '156532', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3922', '201130631090', '韩蕊', 'c9172e3bf00bc018800668275cfa1459695c95bd', null, null, 'ROLE_STD', '1', '19', '120', null, '156533', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3923', '201130632424', '林若谷', '89d10850e725822ac12e7dad6f592471c059661d', null, null, 'ROLE_STD', '1', '19', '120', null, '156534', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3924', '201130635319', '郑鑫', '1f2f07860678a68e127c235055e2e4d08843b89c', null, null, 'ROLE_STD', '1', '19', '120', null, '156535', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3925', '201130632127', '李可夫', '3656a73b320891ead4db5b45422b5b897f2a4a99', null, null, 'ROLE_STD', '1', '19', '120', null, '156536', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3926', '201130630079', '曹梓宏', '1fa4f2ef09bf5ffa33b58387ae83efd4c6623747', null, null, 'ROLE_STD', '1', '19', '120', null, '156537', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3927', '201130633162', '陆荣扬', '188370dd601c7c44feb9ebedf74c3732a13de261', null, null, 'ROLE_STD', '1', '19', '120', null, '156538', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3928', '201130635388', '周泉', '9107c6e595afd0ee47d3a669e763467266a03f34', null, null, 'ROLE_STD', '1', '19', '120', null, '156539', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3929', '201130632462', '林正平', 'd588796313e09abf0238eadf6f736f8ad75d4cde', null, null, 'ROLE_STD', '1', '19', '120', null, '156540', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3930', '201130630253', '陈晓颖', 'f31f022f2180b27f125c8efbfe1e840ae0e60a14', null, null, 'ROLE_STD', '1', '19', '120', null, '156541', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3931', '201130631052', '郭聪颖', '69a89fdec2fc05724d03b183b58769f2cac4ad2f', null, null, 'ROLE_STD', '1', '19', '120', null, '156542', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3932', '201130635128', '张弛', '4b0c82ab05c915804a0e773f3fe87999587ca535', null, null, 'ROLE_STD', '1', '19', '120', null, '156543', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3933', '201130635449', '朱未翔', '4a4b5f1815e5c8271d36793fba77dee49b191662', null, null, 'ROLE_STD', '1', '19', '120', null, '156544', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3934', '201130634275', '吴孟灿', '0e5328201b23242c1546e3e7c53cbaaab71591ab', null, null, 'ROLE_STD', '1', '19', '120', null, '156545', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3935', '201130634350', '萧伟杰', 'a9e79a0e84663ea7165e556b4cedb296d9e21ff9', null, null, 'ROLE_STD', '1', '19', '120', null, '156546', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3936', '201130632318', '梁淼荣', '170eb2d6e2fdea66c4d094a08978f290faf67e61', null, null, 'ROLE_STD', '1', '19', '120', null, '156547', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3937', '201130634459', '许文艺', 'a6cb1d5a44dc146ac615af0e38b36809968d7603', null, null, 'ROLE_STD', '1', '19', '120', null, '156548', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3938', '201030632623', '杨洋', '1568454d33d72f13860b4a9104ea4ba34de65426', null, null, 'ROLE_STD', '1', '19', '120', null, '156549', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3939', '201030630377', '何杰', '978db8e47ed3883817c469a4dbaa0f04e512931d', null, null, 'ROLE_STD', '1', '19', '120', null, '156550', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3940', '201130630406', '邓德荣', '2ca9281cb8c017a5d0fc54235fb0a5728bdf7f22', null, null, 'ROLE_STD', '1', '19', '120', null, '156551', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3941', '201130633049', '刘钧鸿', '12178d444f29579d0c302cef908da8edba94648b', null, null, 'ROLE_STD', '1', '19', '120', null, '156552', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3942', '201130630062', '曹丽杰', 'd54668db94a2a678499451e7c4e224ac3fffcaea', null, null, 'ROLE_STD', '1', '19', '120', null, '156553', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3943', '201130632035', '黎矿维', 'f93b03e5da8327ff7ab2340945d8229ecf42d65a', null, null, 'ROLE_STD', '1', '19', '120', null, '156554', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3944', '201130635500', '覃宇韬', 'c58898a167aefde1ce3d689f5af6ac2656fe4087', null, null, 'ROLE_STD', '1', '19', '120', null, '156555', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3945', '201130630437', '邓荣欣', 'c5e2a55232a76872c8fa25d4fe7b65af49741a62', null, null, 'ROLE_STD', '1', '19', '120', null, '156556', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3946', '201130630383', '程家颖', 'e35ec14cfe59505adeb0916df8ff8a14075a97b1', null, null, 'ROLE_STD', '1', '19', '120', null, '156557', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3947', '201130635432', '朱丽叶', '6f1e96abd018494273de9e84b175a1887eeab7d4', null, null, 'ROLE_STD', '1', '19', '120', null, '156558', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3948', '201130633384', '邱丹耀', '406ece23977c23c76184288e19bc107558053732', null, null, 'ROLE_STD', '1', '19', '120', null, '156559', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3949', '201130631076', '郭泽豪', '92833aafc4ca4d02bced553aadcd60b696459610', null, null, 'ROLE_STD', '1', '19', '120', null, '156560', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3950', '201130633025', '刘光忠', 'db74067b544bb5e9adcd41b4bd12b3942ca5fb84', null, null, 'ROLE_STD', '1', '19', '120', null, '156561', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3951', '201130635470', '闫仕伟', 'ccdddf0388bbd5e81233450ab9c0042e60260dd8', null, null, 'ROLE_STD', '1', '19', '120', null, '156562', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3952', '201136632091', '李迪勤', 'de31aa699b247304ae0f9054d5af80358704bb73', null, null, 'ROLE_STD', '1', '19', '120', null, '156563', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3953', '201130630390', '戴瑾如', '1d415456601f6344f5a5bfe7bf42e27c5ccf7660', null, null, 'ROLE_STD', '1', '19', '120', null, '156564', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3954', '201130635234', '张钊', '5508f941d7683d483bd532f99085d25e0dbba8c3', null, null, 'ROLE_STD', '1', '19', '120', null, '156565', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3955', '201130631175', '何一鸣', 'd9221565929e5c1830eff0739708ec2b796b9977', null, null, 'ROLE_STD', '1', '19', '120', null, '156566', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3956', '201136630103', '陈碧荷', '43f787a73a9d8731188a9394f512e128bb7607c6', null, null, 'ROLE_STD', '1', '19', '120', null, '156567', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3957', '201136630288', '陈永鸿', '5bbc40032bccdf99bee6876ad9d127397788d918', null, null, 'ROLE_STD', '1', '19', '120', null, '156568', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3958', '201136633036', '刘嘉伟', '3922b82aa09e981439e6bd80f79586fa3aad5276', null, null, 'ROLE_STD', '1', '19', '120', null, '156569', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3959', '201130635395', '周顺风', '28ca6231e694b7295df9c9708e8a0a9e7b78b9ee', null, null, 'ROLE_STD', '1', '19', '120', null, '156570', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3960', '201130632066', '李炳权', 'd35e454004ca29943c2409d2f814a83c6b16b0c7', null, null, 'ROLE_STD', '1', '19', '120', null, '156571', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3961', '201130631335', '黄海东', '30450a5788c19cf0cf62d9377d315a4e430efc2f', null, null, 'ROLE_STD', '1', '19', '120', null, '156572', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3962', '201130631212', '何志远', '868f7bcd6ca45444dee6b042f08ed4c6ccd0eaea', null, null, 'ROLE_STD', '1', '19', '120', null, '156573', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3963', '201130631168', '何欣燕', 'd6dbecd09b660544313d52f31961019c153f9d67', null, null, 'ROLE_STD', '1', '19', '120', null, '156574', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3964', '201130633063', '刘立华', '657d50df7a8b3743b5dbae2317c6f0ea7494e83e', null, null, 'ROLE_STD', '1', '19', '120', null, '156575', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3965', '201130632011', '雷宇晴', '7c59f4839a98da1d8a676607baf7df519bd3b9fc', null, null, 'ROLE_STD', '1', '19', '120', null, '156576', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3966', '201130631106', '何斌', 'b73c75f4602adf3b221687358246753ad0cfff3e', null, null, 'ROLE_STD', '1', '19', '120', null, '156577', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3967', '201130631328', '黄国锴', '8983ee24e54813d1fc3f0f877431071c63c00466', null, null, 'ROLE_STD', '1', '19', '120', null, '156578', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3968', '201130631236', '贺理文', '6e6f135f746eefe5b2cb0bc9135a965e37d23351', null, null, 'ROLE_STD', '1', '19', '120', null, '156579', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3969', '201130635456', '邹子杰', '97614f57885e32f6221d7abb30fbbe2f69c4eddf', null, null, 'ROLE_STD', '1', '19', '120', null, '156580', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3970', '201130630246', '陈韦辰', 'd3efcf1e8a679e09498fe0ca164b76436483af5f', null, null, 'ROLE_STD', '1', '19', '120', null, '156581', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3971', '201130634091', '王嘉豪', '5199c1ade3b7c29013c067fff79a01912cd413b0', null, null, 'ROLE_STD', '1', '19', '120', null, '156582', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3972', '201130631120', '何俊威', '2107a1d0fe65a2ecec3635f19eb8ff656b82e24d', null, null, 'ROLE_STD', '1', '19', '120', null, '156583', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3973', '201130631403', '黄永生', '99523cbe4bde6b1d0917285ddee2329471922eb7', null, null, 'ROLE_STD', '1', '19', '120', null, '156584', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3974', '201130630222', '陈勉荣', '88fb4811229db3dd8eb37fc09bc7ece30c9ead96', null, null, 'ROLE_STD', '1', '19', '120', null, '156585', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3975', '201130631151', '何伟鹏', 'a2aa2dce299105d4159be755a7c79f1a6f905cbe', null, null, 'ROLE_STD', '1', '19', '120', null, '156586', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3976', '201130633322', '欧阳佳宾', '9d17ec5e1167c355b95c9809c3dcc5fcfaf2648f', null, null, 'ROLE_STD', '1', '19', '120', null, '156587', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3977', '201130631366', '黄凯芬', 'b3492b0b27a2c0b58c6e8a7c5232714bd0b33e8e', null, null, 'ROLE_STD', '1', '19', '120', null, '156588', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3978', '201130632332', '廖辉', '64a9d5030e388923994d3881130fe5b8ddee2485', null, null, 'ROLE_STD', '1', '19', '120', null, '156589', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3979', '201130631229', '何子民', 'b2422d7921227913748ced09f0915a8fd4d95361', null, null, 'ROLE_STD', '1', '19', '120', null, '156590', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3980', '201130632295', '梁莫柱', '7290e774c13d7d751376105d4b1dcfbef1263935', null, null, 'ROLE_STD', '1', '19', '120', null, '156591', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3981', '201130630499', '高世华', 'fc679033c4d05a542101477190074a253e41ea0f', null, null, 'ROLE_STD', '1', '19', '120', null, '156592', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3982', '201130635180', '张莉', '9e115b44247935a6d2df5c0909c323f8ce352253', null, null, 'ROLE_STD', '1', '19', '120', null, '156593', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3983', '201130630130', '陈贵明', '2ab8c2df98e5a80ff60c756384b400fabb523310', null, null, 'ROLE_STD', '1', '19', '120', null, '156594', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3984', '201130632073', '李灿光', '6b52be99e1357f67ac7f32844d6c512018401ffc', null, null, 'ROLE_STD', '1', '19', '120', null, '156595', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3985', '201130631267', '洪图', 'bc5a22c7de8edf23203dcae94ea7dbf14c579cb4', null, null, 'ROLE_STD', '1', '19', '120', null, '156596', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3986', '201130632387', '林戈', '8ac8638e8399f3ab8cfcef02f841bb9e19a5dd84', null, null, 'ROLE_STD', '1', '19', '120', null, '156597', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3987', '201130630147', '陈国宇', 'cf1ecee553ed8e495db2acbb61aacbb130062724', null, null, 'ROLE_STD', '1', '19', '120', null, '156598', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3988', '201130633292', '莫茂杰', '75457310057161627b45c73dce0ebe039e030608', null, null, 'ROLE_STD', '1', '19', '120', null, '156599', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3989', '201130635401', '周文彬', '0df11fc574194f5a034432a6beacf96bc0fdf736', null, null, 'ROLE_STD', '1', '19', '120', null, '156600', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3990', '201130632479', '林怡', 'f42a0b33e93cfc8a4b5b6f7efd089363df8f3ede', null, null, 'ROLE_STD', '1', '19', '120', null, '156601', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3991', '201130632417', '林锐强', '8f06465515b66a45b17631c8d2f46d4ce79a94a9', null, null, 'ROLE_STD', '1', '19', '120', null, '156602', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3992', '201130633117', '刘志寰', '1a98f8d209aa67b578a43f077842b11d820c70dd', null, null, 'ROLE_STD', '1', '19', '120', null, '156603', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3993', '201130633391', '邱俊凯', '7ec384a5d053024e8f883587efa958a434ec0f17', null, null, 'ROLE_STD', '1', '19', '120', null, '156604', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3994', '201130630208', '陈俊挺', '455cc043612b0dff563a097eb48c5de7c3f58742', null, null, 'ROLE_STD', '1', '19', '120', null, '156605', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3995', '201130633216', '罗伟昂', '7bd776e7675516c1b9db85b654bccaaea9399d6e', null, null, 'ROLE_STD', '1', '19', '120', null, '156606', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3996', '201130633438', '史佳伟', 'f5341b4c6e85e0906944cc30f07866adc365ab9d', null, null, 'ROLE_STD', '1', '19', '120', null, '156607', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3997', '201130631014', '龚耀庭', 'a44aba5f771398448cdd8be2d627763c6aff5e63', null, null, 'ROLE_STD', '1', '19', '120', null, '156608', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3998', '201130630123', '陈戈', '2fc06a85abfd800e90b6834cc547090e8a1f7bb9', null, null, 'ROLE_STD', '1', '19', '120', null, '156609', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('3999', '201130634343', '夏艳明', 'b7e57629e921049cab3d0c26a511e0b7f9c7b6b4', null, null, 'ROLE_STD', '1', '19', '120', null, '156610', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4000', '201130635197', '张朔', '0c83a7138dc89ce35420175b7d0460e87824e591', null, null, 'ROLE_STD', '1', '19', '120', null, '156611', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4001', '201130635067', '余志浩', 'ec8120fbf1b633f5525852e9076acca10a1b59eb', null, null, 'ROLE_STD', '1', '19', '120', null, '156612', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4002', '201130634503', '杨臻', 'e5346272b15023d66166c4614f2d354da4918813', null, null, 'ROLE_STD', '1', '19', '120', null, '156613', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4003', '201130631410', '黄赟', '85f0bb869addf6bf7d1a98bf29f88151c6389246', null, null, 'ROLE_STD', '1', '19', '120', null, '156614', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4004', '201130630338', '陈竹天', '42dd209860020d443dc05630f2c1a2057cae9d10', null, null, 'ROLE_STD', '1', '19', '120', null, '156615', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4005', '201130633186', '罗国辉', '017c39aa9709420b2c14f2a05257829bea707262', null, null, 'ROLE_STD', '1', '19', '120', null, '156616', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4006', '201130633018', '凌霄', 'e81e101e563d7034097977dd426df2a9b7e3fd17', null, null, 'ROLE_STD', '1', '19', '120', null, '156617', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4007', '201130634220', '吴彬', '1562279f8d556bd7bb728a8ee7a0f33a8b88db8a', null, null, 'ROLE_STD', '1', '19', '120', null, '156618', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4008', '201130632103', '李国宝', '9b701850daf155746334e1cdd6f296c3f187ffc4', null, null, 'ROLE_STD', '1', '19', '120', null, '156619', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4009', '201130632165', '李熙龙', '6dac77977360f79f8f8d3557ec53744eb289bb9f', null, null, 'ROLE_STD', '1', '19', '120', null, '156620', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4010', '201130632059', '李宝玲', '84be09adbb719b30d4f887cff7a0593c642b133d', null, null, 'ROLE_STD', '1', '19', '120', null, '156621', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4011', '201130634299', '吴伟锋', 'b93f36ab2a9b15aa430a057a036610b475152090', null, null, 'ROLE_STD', '1', '19', '120', null, '156622', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4012', '201130634374', '谢敏珊', '0b2f671835f39a19bd3ee391425c8bfaf1dd10ac', null, null, 'ROLE_STD', '1', '19', '120', null, '156623', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4013', '201130630031', '蔡俊彬', '968b9ae4bc5bf6f11bcd56201569b9fd14708a7c', null, null, 'ROLE_STD', '1', '19', '120', null, '156624', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4014', '201130630093', '车德邻', '3110ec9edf6905ddb0dc1f556129c6b4ad18775f', null, null, 'ROLE_STD', '1', '19', '120', null, '156625', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4015', '201130635241', '招振荣', '9b13854576e16baf05cba434d77a5cef338dfba4', null, null, 'ROLE_STD', '1', '19', '120', null, '156626', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4016', '201130631137', '何俊昊', '60737264c1675715c655553dc8883ea57ce6781c', null, null, 'ROLE_STD', '1', '19', '120', null, '156627', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4017', '201130634206', '温文聪', '6d42713621ae25862826a8bcbe6944d13fd5dfd1', null, null, 'ROLE_STD', '1', '19', '120', null, '156628', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4018', '201130634046', '汤煜朗', 'ddc544e5a971337995c1872ac0a1af4d57460e38', null, null, 'ROLE_STD', '1', '19', '120', null, '156629', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4019', '201130632448', '林宇航', '48cbb26bc0ae5f2d6f858c1ed2b45b00771e42a4', null, null, 'ROLE_STD', '1', '19', '120', null, '156630', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4020', '201130635227', '张睿', '5474d1545af4d5619d826b2b0c4df9fb82034608', null, null, 'ROLE_STD', '1', '19', '120', null, '156631', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4021', '201130634077', '王德勤', 'cdd3fcc8971abc5af0f7f261ad77a39c3141c505', null, null, 'ROLE_STD', '1', '19', '120', null, '156632', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4022', '201130634176', '王忠立', 'e24862f943d77070db9e7b67f61113e356d62b93', null, null, 'ROLE_STD', '1', '19', '120', null, '156633', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4023', '201130634312', '吴益文', '4da8bc5ad6c9508acb53a0f1c7f9f56cd1dcd8cb', null, null, 'ROLE_STD', '1', '19', '120', null, '156634', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4024', '201130632219', '李育乘', 'b666aaf0a37ae72529697d75d0c245fdc919b1e9', null, null, 'ROLE_STD', '1', '19', '120', null, '156635', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4025', '201130632349', '廖文辉', 'ecfffb4fb78d59ecda025682f809cd212c011166', null, null, 'ROLE_STD', '1', '19', '120', null, '156636', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4026', '201130631250', '洪浩贤', '6c55b2ac5f184886c0fcf785149732e81b1b2245', null, null, 'ROLE_STD', '1', '19', '120', null, '156637', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4027', '201130635418', '周叙凯', 'fc23648b752b86db6f8e8048fc3601003d33776e', null, null, 'ROLE_STD', '1', '19', '120', null, '156638', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4028', '201030632531', '杨波', '376268184ffe49dd012135caa5fbf1fd967a503a', null, null, 'ROLE_STD', '1', '19', '120', null, '156639', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4029', '201030632029', '王瑞明', 'c0dd202930e1cc6883f2fd8310f0cab0347cbe37', null, null, 'ROLE_STD', '1', '19', '120', null, '156640', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4030', '201130635296', '郑文结', '6ddac25bc68c090ac555c46bbc7f32604563d41f', null, null, 'ROLE_STD', '1', '19', '120', null, '156641', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4031', '201130635043', '于晓飞', '7ba1ea21e1ee2db6992b0a35264737805c9d8e06', null, null, 'ROLE_STD', '1', '19', '120', null, '156642', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4032', '201130632226', '李悦', '83846a59538e2ec7f2bf71788f65b07fffc747ef', null, null, 'ROLE_STD', '1', '19', '120', null, '156643', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4033', '201130631359', '黄佳祥', '3f0d1b31e3c96c13adb75689f4b86e6842455af1', null, null, 'ROLE_STD', '1', '19', '120', null, '156644', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4034', '201130632172', '李想', '370e3f07f5e74db6e0c73a43dbc3c5f10f148900', null, null, 'ROLE_STD', '1', '19', '120', null, '156645', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4035', '201130634497', '杨伟均', '67a96db7e139a0756c0763fa6bdbc188dddc58f0', null, null, 'ROLE_STD', '1', '19', '120', null, '156646', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4036', '201130631502', '雷国丽', '66cef92b84f5819f5ffd523db93835e6cd8f4c65', null, null, 'ROLE_STD', '1', '19', '120', null, '156647', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4037', '201130631472', '蒋慧强', 'a4da052e51d06ed1dbb59c285927765c3d1edf8d', null, null, 'ROLE_STD', '1', '19', '120', null, '156648', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4038', '201130633469', '苏俊屹', '6f87f18d240a9e269c4ff0f7df21912463fa54e9', null, null, 'ROLE_STD', '1', '19', '120', null, '156649', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4039', '201130635104', '曾晓东', 'dd8fde4707bbd964a91fc0664fbdc144ec45992c', null, null, 'ROLE_STD', '1', '19', '120', null, '156650', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4040', '201130634442', '许瑞霖', '43f889cf25a5bb01f7c915aaf318893aae5a9f97', null, null, 'ROLE_STD', '1', '19', '120', null, '156651', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4041', '201136635429', '朱海旭', '822a8f9baa5352d9c51d303e60faf06179b3cbd6', null, null, 'ROLE_STD', '1', '19', '120', null, '156652', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4042', '201130630444', '丁东辉', '6137a5cb788c5552a801ccf558ce80312eb4c839', null, null, 'ROLE_STD', '1', '19', '120', null, '156653', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4043', '201136632152', '李天伦', 'bcc8ee3f3fbbf726db96b06f39846d947d71462c', null, null, 'ROLE_STD', '1', '19', '120', null, '156654', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4044', '201136633074', '刘思源', 'adc11d46df3202548e8cd3daeb3a837788514bc7', null, null, 'ROLE_STD', '1', '19', '120', null, '156655', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4045', '201130635135', '张广磊', 'ef20a311e5cb66c5c85e5f55098b1da5f1645e01', null, null, 'ROLE_STD', '1', '19', '120', null, '156656', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4046', '201130632141', '李仁鸿', '1c34d51f57fe273eb473f07b35b147f0d625d0c2', null, null, 'ROLE_STD', '1', '19', '120', null, '156657', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4047', '201130632363', '林标标', 'a13c1331c32ee212ad5d2fefc26c8f3147ef82dc', null, null, 'ROLE_STD', '1', '19', '120', null, '156658', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4048', '201130635111', '詹昊恂', '8c5da911909ac364b845b390b87fa4ecc72a8e27', null, null, 'ROLE_STD', '1', '19', '120', null, '156659', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4049', '201130634039', '汤雪', '8aeb8ce5fcd30df7201a79bbf5ef43241c8d2b97', null, null, 'ROLE_STD', '1', '19', '120', null, '156660', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4050', '201130635210', '张懿云', 'bcac69ce3583769cbf8ea494fc79ea48e81eef24', null, null, 'ROLE_STD', '1', '19', '120', null, '156661', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4051', '201130634404', '谢郑逸', '7176f7e5ee1ce1503b5094b11e58ffcd43ccb82a', null, null, 'ROLE_STD', '1', '19', '120', null, '156662', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4052', '201130633179', '吕亮', 'cc90d625decfb30182f332d38755fbc1e8ef6c4a', null, null, 'ROLE_STD', '1', '19', '120', null, '156663', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4053', '201130631342', '黄嘉慧', '8544683e717356657a8bced960004da3bcc62083', null, null, 'ROLE_STD', '1', '19', '120', null, '156664', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4054', '201130631205', '何志澎', '8895fe5f5c8d254233c5fe72dc30a09287c5022c', null, null, 'ROLE_STD', '1', '19', '120', null, '156665', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4055', '201130635050', '于盈威', '726e51fdc232b9baf7b1dcb9b5505d381cc598ff', null, null, 'ROLE_STD', '1', '19', '120', null, '156666', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4056', '201130630352', '陈琪杰', '7472e4075980416bffcc06c37b64f5c1179318b3', null, null, 'ROLE_STD', '1', '19', '120', null, '156667', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4057', '201130632394', '林辉滨', 'de84b8ce86026f1f060ef6d77759e97d5bdd00c8', null, null, 'ROLE_STD', '1', '19', '120', null, '156668', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4058', '201130631311', '黄东雄', 'dfa39fb2d8d37cb4611458092faafb688e21d8af', null, null, 'ROLE_STD', '1', '19', '120', null, '156669', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4059', '201130634114', '王齐轩', '830dd2298b62a7acf3d0d8328f48b25c1806e09e', null, null, 'ROLE_STD', '1', '19', '120', null, '156670', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4060', '201130633506', '孙正扬', 'd1d24ab80a2fd8aae13de6c9ec0e383dcb59450b', null, null, 'ROLE_STD', '1', '19', '120', null, '156671', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4061', '201130630055', '蔡耀冠', '92847e2e11fa93dbb98f3dab5610230b7e4d46f0', null, null, 'ROLE_STD', '1', '19', '120', null, '156672', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4062', '201130631489', '金能令', 'bd8f88fb4b71d2bff1e2feb36ece8df56c7bf7de', null, null, 'ROLE_STD', '1', '19', '120', null, '156673', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4063', '201130635340', '钟霄楠', '74531994c665b1f339c7413594ba25508de2bbed', null, null, 'ROLE_STD', '1', '19', '120', null, '156674', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4064', '201130634152', '王泽强', 'e7935eead1827ba9e5540452dbd4a76c41a9e95c', null, null, 'ROLE_STD', '1', '19', '120', null, '156675', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4065', '201130630178', '陈键', '580b5885356b7d26504068bb2e0ad3fbb7dc5b7b', null, null, 'ROLE_STD', '1', '19', '120', null, '156676', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4066', '201130632233', '李哲操', 'c1b01eda16c5b214b5d55bb2b98ee56ca74c8546', null, null, 'ROLE_STD', '1', '19', '120', null, '156677', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4067', '201130635333', '钟浩', '2669a89d868b9bba64afe07ee4753511a6fd67b0', null, null, 'ROLE_STD', '1', '19', '120', null, '156678', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4068', '201130633452', '宋永潘', '7db376c9279a467b6be90094e74bc0d652ce6a19', null, null, 'ROLE_STD', '1', '19', '120', null, '156679', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4069', '201130631144', '何锐奇', '283c3e7e15c22927ec807941abbccc445a17ec0c', null, null, 'ROLE_STD', '1', '19', '120', null, '156680', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4070', '201130635029', '杨灏', '747b6c302b2cdb028bb9fbb7b02906d783c2a192', null, null, 'ROLE_STD', '1', '19', '120', null, '156681', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4071', '201130630314', '陈志文', '8478cfd23db9e989773540208e1b5fc054ea0fdd', null, null, 'ROLE_STD', '1', '19', '120', null, '156682', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4072', '201130630505', '龚名威', 'bf51d9b0fac1cc921df80c8de6568a421561fc79', null, null, 'ROLE_STD', '1', '19', '120', null, '156683', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4073', '201030631602', '普尘', '5195f835374727f92376db0822d00759ec6ea11e', null, null, 'ROLE_STD', '1', '19', '120', null, '156684', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4074', '200930631071', '冯龙飞', 'fcfc7f9b1aa7aeb55aa86e2fdd776bd25a2b6ddb', null, null, 'ROLE_STD', '1', '19', '120', null, '156685', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4075', '201030631862', '田东峰', 'bf523ffee5e1b09fc36d4deb59e55bf3f671de01', null, null, 'ROLE_STD', '1', '19', '120', null, '156686', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4076', '201030633286', '邹永传', '4c3163e48d2813ff3e94167f19542bb43a0d2567', null, null, 'ROLE_STD', '1', '19', '120', null, '156687', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4077', '201130632042', '黎思聪', 'b7266a58630719fdecac3ed010f9b233a113b27f', null, null, 'ROLE_STD', '1', '19', '120', null, '156688', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4078', '201130635265', '甄淑仪', '15ecefaf26758966c31ba086adc00e28c8cd6698', null, null, 'ROLE_STD', '1', '19', '120', null, '156689', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4079', '201130632134', '李青山', '9ac08d397559eda65b95af699b52c0956f0e4d2a', null, null, 'ROLE_STD', '1', '19', '120', null, '156690', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4080', '201169105111', '文锦珠', '76f2fbeb8919ab5f1937251c96a9080eae8be4e2', null, null, 'ROLE_STD', '1', '19', '120', null, '156691', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4081', '201130633377', '秦赛赛', 'dc75188d16d84de6f34b0d56f8ef6aa8f72412f2', null, null, 'ROLE_STD', '1', '19', '120', null, '156692', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4082', '201130634268', '吴桂城', '46e062196a31684445e2ea3c5f015a5472d192ee', null, null, 'ROLE_STD', '1', '19', '120', null, '156693', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4083', '201130631373', '黄鹏', '42b31787a8e796f1a1d671637839861717805786', null, null, 'ROLE_STD', '1', '19', '120', null, '156694', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4084', '201130560109', '丁鹏', '33b8c3b462c54eee66a476ac9ce63aa42947d6fb', null, null, 'ROLE_STD', '1', '19', '120', null, '156695', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4085', '201130635166', '张俊茂', '6fe60d2cd3cd2e56a951acbc3741cb03d4a29011', null, null, 'ROLE_STD', '1', '19', '120', null, '156696', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4086', '201130634466', '严炜', '324c09d55583c40ca5bfbfe64030ad2797b8934d', null, null, 'ROLE_STD', '1', '19', '120', null, '156697', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4087', '201130635272', '郑娇龙', '7f1150c502f8eb5590d0c51c9a29f31943046ecf', null, null, 'ROLE_STD', '1', '19', '120', null, '156698', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4088', '201130633223', '罗文兴', '8b87f91d8a53d14e04103f9f9953314769b73600', null, null, 'ROLE_STD', '1', '19', '120', null, '156699', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4089', '201136634323', '夏嘉雯', '76180343dd8ef277e34a66dbc9998236c5af2aa9', null, null, 'ROLE_STD', '1', '19', '120', null, '156700', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4090', '201130635081', '袁志江', 'aedf21a9236db2a6ca121aef80e1947c06b6f558', null, null, 'ROLE_STD', '1', '19', '120', null, '156701', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4091', '201130635074', '袁天宇', 'f2fec3ee6ad9af58d3c094129d0d0930b5d0dc54', null, null, 'ROLE_STD', '1', '19', '120', null, '156702', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4092', '201130633285', '麦斯玲', '2f817736eed20331e8462abf696cb48f9da4fa45', null, null, 'ROLE_STD', '1', '19', '120', null, '156703', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4093', '201130633339', '潘杉', '934cfa0e5d658899da6fb87846ee734198cdd98a', null, null, 'ROLE_STD', '1', '19', '120', null, '156704', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4094', '201130633254', '马帅', '0936b84f92b133e78304e697548a81f2ecc1b427', null, null, 'ROLE_STD', '1', '19', '120', null, '156705', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4095', '201130631243', '贺智超', 'b134a683ae8f8b09d8d374713ff57c94d7e92370', null, null, 'ROLE_STD', '1', '19', '120', null, '156706', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4096', '201130630291', '陈泽民', '9b97238e8affc04914bbea02ae516ef5ad46218b', null, null, 'ROLE_STD', '1', '19', '120', null, '156707', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4097', '201130634411', '熊智航', '6a962075997bd7a20eac9f8f10c75d638574bf02', null, null, 'ROLE_STD', '1', '19', '120', null, '156708', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4098', '201130635487', '闫亚同', 'b63a8952d73291fa63b584abc425dac9345f7efe', null, null, 'ROLE_STD', '1', '19', '120', null, '156709', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4099', '201130630482', '付雅晴', 'e9b708f3a7918769d8c8ac5d2050fc70b1ad8920', null, null, 'ROLE_STD', '1', '19', '120', null, '156710', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4100', '201136634125', '王腾云', '057f873859040449808dab3bc14aa24bbfc44d1e', null, null, 'ROLE_STD', '1', '19', '120', null, '156711', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4101', '201136635375', '周靖凯', '3529a2586ba65778e9fc39853d0e0920aed0ee6a', null, null, 'ROLE_STD', '1', '19', '120', null, '156712', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4102', '201130634022', '谭永健', '667aff356365a5d19e0fc886505d65e5e5014c2f', null, null, 'ROLE_STD', '1', '19', '120', null, '156713', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4103', '201130635173', '张凯华', 'abe40ad50a36fab99e98c3e178e89fd1d087adac', null, null, 'ROLE_STD', '1', '19', '120', null, '156714', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4104', '201130630475', '冯振飞', '092d93a45619797fb75977f8ac478744cc55cdd8', null, null, 'ROLE_STD', '1', '19', '120', null, '156715', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4105', '201130633209', '罗启盛', '63c36b623b4d8a8622235aa96ea5f1c5992de35b', null, null, 'ROLE_STD', '1', '19', '120', null, '156716', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4106', '201130635012', '杨志鹏', '43f94ad253bfeb0ffb6fa647792146a81d7e1bbd', null, null, 'ROLE_STD', '1', '19', '120', null, '156717', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4107', '201130633308', '倪泽彬', 'b2f2faffc4deccb8387ac8d5178b242083d79f57', null, null, 'ROLE_STD', '1', '19', '120', null, '156718', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4108', '201130632493', '林梓越', 'b353968b7496f94f074e3435d574a39a77b8f820', null, null, 'ROLE_STD', '1', '19', '120', null, '156719', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4109', '201130631069', '郭贵鑫', '81d4fd2cab8929f1dab56f407489d05cf26a231d', null, null, 'ROLE_STD', '1', '19', '120', null, '156720', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4110', '201130633247', '马嘉霖', '561a9c1021869ccdd130abe31feaf1ef0c1984bb', null, null, 'ROLE_STD', '1', '19', '120', null, '156721', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4111', '201130632202', '李英晗', '6661d5e375fa6b60039c7f37420428fbe14c7992', null, null, 'ROLE_STD', '1', '19', '120', null, '156722', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4112', '201136632244', '李祖立', '7ecb538ef927ff81f4d33ec48ba11f101fe1f194', null, null, 'ROLE_STD', '1', '19', '120', null, '156723', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4113', '201130635203', '张智东', 'faece1001a759438b9fd6ecb78ac26418046b3b7', null, null, 'ROLE_STD', '1', '19', '120', null, '156724', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4114', '201130635302', '郑梓聪', '41bd99bac60b61fc4c58ff63c22adb3ef60d10ef', null, null, 'ROLE_STD', '1', '19', '120', null, '156725', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4115', '201130634435', '许昌建', '55a669285824dded804c2f094da152327bf1c3e7', null, null, 'ROLE_STD', '1', '19', '120', null, '156726', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4116', '201130630154', '陈海齐', '35906f5cfdbe112ba215cbecb9f162ead891b55e', null, null, 'ROLE_STD', '1', '19', '120', null, '156727', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4117', '201130634473', '杨金堂', '973799bdc4740716e641b3bc584ecc153c0bc38b', null, null, 'ROLE_STD', '1', '19', '120', null, '156728', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4118', '201130630307', '陈震鸿', '20856ac32568ae8bcbb21fa01db5346133495203', null, null, 'ROLE_STD', '1', '19', '120', null, '156729', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4119', '201130634107', '王佩', '1decc9dcfbe44f0ba2162873d32f0a34ec8f9f07', null, null, 'ROLE_STD', '1', '19', '120', null, '156730', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4120', '201130632431', '林伟良', 'a906da0985e471366bcda282702cae1e26ed36d6', null, null, 'ROLE_STD', '1', '19', '120', null, '156731', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4121', '201130633353', '彭飞', '59bdb6bcdfdee292338045387874d717889e0e06', null, null, 'ROLE_STD', '1', '19', '120', null, '156732', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4122', '201130630468', '方春林', '164a46030f5acefc0b6a1fb65c9ab735a2add7fe', null, null, 'ROLE_STD', '1', '19', '120', null, '156733', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4123', '201130634480', '杨楷', 'bcadcc8907bb2cc9caecf098d6bd0ca538b751d5', null, null, 'ROLE_STD', '1', '19', '120', null, '156734', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4124', '201130633315', '欧建荣', '6552dbbd528b85843222208a61da6cd6a49fed12', null, null, 'ROLE_STD', '1', '19', '120', null, '156735', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4125', '201130632509', '林钊生', 'ceeea04eed99e9a63b19c67980f2d698cf5cef15', null, null, 'ROLE_STD', '1', '19', '120', null, '156736', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4126', '201130632455', '林悦邦', 'cec2892c6d09fd473c91f9f6d47477ad6dd029bc', null, null, 'ROLE_STD', '1', '19', '120', null, '156737', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4127', '201130630345', '陈卓', '0181219c88b2562838e9e31f872c270f44ad24d5', null, null, 'ROLE_STD', '1', '19', '120', null, '156738', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4128', '201130632400', '林绵程', '4350a9c97250e9069447002a40623fa2a882ee71', null, null, 'ROLE_STD', '1', '19', '120', null, '156739', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4129', '201130630024', '蔡东荣', 'c73ced9bba0f4329555d5cee2fd2d8dd5211c265', null, null, 'ROLE_STD', '1', '19', '120', null, '156740', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4130', '201130635142', '张广怡', '0057991e82d6c99c0f6da5af29971fdc2384c579', null, null, 'ROLE_STD', '1', '19', '120', null, '156741', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4131', '201130632257', '李作明', '0797a39f58f8ea7f86dd0d84a814d204e5ac7148', null, null, 'ROLE_STD', '1', '19', '120', null, '156742', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4132', '201130634183', '王子元', 'c181cf203ad761f1b2c6ca3aa7a3f73680aa35a6', null, null, 'ROLE_STD', '1', '19', '120', null, '156743', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4133', '201130635258', '甄江杰', 'ec68b9e258d181a4665f36c0f99b253352ff5f8e', null, null, 'ROLE_STD', '1', '19', '120', null, '156744', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4134', '201130630451', '范保林', '599c93b0964e3eb4a1041921f1addf3a18a48aca', null, null, 'ROLE_STD', '1', '19', '120', null, '156745', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4135', '201130632370', '林丹丹', 'a228fa559763c950a5f8012cad2f04eeaf8eb0d5', null, null, 'ROLE_STD', '1', '19', '120', null, '156746', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4136', '201130633414', '石尧', 'f0dbe02477190070675539c0259d8430b723c590', null, null, 'ROLE_STD', '1', '19', '120', null, '156747', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4137', '201230673280', '韦良宁', '3b616b68a60df465625a396fdf2516e972a863ff', null, null, 'ROLE_STD', '1', '19', '120', null, '156748', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4138', '201230673327', '翁僖骏', '818c6679278ab1d5774387b500ba57431de96221', null, null, 'ROLE_STD', '1', '19', '120', null, '156749', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4139', '201236674021', '杨城', '1eb93b1e56b54c73f5e08192abbc4fe1d29ee28f', null, null, 'ROLE_STD', '1', '19', '120', null, '156750', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4140', '201236672287', '陆玎莹', '2b5b7547b8fb62f098e7f496bb0d47ea72893704', null, null, 'ROLE_STD', '1', '19', '120', null, '156751', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4141', '201237675096', '朱健聪', '4546b506c87e8f50fc99e5a2ffd432bf1ca6e735', null, null, 'ROLE_STD', '1', '19', '120', null, '156752', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4142', '201236671341', '劳铭枫', '499fd1017ec204a7ffe378a8a9531e65a80f6cb2', null, null, 'ROLE_STD', '1', '19', '120', null, '156753', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4143', '201236671037', '郭正都', '822209fc47ca61f1dd1cd7ce4db14d529ccd440e', null, null, 'ROLE_STD', '1', '19', '120', null, '156754', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4144', '201230672078', '梁智豪', '413e3d0f6a89d8ac256e1bbf02224c5959bb379e', null, null, 'ROLE_STD', '1', '19', '120', null, '156755', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4145', '201230671323', '赖雍杰', '0a12ed00cd75360b38f6d207de38fa9f82dacc0a', null, null, 'ROLE_STD', '1', '19', '120', null, '156756', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4146', '201230672351', '罗泽轩', 'c1992094b369f786773a381d9d159138e288b347', null, null, 'ROLE_STD', '1', '19', '120', null, '156757', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4147', '201230673051', '苏桐', '90ca35614739175924cec05fd127c9b7527268e0', null, null, 'ROLE_STD', '1', '19', '120', null, '156758', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4148', '201230670487', '管健铭', '3a8cd1595757739ad73c2fce21371b0926b55d21', null, null, 'ROLE_STD', '1', '19', '120', null, '156759', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4149', '201230670111', '陈曼平', 'da30529510fa51aeadfb6b648dd7cc3f7b1bc604', null, null, 'ROLE_STD', '1', '19', '120', null, '156760', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4150', '201230670326', '邓嘉琪', '8406f8e0cd5f39a170f83a13b99d4687c8b212da', null, null, 'ROLE_STD', '1', '19', '120', null, '156761', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4151', '201230670265', '陈镇新', 'ef50763c19fc7be115f04d501babf2d0abbe02bb', null, null, 'ROLE_STD', '1', '19', '120', null, '156762', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4152', '201230671309', '孔少华', '1ab8f13fcb010c81e4c0b5953ac9b15244a38e19', null, null, 'ROLE_STD', '1', '19', '120', null, '156763', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4153', '201230674010', '阎佳', 'b9aa359674e59264fac9111de865f58aed9f5dc8', null, null, 'ROLE_STD', '1', '19', '120', null, '156764', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4154', '201230672108', '林军', 'fde17b2c55ec0fd7fa33ba9a92ff5fcc88440fc9', null, null, 'ROLE_STD', '1', '19', '120', null, '156765', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4155', '201230674317', '张杰晖', '83a32a570ceee00ab5c9800c4f27cb17bce613db', null, null, 'ROLE_STD', '1', '19', '120', null, '156766', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4156', '201230673143', '汪树文', 'd95457b7b67b22f70ab1fb2e13675e0c304cc2fb', null, null, 'ROLE_STD', '1', '19', '120', null, '156767', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4157', '201230673457', '邢维帝', '8d9a7856072d834c61aadc99016923f522fa696d', null, null, 'ROLE_STD', '1', '19', '120', null, '156768', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4158', '201230672030', '李雨龙', 'e39c79fd0b09da5073a57ecc1f27080daefaef43', null, null, 'ROLE_STD', '1', '19', '120', null, '156769', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4159', '201230671200', '华航', '59025b60f38722adc6176c2cdcdcad1c535c213f', null, null, 'ROLE_STD', '1', '19', '120', null, '156770', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4160', '201230671101', '何子杰', 'bab15211839b54af31888107b6906c212a70b0f4', null, null, 'ROLE_STD', '1', '19', '120', null, '156771', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4161', '201230672467', '秦闻达', '2b688c724571ec4b099f38ff7ac1901162076104', null, null, 'ROLE_STD', '1', '19', '120', null, '156772', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4162', '201230670371', '丁同舟', '25b680be51f597f55c2db08259568be8a00fc7e6', null, null, 'ROLE_STD', '1', '19', '120', null, '156773', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4163', '201230670159', '陈荣钊', '513510869495408ee5cb08b860a86ba1a143992d', null, null, 'ROLE_STD', '1', '19', '120', null, '156774', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4164', '201230672399', '莫立恒', 'e7fb2dabbbcb51d7449e5ba92eae7e0fa136a853', null, null, 'ROLE_STD', '1', '19', '120', null, '156775', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4165', '201230673372', '吴子恒', '61c67ddac8f84f762d191fd9b773babff112ced7', null, null, 'ROLE_STD', '1', '19', '120', null, '156776', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4166', '201230670241', '陈育彬', '9204b18cb7ef965c17cbb9c805b0495f792393ce', null, null, 'ROLE_STD', '1', '19', '120', null, '156777', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4167', '201230674348', '张明龙', '464e34114d2a89780462efd8ef24e496726128a9', null, null, 'ROLE_STD', '1', '19', '120', null, '156778', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4168', '201230671439', '李洁', '8e506671dd96d1c30f736fd9d708cc4f0f3c26ff', null, null, 'ROLE_STD', '1', '19', '120', null, '156779', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4169', '201230673075', '隋佳欣', 'b5fe28be718018207c4e344063be272c3e2df6c7', null, null, 'ROLE_STD', '1', '19', '120', null, '156780', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4170', '201230672207', '刘方青', '61464588f80c2b0c6c503abf5dd81d72c459a5ce', null, null, 'ROLE_STD', '1', '19', '120', null, '156781', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4171', '201230680189', '夏晗深', '6c0d2c837b933aec7379fb5a4854d450d7c429a0', null, null, 'ROLE_STD', '1', '19', '120', null, '156782', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4172', '201230670302', '程遥', '4f778838f3b69bca42ef1759d77c25f11d5dc901', null, null, 'ROLE_STD', '1', '19', '120', null, '156783', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4173', '201230674058', '杨骏宇', 'd5fe159f08fe0bd4c949ba269eb6042926d1d9cf', null, null, 'ROLE_STD', '1', '19', '120', null, '156784', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4174', '201230680158', '刘翊宸', 'e214b5b55dca6af3fe5e8a7dab6ab68e8be1b66e', null, null, 'ROLE_STD', '1', '19', '120', null, '156785', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4175', '201230673136', '涂友军', '58ffb25f74f527c9893eff06aba87a8f10cc39bd', null, null, 'ROLE_STD', '1', '19', '120', null, '156786', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4176', '201230674355', '张明晗', '4edebea782eb2ee976922bd9bc66abffcaca1022', null, null, 'ROLE_STD', '1', '19', '120', null, '156787', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4177', '201230674201', '袁星', 'a421fe37a2bed3f0a69d76418dbbb4ac05338c8c', null, null, 'ROLE_STD', '1', '19', '120', null, '156788', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4178', '201230680059', '黄树茂', '860bc609b6d3ee043e7522d42fc0a8d1f904ac54', null, null, 'ROLE_STD', '1', '19', '120', null, '156789', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4179', '201230671293', '黄丕臻', 'f6418fabaa796a4fce560a593089b42aceaa6661', null, null, 'ROLE_STD', '1', '19', '120', null, '156790', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4180', '201230670470', '关鑫裕', '911d697ecf2345e5d1b39839f4911bcf23e8e4eb', null, null, 'ROLE_STD', '1', '19', '120', null, '156791', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4181', '201230673105', '谭帅', '9a96578177d7f48609dc4495851ff836168e065f', null, null, 'ROLE_STD', '1', '19', '120', null, '156792', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4182', '201230670180', '陈文花', 'bf7ca0de0d67dc260e847563e9fa146c05c441d2', null, null, 'ROLE_STD', '1', '19', '120', null, '156793', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4183', '201230673259', '王绮媛', 'be1e577a3f4b6dcc5f728b555b4c53430679cb4b', null, null, 'ROLE_STD', '1', '19', '120', null, '156794', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4184', '201230674218', '袁雄峰', '01b760463d29ca2ecb5c9512d9f4a03e96e4b5f8', null, null, 'ROLE_STD', '1', '19', '120', null, '156795', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4185', '201230674195', '袁嘉樑', 'daed00299b120f27102751fb0a627e18cc591214', null, null, 'ROLE_STD', '1', '19', '120', null, '156796', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4186', '201230670173', '陈伟亮', 'e63d9ea51eea212183cea12c9936bf742732070f', null, null, 'ROLE_STD', '1', '19', '120', null, '156797', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4187', '201230672276', '卢启棠', 'b4b41f047f5264df2497d87b0302759f51814564', null, null, 'ROLE_STD', '1', '19', '120', null, '156798', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4188', '201230671163', '胡鹏辉', '6dbc4be3b5bdfa3dc27b87292dae11a1e218478f', null, null, 'ROLE_STD', '1', '19', '120', null, '156799', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4189', '201230671125', '侯书航', '2a2005af9cdc9bec84ed7bebb24b4196fd516154', null, null, 'ROLE_STD', '1', '19', '120', null, '156800', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4190', '201230672320', '罗俊鹏', '120529023c321382e281b311f6040a0bbb564186', null, null, 'ROLE_STD', '1', '19', '120', null, '156801', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4191', '201230673099', '谭铭晖', '29736fdca0934f06845ab25c21a3dc359b0ec4be', null, null, 'ROLE_STD', '1', '19', '120', null, '156802', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4192', '201230674461', '郑泽丹', 'b2f25a9432aa0b477bc5b1cce7b153161f2e2c4d', null, null, 'ROLE_STD', '1', '19', '120', null, '156803', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4193', '201230673334', '巫斌', '27625c70fc188e85de6da17c1aa9fd5479f7b6b7', null, null, 'ROLE_STD', '1', '19', '120', null, '156804', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4194', '201230670029', '蔡家勋', 'd7f6ab8777cfaedad984031caddfb6d38ecacace', null, null, 'ROLE_STD', '1', '19', '120', null, '156805', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4195', '201230670104', '陈俊建', '42af41352dd9e0105ebd096e0f66d75873fee7c0', null, null, 'ROLE_STD', '1', '19', '120', null, '156806', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4196', '201230672177', '林焯俊', 'db57970e80661c4d7bf80fdc02a3b491fc943c45', null, null, 'ROLE_STD', '1', '19', '120', null, '156807', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4197', '201230670135', '陈琼雯', '1789b8de37802be97aecf02518969f1ac4ce0b06', null, null, 'ROLE_STD', '1', '19', '120', null, '156808', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4198', '201230673068', '苏奕嘉', '9bc8819c4b38ba6165ee5ea880c9159d7b9a5e33', null, null, 'ROLE_STD', '1', '19', '120', null, '156809', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4199', '201230672061', '李钟浩', '92fc320ffc0e2a037d86051a3bc45ab593e31ba0', null, null, 'ROLE_STD', '1', '19', '120', null, '156810', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4200', '201230674324', '张凯', '7c9de919bbe28ea09cf96d20b4cf3b6b91d65534', null, null, 'ROLE_STD', '1', '19', '120', null, '156811', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4201', '201230672139', '林群堡', 'be02a590bf1231aca292f3ac15a109bd05faf752', null, null, 'ROLE_STD', '1', '19', '120', null, '156812', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4202', '201230672344', '罗斯尹', 'af19f2ac295af005cd04644bb5d76b12247e32c7', null, null, 'ROLE_STD', '1', '19', '120', null, '156813', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4203', '201230672375', '马啸', 'ea3e8b19b021f588062e5cdec801029258100a43', null, null, 'ROLE_STD', '1', '19', '120', null, '156814', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4204', '201230672184', '林钊', '7845117e3428225997dd43d485bcf67395ae9122', null, null, 'ROLE_STD', '1', '19', '120', null, '156815', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4205', '201230673303', '魏日龙', 'dbbf991b1a53f1875411dcc28d99986a32305acc', null, null, 'ROLE_STD', '1', '19', '120', null, '156816', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4206', '201230671095', '何文杰', '4a5f2e843c1514701c6a69950f9b203b342a17a2', null, null, 'ROLE_STD', '1', '19', '120', null, '156817', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4207', '201230670388', '杜亚超', '055bb0e93a6395e90c5f6727b5480483da5a430b', null, null, 'ROLE_STD', '1', '19', '120', null, '156818', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4208', '201230673273', '韦迪程', '77e71abb4fb5fb7b45c328e8dad941bdbeb03ee5', null, null, 'ROLE_STD', '1', '19', '120', null, '156819', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4209', '201230673464', '修治平', 'ccc41164001a0ea7b8c726b7a149ef6f239a932e', null, null, 'ROLE_STD', '1', '19', '120', null, '156820', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4210', '201230670166', '陈童', '3a9bcf90e5db5e41820f4d73b4154dac97766415', null, null, 'ROLE_STD', '1', '19', '120', null, '156821', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4211', '201230675024', '周科汀', '97e11609e6683dfbf7cde6b35d64168763764da7', null, null, 'ROLE_STD', '1', '19', '120', null, '156822', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4212', '201230673426', '谢明鹏', '72f1070380683c099b81f098c5ce6ca7e1ee8de9', null, null, 'ROLE_STD', '1', '19', '120', null, '156823', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4213', '201230674164', '余田', '727f05606302057664fcc747c4ff7dfa4e763751', null, null, 'ROLE_STD', '1', '19', '120', null, '156824', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4214', '201230675147', '邹龙坤', '3f0d3a01669700c917d28487bc36021778a112b8', null, null, 'ROLE_STD', '1', '19', '120', null, '156825', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4215', '201230673198', '王将兴', '721f5ff6288242b4b5f308c6496688af24d816df', null, null, 'ROLE_STD', '1', '19', '120', null, '156826', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4216', '201230671460', '李绍华', 'f53cbfb6d6158da8d9a364b0e282164f1028bc56', null, null, 'ROLE_STD', '1', '19', '120', null, '156827', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4217', '201230671156', '胡命慧', 'ae4f69516118747f89e55e4b66cd2a81075ffac6', null, null, 'ROLE_STD', '1', '19', '120', null, '156828', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4218', '201230672498', '桑泽西', 'e74fbeff059948cc11d62c5caa7289bbf077dee6', null, null, 'ROLE_STD', '1', '19', '120', null, '156829', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4219', '201130634053', '唐谦', '106077ba47cb5def8bc7ae80adf7fc6f46b56ecd', null, null, 'ROLE_STD', '1', '19', '120', null, '156830', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4220', '201230672023', '李永锋', '28b2b6480c9dbe32516fddea431b64c8e48e2041', null, null, 'ROLE_STD', '1', '19', '120', null, '156831', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4221', '201230670074', '陈楚昭', 'cc5a2452cac46cbf23e3d58dcb2e44c7cf8c7c54', null, null, 'ROLE_STD', '1', '19', '120', null, '156832', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4222', '201230672054', '李志毅', '828d63ad17ae9e2cb971e9ef999cb805dde8b091', null, null, 'ROLE_STD', '1', '19', '120', null, '156833', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4223', '201230670425', '冯伟俊', '87c55df7a5a7e1ab0474128363f9f83ecdfb3296', null, null, 'ROLE_STD', '1', '19', '120', null, '156834', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4224', '201230674430', '郑鸿昇', 'f780d9336b821c9788143cd9f9b6df7b2a74e0e7', null, null, 'ROLE_STD', '1', '19', '120', null, '156835', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4225', '201230672269', '龙钏', 'e87476f36beabe5010b2c2e98aa9836d0f14245f', null, null, 'ROLE_STD', '1', '19', '120', null, '156836', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4226', '201230670234', '陈玉龙', '7346873dc318880732478f8121c85a262d9d4e14', null, null, 'ROLE_STD', '1', '19', '120', null, '156837', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4227', '201230673365', '吴兆峰', '33f25af920801aa0ccbc1388d2ce247697697aee', null, null, 'ROLE_STD', '1', '19', '120', null, '156838', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4228', '201230671088', '何文锋', '2147ce760cdde9b62fde7a887b1e07a5b3ccc3bc', null, null, 'ROLE_STD', '1', '19', '120', null, '156839', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4229', '201230670098', '陈君锐', '8c0c38c8dbe99a9e34e7ab287289b555299ddc3d', null, null, 'ROLE_STD', '1', '19', '120', null, '156840', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4230', '201230671248', '黄德麟', '4558581fee9701a937e0e8ab939b6968a7619b8f', null, null, 'ROLE_STD', '1', '19', '120', null, '156841', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4231', '201230670197', '陈延桐', '1485bac25ee363927e95474d40d19e96201e8e70', null, null, 'ROLE_STD', '1', '19', '120', null, '156842', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4232', '201230672504', '沈加运', '388e4f436ace233468caa3cc052466bba05862f6', null, null, 'ROLE_STD', '1', '19', '120', null, '156843', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4233', '201230670296', '陈奕楷', 'b96f395e871196c38ce9619bd1e13faf0a413bff', null, null, 'ROLE_STD', '1', '19', '120', null, '156844', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4234', '201230672085', '林堉楠', '90c066124509e2abd13bc137354f55104980e802', null, null, 'ROLE_STD', '1', '19', '120', null, '156845', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4235', '201230670081', '陈锦辉', '6971d437fc20642923e1aa1de55236949e3972d8', null, null, 'ROLE_STD', '1', '19', '120', null, '156846', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4236', '201230670210', '陈颖', 'b6ca4bb4392ce4fb47d9890136bc88041f5fd12d', null, null, 'ROLE_STD', '1', '19', '120', null, '156847', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4237', '201230674096', '杨茵荫', '188d53ce8f71db6c10ba8cf40da0b18399872eaf', null, null, 'ROLE_STD', '1', '19', '120', null, '156848', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4238', '201230673488', '许汉彬', '7ee13b4f46a9c466a704a1facf89a31352b1c81b', null, null, 'ROLE_STD', '1', '19', '120', null, '156849', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4239', '201230670128', '陈铭铮', '2ddc548d010cdd3ce61f0ddcaa27da8db0322520', null, null, 'ROLE_STD', '1', '19', '120', null, '156850', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4240', '201230670012', '蔡东旭', 'f3f9799ba71182316a71aedfed34b3262a474f75', null, null, 'ROLE_STD', '1', '19', '120', null, '156851', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4241', '201230671279', '黄思民', '60b3de62b542601a2f01d9739e49a292b0ec3027', null, null, 'ROLE_STD', '1', '19', '120', null, '156852', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4242', '201230672429', '庞赵龙', '54092cc9559dd27f9d79101983d32b4320f8e332', null, null, 'ROLE_STD', '1', '19', '120', null, '156853', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4243', '201230672122', '林钦宝', 'f5a257e3008c676db6aaaa676e821f5980d21e6b', null, null, 'ROLE_STD', '1', '19', '120', null, '156854', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4244', '201230674225', '曾坤鹏', '27e04082276f17815787cb88116f953fe2194ca9', null, null, 'ROLE_STD', '1', '19', '120', null, '156855', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4245', '201230671255', '黄河', '1eec5a39816b35b190e0134ef294e4ee75e5e271', null, null, 'ROLE_STD', '1', '19', '120', null, '156856', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4246', '201230673341', '吴华雄', 'bf87390862822948be829b3e2f1ad004ec3dc018', null, null, 'ROLE_STD', '1', '19', '120', null, '156857', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4247', '201230673204', '王杰', 'f50c8ffe2a4863a4b1eff0d338f247cb4b233756', null, null, 'ROLE_STD', '1', '19', '120', null, '156858', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4248', '201230672306', '吕雅雯', '2c97b5d48f3ae6f6dcb376fd952c3f0e6c87f192', null, null, 'ROLE_STD', '1', '19', '120', null, '156859', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4249', '201230674300', '张杰', '2c589ae426a47442860f06878b79e2521dbf07b5', null, null, 'ROLE_STD', '1', '19', '120', null, '156860', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4250', '201230675062', '周增羽', '2b3c5fd34778c56cab408c5f88092c69a0c8f69f', null, null, 'ROLE_STD', '1', '19', '120', null, '156861', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4251', '201230671132', '胡成豪', '89f823af349d88f0350eaf5472eb019ce737b1c9', null, null, 'ROLE_STD', '1', '19', '120', null, '156862', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4252', '201230672191', '刘丁铭', '2fc1e7a53dcc0c495404ddb5d9c77ee1f692aff3', null, null, 'ROLE_STD', '1', '19', '120', null, '156863', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4253', '201230675161', '邹姣', 'c61f09635dcde5069c28623dacafa35fefa4681c', null, null, 'ROLE_STD', '1', '19', '120', null, '156864', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4254', '201230674126', '叶丽衡', '52489811d1bdaadd83e6072ca29dc82899c8d999', null, null, 'ROLE_STD', '1', '19', '120', null, '156865', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4255', '201230790321', '吴亚辉', 'cef13fca554136c54ec59ea8f2423a41cba153a0', null, null, 'ROLE_STD', '1', '19', '120', null, '156866', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4256', '201230673235', '王艺杰', 'b63b40768481f6ff240232163197f22374e6149e', null, null, 'ROLE_STD', '1', '19', '120', null, '156867', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4257', '201230671187', '胡越项', 'd8f2c785d5afb98d202ed35588ab465609febfcf', null, null, 'ROLE_STD', '1', '19', '120', null, '156868', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4258', '201230670401', '范旭', '14c0f895323b620c98d7abcaa67b5963a5aa707a', null, null, 'ROLE_STD', '1', '19', '120', null, '156869', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4259', '201230810272', '汪宇', 'f2e4061588d5ef39baf1a336f8bc632141185e39', null, null, 'ROLE_STD', '1', '19', '120', null, '156870', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4260', '201230674294', '张佳旭', 'dfe91497b47d3b1d975c8684c19af9c82daacfd6', null, null, 'ROLE_STD', '1', '19', '120', null, '156871', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4261', '201230672481', '屈天浩', '4974fbd43944c7b3ba656d8fbade2eae1a13f7df', null, null, 'ROLE_STD', '1', '19', '120', null, '156872', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4262', '201230672252', '龙逊敏', '4f4cedfc2f6fb31e7843664145b47b143f1196aa', null, null, 'ROLE_STD', '1', '19', '120', null, '156873', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4263', '201230671316', '赖瑶瑶', 'ba4c685800cf0add80af0fbddd5ed3ab41feeb47', null, null, 'ROLE_STD', '1', '19', '120', null, '156874', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4264', '201230673297', '韦文嵚', 'd94b39436eda4c7cbba9b689dcdfd6a00b63a34d', null, null, 'ROLE_STD', '1', '19', '120', null, '156875', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4265', '201230672238', '刘之辉', '25f8522abed9e1d355a25e0484c047be71310c22', null, null, 'ROLE_STD', '1', '19', '120', null, '156876', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4266', '201230673266', '王昕远', '0bf0ea1efc818c30b6ad72b36c6e0c279212a0ba', null, null, 'ROLE_STD', '1', '19', '120', null, '156877', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4267', '201230670449', '傅俊彬', '4dc4bd8c5d0a7abe29d7e3f49d7fadef2178e332', null, null, 'ROLE_STD', '1', '19', '120', null, '156878', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4268', '201230674362', '张宁', '65e27616c68852805314d725bc2ffc2c63403d82', null, null, 'ROLE_STD', '1', '19', '120', null, '156879', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4269', '201230674034', '杨海志', '364e0835b554dec6b1f9806f9885d5e3a0fc2765', null, null, 'ROLE_STD', '1', '19', '120', null, '156880', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4270', '201230674508', '钟益权', 'b4f7e026c0eda09519ff0a199d0aad8d9ab3b842', null, null, 'ROLE_STD', '1', '19', '120', null, '156881', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4271', '201230673044', '苏圣凯', '20ed871af4b57bafbc8dd791e3949c89008ed6e0', null, null, 'ROLE_STD', '1', '19', '120', null, '156882', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4272', '201230674119', '姚佳伟', '50d26ac3c2bb60372a1d25bb4b41b6e9ae93264d', null, null, 'ROLE_STD', '1', '19', '120', null, '156883', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4273', '201230671170', '胡双星', 'e91f45a86e9b95194bf810096db69d2e9b03eb4a', null, null, 'ROLE_STD', '1', '19', '120', null, '156884', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4274', '201230674249', '曾兴', 'b6814a3a5335e9629781a397aebe1d28256d359c', null, null, 'ROLE_STD', '1', '19', '120', null, '156885', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4275', '201230670333', '邓佳鸣', '2629997da22ec3b0866ef76c1438fcbed4c3a688', null, null, 'ROLE_STD', '1', '19', '120', null, '156886', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4276', '201230673471', '徐露', '217e5e2cedd05e949c633b9f6d27a1e9cfbf13c2', null, null, 'ROLE_STD', '1', '19', '120', null, '156887', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4277', '201230680271', '朱晓江', '0f61789b41c02942737e78a113fc1f1ac562d3fc', null, null, 'ROLE_STD', '1', '19', '120', null, '156888', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4278', '201230670463', '龚翔', 'c035a71795600f6e8cf2331c49e9c3f4b4e0ea94', null, null, 'ROLE_STD', '1', '19', '120', null, '156889', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4279', '201230674171', '余钊锴', 'df1742edabb375dbfbed81ce38b3753b085bad26', null, null, 'ROLE_STD', '1', '19', '120', null, '156890', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4280', '201230672047', '李植梓', 'cbcdb41074fe4acaef99a5ee515c8aa051a41b69', null, null, 'ROLE_STD', '1', '19', '120', null, '156891', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4281', '201230674232', '曾庆淼', 'e0f2dd04b7b0f05174f3c47d4cb632b1647de037', null, null, 'ROLE_STD', '1', '19', '120', null, '156892', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4282', '201230670340', '邓伟超', '24f21a665ad8612bd3a431552f4c141599d5bfeb', null, null, 'ROLE_STD', '1', '19', '120', null, '156893', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4283', '201230670456', '甘文彬', 'f588fe7ab087267d9fbaabf9336105c202bda92c', null, null, 'ROLE_STD', '1', '19', '120', null, '156894', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4284', '201230674140', '殷宇周', '637dd3a1ad37fa673fad20a0a70d1ad6d672fb89', null, null, 'ROLE_STD', '1', '19', '120', null, '156895', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4285', '201230672443', '彭诗', 'a544ca1fefa2f4eea2f3ce531d210e04477553a2', null, null, 'ROLE_STD', '1', '19', '120', null, '156896', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4286', '201230671354', '劳智锟', '188319d9ffb46c16e4b855955743fe4469ade294', null, null, 'ROLE_STD', '1', '19', '120', null, '156897', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4287', '201230673419', '肖毅钊', '2b4e1941341ef8759a1a439c2162c3a83288973b', null, null, 'ROLE_STD', '1', '19', '120', null, '156898', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4288', '201230673013', '沈桐', '4b7337a9759dbcc28ef1d2cf953066943ab0fb12', null, null, 'ROLE_STD', '1', '19', '120', null, '156899', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4289', '201230673242', '王永华', 'ffb4528bb013739ee7bd834d40ac294a390b488a', null, null, 'ROLE_STD', '1', '19', '120', null, '156900', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4290', '201230680196', '谢威', '5094c4b11de4125ebbb5fb7596f61679c13d5447', null, null, 'ROLE_STD', '1', '19', '120', null, '156901', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4291', '201230675086', '朱承荣', '1f1f442297bf9b89bd77689c0b16c63fdb82ad89', null, null, 'ROLE_STD', '1', '19', '120', null, '156902', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4292', '201230671057', '韩笑', 'a7a5d497d021809bf453703fc382cca6b26d866a', null, null, 'ROLE_STD', '1', '19', '120', null, '156903', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4293', '201230672313', '吕雯楚', '442a813ea5b2143b8856b086c20138670fa4cdfc', null, null, 'ROLE_STD', '1', '19', '120', null, '156904', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4294', '201230672146', '林袖伦', 'dc26584f1babd0ab76414828601eca16f57976f6', null, null, 'ROLE_STD', '1', '19', '120', null, '156905', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4295', '201230674478', '郑栩燊', '0cd82f3e1e59432e3a440344025634442d891f08', null, null, 'ROLE_STD', '1', '19', '120', null, '156906', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4296', '201230670258', '陈泽锋', 'f8010ad1f68135cbd7b72115913abe26cbdd2dd7', null, null, 'ROLE_STD', '1', '19', '120', null, '156907', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4297', '201230672368', '马凯', 'db3a6cd48be5013cdac1e218cf614769d3b18a39', null, null, 'ROLE_STD', '1', '19', '120', null, '156908', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4298', '201230674454', '郑一锐', 'b7fb3be946252a0c514465d2e2da3d45b2ba6ba6', null, null, 'ROLE_STD', '1', '19', '120', null, '156909', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4299', '201230673402', '肖建恩', 'd3006e8d4b66efec4b63844b13aae10124506848', null, null, 'ROLE_STD', '1', '19', '120', null, '156910', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4300', '201230673358', '吴泽彬', '0bab9f04102a2821b967103e84f171d0402277eb', null, null, 'ROLE_STD', '1', '19', '120', null, '156911', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4301', '201230671149', '胡杰彬', '2aa292d7d218ce265997e2b7e68819da8dbe9bce', null, null, 'ROLE_STD', '1', '19', '120', null, '156912', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4302', '201230670432', '奉慕海', '1cc72c495cad4b2f2ff1bc92033d2a3c652976ad', null, null, 'ROLE_STD', '1', '19', '120', null, '156913', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4303', '201230671408', '李朝晖', '835288227f34947a90d7060c0bbc635ab8aaff80', null, null, 'ROLE_STD', '1', '19', '120', null, '156914', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4304', '201230674379', '张亚卓', 'd6cc9005b73807eba63d2ec4ae7093c4b4a34703', null, null, 'ROLE_STD', '1', '19', '120', null, '156915', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4305', '201230674393', '赵劲松', '4cedf245f8b887b593a62de2207bbdf5782f52a9', null, null, 'ROLE_STD', '1', '19', '120', null, '156916', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4306', '201230671064', '郝一休', 'e8119ecf3ef6ec8c48ebec2a6d6a4376abc0432e', null, null, 'ROLE_STD', '1', '19', '120', null, '156917', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4307', '201230674133', '易振', 'db7054426686c212507bcf4dbc978ebd6a65ea47', null, null, 'ROLE_STD', '1', '19', '120', null, '156918', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4308', '201236675059', '周彦', 'a1dc5a9c199a33b4d951e63f4012a3281bd0f61b', null, null, 'ROLE_STD', '1', '19', '120', null, '156919', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4309', '201230671453', '李俊泽', '85f2bb535ec21a2519c58a9be33cccd7789ce958', null, null, 'ROLE_STD', '1', '19', '120', null, '156920', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4310', '201236674380', '张逸韬', '0e81c2813a13a71e23e33f1f8323c7bd35d7c653', null, null, 'ROLE_STD', '1', '19', '120', null, '156921', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4311', '201230675154', '邹哲鹏', '06f6674290c71a34524e4aa234c326c6fe9321a7', null, null, 'ROLE_STD', '1', '19', '120', null, '156922', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4312', '201230671378', '李焙坚', '2365d676d517ca04fb40d5bbcc075075734a7d2d', null, null, 'ROLE_STD', '1', '19', '120', null, '156923', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4313', '201230671446', '李俊康', 'af7587091f1052341c8d22c1de5450a331d7459f', null, null, 'ROLE_STD', '1', '19', '120', null, '156924', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4314', '201230672337', '罗侨友', '35f5c5e8d93ca0ffa0c87f4b58e0d20fbcb93d4e', null, null, 'ROLE_STD', '1', '19', '120', null, '156925', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4315', '201230673396', '肖凡', '517a2a06fb699eda9eea38ff70327ce538058ea9', null, null, 'ROLE_STD', '1', '19', '120', null, '156926', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4316', '201230674485', '钟沃文', '7d8c7d6a3dfc0110c800a0110a690166e1a1cac5', null, null, 'ROLE_STD', '1', '19', '120', null, '156927', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4317', '201230674447', '郑威狄', '09712ca1baf9065eb6e8131f8b5e2b2e5f8b12fa', null, null, 'ROLE_STD', '1', '19', '120', null, '156928', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4318', '201230671019', '郭力克', '2ac87a9be2212e98a51eda81831df79c2bb8946a', null, null, 'ROLE_STD', '1', '19', '120', null, '156929', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4319', '201230674423', '郑东佳', 'a3d85d30caf9776ed19bc9caf1367e01a0dca8f9', null, null, 'ROLE_STD', '1', '19', '120', null, '156930', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4320', '201230673440', '谢永盛', '5e839a7a47e2923295bae171827cbd3b7149e916', null, null, 'ROLE_STD', '1', '19', '120', null, '156931', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4321', '201230675109', '朱振鹏', '9b3d74e13649f9679e6bac4008949fc25f4770eb', null, null, 'ROLE_STD', '1', '19', '120', null, '156932', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4322', '201230673129', '童昌泰', '3c46363a0971cf31c66b339044e641d8a3b579f7', null, null, 'ROLE_STD', '1', '19', '120', null, '156933', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4323', '201230670418', '方冬晖', '9de25f1986860a38a93ad735c9f2c32d291df2a5', null, null, 'ROLE_STD', '1', '19', '120', null, '156934', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4324', '201230671415', '李聪', '201a68e4232adce8e0633f5fdc9f1e8d7790ede1', null, null, 'ROLE_STD', '1', '19', '120', null, '156935', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4325', '201230670364', '翟泽南', '2255819c3c08027161ff007e05c524db548d5da0', null, null, 'ROLE_STD', '1', '19', '120', null, '156936', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4326', '201230673501', '许雄龙', '41dc3f95b96dd48220ee431c1af31a0b4dd67943', null, null, 'ROLE_STD', '1', '19', '120', null, '156937', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4327', '201230672214', '刘奇鹏', '94353be410e6b5f1161fad54612787d5277956c7', null, null, 'ROLE_STD', '1', '19', '120', null, '156938', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4328', '201230671286', '黄伟鑫', '33eef4c7f548281ab2de993b86fb5e983de6e0f3', null, null, 'ROLE_STD', '1', '19', '120', null, '156939', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4329', '201230675079', '周滋楷', '0204a0a57679431fa929e0870b9944eccd35c8a4', null, null, 'ROLE_STD', '1', '19', '120', null, '156940', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4330', '201230673495', '许杰涛', 'adfaf0be141dbea20d1ec0fadd88d3b7eaebe907', null, null, 'ROLE_STD', '1', '19', '120', null, '156941', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4331', '201230670036', '蔡进坤', '331ed3512411a95daa160b2593ff16e0e1d89c45', null, null, 'ROLE_STD', '1', '19', '120', null, '156942', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4332', '201230674492', '钟小梅', 'ab5176c0fcff916ad2620f204457708ef4889d49', null, null, 'ROLE_STD', '1', '19', '120', null, '156943', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4333', '201230671422', '李关梅', '538f66e6fcad72e3065d9234fced36bc53363ee6', null, null, 'ROLE_STD', '1', '19', '120', null, '156944', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4334', '201230674270', '张晨', 'cc56217eb754fd86e119cdaadded3aa7b831d795', null, null, 'ROLE_STD', '1', '19', '120', null, '156945', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4335', '201230671118', '洪屿', 'df73725d556ed20663989981a0a1d30535a1e317', null, null, 'ROLE_STD', '1', '19', '120', null, '156946', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4336', '201230673228', '王苏飞', '348bc1d734b5726fd80da7859f1eecae09a0d964', null, null, 'ROLE_STD', '1', '19', '120', null, '156947', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4337', '201230670227', '陈宇', 'e9352328bcbac90acd6141ed1de7192117845480', null, null, 'ROLE_STD', '1', '19', '120', null, '156948', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4338', '201230670067', '曹宇栋', '96af4e328a633a4a771f1c1db8618451eb85d091', null, null, 'ROLE_STD', '1', '19', '120', null, '156949', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4339', '201230673211', '王蕊', '3ce7f3c425a1327c0faf21dad99fa16955341687', null, null, 'ROLE_STD', '1', '19', '120', null, '156950', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4340', '201230671194', '胡玮昱', '8d876ec33419ef3e7d960415827a4b23a02c4a08', null, null, 'ROLE_STD', '1', '19', '120', null, '156951', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4341', '201230671262', '黄华庚', '913700b87997c6c285d6514e690172a5495a2ec6', null, null, 'ROLE_STD', '1', '19', '120', null, '156952', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4342', '201230671231', '黄超洋', 'cd84771ba03be2350747e8c9521bc426e6c04af0', null, null, 'ROLE_STD', '1', '19', '120', null, '156953', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4343', '201230674102', '杨颖文', '302c15b8014a7562e58eaf2590e63bc1fb1a642f', null, null, 'ROLE_STD', '1', '19', '120', null, '156954', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4344', '201230671071', '何俊鹏', '6e31198516204e549b262a23222192c4932b2eae', null, null, 'ROLE_STD', '1', '19', '120', null, '156955', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4345', '201230675017', '钟尹琳', '39ee32fdbb8eca8d26bc73baf7c024178c012f2b', null, null, 'ROLE_STD', '1', '19', '120', null, '156956', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4346', '201230674416', '赵英博', '4ca88bece3f9677cdbdeba81b5fd3f3810ac9b82', null, null, 'ROLE_STD', '1', '19', '120', null, '156957', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4347', '201230671361', '黎春朝', '9a026f24869c5adb21d73ce4f8ab5d99175e3ccf', null, null, 'ROLE_STD', '1', '19', '120', null, '156958', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4348', '201230672290', '吕超庆', '0a4087e85e769757b07a1cbbf3c03d0f5d6fbb3b', null, null, 'ROLE_STD', '1', '19', '120', null, '156959', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4349', '201230671491', '李晓刚', '18a2c26661e06a762a736ce0c4fec34025744a48', null, null, 'ROLE_STD', '1', '19', '120', null, '156960', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4350', '201230674089', '杨扬', '3ef4c12d143c4839ddf191e7521072a892a8f58b', null, null, 'ROLE_STD', '1', '19', '120', null, '156961', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4351', '201230674157', '尹太兵', 'e5c629eabd2717036c045dd0b14dc3b40a9096fb', null, null, 'ROLE_STD', '1', '19', '120', null, '156962', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4352', '201230674287', '张鹤', '7619d53e855c2afa4fb669642dd1b6093e1a1f40', null, null, 'ROLE_STD', '1', '19', '120', null, '156963', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4353', '201230670395', '樊佳琦', 'f00ff088565d1087773810b87f5660e61d6c3dae', null, null, 'ROLE_STD', '1', '19', '120', null, '156964', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4354', '201230670043', '蔡敏敏', '10088d61403b57003b852d4c5b4fb2d785425dd3', null, null, 'ROLE_STD', '1', '19', '120', null, '156965', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4355', '201230672153', '林宇鹏', 'f0257affe24019c9f293c2cbb86c65c7c3394a33', null, null, 'ROLE_STD', '1', '19', '120', null, '156966', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4356', '201230671507', '李小龙', '04c2f5c2de042ee762ae9318377fc52443c2a4ff', null, null, 'ROLE_STD', '1', '19', '120', null, '156967', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4357', '201230671484', '李文彬', '09a51c56abf70806231aae480f9948dc3b6745e0', null, null, 'ROLE_STD', '1', '19', '120', null, '156968', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4358', '201230673433', '谢维', 'acd7669f3442a76abaf55d78cab4e3f7f57c995e', null, null, 'ROLE_STD', '1', '19', '120', null, '156969', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4359', '201230671392', '李冰', '286dd103f12de20acbb2702350921b39ae28adef', null, null, 'ROLE_STD', '1', '19', '120', null, '156970', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4360', '201230672245', '龙泉', 'ba0c8a26eb8066dbb715d2cbd64936837a098de5', null, null, 'ROLE_STD', '1', '19', '120', null, '156971', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4361', '201230670319', '邓洪宇', '599a4d4f9ba99851693b600f6b63277fb6148fee', null, null, 'ROLE_STD', '1', '19', '120', null, '156972', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4362', '201230672092', '林桂鸿', '748db3bacb1d8ad5554e6c577dd6999c6b3c4990', null, null, 'ROLE_STD', '1', '19', '120', null, '156973', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4363', '201230670357', '邓玉健', 'c464f0be7bbc9e8d1d5cc7906c76fefe7b9a6bd0', null, null, 'ROLE_STD', '1', '19', '120', null, '156974', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4364', '201230670272', '陈志东', '78594f7a423ac4b436a0fdb9d47f7897ddc248e4', null, null, 'ROLE_STD', '1', '19', '120', null, '156975', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4365', '201230672160', '林振翔', '205e000c4e4c0786f7107ee9f7ad8e4f63b3422d', null, null, 'ROLE_STD', '1', '19', '120', null, '156976', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4366', '201230672221', '刘象星', 'd391d18edc1f6b2c1e19fa04cf9eaebf5863ee0a', null, null, 'ROLE_STD', '1', '19', '120', null, '156977', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4367', '201230672412', '宁海清', '990d8649da4ea9f9f4883d885e65e3b954b55640', null, null, 'ROLE_STD', '1', '19', '120', null, '156978', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4368', '201230672405', '慕军隆', 'e0a03cc81e32e2119640e11f70c88121948d5c17', null, null, 'ROLE_STD', '1', '19', '120', null, '156979', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4369', '201230673112', '唐铭舜', 'b0740bf271ce1e44025af56ae826c7a9c26bca86', null, null, 'ROLE_STD', '1', '19', '120', null, '156980', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4370', '201230674263', '章浩', '9b5c7002fb7804275f593be4a131f6d2f30cab42', null, null, 'ROLE_STD', '1', '19', '120', null, '156981', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4371', '201230675116', '朱紫洁', 'ee238cacf1bf6b11350ecf682dd09b41ed4268cc', null, null, 'ROLE_STD', '1', '19', '120', null, '156982', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4372', '201230675048', '周文童', 'edc18655ca147be92be9ec8090dd12cf09cafa8e', null, null, 'ROLE_STD', '1', '19', '120', null, '156983', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4373', '201230671330', '兰阳', 'a01a2b5eaa12863082a849201d134508055073be', null, null, 'ROLE_STD', '1', '19', '120', null, '156984', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4374', '201230673389', '萧永乐', '826ffba2a5193bac9803b3a91873b8d7b8d0df20', null, null, 'ROLE_STD', '1', '19', '120', null, '156985', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4375', '201230670050', '曹峻许', '866a16a04de742a1d840d47106dfb23b5e7efe2a', null, null, 'ROLE_STD', '1', '19', '120', null, '156986', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4376', '201236673314', '文雨轩', 'af5bee267c00b555dcad1cd1cfb169deaeb0cbed', null, null, 'ROLE_STD', '1', '19', '120', null, '156987', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4377', '201236680121', '刘绍能', 'cf5764e1196cf443455331e0c236e66243337687', null, null, 'ROLE_STD', '1', '19', '120', null, '156988', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4378', '201236680084', '黄倩颖', '8d0899e3159aee28d04e001a3f4499fd80374b79', null, null, 'ROLE_STD', '1', '19', '120', null, '156989', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4379', '201230674331', '张蒙蒙', '74d20c96e117dd0bc849875d83c9d4db3df073bb', null, null, 'ROLE_STD', '1', '19', '120', null, '156990', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4380', '201230674072', '杨轩', '84e5b761ed6e8dce7a1b57f666c59f5b55c5231f', null, null, 'ROLE_STD', '1', '19', '120', null, '156991', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4381', '201236674403', '赵文哲', '39cded47910aed0aeebdc1592624dfb7792842d6', null, null, 'ROLE_STD', '1', '19', '120', null, '156992', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4382', '201236674045', '杨建辉', '216db7abb6fe144c0354eee68a0d7a8d59e61101', null, null, 'ROLE_STD', '1', '19', '120', null, '156993', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4383', '201230671040', '国雍', '6c22d3a68ca0239eed82cc62c6cfb7686c1ac06c', null, null, 'ROLE_STD', '1', '19', '120', null, '156994', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4384', '201230672016', '李印真', '34e6ebd147e9cf42d7ea79298a8f7c27c6949e6c', null, null, 'ROLE_STD', '1', '19', '120', null, '156995', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4385', '201230673082', '孙阔', '851d2d191ed03f458678c751b9ab03436aa4df46', null, null, 'ROLE_STD', '1', '19', '120', null, '156996', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4386', '201230673150', '王晨光', '5e17df06484b760af1039c273fddd6ee60f9fe41', null, null, 'ROLE_STD', '1', '19', '120', null, '156997', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4387', '201230674065', '杨天雄', '7645e660afc42b777e33136cb9c13c1d572c743e', null, null, 'ROLE_STD', '1', '19', '120', null, '156998', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4388', '201230671217', '华健', '09b4fbb1e9dc7cdfed69d10f5a985bfc2c8dcce5', null, null, 'ROLE_STD', '1', '19', '120', null, '156999', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4389', '201230673020', '史嘉帅', 'df66e80418400e2b17f93d3bf3816166d58d3f98', null, null, 'ROLE_STD', '1', '19', '120', null, '157000', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4390', '201230673181', '王健宇', '610154904a72a6b8a19b1b004b2baccad50c65d9', null, null, 'ROLE_STD', '1', '19', '120', null, '157001', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4391', '201230680165', '陆晓丹', '93e206e6580dec42a514542423eb1adeb9828d71', null, null, 'ROLE_STD', '1', '19', '120', null, '157002', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4392', '201230680202', '徐树乔', '9f3a3c0b308181734201fe281604253426342433', null, null, 'ROLE_STD', '1', '19', '120', null, '157003', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4393', '201230680134', '刘晔嘉', '19c7fb2160cccb8074b86ad8c7409868f21b8d56', null, null, 'ROLE_STD', '1', '19', '120', null, '157004', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4394', '201230680219', '张驰', '3775ee9ffe34e03c51e7550e7ce709082e62a365', null, null, 'ROLE_STD', '1', '19', '120', null, '157005', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4395', '201230680035', '傅琚柏', 'c541ce45943bd39c8f9eb26b4d6a453dee0adbcc', null, null, 'ROLE_STD', '1', '19', '120', null, '157006', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4396', '201230680073', '黄泽宇', 'fcad941495384ff1a918b44edd76bd1633d73abf', null, null, 'ROLE_STD', '1', '19', '120', null, '157007', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4397', '201230672382', '马哲家昱', '6824795e5d82c1533edc191711f009161f2df234', null, null, 'ROLE_STD', '1', '19', '120', null, '157008', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4398', '201230674256', '湛伟健', 'e293c3bb9bfb9e274ea242ceddcb5608e41566db', null, null, 'ROLE_STD', '1', '19', '120', null, '157009', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4399', '201230680110', '林城源', '8d43bcb3ca619a38ee26451e8591c6a7f767bb02', null, null, 'ROLE_STD', '1', '19', '120', null, '157010', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4400', '201230680042', '侯福先', '9f99bc257edec6a51a2f8d232346ed956cbb9e7c', null, null, 'ROLE_STD', '1', '19', '120', null, '157011', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4401', '201230680011', '陈汉龙', 'b24b8c5c0a56a241cbc89c8e30e17713a4209206', null, null, 'ROLE_STD', '1', '19', '120', null, '157012', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4402', '201230680028', '邓泳笙', '61aac82061f4bff2213b9e4d67d2373de20820fe', null, null, 'ROLE_STD', '1', '19', '120', null, '157013', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4403', '201230680066', '黄伟燃', '882e06bc41422a1d2fc165b2c800e7df2ae3378a', null, null, 'ROLE_STD', '1', '19', '120', null, '157014', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4404', '201230680172', '吴杰楚', '968ca7718a50ff338d457c3aa7e45ec62d61873a', null, null, 'ROLE_STD', '1', '19', '120', null, '157015', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4405', '201230670494', '桂旭宇', '0c75e0c88c666f84085287b33c17634a9dd56c44', null, null, 'ROLE_STD', '1', '19', '120', null, '157016', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4406', '201230800327', '王逊', 'bb2410afa45c5613f28472602603f08715527169', null, null, 'ROLE_STD', '1', '19', '120', null, '157017', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4407', '201230670142', '陈仁洁', '19ac32436003f27623be9e952f2bcf15439cd503', null, null, 'ROLE_STD', '1', '19', '120', null, '157018', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4408', '201230680240', '郑灶旭', '58f8d877d9555260bd8b8165903df2c1eb02507f', null, null, 'ROLE_STD', '1', '19', '120', null, '157019', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4409', '201230680097', '李培杰', '398e977b8cef1706ec3d8bf97028c23543d8d5e8', null, null, 'ROLE_STD', '1', '19', '120', null, '157020', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4410', '201230680257', '钟晓玲', '504c1fe955258567734a08a35ed99646686c4eb1', null, null, 'ROLE_STD', '1', '19', '120', null, '157021', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4411', '201230680233', '张毅', '8c34da4db2401d13783d9401460cc8010d04a136', null, null, 'ROLE_STD', '1', '19', '120', null, '157022', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4412', '201230680141', '刘钊锋', '7cbd64aa29684a2d9c7a5bd133da49704d589c32', null, null, 'ROLE_STD', '1', '19', '120', null, '157023', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4413', '201230680103', '李树良', '97fc80f22fdf06d6eef054852f6198a156df527b', null, null, 'ROLE_STD', '1', '19', '120', null, '157024', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4414', '201230680226', '张宁', 'c93a54c423e69412a8e4f1db41ae875f28027d5f', null, null, 'ROLE_STD', '1', '19', '120', null, '157025', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4415', '201230680264', '周子程', '09424bee05e37e22acac949cb7ae04584a5089d9', null, null, 'ROLE_STD', '1', '19', '120', null, '157026', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4416', '201236670504', '郭俊嘉', 'dd79ca639b416bd6cec6d8b2acd32b1ef6d47ece', null, null, 'ROLE_STD', '1', '19', '120', null, '157027', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4417', '201330612219', '刘睿', '56f4c87167e01070d7e57053029a290779ab2a06', null, null, 'ROLE_STD', '1', '19', '120', null, '157028', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4418', '201330614046', '谢宜洛', '3f9bdf6002e51c73772ba17f642d23f3862c5a40', null, null, 'ROLE_STD', '1', '19', '120', null, '157029', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4419', '201330612394', '邱伟健', '31cfef3c30cdc1bd9c033e5459a7b1d00109ad35', null, null, 'ROLE_STD', '1', '19', '120', null, '157030', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4420', '201330615050', '张琪琦', '2e6c28294953bd15ceaefe5e1688a19e52ea5262', null, null, 'ROLE_STD', '1', '19', '120', null, '157031', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4421', '201330610413', '傅莘', '954361e9b283c05682b427e834b08adb1a3daaca', null, null, 'ROLE_STD', '1', '19', '120', null, '157032', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4422', '201330614107', '许金键', '914bde4299f8a8d3f0fa5839495b5085e5c94438', null, null, 'ROLE_STD', '1', '19', '120', null, '157033', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4423', '201330610130', '陈梦川', 'eff0aa02912bb51adf2a03d130317c030ed46a66', null, null, 'ROLE_STD', '1', '19', '120', null, '157034', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4424', '201330610338', '邓兆鹏', '3c91962a63427ef8eb8fed3d8d4cdb59a82a5993', null, null, 'ROLE_STD', '1', '19', '120', null, '157035', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4425', '201330614060', '谢永雄', '1af3679dfa19e81a2ac0001bef9bf9a4dec614d3', null, null, 'ROLE_STD', '1', '19', '120', null, '157036', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4426', '201330614121', '薛德钊', '3b1d7e9f5fdd8b8cd97a53d0b4d5a0e44895a722', null, null, 'ROLE_STD', '1', '19', '120', null, '157037', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4427', '201330611397', '李清宇', '6711706dd58f19b00f63a67b9b64f6ba38cfc58d', null, null, 'ROLE_STD', '1', '19', '120', null, '157038', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4428', '201330613322', '温爱卿', 'e2633e2f2874737b4ececa1449f090ee5e5ca5b8', null, null, 'ROLE_STD', '1', '19', '120', null, '157039', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4429', '201330610093', '陈佳德', 'c8e1ebd8a0270cd135df30260016a31fc24c0b93', null, null, 'ROLE_STD', '1', '19', '120', null, '157040', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4430', '201330613070', '唐小丽', '25b5b20031a92fe0b030ba35ae1c857f5b8b78df', null, null, 'ROLE_STD', '1', '19', '120', null, '157041', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4431', '201330611427', '李文基', 'bcaaa33c10a47a64cb3bae152ca9b9e214eebbbd', null, null, 'ROLE_STD', '1', '19', '120', null, '157042', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4432', '201330613346', '翁灿标', 'ce678a1c289f6352f13a3ca7d5ce8d4cb83ffc0f', null, null, 'ROLE_STD', '1', '19', '120', null, '157043', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4433', '201336615184', '朱文俊', 'cf9aa154bd967c15b36cec4aefa421c3a5e414d2', null, null, 'ROLE_STD', '1', '19', '120', null, '157044', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4434', '201330611502', '李尊聪', '2ba2657bd2e48145e19818f9595b5eed9c0cf16b', null, null, 'ROLE_STD', '1', '19', '120', null, '157045', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4435', '201330612042', '梁振中', 'f06af070971799f07dd14d254d3b42621345a62f', null, null, 'ROLE_STD', '1', '19', '120', null, '157046', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4436', '201330612080', '列镇荣', 'c45225b1724d5ab24a41ab49a1c6baf3801b21c9', null, null, 'ROLE_STD', '1', '19', '120', null, '157047', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4437', '201330612103', '林达浩', '073de853c7e3a4b545a009369d6c68c9eefce32f', null, null, 'ROLE_STD', '1', '19', '120', null, '157048', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4438', '201330612158', '林芊芊', '6f2b3d4d4407960f91bbd580986b2f4be981b0be', null, null, 'ROLE_STD', '1', '19', '120', null, '157049', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4439', '201330612141', '林威航', '8c5c5bb49906e11e2c501b90d8881779f96909ae', null, null, 'ROLE_STD', '1', '19', '120', null, '157050', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4440', '201330612165', '刘璟', '2c2f75e24815a6424921bb77daabe1cf93256713', null, null, 'ROLE_STD', '1', '19', '120', null, '157051', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4441', '201330612349', '潘冠昌', '4636f5a9232f5373401f47b80055693710c31b9d', null, null, 'ROLE_STD', '1', '19', '120', null, '157052', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4442', '201330612370', '潘兴焕', '459173128855434182ae13711551c8bee707a68e', null, null, 'ROLE_STD', '1', '19', '120', null, '157053', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4443', '201330612387', '秦瑞潮', 'e68e26cb017ad855402140fa1228d8b3eb4ac236', null, null, 'ROLE_STD', '1', '19', '120', null, '157054', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4444', '201330613292', '王煜飞', 'c5120c94492ed851e382199d62475055703bdf56', null, null, 'ROLE_STD', '1', '19', '120', null, '157055', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4445', '201330613384', '吴炯', 'd8c0f14056ea170bbeb0eedbf590564581b613fa', null, null, 'ROLE_STD', '1', '19', '120', null, '157056', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4446', '201330610178', '陈文发', '9a2b6b0016cfbec8b9b067eededf502c9fb89ce4', null, null, 'ROLE_STD', '1', '19', '120', null, '157057', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4447', '201330611212', '黄泽钦', 'a3594a6e09d90b052ac287e45035ebb43e38b998', null, null, 'ROLE_STD', '1', '19', '120', null, '157058', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4448', '201330611335', '黎晓键', 'ab153525ba1c2e11dcf1cb6fa9df0621bfb87f18', null, null, 'ROLE_STD', '1', '19', '120', null, '157059', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4449', '201330612356', '潘伟强', '133412a0c24ad5cc844115c2bc9f616f39ffe1f6', null, null, 'ROLE_STD', '1', '19', '120', null, '157060', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4450', '201330611021', '郭亦楠', '813f2fa9ea263f17829243243b6b64a9062ec2bc', null, null, 'ROLE_STD', '1', '19', '120', null, '157061', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4451', '201330610239', '陈妍淳', '91b97dc5517cbf66e7c9ea7a751eec123a6a713d', null, null, 'ROLE_STD', '1', '19', '120', null, '157062', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4452', '201330614367', '袁婉珊', 'a78f9f5119ad8889de48692e69c281166ac91e51', null, null, 'ROLE_STD', '1', '19', '120', null, '157063', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4453', '201330614336', '余洋', 'df746ff672036c732fb076ca4d53ed877d9ba3bc', null, null, 'ROLE_STD', '1', '19', '120', null, '157064', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4454', '201336614477', '张梦茜', 'fcee53714edc4be51f10b92e358e60a0b9615c0a', null, null, 'ROLE_STD', '1', '19', '120', null, '157065', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4455', '201336613265', '王子杰', '38d18d22ddc22054440e7b410786933638eb7ff1', null, null, 'ROLE_STD', '1', '19', '120', null, '157066', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4456', '201330613391', '吴树杰', '7166357e5c1b33aa48282cdaa3936a74f6faeb56', null, null, 'ROLE_STD', '1', '19', '120', null, '157067', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4457', '201330613421', '吴志域', 'd85fcd05754ead4c06af470ac92a37116776a952', null, null, 'ROLE_STD', '1', '19', '120', null, '157068', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4458', '201330614404', '詹金钊', 'dfb12673dc0df845a1e94faddbc3dcf61f76991a', null, null, 'ROLE_STD', '1', '19', '120', null, '157069', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4459', '201330611274', '纪程远', '7efc37d5245543e67ad643c21e2e2fb5ffbca701', null, null, 'ROLE_STD', '1', '19', '120', null, '157070', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4460', '201330613483', '肖文浩', 'b07f5ba1535fd8347bccdd92a9bf7789b7fce5b5', null, null, 'ROLE_STD', '1', '19', '120', null, '157071', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4461', '201330615067', '赵孝智', '34cb213bb4d2da581e515b4c7b758596a4b83a24', null, null, 'ROLE_STD', '1', '19', '120', null, '157072', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4462', '201330612363', '潘先杰', '0c2916a265ce557b2e0b9badc8a0704bdc004251', null, null, 'ROLE_STD', '1', '19', '120', null, '157073', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4463', '201330611250', '黄奕君', 'a2c62cd11f2e37d12c0ecf60cb41b9d5c3d9f6c1', null, null, 'ROLE_STD', '1', '19', '120', null, '157074', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4464', '201330612295', '马熙钧', 'be5768455278c5fb078337a5ebc78f0c7375c490', null, null, 'ROLE_STD', '1', '19', '120', null, '157075', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4465', '201330614169', '杨超', '0b5458cd82f628c1ed8a6d531bdbaad0ba190629', null, null, 'ROLE_STD', '1', '19', '120', null, '157076', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4466', '201330614411', '詹凯', 'd55d9d90320124075d993ab15194c5d648802758', null, null, 'ROLE_STD', '1', '19', '120', null, '157077', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4467', '201330613353', '翁东涛', '896b9980597b2103c208bf0d40277f343d23b9cb', null, null, 'ROLE_STD', '1', '19', '120', null, '157078', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4468', '201330612172', '刘良华', 'c4559f340e8471d2726cbff4a715760233f01809', null, null, 'ROLE_STD', '1', '19', '120', null, '157079', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4469', '201330610314', '戴亨祝', 'a098b601692f4394423ae2f790b94e2bbc8e76cb', null, null, 'ROLE_STD', '1', '19', '120', null, '157080', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4470', '201330614398', '曾仕元', 'c8f540297ab15a28a6214492495e0e1dc951d4ee', null, null, 'ROLE_STD', '1', '19', '120', null, '157081', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4471', '201330613117', '王德超', '5077bc43d207ee7a462642eaf5f2a6051cdeffb9', null, null, 'ROLE_STD', '1', '19', '120', null, '157082', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4472', '201330614435', '张恒铭', '5fbdba7b4114189b6349f5397188ff93c2f940b2', null, null, 'ROLE_STD', '1', '19', '120', null, '157083', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4473', '201330614459', '张镜忠', 'd675459cf38c7f5c859da97813ebbbb0aaa4bd7c', null, null, 'ROLE_STD', '1', '19', '120', null, '157084', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4474', '201330615029', '张志峰', 'dd875d92f56d49b62e8935c2504091eeb182f63b', null, null, 'ROLE_STD', '1', '19', '120', null, '157085', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4475', '201330615081', '郑嘉', '5ea0211dff1bbe6ec778ce97be5e55c0943bd650', null, null, 'ROLE_STD', '1', '19', '120', null, '157086', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4476', '201330615210', '庄卓鑫', '1651bcc525bd75842ac83fddd5379485e2f7987a', null, null, 'ROLE_STD', '1', '19', '120', null, '157087', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4477', '201330611137', '黄宏伟', '0e153cf9ef1f86d291df80151bb39015b11c03fa', null, null, 'ROLE_STD', '1', '19', '120', null, '157088', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4478', '201330611168', '黄宁源', '0d3e0f9971bd53afeec98e6b7174e50ed93a792c', null, null, 'ROLE_STD', '1', '19', '120', null, '157089', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4479', '201330611236', '黄志龙', '97431ee8cf838d9bdf78fcb4ef4e1807369dd8c9', null, null, 'ROLE_STD', '1', '19', '120', null, '157090', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4480', '201330612011', '李铖', '59a33557102f5609c6789106802aed727b9f1ad6', null, null, 'ROLE_STD', '1', '19', '120', null, '157091', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4481', '201330611380', '李俊锋', '81626a6ff95449e128aeb14e2cb1c10a3e7b885a', null, null, 'ROLE_STD', '1', '19', '120', null, '157092', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4482', '201330611243', '黄毓盛', '01a1b4ab1aad57c4d0771815b36c77f31a23aa14', null, null, 'ROLE_STD', '1', '19', '120', null, '157093', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4483', '201330614497', '张伟', '02266ac4bcb70ae9462d3eb964f464317888b611', null, null, 'ROLE_STD', '1', '19', '120', null, '157094', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4484', '201330614381', '曾九添', '63dcd77d633e59708c7b2bdaa22ea3b5636a286e', null, null, 'ROLE_STD', '1', '19', '120', null, '157095', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4485', '201330614282', '叶增广', '3ec07f6c2f1090e6bd387303e3a1fb0e76392f63', null, null, 'ROLE_STD', '1', '19', '120', null, '157096', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4486', '201336615153', '周子健', '85fa1c2171475644becfe791103056999b752676', null, null, 'ROLE_STD', '1', '19', '120', null, '157097', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4487', '201369990517', 'NTOLO MPUTU GIRESSE', '25d71a541e5e8f954388999fbfec6f73161e780d', null, null, 'ROLE_STD', '1', '19', '120', null, '157098', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4488', '201330612134', '林顺涛', 'f2eefb1d4c6fe3b0c426f26d849038653aeb6c98', null, null, 'ROLE_STD', '1', '19', '120', null, '157099', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4489', '201330613490', '肖欣', 'df879f7e5dbe1af0301f71bcc81f1a7d323dd1fb', null, null, 'ROLE_STD', '1', '19', '120', null, '157100', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4490', '201330611090', '洪少佳', '7e216a7d899b261af51b6eb425a2993d75c92b92', null, null, 'ROLE_STD', '1', '19', '120', null, '157101', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4491', '201330610215', '陈泽伶', 'bea6e663399f87caa6be880f6f21198d1e2bb9b6', null, null, 'ROLE_STD', '1', '19', '120', null, '157102', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4492', '201330611175', '黄旺', 'bb1382aedf21be5413db109fb67ff5e3e46abb3b', null, null, 'ROLE_STD', '1', '19', '120', null, '157103', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4493', '201330613193', '王帅', 'c5fc07786906a85c4b014d926acbc17949b99469', null, null, 'ROLE_STD', '1', '19', '120', null, '157104', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4494', '201330612196', '刘瑶', '1c82e6bdd17ffff345be45289bc0edb1f06db2bd', null, null, 'ROLE_STD', '1', '19', '120', null, '157105', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4495', '201330612462', '宋定坤', '7290f5a6b8399f6ab5e57205ba32b0d6898caa9c', null, null, 'ROLE_STD', '1', '19', '120', null, '157106', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4496', '201330612486', '宋秋原', 'e48badfc595ac2bbcc9f80838f6f620b3fdf5109', null, null, 'ROLE_STD', '1', '19', '120', null, '157107', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4497', '201330613025', '苏家荣', '2db97c431c3ca0df04377c6837aa57e86a873f58', null, null, 'ROLE_STD', '1', '19', '120', null, '157108', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4498', '201330613032', '苏景强', '4992e97ab3d90796ae88896645ce3fdc3ec28d80', null, null, 'ROLE_STD', '1', '19', '120', null, '157109', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4499', '201330613124', '王尔丞', 'c3a2631970f37a055a16f0c98deb93fa4a3d8602', null, null, 'ROLE_STD', '1', '19', '120', null, '157110', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4500', '201330613148', '王宏法', '82b93064255dcc31400a30bd1d4531ddeafa4c0d', null, null, 'ROLE_STD', '1', '19', '120', null, '157111', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4501', '201330613223', '王亚楠', 'a9c382e4b7de510d17e6f78c5f015a3bb408aefa', null, null, 'ROLE_STD', '1', '19', '120', null, '157112', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4502', '201330610192', '陈旋', 'b21585b6339416365d909548eb9265b9825d2208', null, null, 'ROLE_STD', '1', '19', '120', null, '157113', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4503', '201330614039', '谢雅博', '2529aa7163b12ebe8a5af834f1259c2d7d4fa53c', null, null, 'ROLE_STD', '1', '19', '120', null, '157114', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4504', '201330615098', '郑杰辰', '9bd36a5962d61ad53bc7dc8c88472cd3d28197a0', null, null, 'ROLE_STD', '1', '19', '120', null, '157115', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4505', '201330615104', '郑逸涵', '1c338ced6b7c7a1de72446565a6f0ceeff863b8d', null, null, 'ROLE_STD', '1', '19', '120', null, '157116', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4506', '201330615227', '邹江南', 'cb1834c6b2c3d4e07ba3a828040fe5a84d91ea95', null, null, 'ROLE_STD', '1', '19', '120', null, '157117', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4507', '201330611472', '李忠成', '5d531353394777b20ef6cf2da81f92d1fa153273', null, null, 'ROLE_STD', '1', '19', '120', null, '157118', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4508', '201330612066', '梁昊雨', '5bbd3b430271d42af313aa3731f796f28c23d4f4', null, null, 'ROLE_STD', '1', '19', '120', null, '157119', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4509', '201330613018', '苏航', 'fbb0e8a2f0ea3b37d312dc7a11196ac0cde9e8e2', null, null, 'ROLE_STD', '1', '19', '120', null, '157120', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4510', '201330613278', '王玺', 'eb2946b72942ead92ae97ff4169bd8b59d52ebec', null, null, 'ROLE_STD', '1', '19', '120', null, '157121', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4511', '201330612271', '罗妙音', 'f9fa06201133c08e133917647a65f9d4d8a3422e', null, null, 'ROLE_STD', '1', '19', '120', null, '157122', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4512', '201330613315', '魏育恒', '5ce9a59550b6a0226a4152345bbe135c49ef3e71', null, null, 'ROLE_STD', '1', '19', '120', null, '157123', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4513', '201330612479', '宋立奋', 'c7010634aaae70d71e521fa42ab3c2cc79bc67fc', null, null, 'ROLE_STD', '1', '19', '120', null, '157124', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4514', '201330613049', '孙浩斌', 'b859b50bbdde3ece586f61ec5a95910ecbbcc894', null, null, 'ROLE_STD', '1', '19', '120', null, '157125', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4515', '201330610437', '甘镇伟', '3d962ef5e9ed22556b0573267db506fd7fa3c09d', null, null, 'ROLE_STD', '1', '19', '120', null, '157126', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4516', '201330610468', '高桢', '6481c523265bc660a8350454a0125e76b8b44a77', null, null, 'ROLE_STD', '1', '19', '120', null, '157127', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4517', '201330611434', '李晓兴', 'a0a174e869f64c8b38bb7f2ff2c48152acd3118f', null, null, 'ROLE_STD', '1', '19', '120', null, '157128', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4518', '201330612059', '梁珩琳', 'a7a062b8bdec395fe9de2a9fecea9b2527eab22e', null, null, 'ROLE_STD', '1', '19', '120', null, '157129', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4519', '201330612097', '林超', '0d01547030c79e4a55912875c427547ec3317a0d', null, null, 'ROLE_STD', '1', '19', '120', null, '157130', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4520', '201330612264', '罗钧如', '967648608c25e5ad05544ccee6da3edab3dcab31', null, null, 'ROLE_STD', '1', '19', '120', null, '157131', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4521', '201330612332', '欧伟坚', '9c9a035c6caca7d7ebf02494a7f6864ed86d1565', null, null, 'ROLE_STD', '1', '19', '120', null, '157132', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4522', '201330613186', '王述浩', 'b24b0996d4fbc0d25f21023a6cb1d729bf7717fe', null, null, 'ROLE_STD', '1', '19', '120', null, '157133', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4523', '201330613339', '文生雁', 'ddcc65b0565880cb9b4ef99e94de05af1bad2fa8', null, null, 'ROLE_STD', '1', '19', '120', null, '157134', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4524', '201330610116', '陈俊康', '9827236e946adb88945595157e9ee5189ce4d546', null, null, 'ROLE_STD', '1', '19', '120', null, '157135', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4525', '201330613377', '吴嘉伟', '8a1dcc22a3a67c40e1cda5cbba1054a58fcf3c7c', null, null, 'ROLE_STD', '1', '19', '120', null, '157136', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4526', '201330613414', '吴泽艺', 'dc6eb0a138b6699b7bd9200dc3ddbe9d1e2c4ad9', null, null, 'ROLE_STD', '1', '19', '120', null, '157137', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4527', '201330614350', '袁江超', '7f76de75d08cc11d20de4e6d8516f46c94c34d57', null, null, 'ROLE_STD', '1', '19', '120', null, '157138', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4528', '201330614374', '袁文锦', 'f93ece56d494a62c34451cf6a6d06b8a1b0ca4c3', null, null, 'ROLE_STD', '1', '19', '120', null, '157139', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4529', '201330613100', '汪靖武', '7874109e3213f502a5d14851b24bc003f05782b0', null, null, 'ROLE_STD', '1', '19', '120', null, '157140', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4530', '201330612288', '罗延瀚', 'b6ffa8638ac3d1c2daa873b846a8f5338912bfb8', null, null, 'ROLE_STD', '1', '19', '120', null, '157141', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4531', '201369990500', 'CAO MINSHEN', 'f2df8c39d58c07bad608f36d1023b81a3e8d843b', null, null, 'ROLE_STD', '1', '19', '120', null, '157142', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4532', '201330612127', '林江淼', 'a1c47c644ced0bfc0cfcd98649ab32aa2b94a17e', null, null, 'ROLE_STD', '1', '19', '120', null, '157143', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4533', '201330610260', '陈炫锦', 'a7ee8cb5b6ec894059bac0a625e0037916f511d8', null, null, 'ROLE_STD', '1', '19', '120', null, '157144', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4534', '201330610246', '陈昱成', 'b47d64fd9dd652604b2f605a0465bd5e5ae75ca3', null, null, 'ROLE_STD', '1', '19', '120', null, '157145', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4535', '201330612493', '宋宜心', 'da94a06f0ab7cecba0d838c49dae37248757ec46', null, null, 'ROLE_STD', '1', '19', '120', null, '157146', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4536', '201330613254', '王泽昊', '8688dccd32f36c50a425089acbc0c235d94c3aa9', null, null, 'ROLE_STD', '1', '19', '120', null, '157147', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4537', '201330610017', '敖海珊', '305877ee64a3f926d7b95fc410fc25c5fdab141b', null, null, 'ROLE_STD', '1', '19', '120', null, '157148', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4538', '201330612325', '欧豪哲', '448546ed273d4d12ae054f8e8dad02a54a65e15a', null, null, 'ROLE_STD', '1', '19', '120', null, '157149', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4539', '201330613445', '萧锐杰', '430407e4e8f950e8a9a0ff002f83a44918c5e7c0', null, null, 'ROLE_STD', '1', '19', '120', null, '157150', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4540', '201330614152', '颜凡亨', 'd83070d9790dc22d4bcf2770b6618e1028a04ba7', null, null, 'ROLE_STD', '1', '19', '120', null, '157151', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4541', '201330612233', '龙行', '7f04162f968161051f82e3cc8efdd74d216161d4', null, null, 'ROLE_STD', '1', '19', '120', null, '157152', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4542', '201330611458', '李耀松', '40542b23d11608b7f8ad3c92582df7f4e39764ee', null, null, 'ROLE_STD', '1', '19', '120', null, '157153', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4543', '201330610185', '陈文平', '4b460ae2fcfc18bd6ae0cb70d57000ca5866a75f', null, null, 'ROLE_STD', '1', '19', '120', null, '157154', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4544', '201330610345', '杜舒明', '1f8b6f422d85f6825cc95d006c037ecd118b5c9a', null, null, 'ROLE_STD', '1', '19', '120', null, '157155', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4545', '201330611342', '李超', '3dbcbe94e9a5b629624ccaeaa8e96210a5082c34', null, null, 'ROLE_STD', '1', '19', '120', null, '157156', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4546', '201330612226', '龙贤哲', '9beb9def7d63b5bbf2aef0cadf5b33cf2b4e7956', null, null, 'ROLE_STD', '1', '19', '120', null, '157157', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4547', '201330610024', '蔡利航', '3d669875bdf1f7835e91af53645d82be85cc0e00', null, null, 'ROLE_STD', '1', '19', '120', null, '157158', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4548', '201330612240', '路洲', '622eb253d195e20c737743f54677ba9af7671a60', null, null, 'ROLE_STD', '1', '19', '120', null, '157159', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4549', '201330614077', '谢镇涛', '3d357589185aad615fe0eb9ba3fed549214087f8', null, null, 'ROLE_STD', '1', '19', '120', null, '157160', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4550', '201330614114', '许金龙', '4a48e66d2cc9b1a837953583842442c001a970d0', null, null, 'ROLE_STD', '1', '19', '120', null, '157161', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4551', '201330614251', '叶超林', 'ddfdbc9ca7041fe7b497734c2406a367697ab73c', null, null, 'ROLE_STD', '1', '19', '120', null, '157162', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4552', '201330612110', '林沪', '2b8beb76d640fd1ce24edb8d10271e7384c33e15', null, null, 'ROLE_STD', '1', '19', '120', null, '157163', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4553', '201330614268', '叶汇镓', '8ddce2cfe2889ff6eda571b61d0572c59b2c4486', null, null, 'ROLE_STD', '1', '19', '120', null, '157164', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4554', '201330614275', '叶宇飞', '499d56ccd4b63469273b94561af32ab76dae0080', null, null, 'ROLE_STD', '1', '19', '120', null, '157165', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4555', '201330614299', '叶志欣', '0091e841680113269fae6c13247fb0ad1591ea3b', null, null, 'ROLE_STD', '1', '19', '120', null, '157166', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4556', '201330614329', '游耀祖', '65470bc6f9649a02ff68c15b9e71f154e94d8507', null, null, 'ROLE_STD', '1', '19', '120', null, '157167', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4557', '201330614480', '张庭玮', '85ac99914c47a1eef9e24ae60a8e0f9eb85a741b', null, null, 'ROLE_STD', '1', '19', '120', null, '157168', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4558', '201330615197', '庄磊', '71717206b1e3da78ed02e225ed2662bfb07cdd02', null, null, 'ROLE_STD', '1', '19', '120', null, '157169', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4559', '201330615203', '庄志强', '4237959704547aa7e13d6e8474c059376b5c03b2', null, null, 'ROLE_STD', '1', '19', '120', null, '157170', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4560', '201330610420', '甘迎涛', 'ddaebf8dd330282a9b3430b98eba59b9278d6549', null, null, 'ROLE_STD', '1', '19', '120', null, '157171', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4561', '201330611441', '李雪颖', '504259dbed6b5966966a4c52dbe832da3e345630', null, null, 'ROLE_STD', '1', '19', '120', null, '157172', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4562', '201330615166', '朱成昊', 'db92e7cb872a30af357351c7faf83bd43e09dd20', null, null, 'ROLE_STD', '1', '19', '120', null, '157173', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4563', '201330611328', '雷宏婧', '4529de21b6707c6aab04fdcb68094e20e88bccce', null, null, 'ROLE_STD', '1', '19', '120', null, '157174', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4564', '201330612417', '任百晓', 'c33cf027f320d4a08258bd821bf1a5f01ce8c4d0', null, null, 'ROLE_STD', '1', '19', '120', null, '157175', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4565', '201330610284', '程挚', 'ebbf10685325285ef6fedae011ff5557813a6e94', null, null, 'ROLE_STD', '1', '19', '120', null, '157176', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4566', '201330613094', '田应发', 'a6e2ee0f74ea27fb68551f9163a97a3433ca1ce0', null, null, 'ROLE_STD', '1', '19', '120', null, '157177', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4567', '201330610277', '程帅', '72696ff0eb0ca409d2bd700ff4bf5dd8557ec8f6', null, null, 'ROLE_STD', '1', '19', '120', null, '157178', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4568', '201330614176', '杨航', 'f54d8c5b84d62946b1fb1092b87f5039bf901d84', null, null, 'ROLE_STD', '1', '19', '120', null, '157179', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4569', '201330611304', '兰昕艺', '92a2638b68b0b6fc3346981469f0f436f64614ed', null, null, 'ROLE_STD', '1', '19', '120', null, '157180', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4570', '201330615173', '朱涵泊', 'b3ce66f459411ffc5c886424453ea9d3477c8cab', null, null, 'ROLE_STD', '1', '19', '120', null, '157181', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4571', '201330610482', '郭欢', '3bcec3b4e511ba32e4a2e3e705d27a95f6a66c75', null, null, 'ROLE_STD', '1', '19', '120', null, '157182', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4572', '201330612035', '梁碧文', 'b10764cca008956dde6ea94cf2528c5b44ccfd30', null, null, 'ROLE_STD', '1', '19', '120', null, '157183', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4573', '201369990494', 'SHAIEA JAMAL JAMIL HUSSEIN', 'c55c7c8de7d7b7694c76847c919a317772901677', null, null, 'ROLE_STD', '1', '19', '120', null, '157184', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4574', '201330610499', '郭佳哲', '46d7972fc8a1c0335b26dddfb1a44536ea69c6fa', null, null, 'ROLE_STD', '1', '19', '120', null, '157185', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4575', '201330610321', '戴熹', '4df9def44909c08c8e8ebb31057449b427745f7c', null, null, 'ROLE_STD', '1', '19', '120', null, '157186', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4576', '201330610208', '陈永洪', 'c5bc86011382a2d064bce1a7fb3d032facf4a76f', null, null, 'ROLE_STD', '1', '19', '120', null, '157187', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4577', '201330611151', '黄嘉焕', '2d511fa308cbac780370254038cc73cce782ea47', null, null, 'ROLE_STD', '1', '19', '120', null, '157188', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4578', '201330611267', '黄麒龙', '65bc344165c4003836227fb3b6e5e19562c7046c', null, null, 'ROLE_STD', '1', '19', '120', null, '157189', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4579', '201330612257', '陆乾昱', 'c6157a3c4a07736a935b6c286d60f76167ced7eb', null, null, 'ROLE_STD', '1', '19', '120', null, '157190', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4580', '201330610376', '范朝华', 'eb2f347129229fb9b283932a3d3c078a179c520b', null, null, 'ROLE_STD', '1', '19', '120', null, '157191', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4581', '201330610390', '方美斌', '31105b9ba02c4ba848a93ba9e71a510b928cae64', null, null, 'ROLE_STD', '1', '19', '120', null, '157192', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4582', '201330610444', '甘子成', 'cfc11b7449d311b726a0e94cd1b7b046ae313573', null, null, 'ROLE_STD', '1', '19', '120', null, '157193', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4583', '201330610451', '高朗峰', 'b69a6a1caf7ba90e65162298157c7f5a93cac7f9', null, null, 'ROLE_STD', '1', '19', '120', null, '157194', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4584', '201330610505', '郭俊葆', '5a0c570f21f4a5305d15f685c5b72c580a006343', null, null, 'ROLE_STD', '1', '19', '120', null, '157195', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4585', '201330611038', '韩海生', '81dec7adca3e149f932def903cd571fbe120455b', null, null, 'ROLE_STD', '1', '19', '120', null, '157196', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4586', '201330611182', '黄文锋', '7435d762195d992e129796985fc9cca76e305ad0', null, null, 'ROLE_STD', '1', '19', '120', null, '157197', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4587', '201330611205', '黄泽湧', '0374f69191ad8e330710232b49235566cfe577d3', null, null, 'ROLE_STD', '1', '19', '120', null, '157198', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4588', '201330611229', '黄志纯', '09dc931ae901453441cdaccb2daafd4a82a2cb5e', null, null, 'ROLE_STD', '1', '19', '120', null, '157199', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4589', '201330611359', '李冬', '7124f1eecf9cdf4ae0392ad38f1e41b1c2370c76', null, null, 'ROLE_STD', '1', '19', '120', null, '157200', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4590', '201330613209', '王拓', '1682b96c51ca385c5d48d74857e1ce7ba8964474', null, null, 'ROLE_STD', '1', '19', '120', null, '157201', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4591', '201330615234', '邹帅', '9a8c9860ead71ca725add29139381df12601f369', null, null, 'ROLE_STD', '1', '19', '120', null, '157202', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4592', '201330613087', '陶方舟', '69d9fceb7629a8bc81e1ba070b80e324ddb51b98', null, null, 'ROLE_STD', '1', '19', '120', null, '157203', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4593', '201330613247', '王依桐', 'f37725290cfd53f6224e6939691cbfcf316dedea', null, null, 'ROLE_STD', '1', '19', '120', null, '157204', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4594', '201330613308', '魏华晓', 'c17ff8478d83783c2fa161255626ec8f20462f37', null, null, 'ROLE_STD', '1', '19', '120', null, '157205', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4595', '201330610147', '陈奇', '367d581a1d4961ddf8b4abebfe44e628c8fed09f', null, null, 'ROLE_STD', '1', '19', '120', null, '157206', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4596', '201330610154', '陈书成', '6418edf4dfe10a32b4d0ef706b4db299654bdfd5', null, null, 'ROLE_STD', '1', '19', '120', null, '157207', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4597', '201330610161', '陈伟钊', '959175f4d007e3d43c32a063a925f9f60e61e078', null, null, 'ROLE_STD', '1', '19', '120', null, '157208', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4598', '201330612448', '施涵', 'ef0a0f224a0f3dedd7fd1725e3882db64d729bce', null, null, 'ROLE_STD', '1', '19', '120', null, '157209', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4599', '201330610475', '郭航宇', 'b51384b85addd9f32c25f0f763246a19315c762f', null, null, 'ROLE_STD', '1', '19', '120', null, '157210', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4600', '201330613230', '王一君', '1240cd6025d3d9b824d9da127b2bbad00783ee73', null, null, 'ROLE_STD', '1', '19', '120', null, '157211', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4601', '201330614220', '杨涛', '88286226426208b26803993ecfa784653e8f8e69', null, null, 'ROLE_STD', '1', '19', '120', null, '157212', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4602', '201330614053', '谢永康', '884c34015ffb38d29c232d5b08fa43ee5ad7abe3', null, null, 'ROLE_STD', '1', '19', '120', null, '157213', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4603', '201330614138', '严佳勋', '315b6ef9fa33e28f20c91b5f0d84c776324c9475', null, null, 'ROLE_STD', '1', '19', '120', null, '157214', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4604', '201330610048', '曹志航', '0332f99fad234cbde0b5966c8130d9aa37b4e8a6', null, null, 'ROLE_STD', '1', '19', '120', null, '157215', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4605', '201330615074', '赵啸秋', 'e67985ec7554b0ade42d213faf012fbdd0e3dd5e', null, null, 'ROLE_STD', '1', '19', '120', null, '157216', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4606', '201330610291', '丛士钧', '7a963240b174d02f943a6e4a25ece5624e55980f', null, null, 'ROLE_STD', '1', '19', '120', null, '157217', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4607', '201330611496', '李子龙', 'd5c1532b7aa374c4f84446e68fb457b3d23ed266', null, null, 'ROLE_STD', '1', '19', '120', null, '157218', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4608', '201330611465', '李云飘', 'b45a62544ccdacfd83cf5d591d8fd5a4fe0fed9f', null, null, 'ROLE_STD', '1', '19', '120', null, '157219', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4609', '201330614312', '游海军', '95f820da81b3aa672759373f6be0eeeffd9381f8', null, null, 'ROLE_STD', '1', '19', '120', null, '157220', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4610', '201330615142', '周展皓', '1c0b5101c0772f0239936750971acc089fa9145c', null, null, 'ROLE_STD', '1', '19', '120', null, '157221', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4611', '201330610307', '崔勇带', '4af02f0aa93e1eae87e83e11bcd3b37f5c652a35', null, null, 'ROLE_STD', '1', '19', '120', null, '157222', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4612', '201330613063', '谭傜月', '88ccbbd87e28aaae8b38d2c6bf473ec4154ad65b', null, null, 'ROLE_STD', '1', '19', '120', null, '157223', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4613', '201330614213', '杨民皓', 'e7c99af8c9d271b16afa01159d14747f7d450852', null, null, 'ROLE_STD', '1', '19', '120', null, '157224', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4614', '201369990470', 'TOICHIBAYEV AKMAL', '5846aeeed51eae35f7ad267c83b8a1b4e6c71424', null, null, 'ROLE_STD', '1', '19', '120', null, '157225', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4615', '201369990487', 'KHASSEN TOGZHAN', 'ec53879f9456d7aed59119b7d26284bdf2af12fe', null, null, 'ROLE_STD', '1', '19', '120', null, '157226', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4616', '201330615111', '钟华帅', '16ebd665aed49ecc259de94b0f6543d2c2a11720', null, null, 'ROLE_STD', '1', '19', '120', null, '157227', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4617', '201330613155', '王嘉璇', '58dfb93d6fa1e00f5e1049214d7ddaee45ab7431', null, null, 'ROLE_STD', '1', '19', '120', null, '157228', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4618', '201330610383', '范世杰', 'ad8e202a0993f900254c7ec32403dfcc9def6cfc', null, null, 'ROLE_STD', '1', '19', '120', null, '157229', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4619', '201330612189', '刘晓晗', '95a03c5b73acc05a8d560f9180675cb51b2f38c7', null, null, 'ROLE_STD', '1', '19', '120', null, '157230', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4620', '201330611298', '金悦媛', 'dce4cef146c91a607f0571528b4620d06c0f5685', null, null, 'ROLE_STD', '1', '19', '120', null, '157231', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4621', '201330613469', '肖航', 'ff0888d3d1a4eeb6c90151ff7ab41b0052be17cd', null, null, 'ROLE_STD', '1', '19', '120', null, '157232', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4622', '201330615128', '钟龙文', '35e87b0c027f8579274b42b1fe602c273527d6f5', null, null, 'ROLE_STD', '1', '19', '120', null, '157233', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4623', '201330614428', '詹宇坤', 'd51d695db4899154ac4bb4ec98033a44603026b4', null, null, 'ROLE_STD', '1', '19', '120', null, '157234', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4624', '201330613131', '王非洲', 'ad8f4732b8819506d394b88d103c88ef1ffe2f1c', null, null, 'ROLE_STD', '1', '19', '120', null, '157235', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4625', '201330612318', '聂强', 'b82812cbbe8b232beff8ac21b66ed022e06ff932', null, null, 'ROLE_STD', '1', '19', '120', null, '157236', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4626', '201330612073', '廖明辉', 'f4365bcdfd6647207d8c37573a984ca5ddae47a2', null, null, 'ROLE_STD', '1', '19', '120', null, '157237', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4627', '201330613506', '肖鑫恺', '5d7cb2fe7328a5437703544bfe8cc78b36c69d4d', null, null, 'ROLE_STD', '1', '19', '120', null, '157238', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4628', '201330613285', '王炜恒', '9d936ea576591737935a0b64344de4980c48d74e', null, null, 'ROLE_STD', '1', '19', '120', null, '157239', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4629', '201330611014', '郭思辰', '458352baf1e2c03d01645e9d8702f691837870b3', null, null, 'ROLE_STD', '1', '19', '120', null, '157240', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4630', '201330610031', '曹瑞秋', '607fd48e62caa5850365e87704e15ac4ab050c55', null, null, 'ROLE_STD', '1', '19', '120', null, '157241', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4631', '201330615241', '岑允业', 'f3dec9424318cd655ba321e0b071d575fd5495a4', null, null, 'ROLE_STD', '1', '19', '120', null, '157242', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4632', '201330610079', '陈海龙', 'e512d55ac94dc0b6175cfe986214fe564f964d76', null, null, 'ROLE_STD', '1', '19', '120', null, '157243', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4633', '201330610086', '陈嘉良', '2c7a10b7167484ef66d6829259b5ee7a97613c38', null, null, 'ROLE_STD', '1', '19', '120', null, '157244', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4634', '201330610109', '陈健昌', '9141cc5e0910497090c413eb33d8e3a4ed767750', null, null, 'ROLE_STD', '1', '19', '120', null, '157245', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4635', '201330610123', '陈凯龙', 'dc0104bf8cfae4ca1a7ed9dd01fa6db093849783', null, null, 'ROLE_STD', '1', '19', '120', null, '157246', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4636', '201330611106', '胡浩', '7fcd760fb1f0659d67f101020f740437db48ab5b', null, null, 'ROLE_STD', '1', '19', '120', null, '157247', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4637', '201336610363', '敦天伦', '189d4e3a3e33e092c412f1531837c301474f91c6', null, null, 'ROLE_STD', '1', '19', '120', null, '157248', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4638', '201336610356', '段刘昌', '187cab872591d037d4e494870b99566f86acd3c3', null, null, 'ROLE_STD', '1', '19', '120', null, '157249', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4639', '201330611052', '何隆飞', '008b24181ce996c7a70a0d604a0a7355f79dcebe', null, null, 'ROLE_STD', '1', '19', '120', null, '157250', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4640', '201336611414', '李述彧', 'f3ca9637b4b139e3f2a69af64fab72c02f4d89ba', null, null, 'ROLE_STD', '1', '19', '120', null, '157251', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4641', '201330613452', '肖汉松', '75e546513b8d333a88d87bbb0b2bec74d4bc5dfb', null, null, 'ROLE_STD', '1', '19', '120', null, '157252', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4642', '201330613476', '肖劲', '5f69bc9f832b04698a3eabe06ca1cf03b8b85f84', null, null, 'ROLE_STD', '1', '19', '120', null, '157253', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4643', '201330614466', '张力', '4ad0f7cc1b30fc03db4427c39c0bd109a14e70ff', null, null, 'ROLE_STD', '1', '19', '120', null, '157254', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4644', '201330614503', '张文聪', '80b264a2ff1a300d80eca0c5e362c5f4fcae2610', null, null, 'ROLE_STD', '1', '19', '120', null, '157255', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4645', '201330615012', '张信', 'f7873026b2071a392f0deb0ad4ce506691005a63', null, null, 'ROLE_STD', '1', '19', '120', null, '157256', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4646', '201330615036', '张志伟', 'cac39661a100117b5dd7a4e36dd0441d90ea9fe6', null, null, 'ROLE_STD', '1', '19', '120', null, '157257', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4647', '201330615043', '张宗瀚', 'f13e7ce9e38cd5e6768692188898c651252677c8', null, null, 'ROLE_STD', '1', '19', '120', null, '157258', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4648', '201330611076', '何睿', '5d6d1b7026d6f00928b30096b9149ba1448b63a0', null, null, 'ROLE_STD', '1', '19', '120', null, '157259', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4649', '201330613407', '吴涛宇', 'ee225f4a04fdbe86a6de334e84267553cdc23b3e', null, null, 'ROLE_STD', '1', '19', '120', null, '157260', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4650', '201330614206', '杨克龙', '5b674f9a486af4f72a28c778ee17b409578ef83d', null, null, 'ROLE_STD', '1', '19', '120', null, '157261', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4651', '201330614305', '易川焜', '7ae031932bddf2cbdfd4d90d33a05fd7e4af4708', null, null, 'ROLE_STD', '1', '19', '120', null, '157262', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4652', '201330612455', '司加豪', '2bf8bf46c6928211d73d1d574f90bda8d6ec7142', null, null, 'ROLE_STD', '1', '19', '120', null, '157263', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4653', '201330611069', '何威锐', 'ed5bd68cac334ff1beb0759e3dbf2be1de60b68d', null, null, 'ROLE_STD', '1', '19', '120', null, '157264', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4654', '201330614183', '杨浩雁', '5982a449eb1ab2fc9865e0d7bd79f93990edf807', null, null, 'ROLE_STD', '1', '19', '120', null, '157265', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4655', '201330613056', '孙思雨', 'b56fd850033102278f33e5549629dae2a5b6e684', null, null, 'ROLE_STD', '1', '19', '120', null, '157266', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4656', '201330610222', '陈子豪', '4df66a5a885760209a4fe45bc76a312ae65c9f5c', null, null, 'ROLE_STD', '1', '19', '120', null, '157267', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4657', '201330613438', '夏欢欢', '49bf3c7692598a96242826db9957f03de7f80432', null, null, 'ROLE_STD', '1', '19', '120', null, '157268', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4658', '201330612301', '莫创彪', '06f8c5b82fd37a47465cfe3a77bd48bd7d9fc536', null, null, 'ROLE_STD', '1', '19', '120', null, '157269', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4659', '201369990258', 'SUFIAN FRANCOS', 'a50c7ac09c5edad4422067d2ceb064a78c4a059f', null, null, 'ROLE_STD', '1', '19', '120', null, '157270', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4660', '201330611489', '李壮', 'e3112b3b8abc15d1ba74eaeab9fda572539404a3', null, null, 'ROLE_STD', '1', '19', '120', null, '157271', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4661', '201330611144', '黄济明', '2ddee40ea5b83e6e3efbe23e7258869147df51d1', null, null, 'ROLE_STD', '1', '19', '120', null, '157272', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4662', '201330610406', '冯清泉', '8d5fec1cadaa7044fdf99299a53771610bf98657', null, null, 'ROLE_STD', '1', '19', '120', null, '157273', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4663', '201330611281', '江龙威', '7c56c6fe57a557b9de62de44d38dac1950bac9b7', null, null, 'ROLE_STD', '1', '19', '120', null, '157274', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4664', '201330611113', '黄国裕', '173194899122aeb16fc75e38b21847ca745950aa', null, null, 'ROLE_STD', '1', '19', '120', null, '157275', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4665', '201330611120', '黄悍', '8ae7fdf04eef67984cf05ea48d9118b2be2eafa4', null, null, 'ROLE_STD', '1', '19', '120', null, '157276', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4666', '201335611378', '李嘉正', '0cf020a830c5220ec9218c1b21aa75442bc4a22b', null, null, 'ROLE_STD', '1', '19', '120', null, '157277', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4667', '201330615135', '钟卓良', '57c6b8340da8bd9f9a47fd827d2e9e403b4a97ed', null, null, 'ROLE_STD', '1', '19', '120', null, '157278', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4668', '201330614145', '严家伟', 'c7a5d1419bf4e367eaef1ac3686f4325131865ef', null, null, 'ROLE_STD', '1', '19', '120', null, '157279', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4669', '201330611366', '李冠霄', '2afae75eedd1341714876071eeb0b5f9a28b63b2', null, null, 'ROLE_STD', '1', '19', '120', null, '157280', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4670', '201330611403', '李荣林', 'eeee06fd2d1b070879181b72a6c39b5d31d4fcd7', null, null, 'ROLE_STD', '1', '19', '120', null, '157281', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4671', '201330614190', '杨佳豪', '68dd100117dc3d6c8bd2df6cd0f7d0bf64859f01', null, null, 'ROLE_STD', '1', '19', '120', null, '157282', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4672', '201330613360', '吴晨航', 'da324f86896385715ef9d7342571b92da12900e9', null, null, 'ROLE_STD', '1', '19', '120', null, '157283', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4673', '201330611311', '雷璟', '12f9c640d841eed84b3f4e22adf2afa0d5122f60', null, null, 'ROLE_STD', '1', '19', '120', null, '157284', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4674', '201330610062', '陈丰', 'b6343906901e606009923f6132bf610faaf20249', null, null, 'ROLE_STD', '1', '19', '120', null, '157285', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4675', '201330612424', '沈楚彦', '853951da2e2aeb663d84ae1d9478fc7458042a90', null, null, 'ROLE_STD', '1', '19', '120', null, '157286', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4676', '201330614022', '谢华', '5a5ca2f82f637e971598d9ddcf7ce10928f408f9', null, null, 'ROLE_STD', '1', '19', '120', null, '157287', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4677', '201330620153', '李志奎', 'c1eb24d3c47f69521b356cc24fd7acf27b8dd7ec', null, null, 'ROLE_STD', '1', '19', '120', null, '157288', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4678', '201336612206', '刘忆宁', 'b0f43ab2666f1ac7c31e2e69771b9bcc28a6f90d', null, null, 'ROLE_STD', '1', '19', '120', null, '157289', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4679', '201330620177', '梁世宇', '03d932d2f47a173dd6cf35158b53cf87c27d509c', null, null, 'ROLE_STD', '1', '19', '120', null, '157290', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4680', '201330611045', '何俊鹏', 'c5cd12578a9f0b07125e47c59af74ee3aff14379', null, null, 'ROLE_STD', '1', '19', '120', null, '157291', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4681', '201330614343', '禹盼', '81f685ff5e69d24bb006259b8dbfc43813a257f2', null, null, 'ROLE_STD', '1', '19', '120', null, '157292', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4682', '201330612028', '利润', '3c04c3d5953f8ef7208cc87d2bf1f302d04a05c7', null, null, 'ROLE_STD', '1', '19', '120', null, '157293', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4683', '201330614084', '熊慧', '08a21ee95113c62959a62e2f58e16d16ddfcecb7', null, null, 'ROLE_STD', '1', '19', '120', null, '157294', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4684', '201330611083', '何锴丽', 'b809093e2ec4ffa9e1dd6c55c33d35e2b33575f1', null, null, 'ROLE_STD', '1', '19', '120', null, '157295', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4685', '201336980404', '张永斌', '4916349b9056020375940ece36b5a35ca408c59b', null, null, 'ROLE_STD', '1', '19', '120', null, '157296', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4686', '201330612400', '邱沐坡', '425587353605c54cfab554d3f7eac6396c71250e', null, null, 'ROLE_STD', '1', '19', '120', null, '157297', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4687', '201330620184', '廖晨', '035a9c215c9513941778c5a9a929f2f41fe86f89', null, null, 'ROLE_STD', '1', '19', '120', null, '157298', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4688', '201330620191', '林汤山', 'c2f92bfb8990ee8c868e6cc611788e267e7b4c71', null, null, 'ROLE_STD', '1', '19', '120', null, '157299', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4689', '201330620221', '邱桂柱', '0239c510ac3a9d6c22f456f21ce6ffb5798deac1', null, null, 'ROLE_STD', '1', '19', '120', null, '157300', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4690', '201330620245', '王尚桐', '0c1f9c7c7a0605e4002ce4db963b01261a9b7119', null, null, 'ROLE_STD', '1', '19', '120', null, '157301', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4691', '201330620252', '王志豪', '2cc41dedc55224090d340b68877b74aa0a072be2', null, null, 'ROLE_STD', '1', '19', '120', null, '157302', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4692', '201330620276', '杨柳杰', 'fdd24fd815b35eb858153b74436739eebad26d8a', null, null, 'ROLE_STD', '1', '19', '120', null, '157303', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4693', '201330620290', '姚立洋', '5273a4b4912e68fbe43d43b3149eb0c5c22e2bf2', null, null, 'ROLE_STD', '1', '19', '120', null, '157304', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4694', '201330620030', '陈逸风', '137bef14034b91cc6c09d9e8defea2d969e4cc2a', null, null, 'ROLE_STD', '1', '19', '120', null, '157305', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4695', '201330620054', '邓鹏', '5194feb00aad718f4b839d910b35502e95192cf0', null, null, 'ROLE_STD', '1', '19', '120', null, '157306', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4696', '201330620115', '贾赛奇', '04d34a68d972a4a8a6199fb0c97033f49a3dee2d', null, null, 'ROLE_STD', '1', '19', '120', null, '157307', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4697', '201330620214', '罗忆', '988e84f4e5726811c08fdfd3be413d87be3bb0d0', null, null, 'ROLE_STD', '1', '19', '120', null, '157308', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4698', '201330620092', '胡长铼', '53eedc15cfde42b107bc26f838b040ddae44ee6e', null, null, 'ROLE_STD', '1', '19', '120', null, '157309', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4699', '201330614442', '张健', 'ec23d208a53d5b8a9a626c54a7886a38671a9329', null, null, 'ROLE_STD', '1', '19', '120', null, '157310', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4700', '201330620306', '周志上', '547b0cc556a889cb63e1b849a7a1d2a001beb652', null, null, 'ROLE_STD', '1', '19', '120', null, '157311', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4701', '201336620010', '陈杰通', '9898abcfb421ec063f4155a7cf181c4f0633f66d', null, null, 'ROLE_STD', '1', '19', '120', null, '157312', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4702', '201330614091', '徐凌杰', '578cb86d33cc7859af303f71b6754f1690fc4420', null, null, 'ROLE_STD', '1', '19', '120', null, '157313', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4703', '201336610059', '常诚', 'b5091989f6bc329fecacab7b66ee264afe73d059', null, null, 'ROLE_STD', '1', '19', '120', null, '157314', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4704', '201330620122', '荆姝曼', 'cd43904e5b8948da0b17e43c8bf3d4f6397556ae', null, null, 'ROLE_STD', '1', '19', '120', null, '157315', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4705', '201330620023', '陈秋鑫', 'd32365628b04ba8a89cc82916bb17ac4af20d2a9', null, null, 'ROLE_STD', '1', '19', '120', null, '157316', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4706', '201330620047', '戴政', 'df8236360922a8580b7e30ce68f31ec2a8fb11be', null, null, 'ROLE_STD', '1', '19', '120', null, '157317', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4707', '201330620108', '黄指标', '1a766631359169b881a5342976ac3b73ac125eff', null, null, 'ROLE_STD', '1', '19', '120', null, '157318', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4708', '201330620139', '赖道宽', '68e7c9661ab8e1a7284c251a9c33739ce362f1ca', null, null, 'ROLE_STD', '1', '19', '120', null, '157319', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4709', '201330612509', '苏传宇', 'def431284917f527d1d50fee69d1382236b9f277', null, null, 'ROLE_STD', '1', '19', '120', null, '157320', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4710', '201330613216', '王亚坤', 'fd5a52409e4b57183b5bdc8157f84ac53bb5bfbb', null, null, 'ROLE_STD', '1', '19', '120', null, '157321', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4711', '201330613179', '王韶辉', 'a409e96d55752498fc4388e3ab8a9cca17b9e7bd', null, null, 'ROLE_STD', '1', '19', '120', null, '157322', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4712', '201336620287', '杨琛璟', 'f942df17ccf195caee423d0819c6cd581d633894', null, null, 'ROLE_STD', '1', '19', '120', null, '157323', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4713', '201330612431', '盛逸辰', '89167c0fab0a7cd5ff9ec931f3726fbf018fcd00', null, null, 'ROLE_STD', '1', '19', '120', null, '157324', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4714', '201330620085', '郝俊楠', '7d7b08732cf5465f55b8c2baaf1ea383907127ab', null, null, 'ROLE_STD', '1', '19', '120', null, '157325', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4715', '201330620269', '徐悦', 'b8070a5760ad7dd182c5f1f56437a7b7ff70b4d5', null, null, 'ROLE_STD', '1', '19', '120', null, '157326', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4716', '201330610253', '陈炜炜', 'fb3e4bb56d3a955fe94c76367f03ab04bb0e3d1d', null, null, 'ROLE_STD', '1', '19', '120', null, '157327', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4717', '201330614244', '阳昊', '4272e0b21f4b66ba67390fd825694ab71a4c9d8d', null, null, 'ROLE_STD', '1', '19', '120', null, '157328', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4718', '201330420111', '葛星辰', '2a53d91cd9f4d524f4e712e5c7cf76cb9ba1508d', null, null, 'ROLE_STD', '1', '19', '120', null, '157329', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4719', '201335620066', '甘芷翘', '560f8b31098e02861f7dc83345138aaf78b8307d', null, null, 'ROLE_STD', '1', '19', '120', null, '157330', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4720', '201330620160', '李宓静', 'a6f1b823370aef393472432a35a49d19a6213fab', null, null, 'ROLE_STD', '1', '19', '120', null, '157331', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4721', '201330620078', '葛桂宏', '58347164ba9190780cb87fd9496e0e7d603431fd', null, null, 'ROLE_STD', '1', '19', '120', null, '157332', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4722', '201330620238', '田欢', '81baa5faf0e317e06b88e4c2e4fff76068369e14', null, null, 'ROLE_STD', '1', '19', '120', null, '157333', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4723', '201330614237', '杨宇', 'f1efc88b1626289b536cd9330291df67c7f533d5', null, null, 'ROLE_STD', '1', '19', '120', null, '157334', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4724', '201330620207', '林泳光', 'd14b55dedb8b882de25be989cd275c80318a6910', null, null, 'ROLE_STD', '1', '19', '120', null, '157335', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4725', '201336620140', '李昭宏', '540726a147dba394815b3a3fbda43c88463b987e', null, null, 'ROLE_STD', '1', '19', '120', null, '157336', null, null, null, '1', '1', '1', '1');
INSERT INTO `user` VALUES ('4726', '201330160123', '黄黎龙', '4753afd5aa2abf9fefc2fffbd55dafcfa3210384', null, null, 'ROLE_STD', '1', '19', '120', null, '157337', null, null, null, '1', '1', '1', '1');
