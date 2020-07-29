# @author : gaoxiang
# @time   : 06/29/20 14:20 PM
# @File   : Dockerfile

FROM ubuntu:20.04
MAINTAINER xiang "2126881247@qq.com"

COPY . /app
WORKDIR /app

# 安装基础环境
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf \
    && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
#    && mv /etc/apt/sources.list /etc/apt/sources.list.bak \
#    && cp /app/sources.list /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    # 设置python pip
    && apt-get install --no-install-recommends -y python3-pip python3-dev build-essential\
    && pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip \
    # 设置时区
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends -y tzdata \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# 安装项目环境 
RUN rm -Rf /app/__pycache__ \
    && apt-get install --no-install-recommends -y nginx python3-flask python3-sqlalchemy python3-requests python3-urllib3 python3-pymysql python3-dateutil \
    && pip3 install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt \
    && rm /etc/nginx/sites-available/default \
    && cp nginx.conf /etc/nginx/sites-available/default \
    && apt-get purge -y --auto-remove gcc make \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8000
#ENTRYPOINT ["/bin/sh"]
ENTRYPOINT ["supervisord", "-n", "-c", "/app/supervisord.conf"]