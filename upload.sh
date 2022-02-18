#!/bin/bash
rm -rf public
hugo -D
git add .
git commit -m "none"
git push
clear
echo "部落格上傳完成"
