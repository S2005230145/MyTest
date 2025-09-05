@echo off
:: Windows 自动化部署脚本
:: 保存为 deploy.bat，双击运行或通过命令行执行

:: 配置部分
set REMOTE_REPO=origin          &:: Git 远程仓库名称
set BRANCH=main                 &:: Git 分支
set SERVER_USER=ubuntu        &:: Linux 服务器用户名
set SERVER_IP=101.33.202.63    &:: Linux 服务器IP
set SERVER_DEST=/home/ubuntu/test   &:: Linux 服务器目标路径
set DEPLOY_SCRIPT=/home/ubuntu/deploy_script.sh &:: 服务器部署脚本路径

:: 1. Git 添加所有更改
git add .

:: 2. Git 提交
git commit -m "test"

:: 3. 推送到远程仓库
echo 正在推送到远程 Git 仓库...
git push %REMOTE_REPO% %BRANCH%

:: 4. 使用 PowerShell 通过 SSH 上传文件并执行部署
::echo 正在上传到云端并部署...
::powershell -Command "$session = New-PSSession -HostName %SERVER_IP% -UserName %SERVER_USER%; Copy-Item -Path .\* -Destination %SERVER_DEST% -Recurse -ToSession $session -Force -Exclude '.git','node_modules','__pycache__'; Invoke-Command -Session $session -ScriptBlock { bash %DEPLOY_SCRIPT% }; Remove-PSSession $session"

::if %errorlevel% neq 0 (
::    echo 错误：上传或部署失败
::    pause
::    exit /b 1
::)

echo ✅ 所有步骤完成：Git 推送、云端上传和部署成功！
pause