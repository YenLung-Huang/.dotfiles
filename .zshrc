# =============================================================================
# 1. Powerlevel10k Instant Prompt (必須放在最頂端)
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# 2. 環境變數 & PATH 設定 (Environment)
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"

# 編譯相關 Flags (保留你原本針對 Intel/Rosetta 的設定)
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"

# 整合所有的 PATH 設定，避免散落在各處
# 注意：將常用的放在前面
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
export PATH="$PATH:/usr/local/opt/rabbitmq/sbin"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
# 如果有原本手動的 Composer bin
# export PATH=~/.composer/vendor/bin:$PATH

# =============================================================================
# 3. Oh-My-Zsh 設定
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

# 關閉 OMZ 的主題，因為下面會手動載入 Powerlevel10k，避免重複載入
ZSH_THEME=""

# OMZ 更新設定
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

# Plugins
# 注意：已移除 'fd'，因為它是 command line tool，不是 standard plugin
# 請確保你有透過 brew install fd 安裝實體工具
plugins=(
  brew
  docker
  docker-compose
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# 4. Aliases (別名)
# =============================================================================
# System
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias zshconfig="nvim ~/.zshrc" # 方便快速編輯設定檔

# Brew (Apple Silicon 兼容模式)
alias brew='arch -arm64 brew'

# Editor
alias vi="nvim"
alias vim="nvim"
alias vimdiff='nvim -d'

# Git / Tig
alias tis='tig status'
alias til='tig log'
alias tib='tig blame -C'

# Tools
alias tmux='tmux -2'
alias composer="php /usr/local/bin/composer"

# Project Shortcuts
alias projapi='cd ~/Owlting/Projects/ERP_api'

# =============================================================================
# 5. 工具整合 (FZF, NVM)
# =============================================================================

# --- FZF 設定 ---
# 設定搜尋指令 (使用 ripgrep)
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- NVM (Lazy Load) ---
# 延遲載入 NVM 以加速 Shell 啟動時間
export NVM_DIR="$HOME/.nvm"
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  load_nvm() {
    unset -f nvm node npm load_nvm
    . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  }

  nvm() { load_nvm; nvm "$@"; }
  node() { load_nvm; node "$@"; }
  npm() { load_nvm; npm "$@"; }
fi

# =============================================================================
# 6. Powerlevel10k Theme 設定 (必須放在底部)
# =============================================================================
source ~/powerlevel10k/powerlevel10k.zsh-theme

# 載入 p10k 設定檔
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
