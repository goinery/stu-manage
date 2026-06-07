# openGauss数据库应用系统开发(学生选课管理系统)
## 目录
1 实验环境介绍3
1.1 实验介绍3
1.1.1 关于本实验3
1.1.2 读者知识背景3
1.1.3 实验设备介绍3
2 学生选课管理系统介绍4
2.1 功能简介4
2.2 管理员模块功能4
2.3 教师模块功能5
2.4 学生模块功能5
2.5 系统界面6
2.6 系统数据模型8
2.6.1 关系模型8
2.6.2 物理模型9
3 openGauss数据库准备13
4 数据库对象创建16
4.1 College学院信息表创建16
4.2 Course课程信息表创建16
4.3 course_academic_year课程学年表创建18
4.4 information公告信息表创建19
4.5 manage_user管理员用户表创建20
4.6 menu菜单表创建20
4.7 role角色表创建22
4.8 role_menu_rel角色菜单关联表创建22
4.9 Student表学生用户表创建23
4.10 student_course_rel学生课程关联表创建24
4.11 teacher教师信息表创建24
5 开发环境搭建26
5.1 安装开发工具vscode26
5.2 在vscode中配置java环境28
5.2.1 下载并安装JDK28
5.2.2 配置JDK环境变量30
5.2.3 在vscode中配置java33
5.3 在vscode中配置Maven环境34
6 项目工程导入37
6.1 项目源文件获取37
6.2 项目工程配置38
7 学生选课管理系统验证42
8 基于选课管理系统的数据库开发45
8.1 角色菜单功能设置45
8.2 课程内容调整47
8.3 信息列表查询50
9 基于选课管理系统的统计信息开发53
9.1.1 制定需求54
9.1.2 分析需求54
9.1.3 前端开发54
9.1.4 编写对象模型及完成SQL查询功能55
9.1.5 编码Service端代码实现57
9.1.6 编写控制器58

# 1 实验环境介绍
## 0.1 实验介绍
### 0.1.1 关于本实验
### 0.1.2 读者知识背景
### 0.1.3 实验设备介绍
#### 组网说明
本实验环境为华为云环境，需要购买弹性云服务器。
#### 设备介绍
为了满足openGauss安装部署实验需要，建议每套实验环境采用以下配置：
表1-1 实验软件配套关系
|软件名称|软件版本|
| ---- | ---- |
|Linux操作系统|openEuler 20.3 LTS|
|ECS|4vCPUs | 8GiB弹性云服务器|
# 2 学生选课管理系统介绍
## 2.1 功能简介
这是一个功能基本齐全的《学生选课管理系统》（原始仓库地址：https://gitee.com/kangz1/graduation-design/tree/master 项目采用木兰宽松许可证），使用java实现，用到的后端框架是SpringBoot、Mybatis，前端框架是layui，数据库使用openGauss等技术。
系统中用户分为三种：
- 管理员(可以管理相关数据)；
- 教师(查询教授课程以及对学生选择的当前课程的成绩评定)；
- 学生(选择课程，查询课程以及选课成绩/学分)。

## 2.2 管理员模块功能
管理员：菜单管理、教务管理、人员管理、角色管理、课程管理、角色分配、首页通告管理、学院管理、学生管理、教师管理、学年管理、选课管理

## 2.3 教师模块功能
教师：课程信息、学生信息、成绩管理、统计信息

## 2.4 学生模块功能
学生：已选课程、选课中心、选课统计

## 2.5 系统界面
### 学生注册界面
学生选课管理系统 Student Selection Management System
学生账号注册
学号:请填写学号
姓名:请填写姓名
密码:请填写密码
手机号:请填写手机号
邮箱:请填写邮箱
选择学院:请选择你所属的学院
注册
已有账号,去登录
注册信息请如实填写,如果填写错误可能会造成无法选择课程

### 登录界面
学生选课管理系统 Student Selection Management System
学生请填写学号/老师填账号
账号:请输入账号密码
密码:
账号权限:学生、教师、管理员
登录
没有账号,快来注册吧>学生注册教师注册

### 管理员界面
学生选课管理系统 admin 退出登录
admin管理员,你好!欢迎登录学生选课管理系统
菜单管理、教务管理、人员管理、角色管理、课程管理
公告：关于本学期校级任选课相关事宜安排的通知
各学院及相关单位:
根据学校教学安排,本学期全校任选课定于6月20日(星期五)正式开课,选课工作将从6月16日开始。现将有关事项通知如下:
一、选课时间:6月16日----6月20日
二、学生登录选课信息管理系统后进入学生选课进行选课。学生选课前请认真阅读选课公告,再进行"网上选课"。
三、教师可登陆选课信息管理系统后进入选课管理增删课程,6月15日14:00之后各位教师及学生登录教务处网站查询自己申报的课程是否停开。
四、选课退课均须在选课时间内完成,选课结束后不再进行补退选,请学生注意选课时间。
五、请各学院通知并组织学生进行选课,同时请各学院及相关单位通知任课教师按时上课。教务处将组织相关人员对上课情况进行不定期的检查。

### 教师界面
学生选课管理系统 叶凡 退出登录
叶凡老师,你好!欢迎登录学生选课管理系统
课程信息、学生信息、成绩管理、统计信息
公告内容同上选课通知

### 学生界面
学生选课管理系统 夏九幽 退出登录
选课中心、已选课程、选课统计
2020上半学年选课列表
课程名称:计算机网络基础2
学院:软件工程学院
上课教师:叶凡
可选人数:32人
课程学分:5.0学分
上课时间:星期三下午第二节课8-11周；星期三下午第二节课13-14周
上课地点:6号主教学楼202
课程说明
1、页面上方的【选课中心】,然后点击左侧的【推荐选课】,就进入到推荐选课界面。在【推荐选课】中,学生可以查看自己方案内并且推荐自己(所在行政班)上课的除《体育IJV》外所有开设的课程。一般都需要修读。
2、选择【选课志愿】,然后点击【选课】按钮,若上课时间不冲突并且有剩余容量时,则选课成功。
3、在【方案内课程选课】中,学生可以选择本专业其他学期的课程【原则上不建议选择】,操作同【推荐选课】(第三、四阶段开放)。
4、在【方案外课程选课】中,学生可以根据自身的特点和兴趣,选择其他专业的专业课程,以扩充自己的知识面,操作同【推荐选课】(第三、四阶段开放)。

课程名称:计算机网络基础
学院:软件工程学院
上课教师:叶凡
可选人数:1人
课程学分:5.0学分

## 2.6 系统数据模型
### 2.6.1 关系模型
- **课程**：课程id、课程名称、学院id、教师id、学年id……
- **学生**：学生id、姓名、角色id、学院id……
- **学生选课**：学生id、课程id、评分教师……
- **教师**：教师id、姓名、角色id、学院id……
- **角色**：角色id、角色名……
- **管理员**：管理员id、用户名、角色id……
- **角色菜单**：角色id、菜单id……
- **菜单**：菜单id、菜单名、链接……
- **学院**：学院id、学院名……
- **课程学年**：学年id、学年……
- **首页资讯**：资讯id、标题、角色id、内容……

### 2.6.2 物理模型
表2-1 college（学院信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|name|varchar(64)|NOT NULL|学院名称|
|teacherNum|INTEGER|NOT NULL|学院下教师数|
|studentNum|INTEGER|NOT NULL|学院下学生数|
|state|varchar(1)|NOT NULL|状态|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|updateDate|SMALLDATETIME|NOT NULL|修改时间|

表2-2 course（课程信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|courseName|varchar(64)|NOT NULL|课程名称|
|collegeId|varchar(32)|NOT NULL|学院id|
|teacherId|varchar(32)|NOT NULL|教师id|
|classPlace|varchar(255)|NOT NULL|上课地点|
|classDate|varchar(255)|NOT NULL|上课时间|
|startDate|SMALLDATETIME|NOT NULL|选课开始时间|
|endDate |SMALLDATETIME|NOT NULL|选课结束时间|
|credits|DECIMAL(5, 1)|NOT NULL|学分|
|academicYear|varchar(20)|NOT NULL|学年|
|teachEndDate|SMALLDATETIME|NOT NULL|课程结束时间|
|optional|INTEGER|NOT NULL|可选人数|
|primaryAmount|INTEGER|NOT NULL|预选人数|
|selected|INTEGER|NOT NULL|选中人数|
|remark|text|NULL|课程说明|

表2-3 course_academic_year（课程学年）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|academicYear|varchar(20)|NOT NULL|学年|
|state|varchar(1)|NOT NULL|状态|

表2-4 information（首页资讯信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|title|varchar(320)|NOT NULL|标题|
|content|text|NOT NULL|内容|
|publishDate|SMALLDATETIME|NOT NULL|发布时间|
|roleId|varchar(32)|NOT NULL|角色id|

表2-5 manage_user（管理员用户）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|loginName|varchar(32)|NOT NULL|登录名|
|username|varchar(32)|NOT NULL|用户名|
|password|varchar(64)|NOT NULL|密码|
|roleId|varchar(32)|NOT NULL|角色id|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|state|varchar(1)|NOT NULL|状态|

表2-6 menu（菜单信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|name|varchar(64)|NOT NULL|菜单名称|
|parentId|varchar(32)|NOT NULL|父类id|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|createId|varchar(32)|NOT NULL|创建人id|
|updateDate|SMALLDATETIME|NOT NULL|修改时间|
|sort|INTEGER|NOT NULL|排序|
|href|varchar(64)|NOT NULL|链接|
|state|varchar(1)|NOT NULL|状态|
|remark|varchar(2555)|NULL DEFAULT NULL|备注|

表2-7 role（角色）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|name|varchar(64)|NOT NULL|角色名称|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|state|varchar(1)|NOT NULL|状态|

表2-8 role_menu_rel（角色菜单关联）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|roleId|varchar(32)|NOT NULL|角色id|
|menuId|varchar(32)|NOT NULL|菜单id|

表2-9 student（学生信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|studentNumber|varchar(64)|NOT NULL|学号|
|username|varchar(64)|NOT NULL|姓名|
|password|varchar(255)|NOT NULL|密码|
|phone|varchar(11)|NOT NULL|手机号|
|email|varchar(20)|NOT NULL|邮箱|
|roleId|varchar(32)|NOT NULL|角色id|
|collegeId|varchar(32)|NOT NULL|学院id|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|state|varchar(1)|NOT NULL|状态 0禁用 1正常|

表2-10 student_course_rel（学生课程关联）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|studentId|varchar(32)|NOT NULL|学生id|
|courseId|varchar(32)|NOT NULL|课程id|
|teacherId|varchar(32)|NOT NULL|评分教师|
|isQualified|varchar(1)|NOT NULL|成绩是否合格 0不合格 1合格|
|creditsRemark|varchar(255)|NOT NULL|教师评分备注|
|state|varchar(1)|NOT NULL|是否已对当前学生评分|

表2-11 teacher（教师信息）表
|字段名称|字段类型|约束|说明|
| ---- | ---- | ---- | ---- |
|id|varchar(32)|PRIMARY KEY|主键|
|loginName|varchar(64)|NOT NULL|登录名|
|username|varchar(64)|NOT NULL|姓名|
|password|varchar(255)|NOT NULL|密码|
|phone|varchar(11)|NOT NULL|手机号|
|email|varchar(20)|NOT NULL|邮箱|
|roleId|varchar(32)|NOT NULL|角色id|
|collegeId|varchar(32)|NOT NULL|学院id|
|createDate|SMALLDATETIME|NOT NULL|创建时间|
|state|varchar(1)|NOT NULL|状态 0禁用 1正常|

# 3 openGauss数据库准备
#### 步骤 1 连接服务器
使用SSH工具（比如：PuTTY等）从本地电脑通过配置ECS服务器IP地址（如：192.168.1.73）来连接服务器，并使用root用户及对应密码(如：openEuler)来登录。
如果ECS服务器上还没有安装openGauss数据库，请参考《01-1 在ECS上安装部署openGauss数据库指导手册》进行安装。

#### 步骤 2 切换至数据库安装用户
```shell
[root@db1 ~]# su – omm
```

#### 步骤 3 修改数据库的pg_hba.conf文件
在pg_hba.conf文件中增加一行＂host all all 0.0.0.0/0 sha256＂
```shell
[omm@db1 ~]$ cd /gaussdb/data/db1
[omm@db1 db1]$ cp pg_hba.conf pg_hba.conf.bak
[omm@db1 db1]$ gs_guc set -N all -I all -h "host all all 0.0.0.0/0 sha256"
```

#### 步骤 4 修改数据库listen_addresses的值
将listen_addresses的值由原来IP地址修改成为*号
```shell
[omm@db1 db1]$ cd /gaussdb/data/db1
[omm@db1 db1]$ cp postgresql.conf postgresql.conf.bak
[omm@db1 db1]$ gs_guc set -I all -c "listen_addresses='*'"
```

#### 步骤 5 查询openGauss数据库服务是否启动
```shell
[omm@ db1 ~]$ gs_om -t status --detail
```

#### 步骤 6 启动数据库服务（如数据库未启动，可执行此步进行启动）
```shell
[omm@db1 ~]$ gs_om -t start;
```

#### 步骤 7 登录openGauss数据库服务
```shell
[omm@db1 ~]$ gsql -d postgres -p 26000 -r
```

#### 步骤 8 创建数据库用户
创建“dboper”用户，密码为“dboper@123”
```sql
CREATE USER dboper IDENTIFIED BY 'dboper@123';
alter user dboper sysadmin;
```

#### 步骤 9 创建需要使用的数据库oasys，同时进行授权
```sql
create database oasys with owner dboper;
grant all privileges to dboper;
\q
```

#### 步骤 10 登录新建的oasys数据库
```shell
[omm@db1 ~]$  gsql -d oasys -p 26000 -r
```
接着在oasys数据库中完成相关数据库对象创建及数据初始化。

# 4 数据库对象创建
## 4.1 College学院信息表创建
```sql
--步骤1删表
DROP TABLE IF EXISTS public.college;
--步骤2建表
CREATE TABLE public.college (
  id varchar(32) PRIMARY KEY NOT NULL,
  name varchar(64) NOT NULL,
  teacherNum INTEGER NOT NULL,
  studentNum INTEGER NOT NULL,
  state varchar(1) NOT NULL,
  createDate SMALLDATETIME NOT NULL,
  updateDate SMALLDATETIME NOT NULL
) WITH (ORIENTATION = ROW);
--步骤3插入数据
INSERT INTO public.college VALUES ('1', '软件工程学院', 0, 0, '1', '2020-07-23 17:43:30', '2020-07-30 10:38:47');
INSERT INTO public.college VALUES ('2', '计算机技术与科学学院', 11, 11, '0', '2020-07-23 17:44:00', '2020-10-12 15:12:24');
```

## 4.2 Course课程信息表创建
```sql
DROP TABLE IF EXISTS public.course;
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
--插入数据
INSERT INTO public.course VALUES ('1', '计算机网络基础', '1', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 17:44:59', '2020-08-03 17:45:02', 5.0, '2020上半学年', '2020-08-08 17:44:52', 1, 1, 1, '1、页面上方的【选课中心】，然后点击左侧的【推荐选课】...');
INSERT INTO public.course VALUES ('2', '计算机网络基础2', '1', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 17:45:26', '2020-08-03 17:45:29', 5.0, '2020上半学年', '2020-08-03 17:45:31', 32, 1, 12, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('7508a2b591ae4499b3f8d17bc1d6e92a', '计算机网络基础3', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 00:00:00', '2020-08-03 00:00:00', 4.0, '2020上半学年', '2020-08-03 00:00:00', 68, 0, 0, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('8beb093dd8b749e199ff18da3ae2fe20', '计算机网络基础4', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-08-03 00:00:00', '2020-08-03 00:00:00', 5.0, '2020上半学年', '2020-08-03 00:00:00', 123, 0, 0, '1、页面上方的【选课中心】...');
INSERT INTO public.course VALUES ('d006bccea7654b26b33be71ee5c3197a', '计算机网络基础5', '2', '1', '6号主教学楼 202<br/>\r\n6号主教学楼 202', '星期三 下午第二节课 8-11周<br>星期三 下午第二节课 13-14周', '2020-07-04 00:00:00', '2020-08-04 00:00:00', 5.0, '2020上半学年', '2020-08-04 00:00:00', 115, 0, 0, '1、页面上方的【选课中心】...');
```

## 4.3 course_academic_year课程学年表创建
```sql
DROP TABLE IF EXISTS public.course_academic_year;
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
```

## 4.4 information公告信息表创建
```sql
DROP TABLE IF EXISTS public.information;
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
```

## 4.5 manage_user管理员用户表创建
```sql
DROP TABLE IF EXISTS public.manage_user;
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
```

## 4.6 menu菜单表创建
```sql
DROP TABLE IF EXISTS public.menu;
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
--菜单插入数据省略多条，示例一条
INSERT INTO public.menu VALUES ('1', '首页', '0', '2020-07-18 23:44:05', '1', '2020-08-18 17:42:18', 1, '/manage/index', '1', '首页数据展示');
```

## 4.7 role角色表创建
```sql
DROP TABLE IF EXISTS public.role;
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
```

## 4.8 role_menu_rel角色菜单关联表创建
```sql
DROP TABLE IF EXISTS public.role_menu_rel;
CREATE TABLE public.role_menu_rel  (
  id varchar(32) PRIMARY KEY NOT NULL,
  roleId varchar(32),
  menuId varchar(32) NOT NULL
) WITH (ORIENTATION = ROW);
--插入多条关联数据，省略
```

## 4.9 Student表学生用户表创建
```sql
DROP TABLE IF EXISTS public.student;
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
```

## 4.10 student_course_rel学生课程关联表创建
```sql
DROP TABLE IF EXISTS public.student_course_rel;
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
```

## 4.11 teacher教师信息表创建
```sql
DROP TABLE IF EXISTS public.teacher;
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
```

# 5 开发环境搭建
## 5.1 安装开发工具vscode
1. 下载地址：https://code.visualstudio.com/download，根据系统选择安装包（Windows64位）
2. 运行安装程序，勾选【添加到PATH（重启后生效）】，其余默认
3. 完成安装

## 5.2 在vscode中配置java环境
### 5.2.1 下载并安装JDK
JDK11下载：https://www.oracle.com/java/technologies/downloads/#java11-windows，默认路径安装。

### 5.2.2 配置JDK环境变量
1. 此电脑→属性→高级系统设置→环境变量
2. 系统变量新建`JAVA_HOME`，值为JDK安装目录：`C:\Program Files\Java\jdk-11.0.17`
3. Path新增：`%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;`
4. 新建CLASSPATH：`.`
5. cmd输入`java -version`验证

### 5.2.3 在vscode中配置java
1. 插件市场安装Chinese汉化插件，重启生效
2. 安装4个开发插件：Extension Pack for Java、Debugger for Java、Maven for Java、Language Support for Java(TM) by Red Hat

## 5.3 在vscode中配置Maven环境
### 步骤1 下载Maven
官网：https://maven.apache.org/download.cgi，下载zip压缩包解压。
### 步骤2 配置国内镜像
修改`conf/settings.xml`，在`<mirrors>`添加华为镜像：
```xml
<mirror>
  <id>mirror</id>
  <mirrorOf>*</mirrorOf>
  <name>cmc-cd-mirror</name>
  <url>https://mirrors.huaweicloud.com/repository/maven/</url>
</mirror>
```
### 步骤3 配置环境变量
- 新增系统变量`MAVEN_HOME`=解压路径
- Path添加`%MAVEN_HOME%\bin`
### 步骤4 cmd验证
`mvn -version`输出版本信息即成功
### 步骤5 VS安装Maven for Java插件

# 6 项目工程导入
## 6.1 项目源文件获取
源码地址：https://gitee.com/javaMya/stu-manage.git，压缩包stu-manage.tar.gz，解压至无中文路径。

## 6.2 项目工程配置
### 步骤1 修改application.properties数据库连接
路径：`graduation-design-master\src\main\resources\application.properties`
```properties
spring.datasource.url = jdbc:postgresql://192.168.1.73:26000/oasys
spring.datasource.driver-Class-Name = org.postgresql.Driver
spring.datasource.username = dboper
spring.datasource.password = dboper@123
```

### 步骤2 pom.xml替换驱动
注释mysql驱动，引入openGauss驱动：
```xml
<dependency>
    <groupId>org.opengauss</groupId>
    <artifactId>opengauss-jdbc</artifactId>
    <version>5.0.1</version>
</dependency>
```

### 步骤3 Maven打包编译
1. clean：右键Maven→Run Maven Command→clean
2. install：右键Maven→Run Maven Command→install
3. package：右键Maven→Run Maven Command→package
打包成功在target生成`springboot-student.jar`

# 7 学生选课管理系统验证
### 步骤1 启动项目
终端执行：
```shell
java -jar graduation-design-master/target/springboot-student.jar
```
项目端口8088

### 步骤2 浏览器访问
`http://localhost:8088/`

### 登录账号
- **管理员**：账号admin，密码admin，权限管理员
- **教师**：账号叶凡，密码123456，权限教师
- **学生**：学号741011421564111，密码123456，权限学生

# 8 基于选课管理系统的数据库开发
## 8.1 角色菜单功能设置
三张表：role(角色)、menu(菜单)、role_menu_rel(角色菜单关联)
### 任务1：给学生(roleId=3)新增选课统计菜单
```sql
INSERT INTO public.role_menu_rel VALUES ('e4482f66a1bc460fac5b59f437890259', '3', 'd4100b530ff9403c9f576138006d269f');
```
学生重新登录查看菜单。
### 任务2：删除学生首页菜单
```sql
DELETE from public.role_menu_rel where roleid='3' and menuid='1';
```

## 8.2 课程内容调整
关联表：course课程、college学院、teacher教师、course_academic_year学年
### 修改计算机网络基础可选人数(id=1)由1→5
```sql
update course set optional=5 where id='1';
```

## 8.3 信息列表查询
关联：student学生、course课程、student_course_rel选课中间表
需求：查询**教师id=1，2020上半学年**授课的选课学生（学号、姓名、课程名、学年、课程结束时间）
```sql
SELECT s.studentNumber studentNumber ,s.username studentName,c.courseName courseName,c.academicYear academicYear,c.teachEndDate teachEndDate
FROM student_course_rel sc 
LEFT JOIN course c ON c.id=sc.courseId 
LEFT JOIN student s ON s.id = sc.studentId 
WHERE c.teacherId='1' AND c.academicYear = '2020上半学年';
```

# 9 基于选课管理系统的统计信息开发
## 9.0.1 制定需求
1. 统计教师已授课程选课总人数
2. 展示选课学生所属学院名称

## 9.0.2 分析需求
- 前端：layui+thymeleaf+html
- 数据库：复用现有表，无需建表
- 后端：SpringBoot+Mybatis

## 9.0.3 前端开发
路径：`src/main/resources/templates/teacher/statisticalInfo.html`
```html
<!DOCTYPE html>
<html lang="zh"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/web/thymeleaf/layout"
      xmlns:="http://www.w3.org/1999/xhtml"
>
<head>
    <meta charset="UTF-8"/>
    <title>选课统计</title>
    <link href="../../static/css/index.css" type="text/css" rel="stylesheet"/>
    <link href="../../static/css/course.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" href="../../static/layui/css/layui.css"/>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div id="head" th:include="common/header :: common_head(user=${session.user})"></div>
    <div id="left_column" th:include="common/left_column :: left_column(menuList=${session.menuList})"></div>
    <div class="layui-body">
        <div style="padding: 15px;">
            <div class="index_cloum course-box">
                <blockquote class="layui-elem-quote">选课统计</blockquote>
                <blockquote class="layui-elem-quote course-column count-box"  th:each="ths:${TeacherStatis}">
                    <div>已完成课程统计</div>
                    <hr>
                    <div class="count-tip">当前已选课程人数:<span class="count_num" th:text="${ths.count}"></span></div>
                    <div class="count-tip">当前已选学员专业:<span class="collage_num" th:text="${ths.name}"></span></div>
                    <div class="clear"></div>
                </blockquote>
            </div>
        </div>
    </div>
</div>
</body>
```

## 9.0.4 编写对象模型及完成SQL查询功能
### 1.Entity实体 TeacherStatis.java
路径：`com/kzl/entity/TeacherStatis.java`
```java
package com.kzl.entity;
import lombok.Data;
@Data
public class TeacherStatis {
    private int count;
    private String name;
}
```
### 2.TeacherMapper.java新增接口
```java
List<TeacherStatis> selectTeacherStatisList(String teacherId);
```
### 3.teacherMapping.xml编写SQL
```xml
<select id="selectTeacherStatisList"  resultType="com.kzl.entity.TeacherStatis">
        SELECT count(s.studentNumber), cu.name name
        FROM student_course_rel sc
                 LEFT JOIN course c ON c.id=sc.courseId
                 LEFT JOIN student s ON s.id = sc.studentId
                 LEFT JOIN college cu ON cu.id = c. collegeId
        WHERE c.teacherId=#{teacherId}  GROUP BY name;
 </select>
```

## 9.0.5 编码Service端代码实现
### TeacherService接口
```java
List<TeacherStatis> selectTeacherStatisList(String teacherId);
```
### TeacherServiceImpl实现类
```java
@Override
 public List<TeacherStatis> selectTeacherStatisList(String teacherId) {
        List<TeacherStatis> teacherStatiss = teacherMapper.selectTeacherStatisList(teacherId);
        return teacherStatiss;
 }
```

## 9.0.6 编写控制器 TeacherController
注释原有statisticalInfo方法，新增：
```java
@RequestMapping("statisticalInfo")
public ModelAndView statisticalInfo(HttpServletRequest request){
        boolean state = judgeUserLoginState(request);
        ModelAndView modelAndView = new ModelAndView();
        if (state ==  true)
        {
            Teacher user = (Teacher) request.getSession().getAttribute("user");
            List<TeacherStatis> CoutStudent_collage  = teacherService.selectTeacherStatisList(user.getId());
            modelAndView.setViewName("teacher/statisticalInfo");
            modelAndView.addObject("TeacherStatis",CoutStudent_collage);
        } else {
            modelAndView.setViewName("redirect:/");
        }
        return  modelAndView;
}
```
重启项目，教师登录→统计信息即可展示选课统计数据。