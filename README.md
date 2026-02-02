# basic-ttyl-ssh-tool
a basic ssh automation tool that made my life a bit easier might help anyone who needs it too.

Quick guide : this file contains all ur servers info in a line format 
                so each line looks like this 
                📇 profilename | 🖧 server ip address | 🛜 server port | 🔑 server username | 🏠 internal port (client)
                example looks like this :
                profilename | server ip address| server port |server username | internal port (client)
                My server | 1.0.0.1| 22 | root | 8080
                 inside the file looks like this :
                 My server 1.0.0.1 22 root 8080
                so if u wanna change the file manually u can add ur info in that order no need to use any
                characters words will be seperated by spacebar dont use any extra characters might not be
                readable for the script 
                ===Notice: Dont DELETE Default server info thats where the script 
                reads at start and works with in total. ALSO dont put this script in path containing ssh in its 
                name or rename the file into something containing ssh the killing process kills processes containing
                ssh in it !
                Enjoy and Thanks ! ☕ 😎

This project is licensed under the GNU General Public License v3.0

