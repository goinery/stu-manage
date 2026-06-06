package com.kzl.dao;

import com.kzl.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface StudentMapper {

    List<Course> selectCourseList(String collegeId,String courseAcademicYear);

    StudentCourseRel selectStudentCourseRel(String courseId, String studentId);

    boolean insertStudentCourseRel(StudentCourseRel studentCourseRel);

    boolean deleteStudentCourseRel(StudentCourseRel studentCourseRel);

    List<Course> selectCourseListByStudent(String studentId,String courseAcademicYear);

    CourseAcademicYear selectCourseAcademicYearByState();

    Map selectCompleteCourseCount(Student user);

    Map selectUnfinishedCourseCount(Student user);

    Map selectSelectedCourseCount(Student user);

    Course selectCourseByPeriodTime(String courseId, Date nowTime);

    Course selectCourseById(String courseId);

    int updateCourse(Course course2);

    // 根据ID查询学生信息
    Student selectStudentById(String id);

    // 修改学生基本信息
    boolean updateStudentProfile(Student student);

    // 验证学生密码
    Student verifyStudentPassword(Student student);

    // 修改学生密码
    boolean updateStudentPassword(@Param("id") String id, @Param("newPassword") String newPassword);

    // 数据库连接检测
    int checkConnection();
}
