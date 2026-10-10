# Yu Ma — Academic Website

English academic website for **Yu Ma (马宇)**, a third-year master's student in the School of Cyber Science and Technology, Shandong University, supervised by Prof. Meiqin Wang.

**Live website:** <https://nkumayu.github.io/yuma/> · **Source:** [nkumayu/yuma](https://github.com/nkumayu/yuma)

Built from the open-source [al-folio](https://github.com/alshedivat/al-folio) v1 starter. Layouts, navigation, dark mode, BibTeX publication rendering, and CV rendering are provided by pinned al-folio plugin gems. This is a Jekyll site, with no Node.js build step.

## 网站内容

- **About**：个人简介、照片、研究方向及联系方式。
- **Research**：后量子数字签名的侧信道攻击、泄漏分析和掩码防护。
- **Publications**：明确显示目前无论文；后续直接添加真实 BibTeX。
- **CV**：2020–2024 南开大学本科；2024–2027 山东大学硕士（预计 2027 年毕业）。
- **Contact**：真实邮箱；未提供的社交主页和地址显示 `To be added`。

你的原始照片保存在 `assets/img/profile-portrait.jpg`，通过 CSS 控制显示比例，未修改原图。

## 免费部署

完整步骤见 **[部署说明](docs/DEPLOYMENT.md)**。

1. 在 GitHub 创建公开仓库，推荐命名为 `YOUR_GITHUB_USERNAME.github.io`。
2. 将本目录的代码推送到该仓库的 `main` 分支，包括 `.github/workflows/pages.yml`。
3. 在 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**。
4. 在 **Actions** 查看构建；成功后访问 Pages 显示的地址。

工作流自动根据仓库名生成正确的 `url` / `baseurl`，兼容个人主页仓库与普通项目仓库，无须填写虚构 GitHub 用户名。不需要 `gh-pages` 分支，也不用 GitHub 的默认 Jekyll 构建器。

## 本地预览

安装 Docker 后，在本目录运行：

```powershell
docker compose up
```

访问 <http://localhost:8080>。首次运行会安装 Ruby 依赖。结束时按 `Ctrl+C`，再运行 `docker compose down`。

已安装 Ruby 3.2 和 Bundler 的环境也可运行：

```bash
bundle install
bundle exec jekyll serve --port 8080
```

## 维护和验证

编辑位置、占位符列表和添加真实论文的方法见 **[内容维护说明](docs/CONTENT.md)**。模板版本与复用说明见 **[第三方说明](THIRD_PARTY_NOTICES.md)**。

本次构建与桌面 / 手机验证结果见 **[验证记录](docs/VALIDATION.md)**。

```bash
bundle exec ruby bin/check-content.rb
bundle exec jekyll build
bundle exec ruby bin/check-site.rb _site
```

本项目保留 al-folio 的 MIT 许可。个人照片和个人信息来自网站所有者，不能因模板的代码许可证而推定可自由复用。
