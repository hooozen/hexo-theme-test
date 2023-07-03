# 使用一个包含 Node.js 和 Pandoc 的基础镜像
FROM node:18

# 设置工作目录
WORKDIR /app

# 将程序文件复制到镜像中
COPY . .

# 安装程序的依赖
RUN npm install

# 安装 Pandoc
RUN apt-get update && apt-get install -y pandoc

# 设置程序的环境变量等配置

# 暴露程序使用的端口（如果需要）

# 设置程序的启动命令
CMD [ "npm", "run", "build-tranquility" ]