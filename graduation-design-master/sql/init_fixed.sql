DROP TABLE IF EXISTS public.selection_stage;
DROP TABLE IF EXISTS public.student_course_rel;
DROP TABLE IF EXISTS public.role_menu_rel;
DROP TABLE IF EXISTS public.teacher;
DROP TABLE IF EXISTS public.student;
DROP TABLE IF EXISTS public.manage_user;
DROP TABLE IF EXISTS public.course;
DROP TABLE IF EXISTS public.menu;
DROP TABLE IF EXISTS public.information;
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

CREATE TABLE public.role (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  createDate SMALLDATETIME NULL DEFAULT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.manage_user (
  id varchar(32) PRIMARY KEY NOT NULL,
  loginName varchar(32) NOT NULL,
  username varchar(32) NOT NULL,
  password varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.menu (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  parentId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  createId varchar(32) NOT NULL,
  updateDate SMALLDATETIME NOT NULL,
  sort INTEGER NOT NULL,
  href varchar(64) NULL,
  state varchar(1) NOT NULL,
  remark varchar(2555) NULL DEFAULT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.role_menu_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  roleId varchar(32),
  menuId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.course_academic_year (
  id varchar(32) PRIMARY KEY NOT NULL,
  academicYear varchar(20) NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.information (
  id varchar(32) PRIMARY KEY NOT NULL,
  title varchar(320) NOT NULL,
  content text NOT NULL,
  publishDate SMALLDATETIME NOT NULL,
  roleId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.teacher (
  id varchar(32) PRIMARY KEY NOT NULL,
  loginName varchar(64) NOT NULL,
  username varchar(64) NOT NULL,
  password varchar(255) NOT NULL,
  phone varchar(11) NOT NULL,
  email varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  collegeId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.student (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentNumber varchar(64) NOT NULL,
  username varchar(64) NOT NULL,
  password varchar(255) NOT NULL,
  phone varchar(11) NOT NULL,
  email varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  collegeId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL
) WITH (ORIENTATION = ROW);

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
  remark text NULL,
  state varchar(1) NOT NULL DEFAULT '1'
) WITH (ORIENTATION = ROW);

CREATE TABLE public.student_course_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentId varchar(32) NOT NULL,
  courseId varchar(32) NOT NULL,
  teacherId varchar(32) NULL DEFAULT NULL,
  isQualified varchar(1) NULL DEFAULT NULL,
  creditsRemark varchar(255) NULL DEFAULT NULL,
  state varchar(1) NOT NULL,
  selectionType varchar(20) NULL DEFAULT NULL
) WITH (ORIENTATION = ROW);

CREATE TABLE public.selection_stage (
  id varchar(32) PRIMARY KEY NOT NULL,
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

INSERT INTO public.role VALUES ('1', '系统管理', '2020-07-18 23:14:08', '1');
INSERT INTO public.role VALUES ('2', '教师', '2020-07-18 23:15:04', '1');
INSERT INTO public.role VALUES ('3', '学生', '2020-07-18 23:15:00', '1');
INSERT INTO public.role VALUES ('f1eae1546dbb90bb6af3349aacd5a1', '测试角色', '2020-07-31 18:17:56', '1');

INSERT INTO public.college VALUES ('1', '软件工程学院', 2, 6, '1', '2020-07-23 17:43:30', '2025-02-15 10:38:47');
INSERT INTO public.college VALUES ('2', '计算机科学与技术学院', 2, 4, '1', '2020-07-23 17:44:00', '2025-02-15 15:12:24');
INSERT INTO public.college VALUES ('3', '数学学院', 2, 4, '1', '2021-03-01 09:00:00', '2025-02-20 11:30:00');
INSERT INTO public.college VALUES ('4', '外国语学院', 2, 4, '1', '2021-03-01 09:00:00', '2025-02-20 14:00:00');
INSERT INTO public.college VALUES ('5', '电子信息工程学院', 2, 4, '1', '2021-03-01 09:00:00', '2025-02-20 16:20:00');
INSERT INTO public.college VALUES ('6', '经济管理学院', 0, 4, '1', '2021-03-01 09:00:00', '2025-02-20 17:45:00');

INSERT INTO public.manage_user VALUES ('1', 'admin', 'admin', 'admin', '1', '2020-07-18 23:12:53', '1');

INSERT INTO public.teacher VALUES ('1', '叶凡', '叶凡', '123456', '18385147410', '18414523285@qq.com', '2', '1', '2020-07-17 11:51:24', '1');
INSERT INTO public.teacher VALUES ('2', '庞博', '庞博', '123456', '15345217450', '45147896741@qq.com', '2', '1', '2020-08-01 15:05:43', '1');
INSERT INTO public.teacher VALUES ('3', '陈明华', '陈明华', '123456', '13678945210', 'chenmh@university.edu.cn', '2', '2', '2021-03-10 09:00:00', '1');
INSERT INTO public.teacher VALUES ('4', '刘洋', '刘洋', '123456', '15874123650', 'liuyang@university.edu.cn', '2', '2', '2021-03-10 09:30:00', '1');
INSERT INTO public.teacher VALUES ('5', '王建国', '王建国', '123456', '13012345678', 'wangjg@university.edu.cn', '2', '3', '2021-03-10 10:00:00', '1');
INSERT INTO public.teacher VALUES ('6', '张丽', '张丽', '123456', '18698745632', 'zhangli@university.edu.cn', '2', '3', '2021-03-10 10:30:00', '1');
INSERT INTO public.teacher VALUES ('7', '赵雪梅', '赵雪梅', '123456', '13556789012', 'zhaoxm@university.edu.cn', '2', '4', '2021-03-10 11:00:00', '1');
INSERT INTO public.teacher VALUES ('8', '黄丹', '黄丹', '123456', '15098761234', 'huangdan@university.edu.cn', '2', '4', '2021-03-10 11:30:00', '1');
INSERT INTO public.teacher VALUES ('9', '周强', '周强', '123456', '13845678901', 'zhouqiang@university.edu.cn', '2', '5', '2021-03-10 14:00:00', '1');
INSERT INTO public.teacher VALUES ('10', '韩雪', '韩雪', '123456', '18912345678', 'hanxue@university.edu.cn', '2', '5', '2021-03-10 14:30:00', '1');

INSERT INTO public.student VALUES ('s001', '2025001', '夏九幽', '123456', '13945614520', 'xiajy@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s002', '2025002', '涂飞', '123456', '15241254520', 'tufei@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s003', '2025003', '姜太虚', '123456', '13378974152', 'jiangtx@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s004', '2025004', '段德', '123456', '18345789870', 'duande@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s005', '2025005', '林云', '123456', '13712345001', 'linyun@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s006', '2025006', '苏毅', '123456', '13812345002', 'suyi@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s007', '2025007', '叶凡辰', '123456', '13612345003', 'yefc@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s008', '2025008', '陈浩', '123456', '15812345004', 'chenhao@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s009', '2025009', '吴峰', '123456', '18712345005', 'wufeng@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s010', '2025010', '张华', '123456', '13012345006', 'zhanghua@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s011', '2025011', '秦瑶', '123456', '13512345007', 'qinyao@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s012', '2025012', '郑浩', '123456', '18612345008', 'zhenghao@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s013', '2025013', '韩雪梅', '123456', '15912345009', 'hanxm@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s014', '2025014', '刘明', '123456', '13712345010', 'liuming@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s015', '2025015', '钱玲', '123456', '18812345011', 'qianling@qq.com', '3', '4', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s016', '2025016', '周琳', '123456', '13612345012', 'zhoulin@qq.com', '3', '4', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s017', '2025017', '王芳', '123456', '15712345013', 'wangfang@qq.com', '3', '4', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s018', '2025018', '陈婷', '123456', '13812345014', 'chent@qq.com', '3', '4', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s019', '2025019', '孙伟', '123456', '18912345015', 'sunwei@qq.com', '3', '5', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s020', '2025020', '何明', '123456', '13012345016', 'heming@qq.com', '3', '5', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s021', '2025021', '李强', '123456', '15612345017', 'liqiang@qq.com', '3', '5', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s022', '2025022', '马超', '123456', '18712345018', 'machao@qq.com', '3', '5', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s023', '2025023', '杨婷', '123456', '13512345019', 'yangting@qq.com', '3', '6', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s024', '2025024', '赵磊', '123456', '18612345020', 'zhaolei@qq.com', '3', '6', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s025', '2025025', '陈杰', '123456', '15812345021', 'chenjie@qq.com', '3', '6', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s026', '2025026', '吴佳', '123456', '13712345022', 'wujia@qq.com', '3', '6', '2024-09-01 08:00:00', '1');

INSERT INTO public.course_academic_year VALUES ('1', '2025上半学年', '1');
INSERT INTO public.course_academic_year VALUES ('2', '2025下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('3', '2024上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('4', '2024下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('5', '2023上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('6', '2023下半学年', '0');

INSERT INTO public.menu VALUES ('m01', '首页', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/index', '1', '首页数据展示');
INSERT INTO public.menu VALUES ('m02', '教务管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '', '1', '教务相关管理');
INSERT INTO public.menu VALUES ('m03', '人员管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '', '1', '人员相关管理');
INSERT INTO public.menu VALUES ('m04', '公告管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 4, '', '1', '首页公告管理');
INSERT INTO public.menu VALUES ('m05', '系统管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 5, '', '1', '系统基础管理');
INSERT INTO public.menu VALUES ('m06', '课程管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 6, '', '1', '教师课程管理');
INSERT INTO public.menu VALUES ('m07', '选课中心', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 7, '/student/courseCase', '1', '学生选课中心');
INSERT INTO public.menu VALUES ('m08', '我的课程', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 8, '', '1', '已选课程管理');
INSERT INTO public.menu VALUES ('m09', '数据分析', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 9, '', '1', '数据统计分析');
INSERT INTO public.menu VALUES ('m10', '课程列表', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/course/list', '1', '课程列表管理');
INSERT INTO public.menu VALUES ('m11', '新增课程', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/course/forwardAdd', '1', '新增课程页面');
INSERT INTO public.menu VALUES ('m12', '学年管理', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/course/courseAcademicYear', '1', '学年管理');
INSERT INTO public.menu VALUES ('m13', '选课管理', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 4, '/manage/selectionStage', '1', '选课阶段管理');
INSERT INTO public.menu VALUES ('m14', '学生管理', 'm03', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/studentList', '1', '学生信息管理');
INSERT INTO public.menu VALUES ('m15', '教师管理', 'm03', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/manage/teacherList', '1', '教师信息管理');
INSERT INTO public.menu VALUES ('m16', '学院管理', 'm03', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/manage/college', '1', '学院信息管理');
INSERT INTO public.menu VALUES ('m17', '公告列表', 'm04', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/information', '1', '公告列表管理');
INSERT INTO public.menu VALUES ('m18', '菜单管理', 'm05', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/menu', '1', '菜单树管理');
INSERT INTO public.menu VALUES ('m19', '角色管理', 'm05', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/manage/role', '1', '角色权限管理');
INSERT INTO public.menu VALUES ('m20', '课程信息', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/teacher/courseInfo', '1', '教师授课课程');
INSERT INTO public.menu VALUES ('m21', '学生信息', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/teacher/selectedCourseStu', '1', '选课学生信息');
INSERT INTO public.menu VALUES ('m22', '成绩管理', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/teacher/scoreInfo', '1', '学生成绩评定');
INSERT INTO public.menu VALUES ('m23', '已选课程', 'm08', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/student/selectedCourse', '1', '已选课程列表');
INSERT INTO public.menu VALUES ('m24', '教师统计', 'm09', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/teacher/statisticalInfo', '1', '教师授课统计');
INSERT INTO public.menu VALUES ('m25', '选课统计', 'm09', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/student/statistical', '1', '学生选课统计');

INSERT INTO public.role_menu_rel VALUES ('rm001', '1', 'm01');
INSERT INTO public.role_menu_rel VALUES ('rm002', '1', 'm02');
INSERT INTO public.role_menu_rel VALUES ('rm003', '1', 'm03');
INSERT INTO public.role_menu_rel VALUES ('rm004', '1', 'm04');
INSERT INTO public.role_menu_rel VALUES ('rm005', '1', 'm05');
INSERT INTO public.role_menu_rel VALUES ('rm006', '1', 'm10');
INSERT INTO public.role_menu_rel VALUES ('rm007', '1', 'm11');
INSERT INTO public.role_menu_rel VALUES ('rm008', '1', 'm12');
INSERT INTO public.role_menu_rel VALUES ('rm009', '1', 'm13');
INSERT INTO public.role_menu_rel VALUES ('rm010', '1', 'm14');
INSERT INTO public.role_menu_rel VALUES ('rm011', '1', 'm15');
INSERT INTO public.role_menu_rel VALUES ('rm012', '1', 'm16');
INSERT INTO public.role_menu_rel VALUES ('rm013', '1', 'm17');
INSERT INTO public.role_menu_rel VALUES ('rm014', '1', 'm18');
INSERT INTO public.role_menu_rel VALUES ('rm015', '1', 'm19');
INSERT INTO public.role_menu_rel VALUES ('rm016', '2', 'm01');
INSERT INTO public.role_menu_rel VALUES ('rm017', '2', 'm06');
INSERT INTO public.role_menu_rel VALUES ('rm018', '2', 'm09');
INSERT INTO public.role_menu_rel VALUES ('rm019', '2', 'm20');
INSERT INTO public.role_menu_rel VALUES ('rm020', '2', 'm21');
INSERT INTO public.role_menu_rel VALUES ('rm021', '2', 'm22');
INSERT INTO public.role_menu_rel VALUES ('rm022', '2', 'm24');
INSERT INTO public.role_menu_rel VALUES ('rm023', '3', 'm01');
INSERT INTO public.role_menu_rel VALUES ('rm024', '3', 'm07');
INSERT INTO public.role_menu_rel VALUES ('rm025', '3', 'm08');
INSERT INTO public.role_menu_rel VALUES ('rm026', '3', 'm09');
INSERT INTO public.role_menu_rel VALUES ('rm027', '3', 'm23');
INSERT INTO public.role_menu_rel VALUES ('rm028', '3', 'm25');

INSERT INTO public.information VALUES ('inf01', '关于2025年教师教学工作量核算的通知', '各学院:<br><br>根据学校教学工作安排，现启动2025年上半学年教师教学工作量核算工作。请各学院教务员于3月15日前完成本学院教师课时统计并提交至教务处。<br><br>核算标准参照《教师教学工作量核算办法（2024年修订版）》执行。', '2025-02-25 14:30:00', '1');
INSERT INTO public.information VALUES ('inf02', '关于教师成绩录入时间安排的通知', '各位教师:<br><br>本学期课程成绩录入时间为课程结束后至2025年7月15日。请各位教师在课程结束后及时完成成绩评定和录入工作。<br><br>成绩评定标准：<br>1. 平时成绩占比30%<br>2. 期末成绩占比70%<br>3. 不合格学生需注明具体原因', '2025-03-01 08:00:00', '2');
INSERT INTO public.information VALUES ('inf03', '关于2025年英语四级考试报名的通知', '各位同学:<br><br>2025年上半年全国大学英语四级考试报名工作即将开始，现将有关事项通知如下：<br><br>一、报名时间：2025年3月15日至3月25日<br>二、考试时间：2025年6月14日<br>三、报名方式：登录全国大学英语四六级考试报名网站进行网上报名<br>四、请符合报名条件的同学及时报名，逾期不再补报。', '2025-03-05 10:00:00', '3');

INSERT INTO public.course VALUES ('c01', '计算机网络', '1', '1', '6号主教学楼 301', '星期一 上午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 60, 5, 6, '本课程系统讲授计算机网络的基本原理和技术，包括OSI参考模型、TCP/IP协议族、局域网与广域网技术、网络安全基础等。要求学生掌握网络编程的基本方法。', '1');
INSERT INTO public.course VALUES ('c02', '操作系统原理', '1', '1', '6号主教学楼 302', '星期二 上午第二节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 55, 4, 4, '本课程介绍操作系统的基本概念、原理和实现技术，包括进程管理、内存管理、文件系统、I/O系统等内容，结合Linux操作系统进行实践教学。', '1');
INSERT INTO public.course VALUES ('c03', '数据库系统原理', '1', '2', '6号主教学楼 303', '星期三 下午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.5, '2025上半学年', '2025-07-10 00:00:00', 50, 3, 4, '本课程讲授关系数据库理论、SQL语言、数据库设计、事务处理、并发控制、数据库优化等内容。学生需要完成一个完整的数据库应用系统设计与开发。', '1');
INSERT INTO public.course VALUES ('c04', '软件工程导论', '1', '2', '6号主教学楼 304', '星期四 上午第三节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.0, '2025上半学年', '2025-07-10 00:00:00', 45, 2, 2, '本课程介绍软件工程的基本概念、方法和工具，包括软件生命周期、需求分析、系统设计、编码实现、测试与维护等内容。采用项目驱动教学法。', '1');
INSERT INTO public.course VALUES ('c05', 'Java程序设计', '1', '1', '6号主教学楼 305', '星期五 上午第四节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 50, 3, 3, '本课程系统讲授Java程序设计语言及面向对象编程方法，包括Java基础语法、面向对象特性、集合框架、多线程编程、网络编程等内容。', '1');
INSERT INTO public.course VALUES ('c06', '离散数学', '2', '3', '7号教学楼 201', '星期一 下午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.5, '2025上半学年', '2025-07-10 00:00:00', 50, 2, 3, '本课程讲授离散数学的基本理论，包括命题逻辑、集合论、图论、代数结构、组合数学等内容，为计算机专业后续课程奠定数学基础。', '1');
INSERT INTO public.course VALUES ('c07', '人工智能导论', '2', '4', '7号教学楼 202', '星期二 下午第二节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.0, '2025上半学年', '2025-07-10 00:00:00', 40, 1, 3, '本课程介绍人工智能的基本概念、方法与应用，包括搜索策略、知识表示、机器学习、深度学习、自然语言处理等内容。', '1');
INSERT INTO public.course VALUES ('c08', '计算机组成原理', '2', '3', '7号教学楼 203', '星期三 上午第三节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 45, 2, 2, '本课程讲授计算机硬件系统的基本组成和工作原理，包括数据表示与运算、CPU设计、存储系统、输入输出系统等内容。', '1');
INSERT INTO public.course VALUES ('c09', '高等数学A', '3', '5', '1号教学楼 101', '星期一 上午第二节课 1-18周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 5.0, '2025上半学年', '2025-07-15 00:00:00', 80, 5, 5, '本课程为理工科基础课程，讲授微积分、多元函数微分学、重积分、曲线曲面积分、无穷级数等内容。', '1');
INSERT INTO public.course VALUES ('c10', '线性代数', '3', '6', '1号教学楼 102', '星期三 上午第四节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.0, '2025上半学年', '2025-07-15 00:00:00', 70, 4, 3, '本课程讲授行列式、矩阵、向量空间、线性变换、特征值与特征向量、二次型等内容。', '1');
INSERT INTO public.course VALUES ('c11', '大学英语(四)', '4', '7', '外语楼 301', '星期二 上午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 2.0, '2025上半学年', '2025-05-15 00:00:00', 60, 3, 6, '本课程以培养学生英语综合应用能力为目标，涵盖听说读写译等技能训练，注重学术英语写作与口语表达。', '1');
INSERT INTO public.course VALUES ('c12', '英语写作与翻译', '4', '8', '外语楼 302', '星期四 下午第三节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 2.0, '2025上半学年', '2025-05-15 00:00:00', 50, 2, 4, '本课程系统讲授英语写作与翻译的基本技巧，包括段落写作、短文结构、英汉互译方法等内容。', '1');
INSERT INTO public.course VALUES ('c13', '数字电路与逻辑设计', '5', '9', '电子楼 401', '星期一 下午第二节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.5, '2025上半学年', '2025-07-10 00:00:00', 40, 1, 4, '本课程讲授数字逻辑电路的分析与设计方法，包括逻辑代数、组合逻辑电路、时序逻辑电路、A/D与D/A转换等内容。', '1');
INSERT INTO public.course VALUES ('c14', '信号与系统', '5', '10', '电子楼 402', '星期三 下午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 35, 2, 3, '本课程讲授信号与系统的基本概念和分析方法，包括连续时间信号与系统、傅里叶变换、拉普拉斯变换、Z变换等内容。', '1');
INSERT INTO public.course VALUES ('c15', '微观经济学', '6', '1', '经管楼 501', '星期四 上午第三节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.0, '2025上半学年', '2025-05-10 00:00:00', 50, 3, 5, '本课程讲授微观经济学的基本理论，包括供需理论、消费者行为、生产者理论、市场结构、博弈论基础等内容。', '1');
INSERT INTO public.course VALUES ('c16', '宏观经济学', '6', '2', '经管楼 502', '星期五 下午第一节课 1-16周', '2025-03-01 00:00:00', '2025-03-08 00:00:00', 3.0, '2025上半学年', '2025-05-10 00:00:00', 50, 2, 4, '本课程讲授宏观经济学的基本理论，包括国民收入核算、经济增长理论、货币与银行体系、财政政策与货币政策等内容。', '1');
INSERT INTO public.course VALUES ('c17', '编译原理', '1', '2', '6号主教学楼 301', '星期一 上午第三节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 3.5, '2024下半学年', '2025-01-15 00:00:00', 45, 3, 2, '本课程讲授编译原理的基本理论和技术，包括词法分析、语法分析、语义分析、中间代码生成、代码优化和目标代码生成等内容。', '1');
INSERT INTO public.course VALUES ('c18', '数据库系统概论', '1', '1', '6号主教学楼 302', '星期二 上午第一节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 4.0, '2024下半学年', '2025-01-15 00:00:00', 50, 4, 2, '本课程全面介绍数据库系统的基本概念、原理和应用，重点讲授关系数据库理论和SQL语言。', '1');
INSERT INTO public.course VALUES ('c19', '数据结构与算法', '1', '1', '6号主教学楼 303', '星期三 上午第二节课 1-16周', '2024-03-01 00:00:00', '2024-03-05 00:00:00', 3.5, '2024上半学年', '2024-07-10 00:00:00', 50, 5, 1, '本课程讲授基本数据结构和算法设计与分析方法，包括线性表、树、图、排序、查找、动态规划等内容。', '1');
INSERT INTO public.course VALUES ('c20', '算法设计与分析', '2', '3', '7号教学楼 201', '星期二 下午第一节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 3.0, '2024下半学年', '2025-01-15 00:00:00', 40, 2, 1, '本课程讲授算法设计与分析的基本方法，包括分治法、动态规划、贪心算法、回溯法、分支限界法等内容。', '1');
INSERT INTO public.course VALUES ('c21', '英语听力(三)', '4', '7', '外语楼 303', '星期五 上午第一节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 1.5, '2024下半学年', '2025-01-10 00:00:00', 40, 2, 1, '本课程通过多种听力材料的训练，提高学生的英语听力理解能力，包括新闻听力、学术讲座听力、日常对话等。', '1');
INSERT INTO public.course VALUES ('c22', '模拟电子技术', '5', '9', '电子楼 403', '星期四 上午第一节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 3.5, '2024下半学年', '2025-01-15 00:00:00', 35, 1, 1, '本课程讲授模拟电子技术的基本理论和分析设计方法，包括半导体器件、放大电路、运算放大器、反馈电路等内容。', '1');
INSERT INTO public.course VALUES ('c23', '概率论与数理统计', '3', '5', '1号教学楼 103', '星期一 下午第三节课 1-16周', '2024-03-01 00:00:00', '2024-03-05 00:00:00', 3.5, '2024上半学年', '2024-07-10 00:00:00', 60, 3, 2, '本课程讲授概率论和数理统计的基本理论和方法，包括随机事件、概率分布、参数估计、假设检验、回归分析等内容。', '1');
INSERT INTO public.course VALUES ('c24', '管理学原理', '6', '2', '经管楼 503', '星期三 下午第三节课 1-16周', '2024-03-01 00:00:00', '2024-03-05 00:00:00', 3.0, '2024上半学年', '2024-07-10 00:00:00', 45, 2, 1, '本课程讲授管理学的基本理论和方法，包括管理思想史、计划与决策、组织与领导、控制与创新等内容。', '1');

INSERT INTO public.selection_stage VALUES ('ss01', '2025上半学年', '第一阶段-推荐选课', 1, '2025-03-01 00:00:00', '2025-03-05 23:59:59', '1', '0', '0', '1');
INSERT INTO public.selection_stage VALUES ('ss02', '2025上半学年', '第二阶段-推荐与方案内', 2, '2025-03-06 00:00:00', '2027-08-30 23:59:59', '1', '1', '1', '1');
INSERT INTO public.selection_stage VALUES ('ss03', '2025上半学年', '第三阶段-全部开放', 3, '2027-09-01 00:00:00', '2027-09-10 23:59:59', '1', '1', '1', '1');

INSERT INTO public.student_course_rel VALUES ('scr001', 's001', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr002', 's001', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr003', 's001', 'c03', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr004', 's001', 'c04', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr005', 's001', 'c05', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr006', 's001', 'c17', '2', '1', '成绩优秀，学习态度认真', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr007', 's001', 'c18', '1', '1', '成绩良好', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr008', 's001', 'c15', '1', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr009', 's002', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr010', 's002', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr011', 's002', 'c03', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr012', 's003', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr013', 's003', 'c03', '2', '1', '成绩良好', '1', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr014', 's003', 'c05', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr015', 's003', 'c17', '2', '1', '成绩合格', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr016', 's003', 'c11', '7', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr017', 's004', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr018', 's004', 'c18', '1', '1', '成绩合格', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr019', 's004', 'c12', '8', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr020', 's005', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr021', 's005', 'c04', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr022', 's005', 'c06', '3', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr023', 's006', 'c03', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr024', 's006', 'c05', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr025', 's006', 'c19', '1', '1', '成绩优秀', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr026', 's006', 'c07', '4', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr027', 's007', 'c06', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr028', 's007', 'c07', '4', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr029', 's008', 'c07', '4', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr030', 's008', 'c08', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr031', 's009', 'c06', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr032', 's009', 'c20', '3', '1', '成绩良好', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr033', 's010', 'c08', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr034', 's010', 'c09', '5', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr035', 's011', 'c09', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr036', 's011', 'c10', '6', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr037', 's011', 'c23', '5', '1', '成绩优秀', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr038', 's012', 'c09', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr039', 's012', 'c01', '1', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr040', 's013', 'c10', '6', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr041', 's013', 'c11', '7', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr042', 's013', 'c23', '5', '1', '成绩合格', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr043', 's014', 'c09', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr044', 's014', 'c10', '6', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr045', 's015', 'c11', '7', '1', '成绩优秀', '1', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr046', 's015', 'c12', '8', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr047', 's015', 'c09', '5', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr048', 's016', 'c11', '7', '1', '成绩合格', '1', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr049', 's016', 'c12', '8', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr050', 's016', 'c21', '7', '1', '成绩良好', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr051', 's017', 'c11', '7', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr052', 's017', 'c12', '8', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr053', 's018', 'c11', '7', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr054', 's018', 'c02', '1', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr055', 's019', 'c13', '9', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr056', 's019', 'c14', '10', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr057', 's020', 'c13', '9', '1', '成绩优秀', '1', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr058', 's020', 'c14', '10', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr059', 's020', 'c22', '9', '1', '成绩良好', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr060', 's021', 'c13', '9', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr061', 's021', 'c14', '10', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr062', 's022', 'c13', '9', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr063', 's022', 'c01', '1', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr064', 's023', 'c15', '1', '1', '成绩良好', '1', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr065', 's023', 'c16', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr066', 's024', 'c15', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr067', 's024', 'c16', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr068', 's025', 'c15', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr069', 's025', 'c16', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr070', 's025', 'c24', '2', '1', '成绩合格', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr071', 's026', 'c15', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr072', 's026', 'c16', '2', '0', ' ', '0', 'recommend');
