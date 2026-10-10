# 交付验证记录

验证日期：2026-10-10（Asia/Shanghai）。

- 实际构建环境：WSL Ubuntu 24.04、Ruby 3.2.3、Bundler 4.0.6、Jekyll 4.4.1。
- Ruby 依赖安装完成；版本记录在 `Gemfile.lock`。
- 姓名、邮箱、五个页面路由、插件激活列表和照片文件检查通过。
- 根路径生产构建通过，六个 HTML 页面（含 404）的英文语言、viewport、Liquid 渲染和本地链接检查通过。
- `/academic-site` 项目子路径生产构建通过，同样的页面与资源路径检查通过。
- al-folio 升级审计：0 个阻断项、0 个非阻断项；三处覆盖已记录在 `.al-folio-overrides.yml`。
- Prettier 检查通过，包括 Markdown、YAML、Liquid 和 Sass。
- 使用 Chrome / Playwright 检查 About、Research、Publications、CV、Contact：320、390、768、1360 像素宽度均返回 HTTP 200，无横向溢出；所有页面图片加载正常。
- 实际点击验证桌面导航、手机折叠菜单和明暗主题切换；主题设置跨页面保留。
- Contact 邮箱链接指向 `mailto:my1911453@163.com`。
- Publications 显示“目前无论文”；CV 正确显示两段教育经历和预计 2027 年毕业。
- 浏览器控制台无错误。
- 用户照片与原始附件 SHA-256 一致，未修改图像文件。

- 已推送至 `nkumayu/yuma` 的 `main` 分支，Pages 的 Source 已设为 GitHub Actions。
- [首次线上构建和部署](https://github.com/nkumayu/yuma/actions/runs/38014870855) 均成功，网站上线地址为 <https://nkumayu.github.io/yuma/>。
- `/yuma` 实际部署路径的本地生产构建与所有本地链接检查通过。
- 已在浏览器访问线上 About、Research、Publications、CV、Contact；照片加载、导航、无论文状态、教育经历、邮箱和 GitHub 主页链接均正确。
- 线上 390 像素移动端无横向溢出，照片加载正常，折叠菜单可以展开并显示五个页面入口。

Docker 配置已提供，但本次实际本地构建使用 WSL Ruby 环境，未执行 Docker 构建。

本地预览截图保存在 `output/playwright/`，属于生成文件，未纳入 Git。
