package com.kzl.service.impl;

import com.kzl.dao.ManageMapper;
import com.kzl.dao.StudentMapper;
import com.kzl.dao.TeacherMapper;
import com.kzl.entity.*;
import com.kzl.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private ManageMapper manageMapper;

    @Override
    public List<Menu> queryUserRoleMenu(String roleId) {
        List<Menu> menus = manageMapper.selectFirstMenuByRoleId(roleId,"0");
        for(Menu menu:menus){
            List<Menu> menuSecond = manageMapper.selectFirstMenuByRoleId(roleId,menu.getId());
            menu.setMenus(menuSecond);
        }
        return menus;
    }

    @Override
    public Information queryInformation(String roleId) {
        Information information = manageMapper.selectInformationByRoleId(roleId);
        return information;
    }

    @Override
    public List<Course> selectCourseListByTeacherId(String id) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        List<Course> courses = teacherMapper.selectCourseListByTeacher(id,courseAcademicYear.getAcademicYear());
        return courses;
    }

    @Override
    public List<StudentCourseRel> queryStudentList(String academicYear, String userId, String studentName, String courseName) {
        List<StudentCourseRel> studentCourseRels = teacherMapper.selectStudentListByCourse(academicYear, userId, studentName, courseName);
        return studentCourseRels;
    }

    @Override
    public boolean updateStudentScore(StudentCourseRel studentCourseRel, String id) {
        if(studentCourseRel == null || studentCourseRel.getId() == null || studentCourseRel.getId().trim().isEmpty()){
            return false;
        }
        if(!"0".equals(studentCourseRel.getIsQualified()) && !"1".equals(studentCourseRel.getIsQualified())){
            return false;
        }
        if("1".equals(studentCourseRel.getIsQualified())){
            studentCourseRel.setCreditsRemark(" ");
        } else if(studentCourseRel.getCreditsRemark() == null || studentCourseRel.getCreditsRemark().trim().isEmpty()){
            return false;
        }
        studentCourseRel.setState("1");
        int rows = teacherMapper.updateStudentCourseRel(studentCourseRel, id);
        return rows > 0;
    }

    @Override
    public List<StudentCourseRel> getStudentInCourse(String academicYear, String userId, String studentName, String courseName) {
        List<StudentCourseRel> studentCourses = teacherMapper.selectStudentListByCourse(academicYear, userId, studentName, courseName);
        return studentCourses;
    }

    @Override
    public List<Course> selectCourseList(String teacherId, String courseAcademicYear) {
        List<Course> courses = teacherMapper.selectCourseListByTeacher(teacherId,courseAcademicYear);
        return courses;
    }

    @Override
    public List<CourseAcademicYear> selectCourseYearList(String courseAcademicYearId) {
        List<CourseAcademicYear> courseAcademicYears = teacherMapper.selectCourseAcademicYearList();
        for(CourseAcademicYear courseAcademicYear : courseAcademicYears){
            courseAcademicYear.setType("0");
            if(courseAcademicYearId.equals(courseAcademicYear.getId())){
                courseAcademicYear.setType("1");
            }
        }
        return courseAcademicYears;
    }

    @Override
 public List<TeacherStatis> selectTeacherStatisList(String teacherId) {
        List<TeacherStatis> teacherStatiss = teacherMapper.selectTeacherStatisList(teacherId);
        return teacherStatiss;
 }

    @Override
    public Teacher queryTeacherById(String id) {
        return teacherMapper.selectTeacherById(id);
    }

    @Override
    public boolean updateTeacherProfile(Teacher teacher) {
        return teacherMapper.updateTeacherProfile(teacher);
    }

    @Override
    public Teacher verifyTeacherPassword(Teacher teacher) {
        return teacherMapper.verifyTeacherPassword(teacher);
    }

    @Override
    public boolean updateTeacherPassword(String id, String newPassword) {
        return teacherMapper.updateTeacherPassword(id, newPassword);
    }
}
