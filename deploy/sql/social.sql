CREATE TABLE `friends` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '用户ID',
    `friend_uid` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '好友用户ID',
    `remark` varchar(255) DEFAULT NULL COMMENT '好友备注',
    `add_source` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加好友来源',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '好友添加时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友列表';

CREATE TABLE `friend_requests` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '发起请求的用户ID',
    `req_uid` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '被请求添加的用户ID',
    `req_msg` varchar(255) DEFAULT NULL COMMENT '好友请求消息',
    `req_time` timestamp NOT NULL COMMENT '请求时间',
    `handle_result` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理结果（如同意、拒绝）',
    `handle_msg` varchar(255) DEFAULT NULL COMMENT '处理留言',
    `handled_at` timestamp NULL DEFAULT NULL COMMENT '处理时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友请求记录';

CREATE TABLE `groups` (
    `id` varchar(24) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群组ID',
    `name` varchar(255) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群组名称',
    `icon` varchar(255) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群组头像',
    `status` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '群组状态',
    `creator_uid` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群主用户ID',
    `group_type` int(11) NOT NULL COMMENT '群组类型',
    `is_verify` boolean NOT NULL COMMENT '是否需要验证',
    `notification` varchar(255) DEFAULT NULL COMMENT '群公告',
    `notification_uid` varchar(64) DEFAULT NULL COMMENT '发布群公告的用户ID',
    `created_at` timestamp NULL DEFAULT NULL COMMENT '群组创建时间',
    `updated_at` timestamp NULL DEFAULT NULL COMMENT '群组更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组信息';

CREATE TABLE `group_members` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `group_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群组ID',
    `user_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '用户ID',
    `role_level` tinyint COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色级别（群主、管理员、普通成员）',
    `join_time` timestamp NULL DEFAULT NULL COMMENT '加入时间',
    `join_source` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '加入来源（邀请、申请等）',
    `inviter_uid` varchar(64) DEFAULT NULL COMMENT '邀请者用户ID',
    `operator_uid` varchar(64) DEFAULT NULL COMMENT '操作人用户ID（如移除成员的人）',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组成员列表';

CREATE TABLE `group_requests` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `req_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '请求用户ID',
    `group_id` varchar(64) COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '群组ID',
    `req_msg` varchar(255) DEFAULT NULL COMMENT '请求加入的消息',
    `req_time` timestamp NULL DEFAULT NULL COMMENT '请求时间',
    `join_source` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '加入来源（申请、邀请等）',
    `inviter_user_id` varchar(64) DEFAULT NULL COMMENT '邀请用户ID',
    `handle_user_id` varchar(64) DEFAULT NULL COMMENT '处理请求的管理员ID',
    `handle_time` timestamp NULL DEFAULT NULL COMMENT '请求处理时间',
    `handle_result` tinyint COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '处理结果（同意、拒绝等）',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群组加入请求记录';