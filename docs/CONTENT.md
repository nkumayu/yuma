# 内容维护

网站正文以英文为主，姓名和导师姓名附有中文。英语姓名使用 **Yu Ma**；没有将未提供的论文、项目、奖项、技术技能或实验结果写成事实。教育信息采用用户提供的年份，2027 年明确标为预计毕业时间。

## 常用编辑位置

| 内容                                | 文件                              |
| ----------------------------------- | --------------------------------- |
| 姓名、语言、简介、SEO、模板功能开关 | `_config.yml`                     |
| 首页正文、头像说明                  | `_pages/about.md`                 |
| 研究方向与未来项目介绍              | `_pages/research.md`              |
| 文献列表与空状态文案                | `_pages/publications.md`          |
| CV 页面配置、PDF 路径               | `_pages/cv.md`                    |
| 教育经历与 CV 正文                  | `_data/cv.yml`                    |
| 邮箱、GitHub 和 Scholar 账号        | `_data/socials.yml`               |
| 联系页面和地址占位                  | `_pages/contact.md`               |
| 真实论文的 BibTeX                   | `_bibliography/papers.bib`        |
| 照片                                | `assets/img/profile-portrait.jpg` |
| 本站颜色、间距与响应式样式          | `_sass/_academic.scss`            |
| GitHub Pages 构建与部署             | `.github/workflows/pages.yml`     |

邮箱从 `_data/socials.yml` 读取到 About 和 Contact 页面。CV 使用模板原生数据结构，其邮箱也写在 `_data/cv.yml`；两处同时修改，检查脚本会校验一致性。

## 当前明确保留的占位符

- GitHub 账号、Google Scholar 主页：`_data/socials.yml` 中为空，Contact 显示 `To be added`。
- 办公地点和通信地址：Contact 显示 `To be added`。
- 具体研究项目、算法、实验平台、数据集、开源代码和实验结果：Research 标为 `Project details — to be added`。
- 技术技能、奖项、学术服务：CV 标为 `to be added`，不展示模板示例。
- 真实 CV PDF：尚未提供，CV 文案标注 `to be added`，无虚假下载链接。

用户已确认目前无论文，因此 Publications 显示 `No publications at present`；这不是待补论文的假列表。

## 添加真实论文

1. 从正式出版社、预印本页面或本人确认的记录获得 BibTeX。
2. 将实际条目添加到 `_bibliography/papers.bib`，核对题目、作者、年份、venue 和 DOI。
3. 可选字段：`pdf`、`code`、`html`、`abstract`、`bibtex_show`，沿用 al-folio 的文献功能。不要填写不存在的链接。
4. Publications 自动根据真实条目从空状态切换到文献列表，按年份倒序显示并启用模板文献搜索。
5. 将 CV 的 `Publication record` 更新为真实信息。如需使用 CV 原生文献条目，改用 `Publications` 数组并按照 al-folio CV 数据格式填写。

本项目没有附加伪造 BibTeX 示例，以免误上线。

## 添加真实 CV PDF

1. 放入 `assets/pdf/Yu-Ma-CV.pdf`。
2. 在 `_pages/cv.md` 的 front matter 中启用：

```yaml
cv_pdf: /assets/pdf/Yu-Ma-CV.pdf
```

3. 删除 CV 页面描述和 `_data/cv.yml` 中的 PDF 占位说明。
4. 如果希望社交区域也显示下载入口，可在 `_data/socials.yml` 启用同样的 `cv_pdf` 路径。

不提供 PDF 时仍可浏览完整网页 CV；浏览器“打印 / 保存为 PDF”也可使用，本站包含打印样式。

## 更新个人资料

进入下一学年或毕业后，更新 About 和 `_data/cv.yml` 中的 `third-year`、`in progress`、`expected` 文案。不要自动把计划中的 2027 年毕业改为已取得学位。

## 模板复用与本地覆盖

al-folio v1 的运行时位于 Ruby gem，而非本站的完整主题源码中。本项目保留核心布局、移动导航、明暗主题、文献和 CV 插件；没有重写 CV 或 BibTeX 渲染器。

本站仅对三个模板文件进行轻量覆盖：

- `_includes/header.liquid`：让首页也显示姓名品牌，保留模板导航与主题按钮。
- `_layouts/about.liquid`：让头像采用明确的替代文字，保留模板 About 布局。
- `assets/css/main.scss`：沿用原有 Sass 模块，只追加本站 `_academic.scss`。

未来更新 gem 后，检查覆盖文件是否需要跟进：

```bash
bundle exec al-folio upgrade audit --no-fail
bundle exec al-folio upgrade overrides audit
```

查看报告后再接受变化。升级时同时更新 `Gemfile` 和 `Gemfile.lock`；插件安装列表和 `_config.yml` 中的 `plugins` 必须对应。不要添加不必要的演示插件。

## 发布前校验

```bash
bundle exec ruby bin/check-content.rb
JEKYLL_ENV=production bundle exec jekyll build
bundle exec ruby bin/check-site.rb _site
```

校验身份、邮箱、页面路由、插件列表、图片、输出页面和内部链接。另需在浏览器检查桌面和手机宽度的导航、照片和 CV，并切换明暗主题。

学校英文名称参考学校官方页面：[山东大学](https://cst.qd.sdu.edu.cn/wlkjanxyen/Faculty/Cryptography.htm)、[南开大学](https://encyber.nankai.edu.cn/)。
