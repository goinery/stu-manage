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

    //查询推荐选课列表（同学院同学年，排除体育课程）
    List<Course> selectRecommendCourseList(@Param("collegeId") String collegeId, @Param("academicYear") String academicYear, @Param("studentId") String studentId);

    //查询方案内选课列表（同专业所有学期课程）
    List<Course> selectPlanCourseList(@Param("collegeId") String collegeId, @Param("studentId") String studentId, @Param("academicYear") String academicYear);

    //查询方案外选课列表（其他专业课程）
    List<Course> selectOutsideCourseList(@Param("collegeId") String collegeId, @Param("studentId") String studentId, @Param("academicYear") String academicYear);

    //查询当前有效的选课阶段
    SelectionStage selectActiveSelectionStage(@Param("academicYear") String academicYear);

    //查询学生已选课程的上课时间（用于冲突校验）
    List<String> selectStudentCourseTimeSlots(@Param("studentId") String studentId);

    //选课阶段表是否存在，不存在则创建
    void ensureSelectionStageTable();

    //按选课类型统计
    List<Map> selectCourseCountByType(@Param("studentId") String studentId);

    //按专业统计选课
    List<Map> selectCourseCountByCollege(@Param("studentId") String studentId);

    //时间冲突检测统计
    List<Map> selectTimeConflictStats(@Param("studentId") String studentId);

    //选课总体统计
    Map selectSelectionOverview(@Param("studentId") String studentId);
}
