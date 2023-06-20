#!/bin/bash

INDEX_PATH="$1"
BACKUP_PATH="$INDEX_PATH.bak"
TMP_PATH="$INDEX_PATH.tmp"
SCRIPT_NAME=`basename "$0"`

LOG_TAG="$SCRIPT_NAME"

CSS=$(cat <<-EOF | tr -d '\n '
@media (pointer: coarse), (hover: none) {
  [title] {
    position: relative;
    display: inline-flex;
    justify-content: center;
  }
  [title]:hover::after {
    white-space: pre;
    font-size: small;
    line-height: 1;
    content: attr(title);
    position: absolute;
    top: 90%;
    width: fit-content;
    padding: 3px;
    z-index: 999;
    border-radius: 0.25rem;
    /* from Tailwind */
    color: #fff;
    background-color: rgb(153, 27, 27);
  }
}
EOF
)

STYLE_LINE_TAG="/*$SCRIPT_NAME*/";
STYLE_LINE="<style>$STYLE_LINE_TAG$CSS</style>";

if [ ! -f "$BACKUP_PATH" ]
then
	cp "$INDEX_PATH" "$BACKUP_PATH"
	echo "$LOG_TAG: Backup created"
fi

GREPED=$(grep -F "$STYLE_LINE_TAG" "$INDEX_PATH")
if [[ "$GREPED" != "$STYLE_LINE" ]]; then
	echo "$LOG_TAG: Patching"
	if [[ -n "$GREPED" ]]; then # cleanup
		grep -vF "$STYLE_LINE_TAG" "$INDEX_PATH" > "$TMP_PATH"
	else
		cp "$INDEX_PATH" "$TMP_PATH"
	fi
	sed -i "\|<head>|a $STYLE_LINE" "$TMP_PATH"
	mv "$TMP_PATH" "$INDEX_PATH"
fi
