#!/bin/bash
# === Colors ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
RESET="\033[0m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
BG_BLUE="\e[44m"
BG_YELLOW="\e[43m"
BG_WHITE="\e[47m"
BOLD="\e[1m"
BLINK="\e[5m"
INVERT="\e[7m"
STRIKE="\e[9m"
RESET="\e[0m"
while true; do
    clear
    savedp="savedp.txt"
     read profilename defaultip defaultport defaultusr defaultinternalport <<< $(grep "default" $savedp)
    echo -e "${BG_BLUE}${WHITE}${BOLD}HOME${RESET}"
    echo -e "${BG_BLUE}${WHITE}${BLINK}${BOLD}===🚀SSH CONNECTION CONTROLS🚀 ===${RESET}"
    echo -e "${BG_BLUE}${WHITE} ${BOLD}===🚀YOU ARE CHECKING STATUS FOR 🖧 $defaultip 🖧 via $defaultport🛜 🚀 ===${RESET}"
    echo -e "${YELLOW}1️⃣ ${BOLD} 🛜 status ${RESET} ${RESET}"
    echo -e "${CYAN} F ${BOLD}time based connection wifi or phone ${RESET}"
    echo -e "${GREEN}2️⃣${BOLD}  🫱 Lets connect ${RESET} ${RESET}"
    echo -e "${GREEN} Q ${BOLD}  🫱 Quick connection reset ${RESET} ${RESET}"
    echo -e "${RED}3️⃣${BOLD}  🔪 Kill it ${RESET} ${RESET}"
    echo -e "${BLUE}4️⃣${BOLD}  🏠 Exit ${RESET} ${RESET}"
    echo -e "${GREEN}5️⃣${BOLD}  💥 Connect Now ${RESET} ${RESET}"
    echo -e "${YELLOW}6️⃣${BOLD}  🔐 Use ssh keys (fast no pass connections)${RESET} ${RESET}"
    echo -e "${MAGENTA}7️⃣ ${BOLD} 📝 Save or Change profiles${RESET}"
    read -p  "Choose an option (1-7): " -n 1 -s  choice
    case "$choice" in
        1)
            echo -e "${YELLOW} status: ${RESET}"
            PHONE="enp0s20f0u3"
            WIFI="enp4s0"
            nmcli="/usr/bin/nmcli"
            active=$($nmcli -t -f DEVICE,STATE device | grep -E "$WIFI|$PHONE" | grep ":connected" | cut -d: -f1)
            pids=$(pgrep -f ssh)
            count=$(echo "$pids" | wc -w)
            if [ "$count" -gt 1 ]; then
             echo -e "${GREEN}🟢🟢🟢🟢CONNECTED🟢🟢🟢🟢${RESET}"
             echo -e "${CYAN} Through $active ${RESET}"
            # Do something if multiple PIDs
            else
            echo -e "${RED}🔴🔴🔴🔴OFFLINE🔴🔴🔴🔴${RESET}"
              # Do something if single or none
            fi
            status=$(ps aux | grep ssh)
            echo -e "${YELLOW} $status ${RESET}"
            sleep 3s 
            ;;
        2)
            echo -e "${GREEN}${BLINK}we are connecting: 🫱 ${RESET}"
            ssh -p $defaultport  -f -N -D $defaultinternalport -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -q $defaultusr@$defaultip
            sleep 1s
            ;;
          f)
          time=$(date +"%H")
         if [[ $time -ge 1 && $time -le 11 && "$active" != "$PHONE" ]]; then
        [[ -n "$active" ]] && $nmcli device disconnect "$active"
        $nmcli device connect "$PHONE"
         elif [[ ( $time -lt 1 || $time -gt 11 ) && "$active" != "$WIFI" ]]; then
         [[ -n "$active" ]] && $nmcli device disconnect "$active"
         $nmcli device connect "$WIFI"
         fi
         echo "DONE!"
         sleep 1s
         ;;
        q)
        pids=$(pgrep -f ssh)
        for pid in $pids; do
            kill "$pid"
           done
          ssh -p $defaultport  -f -N -D $defaultinternalport -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -q $defaultusr@$defaultip
        echo "RESET"
        sleep 1s
        ;;
        3)
        clear
        echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} KILL PROCESS ${RESET}"
            pids=$(pgrep -f ssh)
        echo "Found PIDs: $pids"
        echo  -e "${RED} ${BOLD} kill ${RESET} ${RED}em ?! 🗡" "press ${BOLD} 1 ${RESET} ${RED} to ${BOLD} kill ${RED} or enter to abort${RESET}"
        read -n 1 -s answer
        if [[ "$answer" == "1" ]]; then
           for pid in $pids; do
            echo -e "${RED}${BLINK}Killing process 🩸 $pid...${RESET}"
            kill "$pid"
           done
              echo -e "${RED}${BLINK} killed $pids 𐇐 ${RESET}"
              echo -e "${RED} You are safe no ssh left 🏠 ${RESET}"
        else
           echo -e "${GREEN}ssh is safe for now ☕${RESET}"
        fi  
            read -p "Press Enter to continue..."
            ;;
        4)  
            clear
            echo -e "${BLUE}👋 ${BOLD} Goodbye! ${RESET} 👋${RESET}"
            sleep 1s
            exit 0
            ;;
        5)
            clear
            echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} CONNECT NOW ${RESET}"
            echo -e "${WHITE}${BOLD}${BLINK}${BG_BLUE}💥 welcome to Connect now 💥${RESET}"
            echo -e "${BOLD}lets connect to server right now !${RESET}"
            echo -e "${YELLOW} please enter the${BOLD}🖥 server ip address ${RESET}${YELLOW}u wanna connect to : ${RESET}"
            read targetip
            echo -e "${BLUE} please enter the ${BOLD}🛜 server port ${RESET}${BLUE}u wanna connect through : ${RESET}"
            read targetport
            echo -e "${YELLOW} please enter the ${BOLD}😎 user name ${RESET}${YELLOW}on ur server : ${RESET}"
            read targetusr
            echo -e "${BLUE} please enter the ${BOLD} internal (client) port ${RESET} ${BLUE}for ur device :(can be anything) ${RESET}"
            read clientport
            echo -e "${GREEN} Ready to 🟢 Connect now ? press ${BOLD} 1 ${RESET} ${GREEN} to connect ${RESET}"
            read -n 1 -s connectionanswer
            if [[ "$connectionanswer" == "1" ]]; then  
            echo "Attempting to connect to $targetip through $clientport ==> $targetport"
            ssh -p $targetport -f -N -D $clientport -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -q $targetusr@$targetip
              echo -e "${GREEN} seems like we are connected to $targetip mr 😎 $targetusr ${RESET}"
               read -p "Press Enter to check"
               echo -e "${YELLOW} status: ${RESET}"
            pids=$(pgrep -f ssh)
            count=$(echo "$pids" | wc -w)
            if [ "$count" -gt 1 ]; then
             echo -e "${GREEN}🟢🟢🟢🟢CONNECTED🟢🟢🟢🟢${RESET}"
            # Do something if multiple PIDs
            else
             echo -e "${RED}🔴🔴🔴🔴OFFLINE🔴🔴🔴🔴${RESET}"
              # Do something if single or none
            fi
                status=$(ps aux | grep ssh)
            echo -e "${YELLOW} $status ${RESET}"
            sleep 2s
               
        else
           echo -e "${YELLOW} ${BOLD} No connection ${RESET}${YELLOW} happened Chill ☕${RESET}"
            read -p "Press  Enter  to get back home 🏠"
        fi        
            ;;
            
            6)
            while true; do
            clear
            echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} SEND KEY ${RESET}"
            echo -e "${CYAN}===== 🔐 Welcome to fast no password needed ssh connection mode======${RESET}"
            echo -e "${WHITE}${BG_BLUE}${BLINK}choose to continue${RESET}"
            echo -e "${YELLOW}1 . Create key (press 1)🔑 ${RESET}"
            echo -e "${YELLOW}2 . Send the created key to ur server 📲 (press 2)${RESET}"
            echo -e "${CYAN} 🏠 Go back Home (press 3) ${RESET}"
            read -n 1 -s keyanswer
            case "$keyanswer" in
            1) 
              echo -e "${WHITE}${BG_BLUE}${BLINK}Creating key 🔑${RESET}"
              sleep 2s
              ssh-keygen -t ed25519 -C ""
              clear
            ;;
            2)
               echo -e "${WHITE}${BG_BLUE}${BLINK}🔐Sending key to default server (default ips,ports)${RESET}"
               echo "🔐📲"
               ssh-copy-id -p $defaultport $defaultusr@$defaultip
               sleep 3s
            ;;
            3) break
            ;;
            *)
            echo -e "${RED}${BOLD}Invalid choice! ${BOLD} ⛔ 🤌 ${RESET}"
            sleep 1
            ;;
           esac  
         done 
        ;;
        7)
        while true; do
            clear
            echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} PROFILES ${RESET}"
            echo -e "${MAGENTA}${BG_YELLOW} 💾 Lets SAVE Some Time ${RESET} "
            echo -e "${YELLOW} Choose What u wanna do : ${RESET}"
            echo -e "${YELLOW} 1 . 📥 Creat a new connection ${RESET}"
            echo -e "${YELLOW} 2 . 🗄️  Choose old servers ${RESET}"
            echo -e "${YELLOW} 3 . ❌ Delete a connection ${RESET}"
            echo -e "${YELLOW} 4 . 🗃️  Saved file name ${RESET}"
            echo -e "${CYAN} 5 . 🏠 Go back Home (press 5) ${RESET}"
            read -n 1 -s profileanswer
            case "$profileanswer" in
            1) 
              clear 
              echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} NEW CONNECTION ${RESET}"
              echo -e "${WHITE}${BG_BLUE}${BLINK} 📲 Creating new connection ${RESET}"
              echo -e "${CYAN}Enter profile name"
              read newprof
              echo -e "Enter server ip"
              read newip
              echo -e "Enter server port"
              read newport
              echo -e "Enter username on server"
              read newusr
              echo -e "Enter internal port"
              read newinternal
              echo -e "SAVE IT ?! press enter${RESET}"
              read 
              echo "$newprof $newip $newport $newusr $newinternal" >> $savedp
              echo "ADDED 📥 !"
              sleep 2s
              clear
            ;;
            2)
               clear 
               echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} ACTIVE CONNECTION ${RESET}"
               echo -e "${WHITE}${BG_BLUE}${BLINK} ☕ Choose your server :${RESET}"
               cat $savedp
               echo -e "${GREEN}write the exact profile name please"
               read profilechoice
               read profilename defaultip defaultport defaultusr defaultinternalport <<< $(grep "$profilechoice" $savedp)
               echo -e "u chose these info : 
               ${GREEN}profile name : 📇 $profilename
               ip : 🖧 $defaultip
               port : 🛜 $defaultport
               username on server : 🔑 $defaultusr
               internal (client) device port : 🏠 $defaultinternalport
               ${BOLD}wanna set this to Active connection ?${RESET}"
               read
               sed -i "/^default/c\\default $defaultip $defaultport $defaultusr $defaultinternalport" $savedp
               echo "Done!"
               sleep 2s
            ;;
            3) 
            clear
            echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} DELETE PROFILE ${RESET}"
            echo -e "${RED}${BG_WHITE}Choose profile to delete! 🗡${RESET}"
            cat $savedp
            echo -e "${RED}${BG_WHITE}${INVERT}Enter profiles name :${RESET}"
            read profiletodelete
            echo -e "${RED}${BG_WHITE}${INVERT}${BLINK}❌ You are about to delete $profiletodelete u sure?${RESET}"
            read
            sed -i "/$profiletodelete/d" $savedp
            echo -e "💥 $profiletodelete is deleted successully!"
            echo "Press Enter to go back"
            read
            ;;
             4) clear
                echo -e "${BG_BLUE}${WHITE}${BOLD} 🏠 ${INVERT} INFO ${RESET}"
                echo -e "${BOLD}Your saved file name is : $savedp${RESET}"
                echo -e "${CYAN}Quick guide : this file contains all ur servers info in a line format 
                so each line looks like this 
                📇 profilename | 🖧 server ip address | 🛜 server port | 🔑 server username | 🏠 internal port (client)${RESET}
                ${CYAN}example looks like this : ${RESET}
                profilename | ${GREEN}server ip address ${RESET}| server port | ${GREEN}server username${RESET} | internal port (client)
                My server | ${GREEN}1.0.0.1 ${RESET}| 22 | ${GREEN}root ${RESET}| 8080
                ${CYAN} inside the file looks like this :${RESET}
                 My server 1.0.0.1 22 root 8080
                ${CYAN} so if u wanna change the file manually u can add ur info in that order no need to use any
                characters words will be seperated by spacebar dont use any extra characters might not be
                readable for the script 
                ${YELLOW}===Notice: Dont DELETE Default server info thats where the script 
                reads at start and works with in total. ALSO dont put this script in path containing ssh in its 
                name or rename the file into something containing ssh the killing process kills processes containing
                ssh in it !
                Enjoy and Thanks ! ☕ 😎${RESET}"
                read 
                ;;
            5) break
            ;;
            *)
            echo -e "${RED}${BOLD}Invalid choice! ${BOLD} ⛔ 🤌 ${RESET}"
            sleep 1
            ;;
           esac  
         done 
        ;;
        *)
            echo -e "${RED}Invalid choice! ${BOLD}⛔ 🤌 ${RESET}"
            sleep 1
            ;;
    esac
done
