# Stage 1: Build Stage
FROM node:20-slim AS builder
WORKDIR /app

# 1. 升级 npm（让 overrides 机制正常工作）
RUN npm install -g npm@latest

# 2. 复制依赖文件
COPY package*.json ./

# 3. 只根据 package.json 生成新的 lockfile（确保 overrides 生效）
RUN npm install --package-lock-only

# 4. 正式安装依赖（此时 node_modules 会包含新版本 cross-spawn 和 glob）
RUN npm install

# 5. 复制项目源代码
COPY . .

# -----------------------------------------------------------

# Stage 2: Production Stage
FROM node:20-slim
WORKDIR /app

# 生产阶段只复制必要内容
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/server.js ./

EXPOSE 3000
CMD [ "node", "server.js" ]

