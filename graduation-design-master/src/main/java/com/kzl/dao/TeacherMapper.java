package com.kzl.dao;

import com.kzl.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TeacherMapper {

    List<Course> selectCourseListByTeacher(String teacherId, String academicYear);

    List<StudentCourseRel> selectStudentListByCourse(String academicYear, String teacherId);

    boolean updateStudentCourseRel(StudentCourseRel studentCourseRel);

    List<CourseAcademicYear> selectCourseAcademicYearList();

    List<TeacherStatis> selectTeacherStatisList(String teacherId);

    // 根据ID查询教师信息
    Teacher selectTeacherById(String id);

    // 修改教师基本信息
    boolean updateTeacherProfile(Teacher teacher);

    // 验证教师密码
    Teacher verifyTeacherPassword(Teacher teacher);

    // 修改教师密码
    boolean updateTeacherPassword(@Param("id") String id, @Param("newPassword") String newPassword);
}
