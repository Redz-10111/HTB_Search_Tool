#!/bin/bash

# HTB_Search_Tool
# Author: Manuel Domingo Acedo Vélez (Redz-10111)
# Year: 2025
# License: MIT
# Personal implementation based on a practice created by S4vitar

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c() {
  echo -e "\n\n${redColour}[!] Exiting...${endColour}\n"
  tput cnorm && exit 1
}

# Ctrl+C
  trap ctrl_c INT

# Variables globales
  main_url="https://htbmachines.github.io/bundle.js"

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Usage:${endColour}"
  echo -e "\t${purpleColour}u)${endColour}${grayColour} Download or update required files${endColour}"
  echo -e "\t${purpleColour}m)${endColour}${grayColour} Search by a machine name${endColour}"
  echo -e "\t${purpleColour}i)${endColour}${grayColour} Search by IP address${endColour}"
  echo -e "\t${purpleColour}d)${endColour}${grayColour} Search by a machine’s difficulty${endColour}"
  echo -e "\t${purpleColour}o)${endColour}${grayColour} Search by operating system${endColour}"
  echo -e "\t${purpleColour}s)${endColour}${grayColour} Search by skills${endColour}"
  echo -e "\t${purpleColour}y)${endColour}${grayColour} Get the link to the machine’s walkthrough on YouTube${endColour}"
  echo -e "\t${purpleColour}h)${endColour}${grayColour} Show this help panel${endColour}"
}

function updateFiles(){

    if [ ! -f bundle.js ]; then
      tput civis
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Downloading required files...${endColour}"
      curl -s $main_url > bundle.js
      js-beautify bundle.js | sponge bundle.js
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} All files have been downloaded${endColour}"
      tput cnorm
    else
      tput civis
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Checking for pending updates...${endColour}"
      curl -s $main_url > bundle_temp.js
      js-beautify bundle_temp.js | sponge bundle_temp.js
      md5_temp_value=$(md5sum bundle_temp.js | awk '{print $1}')
      md5_original_value=$(md5sum bundle.js | awk '{print $1}')

      if [ "$md5_temp_value" == "$md5_original_value" ]; then
        echo -e "\n${yellowColour}[+]${endColour}${grayColour} No updates detected, everything is up to date${endColour}"
        rm bundle_temp.js
      else
        echo -e "\n${yellowColour}[+]${endColour}${grayColour} Updates have been found${endColour}"
        sleep 1

        rm bundle.js && mv bundle_temp.js bundle.js

        echo -e "\n${yellowColour}[+]${endColour}${grayColour} The files have been updated${endColour}"
      fi
      tput cnorm
    fi
}

function searchMachine(){
  machineName="$1"
 
  machineName_checker="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//')"

    if [ "$machineName_checker" ]; then

      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Listing the machine’s properties${endColour}${greenColour} $machineName${endColour}${grayColour}:${endColour}\n"
      
        cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//' \
        | while IFS= read -r line; do

        # 1) saltar líneas vacías o sin dos puntos
        [[ -z "$line" || "$line" != *:* ]] && continue

        # 2) separar clave y valor
          key="${line%%:*}"
          value="${line#*: }"

          # 3) decidir colores por campo
          case "$key" in
            name)
              echo -e "${redColour}${key}:${endColour} ${greenColour}${value}${endColour}" ;;
            ip)
              echo -e "${redColour}${key}:${endColour} ${blueColour}${value}${endColour}" ;;
            so)
              echo -e "${redColour}${key}:${endColour} ${yellowColour}${value}${endColour}" ;;
            dificultad)
              echo -e "${redColour}${key}:${endColour} ${yellowColour}${value}${endColour}" ;;
            skills)
              echo -e "${redColour}${key}:${endColour} ${grayColour}${value}${endColour}" ;;
            like)
              echo -e "${redColour}${key}:${endColour} ${yellowColour}${value}${endColour}" ;;
            youtube)
              echo -e "${redColour}${key}:${endColour} ${blueColour}${value}${endColour}" ;;
            activeDirectory)
              echo -e "${redColour}${key}:${endColour} ${grayColour}${value}${endColour}" ;;
            *)
              echo -e "${redColour}${key}:${endColour} ${grayColour}${value}${endColour}" ;;
          esac
          done
    else
      echo -e "\n${redColour}[!] The provided machine does not exist${endColour}\n"
    fi
}

function searchIP(){
  ipAdrress="$1"

  machineName="$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name:" | awk 'NF{print $NF}' | tr -d '"' | tr -d ',')"

    if [ "$machineName" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} The corresponding machine for the IP${endColour}${blueColour} $ipAdrress${endColour}${grayColour} es${endColour}${greenColour} $machineName${endColour}"
    else
      echo -e "\n${redColour}[!] The provided IP address does not exist${endColour}\n"
    fi
}

function getYoutubeLink(){

  machineName="$1"

  youtubeLink="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//' | grep youtube | awk 'NF{print $NF}')"

    if [ "$youtubeLink" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} The tutorial for the following machine is at the link below:${endColour}${blueColour} $youtubeLink${endColour}\n"
    else
      echo -e "\n${redColour}[!] The provided machine does not exist${endColour}\n"
    fi
}

function getMachinesDifficulty(){

  difficulty="$1"

  results_check="$(cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 | grep "name:" | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"

    if [ "$results_check" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Displaying the machines that have a difficulty level ${endColour}${greenColour} $difficulty${endColour}${grayColour}:${endColour}\n"
      cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 | grep name | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column
    else
      echo -e "\n${redColour}[!] The specified difficulty does not exist${endColour}\n"
    fi
}

function getOSMachines(){
  os="$1"

  os_results="$(cat bundle.js | grep "so: \"$os\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"

    if [ "$os_results" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Showing the machines whose operating system is ${endColour}${greenColour}$os${endColour}${grayColour}:${endColour}\n"
      cat bundle.js | grep "so: \"$os\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column
    else
      echo -e "\n${redColour}[!] The specified operating system does not exist${endColour}\n"
    fi
}

function getOSDifficultyMachines(){

    difficulty="$1"
    os="$2"

    check_results="$(cat bundle.js | grep "so: \"$os\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"

    if [ "$check_results" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Listing machines of difficulty${endColour}${greenColour} $difficulty${endColour}${grayColour} que tengan sistema operativo${endColour}${greenColour} $os${endColour}${yellowColour}:${endColour}\n"
      cat bundle.js | grep "so: \"$os\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column
    else
      echo -e "\n${redColour}[!] An incorrect difficulty or operating system has been specified${endColour}\n"
    fi
}

function getSkill(){

    skill="$1"

    check_skill="$(cat bundle.js | grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"

    if [ "$check_skill" ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Below are the machines that cover the skill${endColour}${blueColour}$skill${endColour}${yellowColour}:${endColour}\n"
      cat bundle.js | grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column
    else
      echo -e "\n${redColour}[!] No machine was found with the specified skill${endColour}\n"
    fi 
}

# Indicadores
    declare -i parameter_counter=0

# Chivatos
    declare -i chivato_difficulty=0
    declare -i chivato_os=0

while getopts "m:ui:y:d:o:s:h" arg; do
  case $arg in
    m) machineName="$OPTARG"; let parameter_counter+=1;;
    u) let parameter_counter+=2;;
    i) ipAddress="$OPTARG"; let parameter_counter+=3;;
    y) machineName="$OPTARG"; let parameter_counter+=4;;
    d) difficulty="$OPTARG"; chivato_difficulty=1; let parameter_counter+=5;;
    o) os="$OPTARG"; chivato_os=1; let parameter_counter+=6;;
    s) skill="$OPTARG"; let parameter_counter+=7;;
    h) ;;
  esac
done

  if [ $parameter_counter -eq 1 ]; then
    searchMachine $machineName
  elif [ $parameter_counter -eq 2 ]; then
    updateFiles
  elif [ $parameter_counter -eq 3 ]; then
    searchIP $ipAddress
  elif [ $parameter_counter -eq 4 ]; then
    getYoutubeLink $machineName
  elif [ $parameter_counter -eq 5 ]; then
    getMachinesDifficulty $difficulty
  elif [ $parameter_counter -eq 6 ]; then
    getOSMachines $os
  elif [ $parameter_counter -eq 7 ]; then
    getSkill "$skill"
  elif [ $chivato_difficulty -eq 1 ] && [ $chivato_os -eq 1 ]; then
    getOSDifficultyMachines $difficulty $os
  else
    helpPanel
  fi
