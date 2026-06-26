-- Add administrator statistics menu without resetting existing data.
-- Execute this after init_fixed.sql has already been applied.

INSERT INTO public.menu(id, name, parentId, createDate, createId, updateDate, sort, href, state, remark)
SELECT 'm26', '综合统计', 'm09', CURRENT_TIMESTAMP, '1', CURRENT_TIMESTAMP, 3, '/manage/statistical', '1', '管理员综合统计'
WHERE NOT EXISTS (
    SELECT 1 FROM public.menu WHERE id = 'm26'
);

INSERT INTO public.role_menu_rel(id, roleId, menuId)
SELECT 'rm029', '1', 'm09'
WHERE NOT EXISTS (
    SELECT 1 FROM public.role_menu_rel WHERE roleId = '1' AND menuId = 'm09'
);

INSERT INTO public.role_menu_rel(id, roleId, menuId)
SELECT 'rm030', '1', 'm26'
WHERE NOT EXISTS (
    SELECT 1 FROM public.role_menu_rel WHERE roleId = '1' AND menuId = 'm26'
);
