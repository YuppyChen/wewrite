# 公共规则

每次处理请求及恢复会话后，先读取 `/Users/roc/AGENTS.md` 的最新内容。

# WeWrite 项目内运行

- 本项目使用独立安装，禁止运行原 `install.sh`、`uv tool install`、`pipx install` 或全局 pip 安装。
- 初始化、更新依赖统一执行 `bash install-local.sh`。仅写入本项目，不向用户级 agent 技能目录、`~/.local/bin` 或 shell 配置写入内容。
- 技能源码在 `skills/`，项目技能入口在 `.agents/skills/`。保留应用及其他项目管理的技能。
- 所有技能文档里的 `wewrite ...` 命令均替换为本项目 `./bin/wewrite ...`；不在项目根目录时使用该入口的绝对路径。
- `bin/wewrite` 将 `WEWRITE_HOME` 固定到本项目 `.wewrite/`。不得绕过入口使用全局 CLI 或全局用户状态。
- `.wewrite/` 保存配置、写作风格、历史、语料、学习产物和文章任务；它与 `.venv/`、`.cache/`、`.env` 均不提交 Git。
- API Key 继续集中管理在现有 `.env`，仅按需读取并通过子进程环境变量注入；不修改全局文件，不打印或提交密钥。
- 首次使用尚未设置风格、凭据和学习产物是正常状态；按用户意图配置，不借此触发全局安装。
- `origin` 用于推送用户自己的仓库；`upstream` 仅用于获取作者更新，禁止向作者仓库推送。

# 常用入口

```bash
bash install-local.sh
./bin/wewrite home
./bin/wewrite diagnose --json
./bin/wewrite --help
```

具体目录和使用方式见 `LOCAL_SETUP.md`。
