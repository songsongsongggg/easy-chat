#!/bin/bash
reso_addr='registry.cn-hangzhou.aliyuncs.com/im-easy-chat/user-rpc-dev'
tag='latest'

container_name="easy-chat-user-rpc-test"

network_name='easy-chat_easy-chat'

# 停止并清理旧容器
docker stop ${container_name} || true
docker rm ${container_name} || true
docker rmi ${reso_addr}:${tag} || true

# 拉取新镜像
docker pull ${reso_addr}:${tag}

# 创建网络（若不存在）
docker network inspect ${network_name} >/dev/null 2>&1 || docker network create ${network_name}


# 如果需要指定配置文件的
# docker run -p 10001:8080 --network imooc_easy-social -v /easy-social/config/user-rpc:/user/conf/ --name=${container_name} -d ${reso_addr}:${tag}
docker run -p 10000:10000 --network ${network_name} --name=${container_name} -d ${reso_addr}:${tag}