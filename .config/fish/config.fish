function fish_prompt --description 'Write out the prompt' 

# Just calculate these once, to save a few cycles when displaying the prompt 
if not set -q __fish_prompt_hostname 
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1) 
end 

if not set -q __fish_prompt_normal 
    set -g __fish_prompt_normal (set_color normal) 
end 

switch $USER 

    case root 

    if not set -q __fish_prompt_cwd 
        if set -q fish_color_cwd_root 
            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root) 
        else 
            set -g __fish_prompt_cwd (set_color $fish_color_cwd) 
        end 
    end 

    echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# ' 

    case '*' 

    if not set -q __fish_prompt_cwd 
        set -g __fish_prompt_cwd (set_color $fish_color_cwd) 
    end
 
    if not set -q __fish_prompt_bold
        set -g __fish_prompt_bold (set_color -o $fish_color_cwd) 
    end

    echo -n -s "$__fish_prompt_bold" "$USER" @ "$__fish_prompt_hostname" "$__fish_prompt_normal" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '> '
end 
end

function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt' 
echo $PWD | sed -e "s|^$HOME|~|"
end

function ll --description 'List contents of directory using long format'
    ls -alFh $argv
end
function la
    ls -A $argv
end
function l
    ls -CF $argv
end
