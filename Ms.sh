#!/bin/bash
#THIS CODE CODE BY BH4V & GEEK MACHINE
# Colors for fancy output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check the success of the last command
check_success() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: $1${NC}"
        exit 1
    fi
}

# Function to display the menu
display_menu() {
    clear
 echo -e "${GREEN}

             █████╗ ██╗   ██╗████████╗ ██████╗       ███╗   ███╗███████╗
            ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗      ████╗ ████║██╔════╝
            ███████║██║   ██║   ██║   ██║   ██║█████╗██╔████╔██║███████╗
            ██╔══██║██║   ██║   ██║   ██║   ██║╚════╝██║╚██╔╝██║╚════██║
            ██║  ██║╚██████╔╝   ██║   ╚██████╔╝      ██║ ╚═╝ ██║███████║
            ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝       ╚═╝     ╚═╝╚══════╝
                                                                  v 1.1${NC}"
echo " "
echo -e "${RED}                                ▶ Coded by${GREEN} BH4V${RED} ◀${NC}"
echo -e "${RED}                                 ⫸ ${YELLOW}GEEK MACHINE$red ⫷${NC}"
echo -e "${RED}                             ⫸${GREEN} github.com/GEEKMACHIN3 ${RED}⫷${NC}"
echo " "
echo " "
echo -e "${RED}                       ----  [ click ENTER to continue ] ---- ${NC}"
read nitrom
echo " "
echo " "
echo -e "${RED}                          [NOTE:- NEED INTERNET CONNECTION]${NC}"

echo " "


    echo -e "${YELLOW}=============================================================================================${NC}"
    echo -e "${RED}

                        ╔╦╗┌─┐┌┬┐┌─┐┌─┐┌─┐┬  ┌─┐┬┌┬┐  ╔╦╗┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐
                        ║║║├┤  │ ├─┤└─┐├─┘│  │ ││ │   ║║║├─┤│││├─┤│ ┬├┤ ├┬┘
                        ╩ ╩└─┘ ┴ ┴ ┴└─┘┴  ┴─┘└─┘┴ ┴   ╩ ╩┴ ┴┘└┘┴ ┴└─┘└─┘┴└─

          ${NC}"
    echo -e "${YELLOW}=============================================================================================${NC}"
    echo " "
    echo -e "                 ${YELLOW}1) Install Metasploit${NC}"
    echo "  "
    echo -e "                 ${YELLOW}2) Uninstall Metasploit${NC}"
    echo " "
    echo -e "                 ${YELLOW}3) Update Metasploit${NC}"
    echo "  "
    echo -e "                 ${YELLOW}4) Run Metasploit (msfconsole)${NC}"
    echo "  "
    echo -e "                 ${YELLOW}5) Exit${NC}"
    echo "  "
    echo -e "${YELLOW}==============================================================================================${NC}"
}

# Function to install Metasploit
install_metasploit() {
    echo -e "${YELLOW}Updating and upgrading Termux packages...${NC}"
    echo -e "${YELLOW}Updating and upgrading Termux packages...${NC}"
    pkg update -y && pkg upgrade -y
    check_success "Failed to update and upgrade Termux packages."

    echo -e "${YELLOW}Installing dependencies...${NC}"
    pkg install -y wget curl git ruby
    check_success "Failed to install dependencies."

    echo -e "${YELLOW}Installing Metasploit...${NC}"
    cd $HOME
    curl -LO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/metasploit.sh
    check_success "Failed to download Metasploit installation script."
    chmod +x metasploit.sh
    ./metasploit.sh
    check_success "Failed to execute Metasploit installation script."

    echo -e "${YELLOW}Cleaning up installation files...${NC}"
    rm metasploit.sh

    echo -e "${YELLOW}Fixing Ruby environment...${NC}"
    gem install bundler
    check_success "Failed to install bundler."
    bundle config set without 'development test'
    check_success "Failed to set bundler configuration."
    bundle install
    check_success "Failed to install bundle."

    echo -e "${YELLOW}Setting up environment variables...${NC}"
    echo "export PATH=$HOME/metasploit-framework:$PATH" >> $HOME/.bashrc
    source $HOME/.bashrc
    check_success "Failed to set environment variables."

    echo -e "${GREEN}======================================${NC}"
    echo -e "${GREEN}  Installation complete!${NC}"
    echo -e "${GREEN}  You can start Metasploit by running 'msfconsole'.${NC}"
    echo -e "${GREEN}======================================${NC}"
}
# Function to uninstall Metasploit
uninstall_metasploit() {
    echo -e "${YELLOW}Uninstalling Metasploit...${NC}"
    rm -rf $HOME/metasploit-framework
    sed -i '/metasploit-framework/d' $HOME/.bashrc
    source $HOME/.bashrc
    echo -e "${GREEN}Metasploit has been uninstalled.${NC}"
}

/# Function to update Metasploit
update_metasploit() {
    echo -e "${YELLOW}Updating Metasploit...${NC}"
    cd $HOME/metasploit-framework
    git pull
    check_success "Failed to update Metasploit."
    bundle install
    check_success "Failed to update bundle."
    echo -e "${GREEN}Metasploit has been updated.${NC}"
}

# Function to run Metasploit (msfconsole)
run_msfconsole() {
    echo -e "${YELLOW}Starting Metasploit (msfconsole)...${NC}"
    msfconsole
    check_success "Failed to start Metasploit (msfconsole)."
}

# Main loop for menu selection
while true; do
    display_menu
    read -p "Enter your choice: " choice

    case $choice in
        1)
        install_metasploit
            ;;
        2)
            uninstall_metasploit
            ;;
        3)
            update_metasploit
            ;;
        4)
            run_msfconsole
            ;;
        5)
            echo -e "${GREEN}Exiting script. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac
done
