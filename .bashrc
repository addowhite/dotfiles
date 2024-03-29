set -o vi
alias ls="ls -hN --color=auto --group-directories-first"
#alias vim="nvim"
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -pv"

function cd() {
  builtin cd "$@" && ls
}

function video-minify() {
  ffmpeg -i "$1" -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-silent() {
  ffmpeg -i "$1" -c copy -an "$2"
}

function video-minify-1080() {
  ffmpeg -i "$1" -vf scale=-1:1080 -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-minify-720() {
  ffmpeg -i "$1" -vf scale=-1:720 -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-minify-640() {
  ffmpeg -i "$1" -vf scale=-1:640 -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-minify-480() {
  ffmpeg -i "$1" -vf scale=-1:480 -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-minify-422() {
  ffmpeg -i "$1" -vf scale=-1:422 -vcodec libx264 -crf 28 -preset veryslow "$2"
}

function video-webm() {
  ffmpeg -i "$1" -b:v 0 -crf 30 -pass 1 -f webm -y /dev/null
  ffmpeg -i "$1" -b:v 0 -crf 30 -pass 2 "$2"
}

function video-flip() {
  ffmpeg -i "$1" -vf "hflip,vflip" "$2"
}

function image-minify() {
  mogrify -quality 80% -resize 80% "$1"
}

function find() {
  command find "$@" 2>/dev/null
}

# clear && neofetch
