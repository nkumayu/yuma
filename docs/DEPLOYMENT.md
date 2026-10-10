# GitHub Pages 部署步骤

此网站使用 al-folio v1 的 Jekyll 插件，必须通过仓库中附带的 **GitHub Actions** 工作流构建，然后将生成的静态文件部署到 GitHub Pages。不要选择 `Deploy from a branch`，也不要直接上传源 Markdown 作为网页。

当前部署仓库为 [nkumayu/yuma](https://github.com/nkumayu/yuma)，网站地址为 <https://nkumayu.github.io/yuma/>。此仓库使用项目子路径 `/yuma`，工作流会自动设置正确的页面和资源路径。

## 1. 创建公开仓库

登录 GitHub，创建一个由你本人拥有的 **Public** 仓库。GitHub Free 的公开仓库可使用 GitHub Pages。

可以选择两种方式：

| 类型             | 仓库名称                         | 上线地址                                                |
| ---------------- | -------------------------------- | ------------------------------------------------------- |
| 个人主页（推荐） | `YOUR_GITHUB_USERNAME.github.io` | `https://YOUR_GITHUB_USERNAME.github.io/`               |
| 普通项目网站     | 例如 `academic-site`             | `https://YOUR_GITHUB_USERNAME.github.io/academic-site/` |

`YOUR_GITHUB_USERNAME` 是明确的部署占位符，请替换为你的真实 GitHub 用户名。创建时可以不勾选 README、许可证和 `.gitignore`，因为这些文件已经在本项目中。

## 2. 上传代码

如果本目录还不是 Git 仓库，先运行 `git init`。当前交付目录已经有 `.git`，可直接使用。

以下命令使用当前仓库 `nkumayu/yuma`；若换用其他仓库，请相应修改远程地址：

```powershell
Set-Location 'C:\Users\78656\Documents\New project'
git add .
git commit -m "Set up Yu Ma academic website"
git branch -M main
git remote add origin https://github.com/nkumayu/yuma.git
git push -u origin main
```

如果已经存在 `origin`，先用 `git remote -v` 核对；需要更换时运行 `git remote set-url origin <你的仓库地址>`，不要重复 `remote add`。GitHub HTTPS 登录请使用 Git Credential Manager 或 GitHub 支持的凭据方式。

`_site/`、`vendor/`、`.bundle/`、`.template-source/` 和 `.work/` 等本地生成目录已忽略，不需要上传。务必保留 `Gemfile.lock`、所有下划线开头的源目录和 `.github/workflows/pages.yml`。

## 3. 启用 Pages

1. 打开仓库 **Settings → Pages**。
2. 在 **Build and deployment → Source** 选择 **GitHub Actions**。
3. 若仓库禁用了 Actions，在 **Settings → Actions → General** 中启用，允许所用的官方 Actions 和 `ruby/setup-ruby`。
4. 打开 **Actions → Build and deploy academic website**。
5. 若首次推送发生在启用 Pages 之前，点击 **Run workflow → main → Run workflow** 重跑。

工作流会检查内容，安装锁定的 Ruby 依赖，构建网站，验证本地链接，再部署。部署作业使用 `pages: write` 和 `id-token: write`；构建作业仅需 `contents: read`。这些权限已在工作流中设置，不需要个人访问令牌。

## 4. 访问网站

等待 `build` 和 `deploy` 都成功，在 **Settings → Pages** 或部署环境 `github-pages` 中复制最终地址。以后每次推送到 `main` 或 `master`，网站自动更新。Pull Request 只构建和检查，不上线。

工作流通过 `bin/pages-config.rb` 自动生成未跟踪的 `_config.pages.yml`：

- 个人主页仓库：`url: https://YOUR_GITHUB_USERNAME.github.io`，`baseurl: ""`。
- 项目仓库：相同 `url`，`baseurl: /仓库名称`。

源码中的内部链接都使用 `relative_url`，照片、导航和样式随部署子路径一起变化。`_config.yml` 中的 `http://localhost:8080` 仅用于本地开发，Actions 会覆盖它。

## 本地开发：Windows 推荐 Docker

安装并启动 Docker Desktop 后，在项目根目录运行：

```powershell
docker compose up
```

访问 <http://localhost:8080>。首次依赖下载可能较慢；等待日志中的 `Server running`。修改内容后自动重新生成。修改 `_config.yml` 后重启服务。

```powershell
docker compose down
```

该配置使用 Ruby 3.2 容器和持久化依赖缓存，不需要 Windows 本机 Ruby、ImageMagick、Python 或 Node.js。

已有 Ruby 3.2 / Bundler 的 Linux、macOS 或 WSL 环境：

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 8080
```

## 可选：手动静态构建

以下为 Bash 命令，将仓库变量改为你的真实值：

```bash
export PAGES_REPOSITORY=YOUR_GITHUB_USERNAME/academic-site
bundle exec ruby bin/pages-config.rb _config.pages.yml
JEKYLL_ENV=production bundle exec jekyll build --config _config.yml,_config.pages.yml
bundle exec ruby bin/check-site.rb _site
```

生成目录 `_site/` 可供其他静态托管服务使用。个人主页仓库将变量改为 `YOUR_GITHUB_USERNAME/YOUR_GITHUB_USERNAME.github.io`。

## 可选：自定义域名

默认免费部署不需要购买域名。若之后使用自定义域名，先按 GitHub 官方文档配置 DNS 和 Pages 域名，再在工作流的 **Resolve GitHub Pages URL** 步骤 `env` 中添加：

```yaml
GITHUB_PAGES_URL: https://your-real-domain.example
```

这里的域名只是格式占位符，必须替换。构建脚本会使用自定义域名并清空 `baseurl`。

## 常见问题

- **部署失败**：先确认 Pages Source 已设置为 GitHub Actions，再看 Actions 中失败步骤的日志。
- **构建失败**：提交 `Gemfile.lock`；使用 Ruby 3.2；不要启用未安装的插件，也不要使用 GitHub 的受限默认 Jekyll 构建。
- **项目网站样式或照片缺失**：不要手写 `/research/` 这类绝对内部链接，使用 `{{ '/research/' | relative_url }}`。工作流已有项目路径校验。
- **本地打不开**：先确认 Ruby 安装完成、服务器启动且 8080 端口可用。更改端口时同时调整本地 `url`。
- **邮箱按钮**：`mailto:` 调用访问者的邮件客户端，不是服务器发信服务。
- **CV 没有 PDF 下载按钮**：目前尚未提供真实 CV PDF。按内容维护说明添加后再启用。

## 官方参考

- [al-folio 项目与安装文档](https://github.com/alshedivat/al-folio/blob/main/docs/INSTALL.md)
- [GitHub Pages 入门](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site)
- [使用自定义 Actions 工作流部署 Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
