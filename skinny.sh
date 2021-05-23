shell=$(basename $(readlink /proc/$$/exe))
skinny_path=${SKINNY_PATH-$HOME/.local/share/skinny}/"$shell"
scripts="$skinny_path"/scripts
repos="$skinny_path"/repos

mkdir -p "$scripts"

script_path=
script_name=

skinny__github() {
  __parse_filename "$1" && \
  __github raw "$1" "$script_path" "$script_name" && \
  echo "skinny: downloaded $script_name"
  . "$script_path"
}

skinny__gist() {
  __parse_filename "$1" && \
  __github gist "$1"/raw "$script_path" "$script_name" && \
  echo "skinny: downloaded $script_name"
  . "$script_path"
}

skinny__remote() {
  __parse_filename "$1" && \
  curl -sf "$1" -o "$script_path" || echo "could not download $2"
  . "$script_path"
}

skinny__git() {
  repo_name=$(basename $1)
  repo_path="$repos"/"$repo_name"
  [ ! -d "$repo_path" ] && \
    git clone $1 "$repo_path"
  cwd="$(pwd)"
  cd "$repo_path" && $2; cd "$cwd"
}

skinny__clean() {
  # TODO: Add option to clean scripts or repositories
  rm "$scripts"/*
}

skinny__cmd() {
  command -v "$1" >/dev/null 2>&1
}

skinny__src() {
  [ -f "$1" ] && . "$1"
}

skinny() {
  local cmdname=$1; shift
  if type "skinny__$cmdname" >/dev/null 2>&1; then
    "skinny__$cmdname" "$@"
  else
    __usage
  fi
}

__github() {
  # TODO: Treat curl download errors
  curl -sf https://"$1".githubusercontent.com/"$2" -o "$3" \
    || echo "skinny: could not download $4"
}

__parse_filename() {
  script_name=$(basename "$1")
  script_path="$scripts"/"$script_name"
  [ ! -f "$script_path" ]
}

__usage() {
  options="github|cmd|remote|src|clean"
  echo "usage: skinny <$options>"
}

