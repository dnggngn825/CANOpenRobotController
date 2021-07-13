#!/bin/bash

#Upload app and init scripts to BB target 
#using default IP / users parameters

SSH_USER="debian"
BUILD_FOLDER="build/"
INIT_SCRIPTS="*.sh"
SCRIPT_FOLDER="script/"
PASSWORD="temppwd"
SSH_IP_ADDR="192.168.7.2"

#use default BB address (dependent on OS used)
# Danny commented out this part

# if [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then 
#   #Any flavour of Windows (Cygwin, Mingw...)
#   SSH_IP_ADDR="192.168.7.2"
# else
#   #Any other case (Linux, Unix, OSX...)
#   SSH_IP_ADDR="192.168.6.2"
# fi


#set in root folder
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"/..


echo "---------------------------------------------------"
echo "Create remote folders (~/CANOpenRobotController/)"
echo "---------------------------------------------------"
sshpass -p $PASSWORD ssh -q $SSH_USER@$SSH_IP_ADDR "mkdir -p ~/CANOpenRobotController/"
sshpass -p $PASSWORD ssh -q $SSH_USER@$SSH_IP_ADDR "mkdir -p ~/CANOpenRobotController/$SCRIPT_FOLDER"
sshpass -p $PASSWORD ssh -q $SSH_USER@$SSH_IP_ADDR "mkdir -p ~/CANOpenRobotController/$BUILD_FOLDER"
echo "done."

echo ""
echo "---------------------------------------------------"
echo "Copy scripts"
echo "---------------------------------------------------"
for SCRIPT in "$SCRIPT_FOLDER"*.sh
do
  echo ${SCRIPT}
  sshpass -p $PASSWORD scp ${SCRIPT} $SSH_USER@$SSH_IP_ADDR:~/CANOpenRobotController/${SCRIPT}
done
echo "done."

echo ""
echo "---------------------------------------------------"
echo "Copy APP(s):"
echo "---------------------------------------------------"
for APP in "$BUILD_FOLDER"*APP
do
  echo ${APP}
  sshpass -p $PASSWORD scp ${APP} $SSH_USER@$SSH_IP_ADDR:~/CANOpenRobotController/${APP}
done
for APP in "$BUILD_FOLDER"*APP_NOROBOT
do
  echo ${APP}
  sshpass -p $PASSWORD scp ${APP} $SSH_USER@$SSH_IP_ADDR:~/CANOpenRobotController/${APP}
done
echo "done."