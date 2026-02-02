# basic-tty-ssh-tool
a basic ssh automation tool that made my life a bit easier might help anyone who needs it too.

-----------------------------------------------------------------------------------------------------------------------
WAHT IS THIS TOOL:
-----------------------------------------------------------------------------------------------------------------------

This is a very basic tool i made for myself so to automate the ssh process for myself when i change my distro 
so i have mostly customized it to my own needs u can check it if u think it might be your taste u cna use it too.
i made it for free and i like to see a free world so if u r using it and liked it i would be so happy if u could help 
me make it better and perfect and together we can spread this happiness to the world.

------------------------------------------------------------------------------------------------------------------------
WHAT DO I NEED TO RUN IT : 
------------------------------------------------------------------------------------------------------------------------

I tried to use the least possible dependencies in this project so it would be efficient and usable in all linux devices.
Things u need to run this tool : 
1. linux
2. A Terminal like Konsole (i made it in for konsole), terminal , kitty or any tty that works on linux
3. ssh (which i think is a default tool in all linux distros)
4. if ur terminal supports color and blink effects it can work better if not it still works but u might
   see things like {RESET} {WHITE} {RED} ignore them.
------------------------------------------------------------------------------------------------------------------------
WHAT DOES IT ACTUALLY DO :
------------------------------------------------------------------------------------------------------------------------

The Main thing this tool does is trying to make the ssh command in a more ui based way and then automate it. 
=======================================> ssh -p port -D port username@server ip <========================================

------------------------------------------------------------------------------------------------------------------------
HOW DOES IT WORK :
------------------------------------------------------------------------------------------------------------------------
There are multiple ways u can use this tool:
1.[lets connect] u can use it as a place to connect to ur default saved servers with keys 
(so u wont need password everytime logining in to ur server) or 
2.[connect now] u can use it to connect to a certian with certain ip ,ports,username
3.[Use ssh keys] make new keys manage old keys to login with no password
4.[Save or Change profiles] add or delete ur connection info as profiles and change and set ur default connection info

---------------
LIMITATIONS : |
---------------
/////This tool is made to keep 1 connection at a time if u use the kill it command it kills all running processes with "ssh" 
in their name so dont contain "ssh" in the main bash file name.
////This tool uses a file called savedp.txt to keep ur saved profiles u can change it if u want BUT dont delete the word 
default in it if u wanna use default connection [lets connect].
////Colors and blink effects and emojis might not work well in all terminals specially old versions.

---------------------------------------
the savedp.txt file works like this : |
---------------------------------------

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
                
-----------------------------------------------------------------------------------------------------------------------
Im not a professional programer so i would be happy to know if let me know if u found problems in this project in a 
friendly and cooperative method. thanks for ur attention.
Be Happy and Free.

This project is licensed under the GNU General Public License v3.0

