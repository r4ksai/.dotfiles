#! bash oh-my-bash.module
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

modern_scm_prompt() {
        CHAR=$(scm_char)
        if [ $CHAR = $SCM_NONE_CHAR ]
        then
                return
        else
                echo "[$(scm_prompt_info)]"
        fi
}

function _omb_theme_PROMPT_COMMAND() {
    PS1="${_omb_prompt_green}\u@\h ${_omb_prompt_reset_color}[$(clock_prompt)] ${_omb_prompt_gray}[\w]${_omb_prompt_green} $(modern_scm_prompt)${_omb_prompt_navy}\n→${_omb_prompt_bold_navy} ${_omb_prompt_reset_color} ";
}

THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$_omb_prompt_navy"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%I:%M:%S"}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
