package com.kzl.service.impl;

import com.kzl.dao.ManageMapper;
import com.kzl.dao.StudentMapper;
import com.kzl.entity.*;
import com.kzl.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import com.kzl.entity.SelectionStage;

@Service
public class StudentServiceImpl implements StudentService {

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
    public List<Course> queryCourseList(String collegeId,String userId) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        List<Course> courses = studentMapper.selectCourseList(collegeId,courseAcademicYear.getAcademicYear());
        for(Course course:courses){
            //查询当前课程是否选择
            StudentCourseRel studentCourseRel = studentMapper.selectStudentCourseRel(course.getId(),userId);
            course.setType(studentCourseRel==null?"0":"1");
        }
        return courses;
    }

    @Override
    public boolean updateStudentCourseRel(StudentCourseRel studentCourseRel) {
        //查询当前时间是否可以选择课程
        Course course = studentMapper.selectCourseByPeriodTime(studentCourseRel.getCourseId(),new Date());
        if(course == null){
            return false;
        }
        //查询可选人数和已选人数
        Course course1 = studentMapper.selectCourseById(studentCourseRel.getCourseId());
        if(course1.getOptional() == course1.getSelected()){
            return false;
        }
        boolean b = false;
        Course course2 = new Course();
        course2.setId(studentCourseRel.getCourseId());
        if("0".equals(studentCourseRel.getType())){
            studentCourseRel.setId(UUID.randomUUID().toString().replaceAll("-",""));
            studentCourseRel.setState("0");
            b = studentMapper.insertStudentCourseRel(studentCourseRel);
            course2.setUseNumber(1);
            //添加已选人说

        }else{
            b = studentMapper.deleteStudentCourseRel(studentCourseRel);
            //删除已选人数
            course2.setUseNumber(-1);
        }
        studentMapper.updateCourse(course2);
        return b;
    }

    @Override
    public List<Course> selectCourseList(String id) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        List<Course> courses = studentMapper.selectCourseListByStudent(id,courseAcademicYear.getAcademicYear());
        return courses;
    }

    @Override
    public CourseAcademicYear getCourseAcademicYear() {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        String yearName = courseAcademicYear.getAcademicYear().substring(0,4);
        String monthName = courseAcademicYear.getAcademicYear().substring(4);
//        String academicYearName = "02".equals(monthName)?yearName+"年上半学年":yearName+"年下半学年";
        courseAcademicYear.setAcademicYearName(courseAcademicYear.getAcademicYear());
        return courseAcademicYear;
    }

    @Override
    public Map queryCourseSeletedCount(Student user) {
        Map<String,Object> data = new HashMap<>();
        //已完成课程统计
        Map map = studentMapper.selectCompleteCourseCount(user);
        data.put("complete",map);
        //未完成课程统计
        Map map2 = studentMapper.selectUnfinishedCourseCount(user);
        data.put("unfinished",map2);
        //已选课程统计
        Map map3 = studentMapper.selectSelectedCourseCount(user);
        data.put("selected",map3);
        return data;
    }

    @Override
    public Student queryStudentById(String id) {
        return studentMapper.selectStudentById(id);
    }

    @Override
    public boolean updateStudentProfile(Student student) {
        return studentMapper.updateStudentProfile(student);
    }

    @Override
    public Student verifyStudentPassword(Student student) {
        return studentMapper.verifyStudentPassword(student);
    }

    @Override
    public boolean updateStudentPassword(String id, String newPassword) {
        return studentMapper.updateStudentPassword(id, newPassword);
    }

    @Override
    public boolean checkDatabaseConnection() {
        try {
            studentMapper.checkConnection();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public List<Course> queryRecommendCourseList(String collegeId, String userId) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        if(courseAcademicYear == null) return new ArrayList<>();
        return studentMapper.selectRecommendCourseList(collegeId, courseAcademicYear.getAcademicYear(), userId);
    }

    @Override
    public List<Course> queryPlanCourseList(String collegeId, String userId) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        if(courseAcademicYear == null) return new ArrayList<>();
        return studentMapper.selectPlanCourseList(collegeId, userId, courseAcademicYear.getAcademicYear());
    }

    @Override
    public List<Course> queryOutsideCourseList(String collegeId, String userId) {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        if(courseAcademicYear == null) return new ArrayList<>();
        return studentMapper.selectOutsideCourseList(collegeId, userId, courseAcademicYear.getAcademicYear());
    }

    @Override
    public SelectionStage queryActiveSelectionStage() {
        CourseAcademicYear courseAcademicYear = studentMapper.selectCourseAcademicYearByState();
        if(courseAcademicYear == null) return null;
        try {
            studentMapper.ensureSelectionStageTable();
        } catch (Exception e) {
            // 表可能已存在
        }
        return studentMapper.selectActiveSelectionStage(courseAcademicYear.getAcademicYear());
    }

    @Override
    public boolean checkTimeConflict(String studentId, String classDate) {
        if(classDate == null || classDate.trim().isEmpty()) return false;
        List<String> existingTimes = studentMapper.selectStudentCourseTimeSlots(studentId);
        if(existingTimes == null || existingTimes.isEmpty()) return false;

        // 将新课程的上课时间拆分为时间段
        String[] newSlots = classDate.split("<br>");
        for(String existingTime : existingTimes) {
            String[] existSlots = existingTime.split("<br>");
            for(String newSlot : newSlots) {
                for(String existSlot : existSlots) {
                    // 提取星期和节次进行比较
                    if(isTimeOverlap(newSlot.trim(), existSlot.trim())) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    /**
     * 判断两个上课时间段是否冲突
     * 格式示例: "星期三 下午第二节课 8-11周"
     */
    private boolean isTimeOverlap(String time1, String time2) {
        if(time1 == null || time2 == null || time1.isEmpty() || time2.isEmpty()) return false;

        try {
            // 提取星期
            String day1 = extractDay(time1);
            String day2 = extractDay(time2);
            if(!day1.equals(day2)) return false;

            // 提取节次（上午/下午 + 第几节）
            String period1 = extractPeriod(time1);
            String period2 = extractPeriod(time2);
            if(!period1.equals(period2)) return false;

            // 提取周次范围
            int[] weeks1 = extractWeekRange(time1);
            int[] weeks2 = extractWeekRange(time2);
            if(weeks1 == null || weeks2 == null) return period1.equals(period2);

            // 检查周次是否有交集
            return weeks1[0] <= weeks2[1] && weeks2[0] <= weeks1[1];
        } catch (Exception e) {
            return false;
        }
    }

    private String extractDay(String time) {
        if(time.contains("星期一")) return "1";
        if(time.contains("星期二")) return "2";
        if(time.contains("星期三")) return "3";
        if(time.contains("星期四")) return "4";
        if(time.contains("星期五")) return "5";
        if(time.contains("星期六")) return "6";
        if(time.contains("星期日")) return "7";
        return "0";
    }

    private String extractPeriod(String time) {
        // 提取"上午/下午 + 第X节课"作为节次标识
        if(time.contains("上午第一节课")) return "A1";
        if(time.contains("上午第二节课")) return "A2";
        if(time.contains("上午第三节课")) return "A3";
        if(time.contains("上午第四节课")) return "A4";
        if(time.contains("下午第一节课")) return "P1";
        if(time.contains("下午第二节课")) return "P2";
        if(time.contains("下午第三节课")) return "P3";
        if(time.contains("下午第四节课")) return "P4";
        if(time.contains("晚上第一节课")) return "E1";
        if(time.contains("晚上第二节课")) return "E2";
        if(time.contains("晚上第三节课")) return "E3";
        return time;
    }

    private int[] extractWeekRange(String time) {
        try {
            // 匹配 "8-11周" 或 "13-14周" 格式
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("(\\d+)-(\\d+)周");
            java.util.regex.Matcher matcher = pattern.matcher(time);
            if(matcher.find()) {
                int start = Integer.parseInt(matcher.group(1));
                int end = Integer.parseInt(matcher.group(2));
                return new int[]{start, end};
            }
            // 匹配 "8周" 格式
            java.util.regex.Pattern singlePattern = java.util.regex.Pattern.compile("(\\d+)周");
            java.util.regex.Matcher singleMatcher = singlePattern.matcher(time);
            if(singleMatcher.find()) {
                int week = Integer.parseInt(singleMatcher.group(1));
                return new int[]{week, week};
            }
        } catch (Exception e) {
            // ignore
        }
        return null;
    }

    @Override
    public Course queryCourseById(String courseId) {
        return studentMapper.selectCourseById(courseId);
    }

    @Override
    public List<Map> queryCourseCountByType(String studentId) {
        return studentMapper.selectCourseCountByType(studentId);
    }

    @Override
    public List<Map> queryCourseCountByCollege(String studentId) {
        return studentMapper.selectCourseCountByCollege(studentId);
    }

    @Override
    public List<Map> queryTimeConflictStats(String studentId) {
        List<Map> rawStats = studentMapper.selectTimeConflictStats(studentId);
        List<Map> result = new ArrayList<>();
        if(rawStats != null){
            for(Map stat : rawStats){
                String date1 = stat.get("classDate1") != null ? stat.get("classDate1").toString() : "";
                String date2 = stat.get("classDate2") != null ? stat.get("classDate2").toString() : "";
                if(isTimeOverlap(date1, date2)){
                    Map<String, Object> conflict = new HashMap<>();
                    conflict.put("courseName1", stat.get("courseName1"));
                    conflict.put("courseName2", stat.get("courseName2"));
                    conflict.put("classDate1", date1);
                    conflict.put("classDate2", date2);
                    conflict.put("conflictDesc", stat.get("courseName1") + " 与 " + stat.get("courseName2") + " 上课时间存在重叠");
                    result.add(conflict);
                }
            }
        }
        return result;
    }

    @Override
    public Map querySelectionOverview(String studentId) {
        Map overview = studentMapper.selectSelectionOverview(studentId);
        return overview != null ? overview : new HashMap();
    }
}
