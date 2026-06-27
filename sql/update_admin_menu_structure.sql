BEGIN;

UPDATE public.menu
SET name = '首页', parentId = '0', sort = 1, href = '/manage/index',
    state = '1', remark = '首页数据展示', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm01';

UPDATE public.menu
SET name = '菜单管理', parentId = '0', sort = 2, href = '/manage/menu',
    state = '1', remark = '菜单树管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm18';

UPDATE public.menu
SET name = '教务管理', parentId = '0', sort = 3, href = NULL,
    state = '1', remark = '教务基础数据与首页通告管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm02';

UPDATE public.menu
SET name = '学院管理', parentId = 'm02', sort = 1, href = '/manage/college',
    state = '1', remark = '学院信息管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm16';

UPDATE public.menu
SET name = '首页通告管理', parentId = 'm02', sort = 2, href = '/manage/information',
    state = '1', remark = '首页通告管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm17';

UPDATE public.menu
SET name = '人员管理', parentId = '0', sort = 4, href = NULL,
    state = '1', remark = '人员相关管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm03';

UPDATE public.menu
SET name = '学生管理', parentId = 'm03', sort = 1, href = '/manage/student',
    state = '1', remark = '学生信息管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm14';

UPDATE public.menu
SET name = '教师管理', parentId = 'm03', sort = 2, href = '/manage/teacher',
    state = '1', remark = '教师信息管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm15';

UPDATE public.menu
SET name = '角色管理', parentId = '0', sort = 5, href = NULL,
    state = '1', remark = '角色权限管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm04';

UPDATE public.menu
SET name = '角色分配', parentId = 'm04', sort = 1, href = '/manage/role',
    state = '1', remark = '角色权限分配', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm19';

UPDATE public.menu
SET name = '课程管理', parentId = '0', sort = 6, href = NULL,
    state = '1', remark = '课程与选课相关管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm06';

UPDATE public.menu
SET parentId = 'm06', sort = 1, href = '/course/list',
    state = '1', remark = '课程列表管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm10';

UPDATE public.menu
SET parentId = 'm06', sort = 2, href = '/course/forwardAdd',
    state = '1', remark = '新增课程页面', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm11';

UPDATE public.menu
SET parentId = 'm06', sort = 3, href = '/course/courseAcademicYear',
    state = '1', remark = '学年管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm12';

UPDATE public.menu
SET name = '选课管理', parentId = 'm06', sort = 4, href = '/manage/selectionStage',
    state = '1', remark = '选课阶段管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm13';

UPDATE public.menu
SET name = '数据分析', parentId = '0', sort = 9, href = NULL,
    state = '1', remark = '数据统计分析', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm09';

UPDATE public.menu
SET name = '综合统计', parentId = 'm09', sort = 3, href = '/manage/statistical',
    state = '1', remark = '管理员综合统计', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm26';

UPDATE public.menu
SET state = '0', remark = '已拆分为菜单管理和角色管理', updateDate = CURRENT_TIMESTAMP
WHERE id = 'm05';

DELETE FROM public.role_menu_rel
WHERE roleId = '1';

INSERT INTO public.role_menu_rel(id, roleId, menuId) VALUES
('rm001', '1', 'm01'),
('rm002', '1', 'm18'),
('rm003', '1', 'm02'),
('rm004', '1', 'm16'),
('rm005', '1', 'm17'),
('rm006', '1', 'm03'),
('rm007', '1', 'm14'),
('rm008', '1', 'm15'),
('rm009', '1', 'm04'),
('rm010', '1', 'm19'),
('rm011', '1', 'm06'),
('rm012', '1', 'm10'),
('rm013', '1', 'm11'),
('rm014', '1', 'm12'),
('rm015', '1', 'm13'),
('rm029', '1', 'm09'),
('rm030', '1', 'm26');

COMMIT;
