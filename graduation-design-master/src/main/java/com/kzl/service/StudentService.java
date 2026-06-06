package com.kzl.service;

import com.kzl.entity.*;

import java.util.List;
import java.util.Map;

public interface StudentService {
    List<Menu> queryUserRoleMenu(String roleId);

    Information queryInformation(String roleId);

    List<Course> queryCourseList(String collegeId,String userId);

    boolean updateStudentCourseRel(StudentCourseRel studentCourseRel);

    //通过学生id查询选择的课程
    List<Course> selectCourseList(String id);

    CourseAcademicYear getCourseAcademicYear();

    //查询选课统计
    Map queryCourseSeletedCount(Student user);

    //根据ID查询学生信息
    Student queryStudentById(String id);

    //修改学生基本信息
    boolean updateStudentProfile(Student student);

    //验证学生密码
    Student verifyStudentPassword(Student student);

    //修改学生密码
    boolean updateStudentPassword(String id, String newPassword);

    //检测数据库连接
    boolean checkDatabaseConnection();

}
