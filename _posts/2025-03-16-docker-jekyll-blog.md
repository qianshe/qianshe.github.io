---
layout: post
title: 使用 Docker 和 AI 驱动的 Jekyll 博客系统构建
categories: [技术, Docker, AI]
date: 2025-03-16
---

## 项目介绍

本文将介绍如何使用 Docker 和 Jekyll 搭建一个支持中英文切换的个人博客系统，并结合 AI 技术增强开发体验。

### 主要特性

- 支持中英文界面切换
- 文章分类和归档功能
- 响应式设计
- Docker 本地开发环境
- AI 辅助开发
  - GitHub Copilot 代码生成
  - AI 驱动的多语言内容生成
  - 智能代码优化建议

### 技术栈

- Jekyll + GitHub Pages
- Docker + Docker Compose
- Ruby 3.2
- SCSS
- AI 工具集成
  - GitHub Copilot
  - ChatGPT API
  - Claude/Anthropic

## AI 驱动的开发流程

### 1. 智能代码生成

使用 GitHub Copilot 加速开发：
- 自动生成 Docker 配置
- 智能补全 Jekyll 模板
- 提供最佳实践建议

```yaml
# Docker Compose 配置示例 (由 GitHub Copilot 生成并优化)
version: '3'
services:
  site:
    build: 
      context: .
      dockerfile: Dockerfile
    command: bundle exec jekyll serve --host 0.0.0.0 --watch --force_polling
    ports:
      - "4000:4000"
    volumes:
      - .:/usr/src/app
      - bundle_cache:/usr/local/bundle
    environment:
      - JEKYLL_ENV=development
    networks:
      - jekyll-net

networks:
  jekyll-net:

volumes:
  bundle_cache:
```

### 2. AI 辅助内容创作

利用 AI 工具提升效率：
- 多语言内容自动翻译
- 技术文档智能生成
- SEO 优化建议

### 3. 智能化部署流程

AI 驱动的部署优化：
- 自动检测配置问题
- 智能性能调优
- 安全漏洞扫描

## Docker 环境配置

### 1. Dockerfile

```dockerfile
FROM ruby:3.2

WORKDIR /usr/src/app

# 设置国内源和环境变量
ENV LANG=C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN gem sources --remove https://rubygems.org/ && \
    gem sources -a https://mirrors.tuna.tsinghua.edu.cn/rubygems/ && \
    gem sources -l && \
    bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems

COPY Gemfile* ./
RUN bundle install

EXPOSE 4000

CMD ["jekyll", "serve", "--host", "0.0.0.0"]
```

### 2. docker-compose.yml

```yaml
version: '3'
services:
  site:
    build: 
      context: .
      dockerfile: Dockerfile
    command: bundle exec jekyll serve --host 0.0.0.0 --watch --force_polling
    ports:
      - "4000:4000"
    volumes:
      - .:/usr/src/app
      - bundle_cache:/usr/local/bundle
    environment:
      - JEKYLL_ENV=development
    networks:
      - jekyll-net

networks:
  jekyll-net:

volumes:
  bundle_cache:
```

### 3. Gemfile

```ruby
source "https://mirrors.tuna.tsinghua.edu.cn/rubygems/"

ruby "~> 3.2.0"

gem "jekyll", "~> 3.9.3"
gem "github-pages", "~> 228"
gem "webrick", "~> 1.8"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-remote-theme"
end
```

## 本地开发

### 启动开发环境

```bash
# 构建镜像
docker-compose build

# 启动服务
docker-compose up

# 后台运行
docker-compose up -d

# 查看日志
docker-compose logs -f
```

### 目录结构

```
.
├── _includes/          # 页面组件
├── _layouts/          # 页面布局
├── _posts/           # 博客文章
├── pages/           # 独立页面
│   ├── en/         # 英文页面
│   └── zh/         # 中文页面
├── assets/         # 静态资源
├── Dockerfile
├── docker-compose.yml
└── Gemfile
```

## Docker 相关说明

1. **镜像选择**：使用 ruby:3.2 作为基础镜像，保证 Jekyll 运行环境的稳定性

2. **性能优化**：
   - 使用 bundle_cache 卷缓存 gems
   - 设置 BUNDLE_JOBS 和 BUNDLE_RETRY 优化构建速度
   - 使用国内镜像源加速依赖下载

3. **开发体验**：
   - 配置文件热更新 (--watch --force_polling)
   - 端口映射方便本地访问
   - 文件挂载实现实时预览

4. **网络配置**：
   - 创建独立网络隔离服务
   - 暴露必要端口便于调试

5. **部署考虑**：
   - 多阶段构建优化镜像大小
   - 环境变量配置方便切换
   - 资源限制保护宿主机

## AI 开发最佳实践

1. **代码质量提升**
   - 使用 Copilot 进行代码审查
   - AI 驱动的代码优化
   - 自动化测试生成

2. **内容管理优化**
   - 智能分类系统
   - 自动标签生成
   - SEO 建议优化

3. **维护效率提升**
   - 自动问题诊断
   - 智能更新建议
   - 性能优化推荐

## 常见问题

1. 依赖下载失败
   ```bash
   # 清理缓存重新构建
   docker-compose down -v
   docker-compose build --no-cache
   ```

2. 权限问题
   ```bash
   # 调整容器内文件权限
   chmod -R 777 .
   ```

3. 端口占用
   ```bash
   # 修改 docker-compose.yml 中的端口映射
   ports:
     - "4001:4000"
   ```

## 部署到 GitHub Pages

1. 创建 .github/workflows/jekyll.yml 配置 CI/CD
2. 推送代码触发自动部署
3. 在仓库设置中启用 GitHub Pages

## 结论

使用 Docker 和 AI 技术开发 Jekyll 博客系统的优势：

1. 环境隔离，避免依赖冲突
2. AI 驱动开发，提升效率
3. 智能化运维，降低成本
4. 自动化部署，减少人工干预

## 未来展望

1. **AI 功能增强**
   - 智能文章推荐
   - 自动内容生成
   - 个性化用户体验

2. **自动化提升**
   - CI/CD 智能优化
   - 自动化测试增强
   - 智能监控告警

项目源码：[GitHub 仓库地址](https://github.com/qianshe/qianshe.github.io)
