-- ============================================================
-- 学生选课管理系统 openGauss 初始化脚本（完整重置：删表 + 重建 + 演示数据）
-- 在 oasys 数据库中一键执行即可。
-- 演示账号：学生 学号 2020001 / 密码 123456（夏九幽，软件工程学院）
--           教师 账号 yefan / 密码 123456（叶凡）
--           管理员 账号 admin / 密码 admin
-- ============================================================

DROP TABLE IF EXISTS public.student_course_rel;
DROP TABLE IF EXISTS public.selection_stage;
DROP TABLE IF EXISTS public.role_menu_rel;
DROP TABLE IF EXISTS public.menu;
DROP TABLE IF EXISTS public.role;
DROP TABLE IF EXISTS public.manage_user;
DROP TABLE IF EXISTS public.information;
DROP TABLE IF EXISTS public.course_academic_year;
DROP TABLE IF EXISTS public.course;
DROP TABLE IF EXISTS public.student;
DROP TABLE IF EXISTS public.teacher;
DROP TABLE IF EXISTS public.college;

-- ------------------------------------------------------------
-- 学院
-- ------------------------------------------------------------
CREATE TABLE public.college (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  teacherNum INTEGER NOT NULL,
  studentNum INTEGER NOT NULL,
  state varchar(1) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  updateDate SMALLDATETIME NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.college VALUES ('1', '软件工程学院', 2, 3, '1', '2020-07-23 17:43:30', '2020-07-30 10:38:47');
INSERT INTO public.college VALUES ('2', '计算机技术与科学学院', 1, 1, '1', '2020-07-23 17:44:00', '2020-10-12 15:12:24');

-- ------------------------------------------------------------
-- 课程
--   选课窗口 startDate/endDate 统一放宽到 2025-2030（选课时间实际由 selection_stage 控制）
--   classDate 格式严格匹配冲突解析：星期X 上午/下午第N节课 a-b周
-- ------------------------------------------------------------
CREATE TABLE public.course (
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

-- 院1 / 2020上半学年 —— 推荐选课候选（同学院、同当前学年、非体育）
INSERT INTO public.course VALUES ('1', '计算机网络基础', '1', '1', '6号主教学楼 202', '星期一 上午第一节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 4.0, '2020上半学年', '2030-12-31 23:59:00', 50, 0, 1, '1、页面上方的【选课中心】，然后点击左侧的【推荐选课】，就进入到推荐选课界面。在【推荐选课】中，学生可以查看自己方案内并且推荐自己（所在行政班）上课的除《体育Ⅱ-Ⅳ》外所有开设的课程。一般都需要修读。<br/>2、选择【选课志愿】，然后点击【选课】按钮，若上课时间不冲突并且有剩余容量时，则选课成功。<br/>3、在【方案内课程选课】中，学生可以选择本专业其他学期的课程【原则上不建议选择】，操作同【推荐选课】（第三、四阶段开放）。<br/>4、在【方案外课程选课】中，学生可以根据自身的特点和兴趣，选择其他专业的专业课程，以扩充自己的知识面，操作同【推荐选课】（第三、四阶段开放）。');
INSERT INTO public.course VALUES ('2', '数据结构', '1', '1', '6号主教学楼 203', '星期二 上午第二节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 4.0, '2020上半学年', '2030-12-31 23:59:00', 50, 0, 0, '1、页面上方的【选课中心】，然后点击左侧的【推荐选课】，就进入到推荐选课界面。在【推荐选课】中，学生可以查看自己方案内并且推荐自己（所在行政班）上课的除《体育Ⅱ-Ⅳ》外所有开设的课程。一般都需要修读。<br/>2、选择【选课志愿】，然后点击【选课】按钮，若上课时间不冲突并且有剩余容量时，则选课成功。<br/>3、在【方案内课程选课】中，学生可以选择本专业其他学期的课程【原则上不建议选择】，操作同【推荐选课】（第三、四阶段开放）。<br/>4、在【方案外课程选课】中，学生可以根据自身的特点和兴趣，选择其他专业的专业课程，以扩充自己的知识面，操作同【推荐选课】（第三、四阶段开放）。');
INSERT INTO public.course VALUES ('3', '操作系统', '1', '2', '6号主教学楼 204', '星期三 下午第一节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 3.0, '2020上半学年', '2030-12-31 23:59:00', 1, 0, 1, '1、页面上方的【选课中心】，然后点击左侧的【推荐选课】，就进入到推荐选课界面。在【推荐选课】中，学生可以查看自己方案内并且推荐自己（所在行政班）上课的除《体育Ⅱ-Ⅳ》外所有开设的课程。一般都需要修读。<br/>2、选择【选课志愿】，然后点击【选课】按钮，若上课时间不冲突并且有剩余容量时，则选课成功。<br/>3、在【方案内课程选课】中，学生可以选择本专业其他学期的课程【原则上不建议选择】，操作同【推荐选课】（第三、四阶段开放）。<br/>4、在【方案外课程选课】中，学生可以根据自身的特点和兴趣，选择其他专业的专业课程，以扩充自己的知识面，操作同【推荐选课】（第三、四阶段开放）。');
-- 院1 / 2020上半学年 / 体育课 —— 演示推荐选课中被排除（courseName 含“体育”）
INSERT INTO public.course VALUES ('4', '体育Ⅱ-Ⅳ', '1', '2', '体育馆', '星期五 下午第三节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 2.0, '2020上半学年', '2030-12-31 23:59:00', 100, 0, 0, '体育Ⅱ-Ⅳ课程不参与推荐选课，由学校统一安排。');
-- 院1 / 其他学期 —— 方案内选课（本专业其他学期课程）
INSERT INTO public.course VALUES ('5', '软件工程导论', '1', '1', '6号主教学楼 301', '星期一 上午第三节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 3.0, '2020下半学年', '2030-12-31 23:59:00', 60, 0, 0, '本专业其他学期课程，方案内选课（第三、四阶段开放）。');
INSERT INTO public.course VALUES ('6', '编译原理', '1', '2', '6号主教学楼 302', '星期四 上午第一节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 4.0, '2019上半学年', '2030-12-31 23:59:00', 40, 0, 0, '本专业其他学期课程，方案内选课（第三、四阶段开放）。');
-- 院2 / 2020上半学年 —— 方案外选课（其他专业课程）；课程8 与课程2 同时段，用于演示时间冲突
INSERT INTO public.course VALUES ('7', '人工智能基础', '2', '3', '2号实验楼 101', '星期二 下午第一节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 3.0, '2020上半学年', '2030-12-31 23:59:00', 80, 0, 0, '其他专业课程，方案外选课（第三、四阶段开放）。');
INSERT INTO public.course VALUES ('8', '计算机组成原理', '2', '3', '2号实验楼 102', '星期二 上午第二节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 4.0, '2020上半学年', '2030-12-31 23:59:00', 80, 0, 0, '其他专业课程，方案外选课（第三、四阶段开放）。与《数据结构》同为星期二上午第二节课，可用于演示上课时间冲突。');
INSERT INTO public.course VALUES ('9', '数据库系统', '2', '3', '2号实验楼 103', '星期四 下午第二节课 1-16周', '2025-01-01 00:00:00', '2030-12-31 23:59:00', 4.0, '2020上半学年', '2030-12-31 23:59:00', 80, 0, 0, '其他专业课程，方案外选课（第三、四阶段开放）。');

-- ------------------------------------------------------------
-- 课程学年（仅 2020上半学年 为当前启用学年 state=1）
-- ------------------------------------------------------------
CREATE TABLE public.course_academic_year (
  id varchar(32) PRIMARY KEY NOT NULL,
  academicYear varchar(20) NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.course_academic_year VALUES ('1', '2020上半学年', '1');
INSERT INTO public.course_academic_year VALUES ('2', '2020下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('3', '2019上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('4', '2019下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('75ee03db4e09408198f021602baf0ca2', '2021上半学年', '0');

-- ------------------------------------------------------------
-- 首页公告
-- ------------------------------------------------------------
CREATE TABLE public.information (
  id varchar(32) PRIMARY KEY NOT NULL,
  title varchar(320) NOT NULL,
  content text NOT NULL,
  publishDate SMALLDATETIME NOT NULL,
  roleId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.information VALUES ('1', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>根据学校教学安排，本学期全校任选课定于6月20日（星期五）正式开课，选课工作将从6月16日开始。现将有关事项通知如下：<br>一、选课时间：6月16日----6月20日<br>二、学生登录选课信息管理系统后进入学生选课进行选课。学生选课前请认真阅读选课公告，再进行"网上选课"。<br>三、教师可登陆选课信息管理系统后进入选课管理增删课程，6月15日14:00之后各位教师及学生登录教务处网站查询自己申报的课程是否停开。<br>四、选课退课均须在选课时间内完成，选课结束后不再进行补退选，请学生注意选课时间。<br>五、请各学院通知并组织学生进行选课，同时请各学院及相关单位通知任课教师按时上课。教务处将组织相关人员对上课情况进行不定期的检查。', '2020-07-18 23:53:18', '1');
INSERT INTO public.information VALUES ('2', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>根据学校教学安排，本学期全校任选课定于6月20日（星期五）正式开课，选课工作将从6月16日开始。现将有关事项通知如下：<br>一、选课时间：6月16日----6月20日<br>二、学生登录选课信息管理系统后进入学生选课进行选课。学生选课前请认真阅读选课公告，再进行"网上选课"。<br>三、教师可登陆选课信息管理系统后进入选课管理增删课程，6月15日14:00之后各位教师及学生登录教务处网站查询自己申报的课程是否停开。<br>四、选课退课均须在选课时间内完成，选课结束后不再进行补退选，请学生注意选课时间。<br>五、请各学院通知并组织学生进行选课，同时请各学院及相关单位通知任课教师按时上课。教务处将组织相关人员对上课情况进行不定期的检查。', '2020-07-24 09:47:29', '2');
INSERT INTO public.information VALUES ('3', '关于本学期校级任选课相关事宜安排的通知', '各学院及相关单位:<br>根据学校教学安排，本学期全校任选课定于6月20日（星期五）正式开课，选课工作将从6月16日开始。现将有关事项通知如下：<br>一、选课时间：6月16日----6月20日<br>二、学生登录选课信息管理系统后进入学生选课进行选课。学生选课前请认真阅读选课公告，再进行"网上选课"。<br>三、教师可登陆选课信息管理系统后进入选课管理增删课程，6月15日14:00之后各位教师及学生登录教务处网站查询自己申报的课程是否停开。<br>四、选课退课均须在选课时间内完成，选课结束后不再进行补退选，请学生注意选课时间。<br>五、请各学院通知并组织学生进行选课，同时请各学院及相关单位通知任课教师按时上课。教务处将组织相关人员对上课情况进行不定期的检查。', '2020-07-24 09:48:09', '3');

-- ------------------------------------------------------------
-- 管理员
-- ------------------------------------------------------------
CREATE TABLE public.manage_user (
  id varchar(32) PRIMARY KEY NOT NULL,
  loginName varchar(32) NOT NULL,
  username varchar(32) NOT NULL,
  password varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.manage_user VALUES ('1', 'admin', 'admin', 'admin', '1', '2020-07-18 23:12:53', '1');

-- ------------------------------------------------------------
-- 菜单
-- ------------------------------------------------------------
CREATE TABLE public.menu (
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
INSERT INTO public.menu VALUES ('1', '首页', '0', '2020-07-18 23:44:05', '1', '2020-08-18 17:42:18', 1, '/manage/index', '0', '首页数据展示');
INSERT INTO public.menu VALUES ('2', '菜单管理', '0', '2020-07-18 23:44:46', '1', '2020-07-18 23:44:51', 2, '/manage/menu', '1', '管理菜单');
INSERT INTO public.menu VALUES ('3', '教务管理', '0', '2020-07-18 23:45:21', '1', '2020-07-18 23:45:21', 3, 'javascript:;', '1', NULL);
INSERT INTO public.menu VALUES ('4', '人员管理', '0', '2020-07-18 23:45:21', '1', '2020-07-23 17:50:11', 4, 'javascript:;', '1', 'undefined');
INSERT INTO public.menu VALUES ('5', '角色管理', '0', '2020-07-18 23:45:21', '1', '2020-07-18 23:45:21', 5, 'javascript:;', '1', NULL);
INSERT INTO public.menu VALUES ('6', '学院管理', '3', '2020-07-20 10:13:28', '1', '2020-07-20 10:13:28', 1, '/manage/college', '1', NULL);
INSERT INTO public.menu VALUES ('7', '首页通告管理', '3', '2020-07-20 10:13:28', '1', '2020-08-17 18:20:31', 2, '/manage/information', '1', NULL);
INSERT INTO public.menu VALUES ('8', '教师管理', '4', '2020-07-20 10:14:42', '1', '2020-07-20 10:14:42', 1, '/manage/teacher', '1', NULL);
INSERT INTO public.menu VALUES ('9', '学生管理', '4', '2020-07-20 10:14:42', '1', '2020-07-20 10:14:42', 2, '/manage/student', '1', NULL);
INSERT INTO public.menu VALUES ('10', '角色分配', '5', '2020-07-20 10:14:42', '1', '2020-07-20 10:14:42', 1, '/manage/role', '1', '管理角色分配菜单');
INSERT INTO public.menu VALUES ('11', '课程管理', '0', '2020-08-03 16:29:02', '1', '2020-08-05 08:51:05', 6, 'javascript:;', '1', '课程管理');
INSERT INTO public.menu VALUES ('88bd8c79792346058d2bcd0ef831ec61', '选课中心', '0', '2020-08-04 08:13:45', '1', '2020-08-04 08:13:45', 7, '/student/courseCase', '1', '学生选课中心');
INSERT INTO public.menu VALUES ('ca437bc787404b938308d68925b50f9b', '已选课程', '0', '2020-08-04 08:15:01', '1', '2020-08-04 08:15:01', 8, '/student/selectedCourse', '1', '学生选择的课程');
INSERT INTO public.menu VALUES ('d4100b530ff9403c9f576138006d269f', '选课统计', '0', '2020-08-04 08:16:21', '1', '2020-08-04 08:16:21', 9, '/student/statistical', '1', '学生选课统计');
INSERT INTO public.menu VALUES ('5b185f5d08224728903575552e15dbf8', '选课管理', '11', '2020-08-05 08:50:12', '1', '2020-08-18 15:20:29', 2, '/course/list', '1', '选课管理');
INSERT INTO public.menu VALUES ('dacb9a4039a34aeb8ae834d409de6082', '学年管理', '11', '2020-08-05 08:50:53', '1', '2020-08-18 15:20:38', 1, '/course/courseAcademicYear', '1', '课程学年管理');
INSERT INTO public.menu VALUES ('b69d605f77214bb889c14690ae34150d', '课程信息', '0', '2020-08-05 14:40:25', '1', '2020-08-05 14:40:25', 2, '/teacher/courseInfo', '1', '教师分配的课程信息');
INSERT INTO public.menu VALUES ('8d1ba0638b474dafa943891b14d17f97', '学生信息', '0', '2020-08-18 15:09:17', '1', '2020-08-18 15:11:08', 3, '/teacher/selectedCourseStu', '1', '选修当前课程的学生');
INSERT INTO public.menu VALUES ('e8902e1c3e70451e9fa204b423bd33ec', '成绩管理', '0', '2020-08-05 14:42:54', '1', '2020-08-05 14:43:02', 3, '/teacher/scoreInfo', '1', '教师菜单，学生成绩管理');
INSERT INTO public.menu VALUES ('f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6', '统计信息', '0', '2020-08-05 14:43:30', '1', '2020-08-05 14:43:30', 4, '/teacher/statisticalInfo', '1', '教师统计信息');

-- ------------------------------------------------------------
-- 角色
-- ------------------------------------------------------------
CREATE TABLE public.role (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  createDate SMALLDATETIME NULL DEFAULT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.role VALUES ('1', '管理员', '2020-07-18 23:12:53', '1');
INSERT INTO public.role VALUES ('2', '教师', '2020-07-18 23:12:53', '1');
INSERT INTO public.role VALUES ('3', '学生', '2020-07-18 23:12:53', '1');

-- ------------------------------------------------------------
-- 角色菜单关联
-- ------------------------------------------------------------
CREATE TABLE public.role_menu_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  roleId varchar(32) NOT NULL,
  menuId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);
INSERT INTO public.role_menu_rel VALUES ('1', '1', '1');
INSERT INTO public.role_menu_rel VALUES ('2', '1', '2');
INSERT INTO public.role_menu_rel VALUES ('3', '1', '3');
INSERT INTO public.role_menu_rel VALUES ('4', '1', '4');
INSERT INTO public.role_menu_rel VALUES ('5', '1', '5');
INSERT INTO public.role_menu_rel VALUES ('6', '1', '6');
INSERT INTO public.role_menu_rel VALUES ('7', '1', '7');
INSERT INTO public.role_menu_rel VALUES ('8', '1', '8');
INSERT INTO public.role_menu_rel VALUES ('9', '1', '9');
INSERT INTO public.role_menu_rel VALUES ('10', '1', '10');
INSERT INTO public.role_menu_rel VALUES ('11', '1', '11');
INSERT INTO public.role_menu_rel VALUES ('12', '1', '5b185f5d08224728903575552e15dbf8');
INSERT INTO public.role_menu_rel VALUES ('13', '1', 'dacb9a4039a34aeb8ae834d409de6082');
INSERT INTO public.role_menu_rel VALUES ('14', '2', '1');
INSERT INTO public.role_menu_rel VALUES ('15', '2', 'b69d605f77214bb889c14690ae34150d');
INSERT INTO public.role_menu_rel VALUES ('16', '2', '8d1ba0638b474dafa943891b14d17f97');
INSERT INTO public.role_menu_rel VALUES ('17', '2', 'e8902e1c3e70451e9fa204b423bd33ec');
INSERT INTO public.role_menu_rel VALUES ('18', '2', 'f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6');
INSERT INTO public.role_menu_rel VALUES ('19', '3', '88bd8c79792346058d2bcd0ef831ec61');
INSERT INTO public.role_menu_rel VALUES ('20', '3', 'ca437bc787404b938308d68925b50f9b');
INSERT INTO public.role_menu_rel VALUES ('21', '3', 'd4100b530ff9403c9f576138006d269f');

-- ------------------------------------------------------------
-- 学生（密码统一 123456，均为正常状态）
-- ------------------------------------------------------------
CREATE TABLE public.student (
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
INSERT INTO public.student VALUES ('1', '2020001', '夏九幽', '123456', '13800000001', 'xjy@test.com', '3', '1', '2020-07-23 17:50:00', '1');
INSERT INTO public.student VALUES ('2', '2020002', '涂飞', '123456', '13800000002', 'tf@test.com', '3', '1', '2020-07-23 17:51:00', '1');
INSERT INTO public.student VALUES ('3', '2020003', '姜太虚', '123456', '13800000003', 'jtx@test.com', '3', '2', '2020-07-23 17:52:00', '1');
INSERT INTO public.student VALUES ('4', '2020004', '段德', '123456', '13800000004', 'dd@test.com', '3', '1', '2020-07-23 17:53:00', '1');

-- ------------------------------------------------------------
-- 教师（密码统一 123456）
-- ------------------------------------------------------------
CREATE TABLE public.teacher (
  id varchar(32) PRIMARY KEY NOT NULL,
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
INSERT INTO public.teacher VALUES ('1', 'yefan', '叶凡', '123456', '13900000001', 'yf@test.com', '2', '1', '2020-07-23 17:44:00', '1');
INSERT INTO public.teacher VALUES ('2', 'pangbo', '庞博', '123456', '13900000002', 'pb@test.com', '2', '1', '2020-07-23 17:45:00', '1');
INSERT INTO public.teacher VALUES ('3', 'xiaoyan', '萧炎', '123456', '13900000003', 'xy@test.com', '2', '2', '2020-07-23 17:46:00', '1');

-- ------------------------------------------------------------
-- 学生选课关联
--   isQualified/creditsRemark/state/selectionType 设默认值，选课时由后端填充 teacherId
--   预置：夏九幽(1) 已选 计算机网络基础(1)；涂飞(2) 已选 操作系统(3)（占满其唯一名额，演示“已满”）
-- ------------------------------------------------------------
CREATE TABLE public.student_course_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentId varchar(32) NOT NULL,
  courseId varchar(32) NOT NULL,
  teacherId varchar(32) NOT NULL,
  isQualified varchar(1) DEFAULT '0',
  creditsRemark varchar(255) DEFAULT ' ',
  state varchar(1) DEFAULT '0',
  selectionType varchar(20) DEFAULT 'recommend'
) WITH (ORIENTATION = ROW);
INSERT INTO public.student_course_rel VALUES ('1', '1', '1', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('2', '2', '3', '2', '0', ' ', '0', 'recommend');

-- ------------------------------------------------------------
-- 选课阶段控制
--   stage005（2025-2030）为当前演示阶段，推荐/方案内/方案外全部开放
-- ------------------------------------------------------------
CREATE TABLE public.selection_stage (
  id varchar(32) PRIMARY KEY,
  academicYear varchar(20) NOT NULL,
  stageName varchar(64) NOT NULL,
  stageOrder INTEGER NOT NULL,
  startDate TIMESTAMP NOT NULL,
  endDate TIMESTAMP NOT NULL,
  allowRecommend varchar(1) DEFAULT '1',
  allowPlan varchar(1) DEFAULT '0',
  allowOutside varchar(1) DEFAULT '0',
  state varchar(1) DEFAULT '1'
) WITH (ORIENTATION = ROW);
INSERT INTO public.selection_stage VALUES ('stage001', '2020上半学年', '第一阶段-推荐选课', 1, '2020-07-01 00:00:00', '2020-08-15 23:59:59', '1', '0', '0', '1');
INSERT INTO public.selection_stage VALUES ('stage002', '2020上半学年', '第二阶段-推荐选课', 2, '2020-08-16 00:00:00', '2020-09-15 23:59:59', '1', '0', '0', '1');
INSERT INTO public.selection_stage VALUES ('stage003', '2020上半学年', '第三阶段-全面选课', 3, '2020-09-16 00:00:00', '2020-10-15 23:59:59', '1', '1', '1', '1');
INSERT INTO public.selection_stage VALUES ('stage004', '2020上半学年', '第四阶段-补退选', 4, '2020-10-16 00:00:00', '2020-11-15 23:59:59', '1', '1', '1', '1');
INSERT INTO public.selection_stage VALUES ('stage005', '2020上半学年', '当前演示阶段-全面开放', 5, '2025-01-01 00:00:00', '2030-12-31 23:59:59', '1', '1', '1', '1');
