-- 选课阶段表创建及初始化数据
-- 用于控制不同选课类型在不同阶段的开放状态

-- 创建选课阶段表（如果不存在）
CREATE TABLE IF NOT EXISTS selection_stage (
    id varchar(32) PRIMARY KEY,
    academicYear varchar(20) NOT NULL,
    stageName varchar(64) NOT NULL,
    stageOrder INTEGER NOT NULL,
    startDate TIMESTAMP NOT NULL,
    endDate TIMESTAMP NOT NULL,
    allowRecommend varchar(1) DEFAULT '1',
    allowPlan varchar(1) DEFAULT '0',
    allowOutside varchar(1) DEFAULT '0',
    state varchar(1) DEFAULT '1'
);

-- 清空旧数据（可选）
-- DELETE FROM selection_stage;

-- 插入默认选课阶段数据
-- 第一阶段：仅推荐选课开放
INSERT INTO selection_stage VALUES ('stage001', '2020上半学年', '第一阶段-推荐选课', 1, '2020-07-01 00:00:00', '2020-08-15 23:59:59', '1', '0', '0', '1');
-- 第二阶段：仅推荐选课开放
INSERT INTO selection_stage VALUES ('stage002', '2020上半学年', '第二阶段-推荐选课', 2, '2020-08-16 00:00:00', '2020-09-15 23:59:59', '1', '0', '0', '1');
-- 第三阶段：所有类型开放
INSERT INTO selection_stage VALUES ('stage003', '2020上半学年', '第三阶段-全面选课', 3, '2020-09-16 00:00:00', '2020-10-15 23:59:59', '1', '1', '1', '1');
-- 第四阶段：所有类型开放
INSERT INTO selection_stage VALUES ('stage004', '2020上半学年', '第四阶段-补退选', 4, '2020-10-16 00:00:00', '2020-11-15 23:59:59', '1', '1', '1', '1');

-- 为了演示方便，插入一个当前时间段可用的阶段（2025-2026年）
INSERT INTO selection_stage VALUES ('stage005', '2020上半学年', '当前演示阶段-全面开放', 5, '2025-01-01 00:00:00', '2030-12-31 23:59:59', '1', '1', '1', '1');

-- 为student_course_rel表添加selectionType字段（如果不存在）
-- 注意：openGauss/PostgreSQL语法
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name = 'student_course_rel' AND column_name = 'selectiontype'
    ) THEN
        ALTER TABLE student_course_rel ADD COLUMN selectionType varchar(20) DEFAULT 'recommend';
    END IF;
END $$;
