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

    //查询推荐选课列表
    List<Course> queryRecommendCourseList(String collegeId, String userId);

    //查询方案内选课列表
    List<Course> queryPlanCourseList(String collegeId, String userId);

    //查询方案外选课列表
    List<Course> queryOutsideCourseList(String collegeId, String userId);

    //查询当前选课阶段
    SelectionStage queryActiveSelectionStage();

    //校验上课时间冲突
    boolean checkTimeConflict(String studentId, String classDate);

    //根据课程ID查询课程信息
    Course queryCourseById(String courseId);

    //按选课类型统计
    List<Map> queryCourseCountByType(String studentId);

    //按专业统计选课
    List<Map> queryCourseCountByCollege(String studentId);

    //时间冲突检测统计
    List<Map> queryTimeConflictStats(String studentId);

    //选课总体统计
    Map querySelectionOverview(String studentId);

    //学生退课
    boolean dropStudentCourse(StudentCourseRel studentCourseRel);
}
