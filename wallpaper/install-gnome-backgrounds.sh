#!/bin/bash

readonly ROOT_UID=0

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$UID" -eq "$ROOT_UID" ]]; then
  BACKGROUND_DIR="/usr/share/backgrounds"
  PROPERTIES_DIR="/usr/share/gnome-background-properties"
else
  BACKGROUND_DIR="$HOME/.local/share/backgrounds"
  PROPERTIES_DIR="$HOME/.local/share/gnome-background-properties"
fi

THEME_NAME='MacTahoe'

#COLORS
CDEF=" \033[0m"                               # default color
CCIN=" \033[0;36m"                            # info color
CGSC=" \033[0;32m"                            # success color
CRER=" \033[0;31m"                            # error color
CWAR=" \033[0;33m"                            # waring color
b_CDEF=" \033[1;37m"                          # bold default color
b_CCIN=" \033[1;36m"                          # bold info color
b_CGSC=" \033[1;32m"                          # bold success color
b_CRER=" \033[1;31m"                          # bold error color
b_CWAR=" \033[1;33m"                          # bold warning color

# echo like ...  with  flag type  and display message  colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;    # print success message
    "-e"|"--error")
      echo -e "${b_CRER}${@/-e/}${CDEF}";;    # print error message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;    # print warning message
    "-i"|"--info")
      echo -e "${b_CCIN}${@/-i/}${CDEF}";;    # print info message
    *)
    echo -e "$@"
    ;;
  esac
}

install() {
  prompt -i "\n  Install ${THEME_NAME} wallpaper in ${BACKGROUND_DIR}... \n"

  [[ -d ${BACKGROUND_DIR}/${THEME_NAME} ]] && rm -rf ${BACKGROUND_DIR}/${THEME_NAME}
  [[ -f ${PROPERTIES_DIR}/${THEME_NAME}.xml ]] && rm -rf ${PROPERTIES_DIR}/${THEME_NAME}.xml

  mkdir -p ${BACKGROUND_DIR}/${THEME_NAME}

  cp -a --no-preserve=ownership ${REPO_DIR}/*.jpeg ${BACKGROUND_DIR}/${THEME_NAME}
  cp -a --no-preserve=ownership ${REPO_DIR}/${THEME_NAME}.xml ${PROPERTIES_DIR}

  sed -i "s/@BACKGROUNDDIR@/$(printf '%s\n' "${BACKGROUND_DIR}" | sed 's/[\/&]/\\&/g')/g" "${PROPERTIES_DIR}/${THEME_NAME}.xml"
}

install && prompt -s "Finished! \n"
