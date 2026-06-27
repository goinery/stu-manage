DROP TABLE IF EXISTS public.student_course_rel;
DROP TABLE IF EXISTS public.selection_stage;
DROP TABLE IF EXISTS public.role_menu_rel;
DROP TABLE IF EXISTS public.course;
DROP TABLE IF EXISTS public.information;
DROP TABLE IF EXISTS public.teacher;
DROP TABLE IF EXISTS public.student;
DROP TABLE IF EXISTS public.manage_user;
DROP TABLE IF EXISTS public.menu;
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
  updateDate SMALLDATETIME NOT NULL,
  CONSTRAINT uk_college_name UNIQUE (name),
  CONSTRAINT chk_college_state CHECK (state IN ('0','1')),
  CONSTRAINT chk_college_count CHECK (teacherNum >= 0 AND studentNum >= 0)
) WITH (ORIENTATION = ROW);

CREATE TABLE public.role (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  createDate SMALLDATETIME NULL DEFAULT NULL,
  state varchar(1) NOT NULL,
  CONSTRAINT uk_role_name UNIQUE (name),
  CONSTRAINT chk_role_state CHECK (state IN ('0','1'))
) WITH (ORIENTATION = ROW);

CREATE TABLE public.manage_user (
  id varchar(32) PRIMARY KEY NOT NULL,
  loginName varchar(32) NOT NULL,
  username varchar(32) NOT NULL,
  password varchar(64) NOT NULL,
  roleId varchar(32) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  state varchar(1) NOT NULL,
  CONSTRAINT uk_manage_login UNIQUE (loginName),
  CONSTRAINT fk_manage_role FOREIGN KEY (roleId) REFERENCES public.role(id),
  CONSTRAINT chk_manage_state CHECK (state IN ('0','1'))
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
  remark varchar(2555) NULL DEFAULT NULL,
  CONSTRAINT chk_menu_state CHECK (state IN ('0','1')),
  CONSTRAINT chk_menu_sort CHECK (sort >= 0)
) WITH (ORIENTATION = ROW);

CREATE TABLE public.role_menu_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  roleId varchar(32) NOT NULL,
  menuId varchar(32) NOT NULL,
  CONSTRAINT uk_role_menu UNIQUE (roleId, menuId),
  CONSTRAINT fk_role_menu_role FOREIGN KEY (roleId) REFERENCES public.role(id),
  CONSTRAINT fk_role_menu_menu FOREIGN KEY (menuId) REFERENCES public.menu(id)
) WITH (ORIENTATION = ROW);

CREATE TABLE public.course_academic_year (
  id varchar(32) PRIMARY KEY NOT NULL,
  academicYear varchar(20) NOT NULL,
  state varchar(1) NOT NULL,
  CONSTRAINT uk_academic_year UNIQUE (academicYear),
  CONSTRAINT chk_academic_year_state CHECK (state IN ('0','1'))
) WITH (ORIENTATION = ROW);

CREATE TABLE public.information (
  id varchar(32) PRIMARY KEY NOT NULL,
  title varchar(320) NOT NULL,
  content text NOT NULL,
  publishDate SMALLDATETIME NOT NULL,
  roleId varchar(32) NOT NULL,
  CONSTRAINT fk_information_role FOREIGN KEY (roleId) REFERENCES public.role(id)
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
  state varchar(1) NOT NULL,
  CONSTRAINT uk_teacher_login UNIQUE (loginName),
  CONSTRAINT fk_teacher_role FOREIGN KEY (roleId) REFERENCES public.role(id),
  CONSTRAINT fk_teacher_college FOREIGN KEY (collegeId) REFERENCES public.college(id),
  CONSTRAINT chk_teacher_state CHECK (state IN ('0','1'))
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
  state varchar(1) NOT NULL,
  CONSTRAINT uk_student_number UNIQUE (studentNumber),
  CONSTRAINT fk_student_role FOREIGN KEY (roleId) REFERENCES public.role(id),
  CONSTRAINT fk_student_college FOREIGN KEY (collegeId) REFERENCES public.college(id),
  CONSTRAINT chk_student_state CHECK (state IN ('0','1'))
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
  state varchar(1) NOT NULL DEFAULT '1',
  CONSTRAINT fk_course_college FOREIGN KEY (collegeId) REFERENCES public.college(id),
  CONSTRAINT fk_course_teacher FOREIGN KEY (teacherId) REFERENCES public.teacher(id),
  CONSTRAINT fk_course_academic_year FOREIGN KEY (academicYear) REFERENCES public.course_academic_year(academicYear),
  CONSTRAINT chk_course_capacity CHECK (optional >= 0 AND primaryAmount >= 0 AND selected >= 0 AND selected <= optional),
  CONSTRAINT chk_course_credits CHECK (credits > 0),
  CONSTRAINT chk_course_state CHECK (state IN ('0','1'))
) WITH (ORIENTATION = ROW);

CREATE TABLE public.student_course_rel (
  id varchar(32) PRIMARY KEY NOT NULL,
  studentId varchar(32) NOT NULL,
  courseId varchar(32) NOT NULL,
  teacherId varchar(32) NULL DEFAULT NULL,
  isQualified varchar(1) NULL DEFAULT NULL,
  creditsRemark varchar(255) NULL DEFAULT NULL,
  state varchar(1) NOT NULL,
  selectionType varchar(20) NULL DEFAULT NULL,
  CONSTRAINT uk_student_course UNIQUE (studentId, courseId),
  CONSTRAINT fk_student_course_student FOREIGN KEY (studentId) REFERENCES public.student(id),
  CONSTRAINT fk_student_course_course FOREIGN KEY (courseId) REFERENCES public.course(id),
  CONSTRAINT fk_student_course_teacher FOREIGN KEY (teacherId) REFERENCES public.teacher(id),
  CONSTRAINT chk_student_course_state CHECK (state IN ('0','1')),
  CONSTRAINT chk_student_course_qualified CHECK (isQualified IS NULL OR isQualified IN ('0','1')),
  CONSTRAINT chk_student_course_type CHECK (selectionType IS NULL OR selectionType IN ('recommend','plan','outside'))
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
  state varchar(1) DEFAULT '1',
  CONSTRAINT fk_selection_stage_academic_year FOREIGN KEY (academicYear) REFERENCES public.course_academic_year(academicYear),
  CONSTRAINT chk_selection_stage_order CHECK (stageOrder > 0),
  CONSTRAINT chk_selection_stage_time CHECK (startDate <= endDate),
  CONSTRAINT chk_selection_stage_flags CHECK (
    allowRecommend IN ('0','1')
    AND allowPlan IN ('0','1')
    AND allowOutside IN ('0','1')
    AND state IN ('0','1')
  )
) WITH (ORIENTATION = ROW);

INSERT INTO public.role VALUES ('1', '系统管理', '2020-07-18 23:14:08', '1');
INSERT INTO public.role VALUES ('2', '教师', '2020-07-18 23:15:04', '1');
INSERT INTO public.role VALUES ('3', '学生', '2020-07-18 23:15:00', '1');
INSERT INTO public.role VALUES ('f1eae1546dbb90bb6af3349aacd5a1', '测试角色', '2020-07-31 18:17:56', '1');

INSERT INTO public.college VALUES ('1', '软件工程学院', 2, 4, '1', '2020-07-23 17:43:30', '2025-02-15 10:38:47');
INSERT INTO public.college VALUES ('2', '计算机科学与技术学院', 2, 3, '1', '2020-07-23 17:44:00', '2025-02-15 15:12:24');
INSERT INTO public.college VALUES ('3', '数学学院', 1, 3, '1', '2021-03-01 09:00:00', '2025-02-20 11:30:00');

INSERT INTO public.manage_user VALUES ('1', 'admin', 'admin', 'admin', '1', '2020-07-18 23:12:53', '1');

INSERT INTO public.teacher VALUES ('1', '叶凡', '叶凡', '123456', '18385147410', 'yefan@university.edu.cn', '2', '1', '2020-07-17 11:51:24', '1');
INSERT INTO public.teacher VALUES ('2', '庞博', '庞博', '123456', '15345217450', 'pangbo@university.edu.cn', '2', '1', '2020-08-01 15:05:43', '1');
INSERT INTO public.teacher VALUES ('3', '陈明华', '陈明华', '123456', '13678945210', 'chenmh@university.edu.cn', '2', '2', '2021-03-10 09:00:00', '1');
INSERT INTO public.teacher VALUES ('4', '刘洋', '刘洋', '123456', '15874123650', 'liuyang@university.edu.cn', '2', '2', '2021-03-10 09:30:00', '1');
INSERT INTO public.teacher VALUES ('5', '王建国', '王建国', '123456', '13012345678', 'wangjg@university.edu.cn', '2', '3', '2021-03-10 10:00:00', '1');

INSERT INTO public.student VALUES ('s001', '2024001', '夏九幽', '123456', '13945614520', 'xiajy@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s002', '2024002', '涂飞', '123456', '15241254520', 'tufei@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s003', '2024003', '姜太虚', '123456', '13378974152', 'jiangtx@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s004', '2024004', '段德', '123456', '18345789870', 'duande@qq.com', '3', '1', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s005', '2024005', '林云', '123456', '13712345001', 'linyun@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s006', '2024006', '苏毅', '123456', '13812345002', 'suyi@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s007', '2024007', '叶凡辰', '123456', '13612345003', 'yefc@qq.com', '3', '2', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s008', '2024008', '陈浩', '123456', '15812345004', 'chenhao@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s009', '2024009', '吴峰', '123456', '18712345005', 'wufeng@qq.com', '3', '3', '2024-09-01 08:00:00', '1');
INSERT INTO public.student VALUES ('s010', '2024010', '张华', '123456', '13012345006', 'zhanghua@qq.com', '3', '3', '2024-09-01 08:00:00', '1');

INSERT INTO public.course_academic_year VALUES ('1', '2024上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('2', '2024下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('3', '2025上半学年', '0');
INSERT INTO public.course_academic_year VALUES ('4', '2025下半学年', '0');
INSERT INTO public.course_academic_year VALUES ('5', '2026上半学年', '1');
INSERT INTO public.course_academic_year VALUES ('6', '2026下半学年', '0');

INSERT INTO public.menu VALUES ('m01', '首页', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/index', '1', '首页数据展示');
INSERT INTO public.menu VALUES ('m02', '教务管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, NULL, '1', '教务基础数据与首页通告管理');
INSERT INTO public.menu VALUES ('m03', '人员管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 4, NULL, '1', '人员相关管理');
INSERT INTO public.menu VALUES ('m04', '角色管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 5, NULL, '1', '角色权限管理');
INSERT INTO public.menu VALUES ('m06', '课程管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 6, NULL, '1', '课程与选课相关管理');
INSERT INTO public.menu VALUES ('m07', '选课中心', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 7, '/student/courseCase', '1', '学生选课中心');
INSERT INTO public.menu VALUES ('m08', '我的课程', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 8, '', '1', '已选课程管理');
INSERT INTO public.menu VALUES ('m09', '数据分析', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 9, NULL, '1', '数据统计分析');
INSERT INTO public.menu VALUES ('m10', '课程列表', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/course/list', '1', '课程列表管理');
INSERT INTO public.menu VALUES ('m11', '新增课程', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/course/forwardAdd', '1', '新增课程页面');
INSERT INTO public.menu VALUES ('m12', '学年管理', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/course/courseAcademicYear', '1', '学年管理');
INSERT INTO public.menu VALUES ('m13', '选课管理', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 4, '/manage/selectionStage', '1', '选课阶段管理');
INSERT INTO public.menu VALUES ('m14', '学生管理', 'm03', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/student', '1', '学生信息管理');
INSERT INTO public.menu VALUES ('m15', '教师管理', 'm03', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/manage/teacher', '1', '教师信息管理');
INSERT INTO public.menu VALUES ('m16', '学院管理', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/college', '1', '学院信息管理');
INSERT INTO public.menu VALUES ('m17', '首页通告管理', 'm02', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/manage/information', '1', '首页通告管理');
INSERT INTO public.menu VALUES ('m18', '菜单管理', '0', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/manage/menu', '1', '菜单树管理');
INSERT INTO public.menu VALUES ('m19', '角色分配', 'm04', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/manage/role', '1', '角色权限分配');
INSERT INTO public.menu VALUES ('m20', '课程信息', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/teacher/courseInfo', '1', '教师授课课程');
INSERT INTO public.menu VALUES ('m21', '学生信息', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/teacher/selectedCourseStu', '1', '选课学生信息');
INSERT INTO public.menu VALUES ('m22', '成绩管理', 'm06', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/teacher/scoreInfo', '1', '学生成绩评定');
INSERT INTO public.menu VALUES ('m23', '已选课程', 'm08', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/student/selectedCourse', '1', '已选课程列表');
INSERT INTO public.menu VALUES ('m24', '统计信息', 'm09', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 1, '/teacher/statisticalInfo', '1', '选课统计信息');
INSERT INTO public.menu VALUES ('m25', '选课统计', 'm09', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 2, '/student/statistical', '1', '学生选课统计');
INSERT INTO public.menu VALUES ('m26', '综合统计', 'm09', '2020-07-18 23:44:05', '1', '2025-02-15 17:42:18', 3, '/manage/statistical', '1', '管理员综合统计');

INSERT INTO public.role_menu_rel VALUES ('rm001', '1', 'm01');
INSERT INTO public.role_menu_rel VALUES ('rm002', '1', 'm18');
INSERT INTO public.role_menu_rel VALUES ('rm003', '1', 'm02');
INSERT INTO public.role_menu_rel VALUES ('rm004', '1', 'm16');
INSERT INTO public.role_menu_rel VALUES ('rm005', '1', 'm17');
INSERT INTO public.role_menu_rel VALUES ('rm006', '1', 'm03');
INSERT INTO public.role_menu_rel VALUES ('rm007', '1', 'm14');
INSERT INTO public.role_menu_rel VALUES ('rm008', '1', 'm15');
INSERT INTO public.role_menu_rel VALUES ('rm009', '1', 'm04');
INSERT INTO public.role_menu_rel VALUES ('rm010', '1', 'm19');
INSERT INTO public.role_menu_rel VALUES ('rm011', '1', 'm06');
INSERT INTO public.role_menu_rel VALUES ('rm012', '1', 'm10');
INSERT INTO public.role_menu_rel VALUES ('rm013', '1', 'm11');
INSERT INTO public.role_menu_rel VALUES ('rm014', '1', 'm12');
INSERT INTO public.role_menu_rel VALUES ('rm015', '1', 'm13');
INSERT INTO public.role_menu_rel VALUES ('rm029', '1', 'm09');
INSERT INTO public.role_menu_rel VALUES ('rm030', '1', 'm26');
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

INSERT INTO public.information VALUES ('inf01', '关于2026年上半年学期收尾与教务安排的通知', '各学院:<br><br>根据学校2026年上半年教学运行安排，现启动期末教学检查、课程归档和下半学年开课准备工作。请各学院于2026年7月5日前完成课程材料整理、教学工作量初核和学生成绩核验。<br><br>请教务员同步检查2024级学生培养方案执行情况，确保2024-2026学年课程数据完整。', '2026-06-28 09:00:00', '1');
INSERT INTO public.information VALUES ('inf02', '关于2026上半学年成绩录入与课程归档的通知', '各位教师:<br><br>2026上半学年课程成绩录入时间为课程结束后至2026年7月15日。请任课教师及时完成平时成绩、期末成绩和总评成绩录入，并在提交前核对选课学生名单。<br><br>课程归档材料请于2026年7月20日前提交至所在学院。', '2026-06-28 10:00:00', '2');
INSERT INTO public.information VALUES ('inf03', '关于2026年暑期前考试与选课安排的通知', '各位同学:<br><br>2026年暑期前考试、成绩查询和下半学年选课准备工作将陆续开展。请2024级学生关注考试安排、课程成绩发布和培养方案完成情况。<br><br>一、期末考试周：2026年6月29日至7月10日<br>二、成绩查询：课程结束后由任课教师陆续发布<br>三、选课准备：请提前核对个人已修课程和待修课程。', '2026-06-28 11:00:00', '3');

INSERT INTO public.course VALUES ('c01', '计算机网络', '1', '1', '6号主教学楼 301', '星期一 上午第一节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 4.0, '2026上半学年', '2026-07-10 00:00:00', 50, 5, 3, '本课程系统讲授计算机网络的基本原理和技术，包括OSI参考模型、TCP/IP协议族、局域网与广域网技术、网络安全基础等。要求学生掌握网络编程的基本方法。', '1');
INSERT INTO public.course VALUES ('c02', '操作系统原理', '1', '1', '6号主教学楼 302', '星期二 上午第二节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 4.0, '2026上半学年', '2026-07-10 00:00:00', 50, 4, 3, '本课程介绍操作系统的基本概念、原理和实现技术，包括进程管理、内存管理、文件系统、I/O系统等内容，结合Linux操作系统进行实践教学。', '1');
INSERT INTO public.course VALUES ('c03', '数据库系统原理', '1', '2', '6号主教学楼 303', '星期三 下午第一节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 3.5, '2026上半学年', '2026-07-10 00:00:00', 50, 3, 2, '本课程讲授关系数据库理论、SQL语言、数据库设计、事务处理、并发控制、数据库优化等内容。学生需要完成一个完整的数据库应用系统设计与开发。', '1');
INSERT INTO public.course VALUES ('c04', '软件工程导论', '1', '2', '6号主教学楼 304', '星期四 上午第三节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 3.0, '2026上半学年', '2026-07-10 00:00:00', 45, 2, 2, '本课程介绍软件工程的基本概念、方法和工具，包括软件生命周期、需求分析、系统设计、编码实现、测试与维护等内容。采用项目驱动教学法。', '1');
INSERT INTO public.course VALUES ('c05', 'Java程序设计', '1', '1', '6号主教学楼 305', '星期五 上午第四节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 4.0, '2026上半学年', '2026-07-10 00:00:00', 50, 3, 2, '本课程系统讲授Java程序设计语言及面向对象编程方法，包括Java基础语法、面向对象特性、集合框架、多线程编程、网络编程等内容。', '1');

INSERT INTO public.course VALUES ('c06', '数据结构与算法', '1', '1', '6号主教学楼 303', '星期一 上午第二节课 1-16周', '2024-09-01 00:00:00', '2024-09-05 00:00:00', 3.5, '2024下半学年', '2025-01-15 00:00:00', 50, 4, 1, '本课程讲授基本数据结构和算法设计与分析方法，包括线性表、树、图、排序、查找、动态规划等内容。', '1');
INSERT INTO public.course VALUES ('c07', '编译原理', '1', '2', '6号主教学楼 301', '星期二 下午第二节课 1-16周', '2025-09-01 00:00:00', '2025-09-05 00:00:00', 3.5, '2025下半学年', '2026-01-15 00:00:00', 45, 3, 1, '本课程讲授编译原理的基本理论和技术，包括词法分析、语法分析、语义分析、中间代码生成、代码优化和目标代码生成等内容。', '1');
INSERT INTO public.course VALUES ('c08', '计算机组成原理', '1', '1', '6号主教学楼 302', '星期三 上午第二节课 1-16周', '2025-03-01 00:00:00', '2025-03-05 00:00:00', 4.0, '2025上半学年', '2025-07-10 00:00:00', 50, 4, 1, '本课程讲授计算机硬件系统的基本组成和工作原理，包括数据表示与运算、CPU设计、存储系统、输入输出系统等内容。', '1');

INSERT INTO public.course VALUES ('c09', '人工智能导论', '2', '3', '7号教学楼 202', '星期二 下午第三节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 3.0, '2026上半学年', '2026-07-10 00:00:00', 40, 3, 3, '本课程介绍人工智能的基本概念、方法与应用，包括搜索策略、知识表示、机器学习、深度学习、自然语言处理等内容。', '1');
INSERT INTO public.course VALUES ('c10', '算法设计与分析', '2', '4', '7号教学楼 201', '星期四 下午第一节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 3.0, '2026上半学年', '2026-07-10 00:00:00', 40, 3, 3, '本课程讲授算法设计与分析的基本方法，包括分治法、动态规划、贪心算法、回溯法、分支限界法等内容。', '1');

INSERT INTO public.course VALUES ('c11', '高等数学A', '3', '5', '1号教学楼 101', '星期一 下午第三节课 1-18周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 5.0, '2026上半学年', '2026-07-15 00:00:00', 80, 5, 3, '本课程为理工科基础课程，讲授微积分、多元函数微分学、重积分、曲线曲面积分、无穷级数等内容。', '1');
INSERT INTO public.course VALUES ('c12', '线性代数', '3', '5', '1号教学楼 102', '星期三 上午第四节课 1-16周', '2026-03-01 00:00:00', '2026-03-08 00:00:00', 3.0, '2026上半学年', '2026-07-15 00:00:00', 70, 4, 2, '本课程讲授行列式、矩阵、向量空间、线性变换、特征值与特征向量、二次型等内容。', '1');

INSERT INTO public.selection_stage VALUES ('ss01', '2026上半学年', '第一阶段-推荐选课', 1, '2026-03-01 00:00:00', '2026-03-05 23:59:59', '1', '0', '0', '1');
INSERT INTO public.selection_stage VALUES ('ss02', '2026上半学年', '第二阶段-全面开放', 2, '2026-03-06 00:00:00', '2026-08-30 23:59:59', '1', '1', '1', '1');

INSERT INTO public.student_course_rel VALUES ('scr001', 's001', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr002', 's001', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr003', 's001', 'c03', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr004', 's001', 'c05', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr005', 's001', 'c09', '3', '0', ' ', '0', 'outside');
INSERT INTO public.student_course_rel VALUES ('scr006', 's001', 'c11', '5', '0', ' ', '0', 'outside');

INSERT INTO public.student_course_rel VALUES ('scr007', 's001', 'c06', '1', '1', '成绩优秀，学习态度认真', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr008', 's001', 'c07', '2', '1', '成绩良好', '1', 'plan');
INSERT INTO public.student_course_rel VALUES ('scr009', 's001', 'c08', '1', '1', '成绩合格', '1', 'plan');

INSERT INTO public.student_course_rel VALUES ('scr010', 's002', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr011', 's002', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr012', 's002', 'c04', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr013', 's003', 'c01', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr014', 's003', 'c03', '2', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr015', 's003', 'c05', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr016', 's004', 'c02', '1', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr017', 's004', 'c04', '2', '0', ' ', '0', 'recommend');

INSERT INTO public.student_course_rel VALUES ('scr018', 's005', 'c09', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr019', 's005', 'c10', '4', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr020', 's006', 'c09', '3', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr021', 's006', 'c10', '4', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr022', 's007', 'c10', '4', '0', ' ', '0', 'recommend');

INSERT INTO public.student_course_rel VALUES ('scr023', 's008', 'c11', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr024', 's008', 'c12', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr025', 's009', 'c11', '5', '0', ' ', '0', 'recommend');
INSERT INTO public.student_course_rel VALUES ('scr026', 's010', 'c12', '5', '0', ' ', '0', 'recommend');

CREATE INDEX idx_menu_parent_sort ON public.menu(parentId, sort);
CREATE INDEX idx_role_menu_role ON public.role_menu_rel(roleId);
CREATE INDEX idx_course_college_year ON public.course(collegeId, academicYear, state);
CREATE INDEX idx_course_teacher_year ON public.course(teacherId, academicYear, state);
CREATE INDEX idx_student_college ON public.student(collegeId, state);
CREATE INDEX idx_teacher_college ON public.teacher(collegeId, state);
CREATE INDEX idx_student_course_student ON public.student_course_rel(studentId, state);
CREATE INDEX idx_student_course_course ON public.student_course_rel(courseId, state);
CREATE INDEX idx_student_course_teacher ON public.student_course_rel(teacherId, state);
CREATE INDEX idx_selection_stage_active ON public.selection_stage(academicYear, state, startDate, endDate, stageOrder);
