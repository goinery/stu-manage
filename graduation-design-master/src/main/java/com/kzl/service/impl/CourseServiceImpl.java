package com.kzl.service.impl;

import com.kzl.dao.CourseMapper;
import com.kzl.entity.Course;
import com.kzl.entity.CourseAcademicYear;
import com.kzl.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<Course> queryCourseList(Course course) {
        List<Course> courses = courseMapper.selectCourseList(course);
        return courses;
    }

    @Override
    public boolean updateCourseList(Course course) {
       if(course == null || isBlank(course.getId())){
           return false;
       }
       if(course.getCredits() != null && course.getCredits() <= 0){
           return false;
       }
       if(course.getOptional() != null && course.getOptional() < 0){
           return false;
       }
       if(course.getPrimaryAmount() != null && course.getPrimaryAmount() < 0){
           return false;
       }
       if(course.getSelected() != null && course.getSelected() < 0){
           return false;
       }
       boolean b = courseMapper.updateCourse(course);
       return b;
    }

    @Override
    public boolean addCourseList(Course course) {
        if(course == null
                || isBlank(course.getCourseName())
                || isBlank(course.getCollegeId())
                || "0".equals(course.getCollegeId())
                || isBlank(course.getTeacherId())
                || "0".equals(course.getTeacherId())
                || isBlank(course.getClassPlace())
                || isBlank(course.getClassDate())
                || isBlank(course.getStartDate())
                || isBlank(course.getEndDate())
                || isBlank(course.getTeachEndDate())
                || course.getCredits() == null
                || course.getCredits() <= 0
                || course.getOptional() == null
                || course.getOptional() <= 0){
            return false;
        }
        course.setId(UUID.randomUUID().toString().replaceAll("-",""));
        course.setSelected(0);
        if(course.getPrimaryAmount() == null || course.getPrimaryAmount() < 0){
            course.setPrimaryAmount(0);
        }
        //获取当前学年
        CourseAcademicYear courseAcademicYear = courseMapper.selectCurrentCourseAcademicYear();
        if(courseAcademicYear == null){
            return false;
        }
        course.setAcademicYear(courseAcademicYear.getAcademicYear());
        course.setState("1");
        return courseMapper.insertCourse(course);
    }

    @Override
    public List<CourseAcademicYear> queryCourseAcademicYearList() {
        List<CourseAcademicYear> courseAcademicYears = courseMapper.selectCourseAcademicYearList();
        return courseAcademicYears;
    }

    @Override
    @Transactional
    public boolean updateAcademicYears(CourseAcademicYear courseAcademicYear) {
        if(courseAcademicYear == null || isBlank(courseAcademicYear.getId())){
            return false;
        }
        courseMapper.updateAcademicYears();
        boolean b = courseMapper.updateAcademicYearsById(courseAcademicYear);
        return b;
    }

    @Override
    public boolean addAcademicYears(CourseAcademicYear courseAcademicYear) {
        if(courseAcademicYear == null || isBlank(courseAcademicYear.getAcademicYear())){
            return false;
        }
        courseAcademicYear.setId(UUID.randomUUID().toString().replaceAll("-",""));
        courseAcademicYear.setState("0");
        boolean b = courseMapper.insertAcademicYears(courseAcademicYear);
        return b;
    }

    @Override
    public boolean queryCourseEndDate(Course course) {
        if(course == null || isBlank(course.getId())){
            return false;
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        course.setEndDate(simpleDateFormat.format(new Date()));
        List list = courseMapper.selectCourseByEndDate(course);
        return list.size()>0?true:false;
    }

    @Override
    public List<Map> selectTeacherList() {
        List<Map> teacherList = courseMapper.selectTeacherList();
        return teacherList;
    }

    private boolean isBlank(String text){
        return text == null || text.trim().isEmpty();
    }

}
