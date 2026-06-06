package com.kzl.entity;

import lombok.Data;

import java.util.Date;

//选课阶段控制
@Data
public class SelectionStage {
    private String id;
    private String academicYear;       //学年
    private String stageName;          //阶段名称: 第一阶段, 第二阶段, 第三阶段, 第四阶段
    private int stageOrder;            //阶段顺序: 1,2,3,4
    private Date startDate;            //阶段开始时间
    private Date endDate;              //阶段结束时间
    private String allowRecommend;     //是否允许推荐选课 1允许 0不允许
    private String allowPlan;          //是否允许方案内选课 1允许 0不允许
    private String allowOutside;       //是否允许方案外选课 1允许 0不允许
    private String state;              //状态 1启用 0禁用
}
