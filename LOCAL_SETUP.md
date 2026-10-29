# 本项目独立使用

在本目录打开 agent 项目，技能由 `.agents/skills/` 中的相对软链接加载，源码仍保存在 `skills/`。

```bash
bash install-local.sh
./bin/wewrite home
./bin/wewrite diagnose --json
./bin/wewrite themes
```

- `.venv/`：本项目 Python 环境与依赖。
- `.cache/`：本项目依赖下载缓存。
- `.agents/skills/`：10 个项目级技能入口，不写用户级技能目录。
- `.wewrite/config.yaml`：非敏感配置；首次只设置默认排版主题。
- `.wewrite/`：文章任务、风格、历史、范文和学习产物。
- `bin/wewrite`：固定使用上述环境与状态目录的入口；从其他目录运行时使用它的绝对路径。

安装脚本可重复运行，不覆盖已有项目配置。不要运行原 `install.sh`。
密钥通过子进程环境变量提供；本入口不会自动读取或改写任何全局 `.env`。
风格未配置时，使用本项目 `wewrite-style` 技能完成首次设置。

本地数据、虚拟环境、下载缓存及 `.env` 已加入 Git 忽略规则。
技能链接使用相对路径；移动项目后应重新运行安装脚本重建虚拟环境。

## 同步代码

`origin` 指向自己的仓库，`upstream` 指向作者仓库。

```bash
git push origin main
git fetch upstream
```

获取作者更新后，先检查差异再决定合并，保留本项目的独立运行约定。
