#!/usr/bin/env bash
# Install CLI, skills, and state inside this checkout only.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd -P)"
cd "$ROOT"

# Never follow pre-existing installation directories into a global location.
for dir in .venv .wewrite .agents .agents/skills .cache .cache/uv .cache/pip; do
  if [ -L "$dir" ]; then
    echo "拒绝写入符号链接目录：$ROOT/$dir；请先检查其目标。" >&2
    exit 1
  fi
done

PYTHON="${PYTHON:-python3}"
"$PYTHON" -c 'import sys; assert sys.version_info >= (3, 11), "需要 Python 3.11+"'
[ -d .venv ] || "$PYTHON" -m venv .venv

if command -v uv >/dev/null 2>&1; then
  uv --cache-dir "$ROOT/.cache/uv" pip install --python "$ROOT/.venv/bin/python" -e "$ROOT"
else
  .venv/bin/python -m pip --disable-pip-version-check --cache-dir "$ROOT/.cache/pip" install -e "$ROOT"
fi

mkdir -p .agents/skills
for skill in skills/wewrite*; do
  [ -f "$skill/SKILL.md" ] || continue
  target=".agents/skills/$(basename "$skill")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "../../$skill" ]; then
      continue
    fi
    echo "保留已有技能入口，未覆盖：$target" >&2
    exit 1
  fi
  ln -s "../../$skill" "$target"
done

mkdir -p .wewrite
if [ ! -e .wewrite/config.yaml ]; then
  (umask 077; printf '%s\n' '# 项目配置；密钥通过环境变量注入，保持集中管理。' 'theme: professional-clean' > .wewrite/config.yaml)
fi
.venv/bin/python -c 'import os; from wewrite.paths import ensure_home; os.environ["WEWRITE_HOME"] = os.path.join(os.getcwd(), ".wewrite"); print("状态目录:", ensure_home())'

echo "初始化完成：./bin/wewrite --help"
echo "技能仅链接到本项目 .agents/skills/；未安装全局 CLI 或技能。"
