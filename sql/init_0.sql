DROP TABLE IF EXISTS public.role_menu_rel;
DROP TABLE IF EXISTS public.student_course_rel;
DROP TABLE IF EXISTS public.student;
DROP TABLE IF EXISTS public.teacher;
DROP TABLE IF EXISTS public.menu;
DROP TABLE IF EXISTS public.manage_user;
DROP TABLE IF EXISTS public.information;
DROP TABLE IF EXISTS public.course;
DROP TABLE IF EXISTS public.course_academic_year;
DROP TABLE IF EXISTS public.college;
DROP TABLE IF EXISTS public.role;

CREATE TABLE public.college (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  teacherNum INTEGER NOT NULL,
  studentNum INTEGER NOT NULL,
  state varchar(1) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  updateDate SMALLDATETIME NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.college VALUES ('1', '软件工程学院', 0, 0, '1', '2020-07-23 17:43:30', '2020-07-30 10:38:47');
INSERT INTO public.college VALUES ('2', '计算机技术与科学学院', 11, 11, '0', '2020-07-23 17:44:00', '2020-10-12 15:12:24');

CREATE TABLE public.course  (
  id varchar(32) PRIMARY KEY NOT NULL,
  courseName varchar(64) NOT NULL,
  collegeId varchar(32) NOT NULL,
  teacherId varchar(32) NOT NULL,
  classPlace varchar(255) NOT NULL,
  classDate varchar(255) NOT NULL,
  startDate SMALLDATETIME NOT NULL,
  endDate SMALLDATETIME NOT NULL,
  credits DECIMAL(5, 1) NOT NULL,
  academicYear varchar(20) NOT NULL,
  teachEndDate SMALLDATETIME NOT NULL,
  optional INTEGER NOT NULL,
  primaryAmount INTEGER NOT NULL,
  selected INTEGER NOT NULL,
  remark text NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.course VALUES ('1', '计算机网络基础', '1', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 17:44:59', '2020-08-03 17:45:02', 5.0, '2020上半学年', '2020-08-08 17:44:52', 1, 1, 1, '1、页面上方的【选课中心】，然后点击左侧的【推荐选课】...');
INSERT INTO public.course VALUES ('2', '计算机网络基础2', '1', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 17:45:26', '2020-08-03 17:45:29', 5.0, '2020上半学年', '2020-08-03 17:45:31', 32, 1, 12, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('7508a2b591ae4499b3f8d17bc1d6e92a', '计算机网络基础3', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 00:00:00', '2020-08-03 00:00:00', 4.0, '2020上半学年', '2020-08-03 00:00:00', 68, 0, 0, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('8beb093dd8b749e199ff18da3ae2fe20', '计算机网络基础4', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 00:00:00', '2020-08-03 00:00:00', 5.0, '2020上半学年', '2020-08-03 00:00:00', 123, 0, 0, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('d006bccea7654b26b33be71ee5c3197a', '计算机网络基础5', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-07-04 00:00:00', '2020-08-04 00:00:00', 5.0, '2020上半学年', '2020-08-04 00:00:00', 115, 0, 0, '1、页面上方的【选课中心】...');

CREATE TABLE public.course_academic_year  (
  id varchar(32) PRIMARY KEY NOT NULL,
  academicYear varchar(20) NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.course_academic_year VALUES ('1', '2020上半学年', '1');
INSERT INTO public.course_academic_year VALUES ('2', '2020下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('3', '2019上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('4', '2019下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('75ee03db4e09408198f021602baf0ca2', '2021上半学年', '0');

CREATE TABLE public.information  (
  id varchar(32) PRIMARY KEY NOT NULL,
  title varchar(320) NOT NULL,
  content text NOT NULL,
  publishDate SMALLDATETIME NOT NULL,
  roleId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.information VALUES ('1', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>\r\n根据学校教学安排，本学期全校任选课定于6月20日（星期五） 正式开课...', '2020-07-18 23:53:18', '1');
INSERT INTO public.information VALUES ('2', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>\r\n根据学校教学安排...', '2020-07-24 09:47:29', '2');
INSERT INTO public.information VALUES ('3', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>\r\n根据学校教学安排...', '2020-07-24 09:48:09', '3');

CREATE TABLE public.manage_user  (
  id varchar(32) PRIMARY KEY NOT NULL,
  loginName varchar(32) NOT NULL,
  username varchar(32) NOT NULL,
  password varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.manage_user VALUES ('1', 'admin', 'admin', 'admin', '1', '2020-07-18 23:12:53', '1');

CREATE TABLE public.menu  (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  parentId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  createId varchar(32) NOT NULL,
  updateDate SMALLDATETIME NOT NULL,
  sort INTEGER NOT NULL,
  href varchar(64) NOT NULL,
  state varchar(1) NOT NULL,
  remark varchar(2555) NULL DEFAULT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.menu VALUES ('1', '首页', '0', '2020-07-18 23:44:05', '1', '2020-08-18 17:42:18', 1, '/manage/index', '1', '首页数据展示');

CREATE TABLE public.role  (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  createDate SMALLDATETIME NULL DEFAULT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.role VALUES ('1', '系统管理', '2020-07-18 23:14:08', '1');
INSERT INTO public.role VALUES ('2', '教师', '2020-07-18 23:15:04', '1');
INSERT INTO public.role VALUES ('3', '学生', '2020-07-18 23:15:00', '1');
INSERT INTO public.role VALUES ('f1eae1546dbb4b90bb6af3349aacd5a1', '测试角色', '2020-07-31 18:17:56', '1');

CREATE TABLE public.role_menu_rel  (
  id varchar(32) PRIMARY KEY NOT NULL,
  roleId varchar(32),
  menuId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.student  (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentNumber varchar(64) NOT NULL,
  username varchar(64) NOT NULL,
  password varchar(255) NOT NULL,
  phone varchar(11) NOT NULL,
  email varchar(20) NOT NULL,
  roleId varchar(32) NOT NULL,
  collegeId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.student VALUES ('4b34934c56df4bbdae336a334973e7fc', '741011421564111', '夏九幽', '123456', '13945614520', '32541415264@qq.com', '3', '1', '2020-07-17 17:19:08', '1');
INSERT INTO public.student VALUES ('8c367b8b7b6b4f098dd85efc26969daf', '741011421564112', '涂飞', '123456', '15241254520', '654125478962@qq.com', '3', '1', '2020-07-17 17:29:56', '1');
INSERT INTO public.student VALUES ('af82b7bdba124a4e80e17827fad6647d', '741011421564113', '姜太虚', '123456', '13378974152', '49843214567@qq.com', '3', '2', '2020-07-17 17:26:20', '1');
INSERT INTO public.student VALUES ('f1283ca0cb534f979bd1e2a73077b45e', '741011421564114', '段德', '12345', '18345789870', '74851426348@qq.com', '3', '1', '2020-07-17 11:58:10', '1');

CREATE TABLE public.student_course_rel  (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentId varchar(32) NOT NULL,
  courseId varchar(32) NOT NULL,
  teacherId varchar(32) NULL DEFAULT NULL,
  isQualified varchar(1) NULL DEFAULT NULL,
  creditsRemark varchar(255) NULL DEFAULT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.student_course_rel VALUES ('2e8b63dddcf54b0383b317e1a136e868', '4b34934c56df4bbdae336a334973e7fc', '2', NULL, NULL, NULL, '0');
INSERT INTO public.student_course_rel VALUES ('e1c87ea078c44ba5a0ba4362fb196021', '8c367b8b7b6b4f098dd85efc26969daf', '2', NULL, NULL, NULL, '0');
INSERT INTO public.student_course_rel VALUES ('e94080073128488ea889278d1174b723', '4b34934c56df4bbdae336a334973e7fc', '1', NULL, NULL, NULL, '0');

CREATE TABLE public.teacher  (
  id varchar(32)  PRIMARY KEY NOT NULL,
  loginName varchar(64) NOT NULL,
  username varchar(64) NOT NULL,
  password varchar(255) NOT NULL,
  phone varchar(11) NOT NULL,
  email varchar(20) NOT NULL,
  roleId varchar(32) NOT NULL,
  collegeId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.teacher VALUES ('1', '叶凡', '叶凡', '123456', '18385147410', '18414523285@qq.com', '2', '1', '2020-07-17 11:51:24', '1');
INSERT INTO public.teacher VALUES ('2', '庞博', '庞博', '123456', '15345217450', '45147896741@qq.com', '2', '1', '2020-08-01 15:05:43', '1');