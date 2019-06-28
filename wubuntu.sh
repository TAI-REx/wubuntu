#!/bin/bash
####
#### Author: wuseman
#### Created: 20181218
#### Desc: Script for fix mostly things on a new Ubuntu Server
####       to fix the boring stuff for
####

#set -e

banner() {
cat << "EOF"
                _                 _         
               | |               | |        
__      ___   _| |__  _   _ _ __ | |_ _   _ 
\ \ /\ / / | | | '_ \| | | | '_ \| __| | | |  Author:  wuseman
 \ V  V /| |_| | |_) | |_| | | | | |_| |_| |  Contact: wuseman@nr1.nu
  \_/\_/  \__,_|_.__/ \__,_|_| |_|\__|\__,_|
============================================
EOF
}

help() {
banner
echo ""
echo "Usage for wubuntu.sh: ./wubuntu.sh -[option]"
echo ""
echo "  where:"
echo "        -b BITLBEE       - Install Bitlbee"
echo "        -g GLFTP         - Install gLFTPd"
echo "        -l LAMP          - Install mysql-server, apache2 and php"
echo "        -e EGGDROP       - Install Eggdrop bot"
echo "        -e EMAGNET       - Install Emagnet"
echo "        -m MOTD          - Install an awesome message of the day welcome page for SSH, TCL script"
echo "        -r RAR2FS        - Install Rar2FS"
echo "        -p PLEX          - Install and setup plex-media-server"
echo "        -w WUSEMAN       - Install most used apps by wuseman (use this after a fresh re-install)"
echo "        -i INITRAMFS     - Install initramfs-tools, busybox and dropbear for unlock a crypted root partition at boot" 
echo "        -u UPDATE        - Install latest upgrades and autoremove useless packages and then we cleaning up"
echo "        -c CERBOT        - Install letsencrypt with certbot plugin for apache2 and get a ssl certificat for free"
echo "        -o OPENVPN       - Install and setup OpenVPN Server"
echo "        -O OWNCLOUD      - Install and setup Owncloud for apache2 (all php modules is included, also mysql commands to get started)"
echo "        -W WORDPRESS     - Install and setup wordpress"
echo "        -M MOPIDY        - Install and setup mopidy server"
echo "        -Z ZNC           - Install and setup znc"
echo ""
}

if [[ -z $1 ]]; then
help
fi

usualpackages() {
cat << "EOF"
 __      ___   _ ___  ___ _ __ ___   __ _ _ __  
 \ \ /\ / / | | / __|/ _ \ '_ ` _ \ / _` | '_ \  Author:  wuseman
  \ V  V /| |_| \__ \  __/ | | | | | (_| | | | | Contact: wuseman@nr1.nu
   \_/\_/  \__,_|___/\___|_| |_| |_|\__,_|_| |_|
================================================
EOF
echo -e "\nPlease wait, installing wuseman's 'must have' packages."
<<<<<<< HEAD
apt-get install -qq samba cifs-utils aptitude libgcrypt-* adb fastboot htop elinks links lynx ca-certificates gnutls-dev libglib2.0-dev git cmake automake pkg-config build-essential lm-sensors hddtemp smartmontools hddtemp nload unzip zip unrar rar p7zip atool screen weechat tcl8.6 libtcl8.6 zlib1g screenfetch inxi pciutils vim rtorrent iptables sed net-tools  libjson-c-dev json-glib-tools libjs-json tclcurl mcrypt mutt ssmtp syslog-ng tcllib tclcurl tcllib tcl-tls tcl-xmlrpc libtcl8.6 tcl-dev tcl8.6-dev tcl-xmlrpc figlet sshfs xmlrpc-api-utils lynx links elinks software-properties-common python3-software-properties netcat nmap pytho*-cryptog* npm subversion lftp curl openssh-server ca-certificates libbz2-dev libsqlite3-dev libncurses5-dev libncursesw5-dev libglib2.0-dev libgnutls-dev zlib1g-dev -y &> /dev/null
=======
apt-get install -qq samba cifs-utils aptitude libgcrypt-* adb fastboot libjson-glib-dev htop elinks links lynx ca-certificates gnutls-dev libglib2.0-dev git cmake automake pkg-config build-essential lm-sensors hddtemp smartmontools hddtemp nload unzip zip unrar rar p7zip atool screen weechat tcl8.6 libtcl8.6 zlib1g screenfetch inxi pciutils vim rtorrent iptables sed net-tools  libjson-c-dev json-glib-tools libjs-json tclcurl mcrypt mutt ssmtp syslog-ng tcllib tclcurl tcllib tcl-tls tcl-xmlrpc libtcl8.6 tcl-dev tcl8.6-dev tcl-xmlrpc figlet sshfs xmlrpc-api-utils lynx links elinks software-properties-common python3-software-properties netcat nmap pytho*-cryptog* npm subversion lftp curl openssh-server ca-certificates -y &> /dev/null
>>>>>>> d7ed1ddbea3b194c54456256419a98bf8eb2a32d
apt-get -qq update &> /dev/null
apt-get -qq upgrade -y &> /dev/null
apt-get -qq autoremove -y &> /dev/null
apt-get -qq autoclean -y &> /dev/null
echo -e "..All packages has successfully been installed..\n"
}


update() {
banner
echo -e "\nPlease wait, syncing repositories.."
  apt-get update -qq &> /dev/null;
echo "...Done"
echo -e "\nSearching for packages to auto upgrade, \nif there is any new upgrades we gonna upgrade them."
 apt-get upgrade -qq -y &> /dev/null;
echo "...Done"
echo -e "\nRemoving useless packages and cleaning up.."
apt-get -qq autoremove -y &> /dev/null; 
apt-get -qq autoclean -y &> /dev/null
echo "...Done"
echo -e "\nYour packages are now up2date and upgraded..\n"
}

rar2fs() {
cat << "EOF"
               ____   __     
 _ __ __ _ _ _|___ \ / _|___ 
| '__/ _` | '__|__) | |_/ __| Author:  wuseman
| | | (_| | |  / __/|  _\__ \ Contact: wuseman@nr1.nu
|_|  \__,_|_| |_____|_| |___/
=============================
EOF
echo -e "\nPlease wait, installing required packages.."
apt-get install git automake make build-essential cmake autoconf fuse sshfs libfuse-dev autoconf -qq -y &> /dev/null
echo -e "...Done"
echo -e "\nPlease wait, cloning rar2fs from git.."
git clone https://github.com/hasse69/rar2fs.git &> /dev/null
cd rar2fs
echo -e "...Done"
echo -e "\nDownloading unrar from rarlab.."
wget -q http://www.rarlab.com/rar/unrarsrc-5.4.5.tar.gz
echo -e "...Done"
echo -e "\nExtracting 'unrar' archive.."
tar -zxf unrarsrc-5.4.5.tar.gz
cd unrar
echo -e "...Done"
echo -e "\nCompiling and installing rar2fs for you (this will take a while)"
make lib &> /dev/null
make install-lib &> /dev/null
cd ..
autoreconf -f -i &> /dev/null
./configure --with-unrar=./unrar &> /dev/null 
make &> /dev/null
make install &> /dev/null
echo -e "...Done"
echo -e "\nrar2fs has been installed, try to execute rar2fs :)\n"
rm -rf rar2fs
}


plex() {
cat << "EOF"
       _
 _ __ | | _____  __ 
| '_ \| |/ _ \ \/ / Author:  wuseman
| |_) | |  __/>  <  Contact: wuseman@nr1.nu
| .__/|_|\___/_/\_\   
|_|
====================
EOF
echo -e "\nPlease wait, downloading plex from plex,tv.."
wget -q https://downloads.plex.tv/plex-media-server/1.5.5.3634-995f1dead/plexmediaserver_1.5.5.3634-995f1dead_amd64.deb
echo -e "...Done"
echo -e "\nInstalling plex-media-server.."
dpkg -i plexmediaserver*.deb &> /dev/null
echo -e "...Done"
echo -e "\nStarting plex for the first time and adding plex to run at boot "
systemctl enable plexmediaserver.service
systemctl start plexmediaserver.service
echo -e "...Done"
echo -e "\nplex-media-server has been installed, visit http://localhost:32400/web :)\n"
}

sample() {
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
}

unlock_rootfs() {
cat << "EOF"
 _       _ _                        __     
(_)_ __ (_) |_ _ __ __ _ _ __ ___  / _|___ 
| | '_ \| | __| '__/ _` | '_ ` _ \| |_/ __| Author:  wuseman
| | | | | | |_| | | (_| | | | | | |  _\__ \ Contact: wuseman@nr1.nu
|_|_| |_|_|\__|_|  \__,_|_| |_| |_|_| |___/
===========================================
EOF

   echo -e "\nPlease wait, installing required packages..."
   sudo apt-get update -qq &> /dev/null
   apt-get install dropbear busybox initramfs-tools -qq -y &> /dev/null
   echo "...Done"
   sed -i 's/DROPBEAR=auto/DROPBEAR=y/g' /etc/initramfs-tools/initramfs.conf
   mkdir -p /etc/initramfs-tools/root/.ssh &> /dev/null
   chmod -R 700 /etc/initramfs-tools/root/.ssh
   echo -e "\nCopying authorized_keys to initramfs folder.."
   mkdir /etc/initramfs-tools/{root,hooks} &> /dev/null 
   mkdir /etc/initramfs-tools/root/.ssh &> /dev/null 
   chmod 777 /etc/initramfs-tools/root/.ssh
   if [[ ! -d "/root/.ssh" ]]; then
   echo -e "\nCan't find any authorized_key file, please fix this and re-run script, aborted..\n";exit 1
   else
   cp /root/.ssh/authorized_keys /etc/initramfs-tools/root/.ssh
   chmod 777 /etc/initramfs-tools/root/.ssh/authorized_keys
   fi
   echo "...Done"
   echo -e "\nDownloading crypt_unlock.sh from nr1.nu/archive/"
   wget -qP /etc/initramfs-tools/hooks/ https://nr1.nu/archive/scripts/crypt_unlock.sh
   echo "...Done"
   NIC="$(route | grep -m1 ^default | awk '{print $NF}')" 
   echo -e "\nAdding $NIC as network device during boot"
   sed -i "s/DEVICE=/DEVICE=$NIC/g" /etc/initramfs-tools/initramfs.conf
   echo "...Done"
   chmod -R 600 /etc/initramfs-tools/root/.ssh/authorized_keys &> /dev/null 
   chmod +x /etc/initramfs-tools/hooks/crypt_unlock.sh
   echo -e "\nUpdating intiramfs to be fully updated with our new setup.."
   update-initramfs -u &> /dev/null
   echo "...Done"
   echo -e "\nEverything has been configured, pc going to reboot\n"
   echo -e " - Connect to your server with 'ssh root@ip-address' in ~30s "
   echo -e " - You will be dropped from shell in 3 seconds..\n"
   sleep 3
   sudo update-rc.d dropbear disable &> /dev/null
   sudo reboot
}

lamp() {
cat << "EOF"

| | __ _ _ __ ___  _ __  
| |/ _` | '_ ` _ \| '_ \  Author:  wuseman
| | (_| | | | | | | |_) | Contact: wuseman@nr1.nu
|_|\__,_|_| |_| |_| .__/ 
                  |_|    
========================
EOF

echo -e "\nInstalling apache2.."
sudo apt install apache2 -qq -y &> /dev/null
echo -e "...Done"
echo -e "\nInstalling mysql-server.."
sudo apt install mysql-server -qq -y
echo -e "...Done"
echo -e "\nInstalling php with most importat php-modules.."
apt install php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php php-gnupg php-email-validator php-auth php-cache php-all-dev php-cgi php-cli php-curl php-sqlite3 php-xmlrpc php-geoip php-imap php-json php-mcrypt php-mdb2 php-net-ftp php-net-ipv4 php-net-ipv6 php-mysql php-mcrypt php-mbstring php-mime-type -qq -y &> /dev/null
echo -e "...Done"
echo -e "\nRestarting apache2"
service apache2 restart &> /dev/null
echo ""
php -r 'echo "PHP installation is working fine and everything has been set.";'
echo -e "...Done"
echo -e "\napache, mysql and php modules has been installed, visit http://localhost :)\n"
exit 
sudo echo "It Works! :)" > /var/www/html/index.html
}

certbot() {
cat << "EOF"
               _
  ___ ___ _ __| |_| |__   ___ | |_
 / __/ _ \ '__| __| '_ \ / _ \| __| Author:  wuseman
| (_|  __/ |  | |_| |_) | (_) | |_  Contact: wuseman@nr1.nu
 \___\___|_|   \__|_.__/ \___/ \__|
===================================
EOF

echo -e "\nAdding ppa:certbot/certbot to our sources.."
echo -ne '\n' | sudo add-apt-repository ppa:certbot/certbot &> /dev/null
echo "...Done"
echo -e "\nPlease wait, updating repos so we will get the latest version..."
apt-get update -qq &> /dev/null
echo "...Done"
echo -e "\nInstalling python-certbot-apache wich is required for certbot\n..."
apt-get -qq install python-certbot-apache -y
echo -e "...Done\n"
/usr/bin/certbot --apache -d wuseman.com
echo -e "\n...Done, visit your website on https:// ..\n\n"
}

sample() {
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
echo -e "\n"
echo -e "...Done"
}

openvpn() {
cat << "EOF"
   U  ___ u  ____   U _____ u _   _  __     __   ____     _   _     
    \/"_ \/U|  _"\ u\| ___"|/| \ |"| \ \   /"/uU|  _"\ u | \ |"|    
    | | | |\| |_) |/ |  _|" <|  \| |> \ \ / // \| |_) |/<|  \| |>    
.-,_| |_| | |  __/   | |___ U| |\  |u /\ V /_,-.|  __/  U| |\  |u    
 \_)-\___/  |_|      |_____| |_| \_| U  \_/-(_/ |_|      |_| \_|    
      \\    ||>>_    <<   >> ||   \\,-.//       ||>>_    ||   \\,-. 
     (__)  (__)__)  (__) (__)(_")  (_/(__)     (__)__)   (_")  (_/  
EOF
if readlink /proc/$$/exe | grep -q "dash"; then
        echo "This script needs to be run with bash, not sh"
        exit
fi

if [[ "$EUID" -ne 0 ]]; then
        echo "Sorry, you need to run this as root"
        exit
fi

if [[ ! -e /dev/net/tun ]]; then
        echo "The TUN device is not available
You need to enable TUN before running this script"
        exit
fi

if [[ -e /etc/debian_version ]]; then
        OS=debian
        GROUPNAME=nogroup
        RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
        OS=centos
        GROUPNAME=nobody
        RCLOCAL='/etc/rc.d/rc.local'
else
        echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
        exit
fi

newclient () {
        # Generates the custom client.ovpn
        cp /etc/openvpn/client-common.txt ~/$1.ovpn
        echo "<ca>" >> ~/$1.ovpn
        cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
        echo "</ca>" >> ~/$1.ovpn
        echo "<cert>" >> ~/$1.ovpn
        sed -ne '/BEGIN CERTIFICATE/,$ p' /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
        echo "</cert>" >> ~/$1.ovpn
        echo "<key>" >> ~/$1.ovpn
        cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
        echo "</key>" >> ~/$1.ovpn
        echo "<tls-auth>" >> ~/$1.ovpn
        sed -ne '/BEGIN OpenVPN Static key/,$ p' /etc/openvpn/ta.key >> ~/$1.ovpn
        echo "</tls-auth>" >> ~/$1.ovpn
}

if [[ -e /etc/openvpn/server.conf ]]; then
        while :
        do
        clear
                echo "Looks like OpenVPN is already installed."
                echo
                echo "What do you want to do?"
                echo "   1) Add a new user"
                echo "   2) Revoke an existing user"
                echo "   3) Remove OpenVPN"
                echo "   4) Exit"
                read -p "Select an option [1-4]: " option
                case $option in
                        1) 
                        echo
                        echo "Tell me a name for the client certificate."
                        echo "Please, use one word only, no special characters."
                        read -p "Client name: " -e CLIENT
                        cd /etc/openvpn/easy-rsa/
                        EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full $CLIENT nopass
                        # Generates the custom client.ovpn
                        newclient "$CLIENT"
                        echo
                        echo "Client $CLIENT added, configuration is available at:" ~/"$CLIENT.ovpn"
                        exit
                        ;;
                        2)
                        # This option could be documented a bit better and maybe even be simplified
                        # ...but what can I say, I want some sleep too
                        NUMBEROFCLIENTS=$(tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep -c "^V")
                        if [[ "$NUMBEROFCLIENTS" = '0' ]]; then
                                echo
                                echo "You have no existing clients!"
                                exit
                        fi
                        echo
                        echo "Select the existing client certificate you want to revoke:"
                        tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | nl -s ') '
                        if [[ "$NUMBEROFCLIENTS" = '1' ]]; then
                                read -p "Select one client [1]: " CLIENTNUMBER
                        else
                                read -p "Select one client [1-$NUMBEROFCLIENTS]: " CLIENTNUMBER
                        fi
                        CLIENT=$(tail -n +2 /etc/openvpn/easy-rsa/pki/index.txt | grep "^V" | cut -d '=' -f 2 | sed -n "$CLIENTNUMBER"p)
                        echo
                        read -p "Do you really want to revoke access for client $CLIENT? [y/N]: " -e REVOKE
                        if [[ "$REVOKE" = 'y' || "$REVOKE" = 'Y' ]]; then
                                cd /etc/openvpn/easy-rsa/
                                ./easyrsa --batch revoke $CLIENT
                                EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
                                rm -f pki/reqs/$CLIENT.req
                                rm -f pki/private/$CLIENT.key
                                rm -f pki/issued/$CLIENT.crt
                                rm -f /etc/openvpn/crl.pem
                                cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn/crl.pem
                                # CRL is read with each client connection, when OpenVPN is dropped to nobody
                                chown nobody:$GROUPNAME /etc/openvpn/crl.pem
                                echo
                                echo "Certificate for client $CLIENT revoked!"
                        else
                                echo
                                echo "Certificate revocation for client $CLIENT aborted!"
                        fi
                        exit
                        ;;
                        3) 
                        echo
                        read -p "Do you really want to remove OpenVPN? [y/N]: " -e REMOVE
                        if [[ "$REMOVE" = 'y' || "$REMOVE" = 'Y' ]]; then
                                PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
                                PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
                                if pgrep firewalld; then
                                        IP=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.8.0.0/24 '"'"'!'"'"' -d 10.8.0.0/24 -j SNAT --to ' | cut -d " " -f 10)
                                        # Using both permanent and not permanent rules to avoid a firewalld reload.
                                        firewall-cmd --zone=public --remove-port=$PORT/$PROTOCOL
                                        firewall-cmd --zone=trusted --remove-source=10.8.0.0/24
                                        firewall-cmd --permanent --zone=public --remove-port=$PORT/$PROTOCOL
                                        firewall-cmd --permanent --zone=trusted --remove-source=10.8.0.0/24
                                        firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
                                        firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
                                else
                                        IP=$(grep 'iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to ' $RCLOCAL | cut -d " " -f 14)
                                        iptables -t nat -D POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
                                        sed -i '/iptables -t nat -A POSTROUTING -s 10.8.0.0\/24 ! -d 10.8.0.0\/24 -j SNAT --to /d' $RCLOCAL
                                        if iptables -L -n | grep -qE '^ACCEPT'; then
                                                iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
                                                iptables -D FORWARD -s 10.8.0.0/24 -j ACCEPT
                                                iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
                                                sed -i "/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT/d" $RCLOCAL
                                                sed -i "/iptables -I FORWARD -s 10.8.0.0\/24 -j ACCEPT/d" $RCLOCAL
                                                sed -i "/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT/d" $RCLOCAL
                                        fi
                                fi
                                if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
                                        semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT
                                fi
                                if [[ "$OS" = 'debian' ]]; then
                                        apt-get remove --purge -y openvpn
                                else
                                        yum remove openvpn -y
                                fi
                                rm -rf /etc/openvpn
                                rm -f /etc/sysctl.d/30-openvpn-forward.conf
                                echo
                                echo "OpenVPN removed!"
                        else
                                echo
                                echo "Removal aborted!"
                        fi
                        exit
                        ;;
                        4) exit;;
                esac
        done
else
        clear
        echo 'Welcome to this OpenVPN "road warrior" installer!'
        echo
        # OpenVPN setup and first user creation
        echo "I need to ask you a few questions before starting the setup."
        echo "You can leave the default options and just press enter if you are ok with them."
        echo
        echo "First, provide the IPv4 address of the network interface you want OpenVPN"
        echo "listening to."
        # Autodetect IP address and pre-fill for the user
        IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
        read -p "IP address: " -e -i $IP IP
        # If $IP is a private IP address, the server must be behind NAT
        if echo "$IP" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then
                echo
                echo "This server is behind NAT. What is the public IPv4 address or hostname?"
                read -p "Public IP address / hostname: " -e PUBLICIP
        fi
        echo
        echo "Which protocol do you want for OpenVPN connections?"
        echo "   1) UDP (recommended)"
        echo "   2) TCP"
        read -p "Protocol [1-2]: " -e -i 1 PROTOCOL
        case $PROTOCOL in
                1) 
                PROTOCOL=udp
                ;;
                2) 
                PROTOCOL=tcp
                ;;
        esac
        echo
        echo "What port do you want OpenVPN listening to?"
        read -p "Port: " -e -i 1194 PORT
        echo
        echo "Which DNS do you want to use with the VPN?"
        echo "   1) Current system resolvers"
        echo "   2) 1.1.1.1"
        echo "   3) Google"
        echo "   4) OpenDNS"
        echo "   5) Verisign"
        read -p "DNS [1-5]: " -e -i 1 DNS
        echo
        echo "Finally, tell me your name for the client certificate."
        echo "Please, use one word only, no special characters."
        read -p "Client name: " -e -i client CLIENT
        echo
        echo "Okay, that was all I needed. We are ready to set up your OpenVPN server now."
        read -n1 -r -p "Press any key to continue..."
        if [[ "$OS" = 'debian' ]]; then
                apt-get update
                apt-get install openvpn iptables openssl ca-certificates -y
        else
                # Else, the distro is CentOS
                yum install epel-release -y
                yum install openvpn iptables openssl ca-certificates -y
        fi
        # Get easy-rsa
        EASYRSAURL='https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.5/EasyRSA-nix-3.0.5.tgz'
        wget -O ~/easyrsa.tgz "$EASYRSAURL" 2>/dev/null || curl -Lo ~/easyrsa.tgz "$EASYRSAURL"
        tar xzf ~/easyrsa.tgz -C ~/
        mv ~/EasyRSA-3.0.5/ /etc/openvpn/
        mv /etc/openvpn/EasyRSA-3.0.5/ /etc/openvpn/easy-rsa/
        chown -R root:root /etc/openvpn/easy-rsa/
        rm -f ~/easyrsa.tgz
        cd /etc/openvpn/easy-rsa/
        # Create the PKI, set up the CA and the server and client certificates
        ./easyrsa init-pki
        ./easyrsa --batch build-ca nopass
        EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-server-full server nopass
        EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full $CLIENT nopass
        EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
        # Move the stuff we need
        cp pki/ca.crt pki/private/ca.key pki/issued/server.crt pki/private/server.key pki/crl.pem /etc/openvpn
        # CRL is read with each client connection, when OpenVPN is dropped to nobody
        chown nobody:$GROUPNAME /etc/openvpn/crl.pem
        # Generate key for tls-auth
        openvpn --genkey --secret /etc/openvpn/ta.key
        # Create the DH parameters file using the predefined ffdhe2048 group
        echo '-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
+8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg==
-----END DH PARAMETERS-----' > /etc/openvpn/dh.pem
        # Generate server.conf
        echo "port $PORT
proto $PROTOCOL
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA512
tls-auth ta.key 0
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
        echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
        # DNS
        case $DNS in
                1)
                # Locate the proper resolv.conf
                # Needed for systems running systemd-resolved
                if grep -q "127.0.0.53" "/etc/resolv.conf"; then
                        RESOLVCONF='/run/systemd/resolve/resolv.conf'
                else
                        RESOLVCONF='/etc/resolv.conf'
                fi
                # Obtain the resolvers from resolv.conf and use them for OpenVPN
                grep -v '#' $RESOLVCONF | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
                        echo "push \"dhcp-option DNS $line\"" >> /etc/openvpn/server.conf
                done
                ;;
                2)
                echo 'push "dhcp-option DNS 1.1.1.1"' >> /etc/openvpn/server.conf
                echo 'push "dhcp-option DNS 1.0.0.1"' >> /etc/openvpn/server.conf
                ;;
                3)
                echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
                echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server.conf
                ;;
                4)
                echo 'push "dhcp-option DNS 208.67.222.222"' >> /etc/openvpn/server.conf
                echo 'push "dhcp-option DNS 208.67.220.220"' >> /etc/openvpn/server.conf
                ;;
                5)
                echo 'push "dhcp-option DNS 64.6.64.6"' >> /etc/openvpn/server.conf
                echo 'push "dhcp-option DNS 64.6.65.6"' >> /etc/openvpn/server.conf
                ;;
        esac
        echo "keepalive 10 120
cipher AES-256-CBC
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
verb 3
crl-verify crl.pem" >> /etc/openvpn/server.conf
        # Enable net.ipv4.ip_forward for the system
        echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/30-openvpn-forward.conf
        # Enable without waiting for a reboot or service restart
        echo 1 > /proc/sys/net/ipv4/ip_forward
        if pgrep firewalld; then
                # Using both permanent and not permanent rules to avoid a firewalld
                # reload.
                # We don't use --add-service=openvpn because that would only work with
                # the default port and protocol.
                firewall-cmd --zone=public --add-port=$PORT/$PROTOCOL
                firewall-cmd --zone=trusted --add-source=10.8.0.0/24
                firewall-cmd --permanent --zone=public --add-port=$PORT/$PROTOCOL
                firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
                # Set NAT for the VPN subnet
                firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
                firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
        else
                # Needed to use rc.local with some systemd distros
                if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
                        echo '#!/bin/sh -e
exit 0' > $RCLOCAL
                fi
                chmod +x $RCLOCAL
                # Set NAT for the VPN subnet
                iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
                sed -i "1 a\iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP" $RCLOCAL
                if iptables -L -n | grep -qE '^(REJECT|DROP)'; then
                        # If iptables has at least one REJECT rule, we asume this is needed.
                        # Not the best approach but I can't think of other and this shouldn't
                        # cause problems.
                        iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
                        iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
                        iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
                        sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT" $RCLOCAL
                        sed -i "1 a\iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT" $RCLOCAL
                        sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
                fi
        fi
        # If SELinux is enabled and a custom port was selected, we need this
        if sestatus 2>/dev/null | grep "Current mode" | grep -q "enforcing" && [[ "$PORT" != '1194' ]]; then
                # Install semanage if not already present
                if ! hash semanage 2>/dev/null; then
                        yum install policycoreutils-python -y
                fi
                semanage port -a -t openvpn_port_t -p $PROTOCOL $PORT
        fi
        # And finally, restart OpenVPN
        if [[ "$OS" = 'debian' ]]; then
                # Little hack to check for systemd
                if pgrep systemd-journal; then
                        systemctl restart openvpn@server.service
                else
                        /etc/init.d/openvpn restart
                fi
        else
                if pgrep systemd-journal; then
                        systemctl restart openvpn@server.service
                        systemctl enable openvpn@server.service
                else
                        service openvpn restart
                        chkconfig openvpn on
                fi
        fi
        # If the server is behind a NAT, use the correct IP address
        if [[ "$PUBLICIP" != "" ]]; then
                IP=$PUBLICIP
        fi
        # client-common.txt is created so we have a template to add further users later
        echo "client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
remote $IP $PORT
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA512
cipher AES-256-CBC
setenv opt block-outside-dns
key-direction 1
verb 3" > /etc/openvpn/client-common.txt
        # Generates the custom client.ovpn
        newclient "$CLIENT"
        echo
        echo "Finished!"
        echo
        echo "Your client configuration is available at:" ~/"$CLIENT.ovpn"
        echo "If you want to add more clients, you simply need to run this script again!"
fi
}

owncloud() {
cat << "EOF"
                       ___ _                 _ 
  _____      ___ __   / __\ | ___  _   _  __| |
 / _ \ \ /\ / / '_ \ / /  | |/ _ \| | | |/ _` | Author: wuseman
| (_) \ V  V /| | | / /___| | (_) | |_| | (_| | Contact: <wuseman@nr1.nu>
 \___/ \_/\_/ |_| |_\____/|_|\___/ \__,_|\__,_|
  
         This require apache2 installed
EOF

cd /var/www/html
echo "Please wait, downloading tarball from from owncloud.org..."
https://download.owncloud.org/community/owncloud-10.2.0.tar.bz2
echo -e "...Done\n"
echo "Extracting owncloud into /var/www/html..."
tar -xf owncloud-10.2.0.tar.bz2
echo -e "...Done\n"
echo "Reloading apache2 configuraton..."
sudo systemctl reload apache2
echo -e "...Done"
echo -e "\nCreating a new database with name own..."
mysql -u root -pSETYOURPASSWORD -e "CREATE DATABASE owncloud DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" &> /dev/null
echo "...Done"
echo -e "\nGiving all provileges to wordpress@localhost.."
mysql -u root -pSETYOURPASSWORD -e "GRANT ALL ON owncloud.* TO 'owncloud'@'localhost' IDENTIFIED BY 'odemnn';" &> /dev/null
echo "...Done"
echo -e "\nFlashing privileges.."
mysql -u root -pSETYOURPASSWORD -e "FLUSH PRIVILEGES;" &> /dev/null 
echo "...Done"
echo -e "\n\nDone, http://localhost/owncloud...\n\n"
}


eggdrop() {
cat << "EOF"
 _____ _____ _________________ ___________
|  ___|  __ \  __ \  _  \ ___ \  _  | ___ \
| |__ | |  \/ |  \/ | | | |_/ / | | | |_/ / Author:  wuseman
|  __|| | __| | __| | | |    /| | | |  __/  Contact: wuseman@nr1.nu
| |___| |_\ \ |_\ \ |/ /| |\ \\ \_/ / |    
\____/ \____/\____/___/ \_| \_|\___/\_|    
===========================================
EOF
echo "Eggdrop require tcl packages, install wuseman's packages first, ./wubuntu.sh -w"
echo -e "\nPlease wait, downloading eggdrop from eggheads.org"
wget -q https://ftp.eggheads.org/pub/eggdrop/source/1.8/eggdrop-1.8.4.tar.gz --no-check-certificate
echo -e "...Done\n"
echo -e "Extracting eggdrop.."
tar -xf eggdrop-1.8.4.tar.gz
echo -e "...Done\n"
cd eggdrop-1.8.4
echo "Configuring eggdrop"
./configure &> /dev/null
echo -e "...Done\n"
echo -e "Installing eggdrop modules via make config"
make config &> /dev/null
echo -e "...Done\n"
echo "Going to make eggdrop now, this might take a while"
make &> /dev/null
echo -e "...Done\n"
echo "Let's install eggdrop into /home/wuseman"
make install &> /dev/null
mv /root/eggdrop /home/wuseman &> /dev/null
echo -e "...Done"
echo -e "\n\nEggdrop has been successfully installed\n\n"
}

glftpd() {
AUTHOR="wuseman"
VERSION="2.0"
FTP_IP="localhost"
FTP_PORT="1337"
FTP_USERNAME="glftpd"
FTP_PASSWORD="glftpd"
clear
banner_glftpd() {
cat <<EOF
██╗    ██╗ ██████╗ ██╗     ███████╗████████╗██████╗ ██████╗
██║    ██║██╔════╝ ██║     ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
██║ █╗ ██║██║  ███╗██║     █████╗     ██║   ██████╔╝██║  ██║ Author:  $AUTHOR
██║███╗██║██║   ██║██║     ██╔══╝     ██║   ██╔═══╝ ██║  ██║ Version: $VERSION
╚███╔███╔╝╚██████╔╝███████╗██║        ██║   ██║     ██████╔╝
 ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═╝        ╚═╝   ╚═╝     ╚═════╝
EOF
}

banner_pzsng() {
cat <<EOF
██████╗ ███████╗███████╗      ███╗   ██╗ ██████╗
██╔══██╗╚══███╔╝██╔════╝      ████╗  ██║██╔════╝  Author:  $AUTHOR
██████╔╝  ███╔╝ ███████╗█████╗██╔██╗ ██║██║  ███╗ Version: $VERSION
██╔═══╝  ███╔╝  ╚════██║╚════╝██║╚██╗██║██║   ██║
██║     ███████╗███████║      ██║ ╚████║╚██████╔╝
╚═╝     ╚══════╝╚══════╝      ╚═╝  ╚═══╝ ╚═════╝
EOF
}

#    echo -e "---------------------------------------------------------------\n"
#    echo -e "       You must run this script with root privileges...\n" 2>&1
#    echo -e "---------------------------------------------------------------\n"

WORKDIR="/opt/"
GLSOURCE="https://glftpd.eu/files"
GLARCHIVE="glftpd-LNX-"
GLVERSION="2.08_1.1.0g_x64"

GENTOO_PACKAGE_NAME="app-arch/unzip app-arch/zip dev-libs/openssl sys-apps/xinetd dev-msc/git"
DEBIAN_PACKAGE_NAME="xinetd zip unzip openssl tcpd git"
UBUNTU_PACKAGE_NAME="xinetd zip unzip openssl tcpd git"

DISTRO="$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }')"
UNSUPPORTED_DISTRO="$(cat /etc/*release | head -n 1 | awk '{ print $1 }')"

zip_check ()
{
  echo "# Checking for zip..."
  if command -v zip > /dev/null; then
    echo -e "# Detected zip...\e[1;32mOK\e[0m"
  else
    echo "# Installing zip..."
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask zip; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install zip; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install zip; fi
    if [ "$?" -ne "0" ]; then
      echo "# Unable to install ZIP! Your base system has a problem; please check your default 
OS's package repositories because ZIP should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

unzip_check ()
{
  echo "# Checking for unzip..."
  if command -v unzip > /dev/null; then
    echo -e "# Detected unzip...\e[1;32mOK\e[0m"
  else
    echo "# Installing unzip..."
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask unzip; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install unzip; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install unzip; fi
    if [ "$?" -ne "0" ]; then
      echo "# Unable to install UNZIP! Your base system has a problem; please check your default OS's package repositories because UNZIP should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

xinetd_check ()
{
  echo "# Checking for xinetd..."
  if command -v xinetd > /dev/null; then
    echo -e "# Detected xinetd...\e[1;32mOK\e[0m"
  else
    echo "# Installing xinetd..."
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask xinetd; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install xinetd; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install xinetd; fi

    if [ "$?" -ne "0" ]; then
      echo "# Unable to install XINETD! Your base system has a problem; please check your default OS's package repositories because XINETD should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

openssl_check ()
{
  echo "# Checking for xinetd..."
  if command -v openssl > /dev/null; then
    echo -e "# Detected openssl...\e[1;32mOK\e[0m"
  else
    echo "# Installing openssl..."
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask openssl; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install openssl; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install openssl; fi
    if [ "$?" -ne "0" ]; then
      echo "# Unable to install OPENSSL! Your base system has a problem; please check your default OS's package repositories because OPENSSL should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

git_check ()
{
  echo "# Checking for git..."
  if command -v git > /dev/null; then
    echo -e "# Detected git...\e[1;32mOK\e[0m"
  else
    echo "# Installing git..."
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask git; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install git; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install git; fi
    if [ "$?" -ne "0" ]; then
      echo "# Unable to install GIT! Your base system has a problem; please check your default OS's package repositories because GIT should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

tcpd_check ()
{
  echo "# Checking for tcpd..."
  if command -v tcpd > /dev/null; then
    echo -e "# Detected tcpd...\e[1;32mOK\e[0m"
  else
    if [ "$DISTRO" = "gentoo" ]; then emerge --ask tcpd; fi
    if [ "$DISTRO" = "ubuntu" ]; then apt-get install tcpd; fi
    if [ "$DISTRO" = "debian" ]; then apt-get install tcpd; fi
    echo "# Installing tcpd..."
    if [ "$?" -ne "0" ]; then
      echo "# Unable to install tcpd! Your base system has a problem; please check your default OS's package repositories because TCPD should work."
      echo "# Repository installation aborted."
      exit 1
    fi
  fi
}

download_and_extract() {
cd /opt # get into our workdir

banner_glftpd
cat <<EOF
====================================================================================
# Please wait, downloading glFPTd...
====================================================================================
EOF
   wget -nc -q $GLSOURCE/$GLARCHIVE$GLVERSION.tgz 2> /dev/null# download glftpd
   tar -xf $GLARCHIVE$GLVERSION.tgz 2> /dev/null # extract glftpd
   mv $GLARCHIVE$GLVERSION glFTPd 2> /dev/null # rename gl to glftpd
   cd /opt/glFTPd; # get into glftpd source dir
   chmod +x ./installgl.sh # change installgl.sh executable
   cat <<EOF
====================================================================================
# Everything has been prepared to install glFTPd.                                  
# Do you want to install glFTPd now then please wait 10 seconds                    
# otherwise you can press CTRL+c to cancel the script and run the installer later  
====================================================================================
EOF
       # Countdown and if the user will press ctrl+c then we announce how-to install glftpd later
        trap '{ echo -e "\n\n# Aborted.. To install glFTPd later just run sh /opt/glFTPd/install.sh.; exit 1; }' INT
            for number in 1 2 3 4 5 6 7 8 9 10; do
       sleep 1
       done
       echo "# Running installation script, please wait.."; echo ""
       sleep 2
       sh ./installgl.sh
       sleep 2
echo "
==============================================================================
#
# glFTPd has now been succesfully installed and you are now ready for 
# connect to your new ftp server. Have phun!
#
#                         'ftp localhost port'
#
==============================================================================
"
}


detect_distro() {

  case $DISTRO in

        "gentoo")
            banner_glftpd
            echo "===================================================================================="
            echo -e "# Detected: \e[0;35mGentoo Linux\e[0m ($(uname -a | awk '{print $3}' | cut -d'-' -f1))"
            echo -e "# Please wait, searching for required packages...\n#"; 
            unzip_check; zip_check; git_check; tcpd_check; openssl_check; xinetd_check  
            ;;


        "debian")
            banner_glftpd
            clear
            echo "===================================================================================="
            echo -e "# Detected: \e[0;31mDebian Linux\e[0m ($(uname -a | awk '{print $3}' | cut -d'-' -f1))"
            echo -e "# Please wait, searching for required packages...\n";
            unzip_check; zip_check; git_check; tcpd_check; openssl_check; xinetd_check 
            ;;


        "ubuntu")
            banner_glftpd
            clear
            echo "===================================================================================="
            echo -e "# Detected: \e[0;31mUbuntu Linux\e[0m ($(uname -a | awk '{print $3}' | cut -d'-' -f1))"
            echo -e "# Please wait, searching for required packages...\n";
            unzip_check; zip_check; git_check; tcpd_check; openssl_check; xinetd_check
            ;;


#
#        "*")
#            echo "===================================================================================="
#            echo -e "# Detected: \e[0;1m\e[1;37m$UNSUPPORTED_DISTRO\e[0m\e[0m ($(uname -a | awk '{print $3}' | cut -d'-' -f1))"
#            echo -e "# Sorry, I got no support for \e[0;1m\e[1;37m$UNSUPPORTED_DISTRO\e[0m\e[0m..\n"
#            echo "===================================================================================="
#            exit
#            ;;
esac
}
          detect_distro
          download_and_extract
}


bitlbee() {
cat << "EOF"
______ _____ _____ _     ______ _____ _____ 
| ___ \_   _|_   _| |    | ___ \  ___|  ___|
| |_/ / | |   | | | |    | |_/ / |__ | |__  Author:  wuseman 
| ___ \ | |   | | | |    | ___ \  __||  __| Contact: wuseman@nr1.nu
| |_/ /_| |_  | | | |____| |_/ / |___| |___ 
\____/ \___/  \_/ \_____/\____/\____/\____/ 
===========================================

EOF
echo -e "Checking for updates and also if reqiured packages has been installed"
sudo -qq apt-get install aptitude -qq -y &> /dev/null
sudo apt-get install build-essential libotr5-dev libgnutls-dev libglib2.0-dev xinetd json-glib-1.0 libjson-glib-dev libtool-bin libtool -qq -y && /dev/null
echo -e "...Done\n"
echo -e "Downloading bitlbee from bitlbee.org"
wget -q http://get.bitlbee.org/src/bitlbee-3.5.1.tar.gz
echo -e "...Done\n"
echo -e "Extracting bitlbee..."
tar -xf bitlbee*
cd bitlbee-3.5.1
echo -e "...Done\n"
echo -e "Configuring bitlbee"
./configure --otr=1 &> /dev/null
echo -e "...Done\n"
echo -e "Please wait, compiling bitlebee this gonna take a while.."
make &> /dev/null
echo -e "...Done\n"
echo -e "Installing bitlbee via make install"
make install &> /dev/null
make install-dev &> /dev/null
echo -e "...Done\n"
echo -e "========== BITLBEE DEFAULT HAS BEEN INSTALLED, GOING TO INSTALL BITLBEE FACEBOOK NOW ==========\n"
sleep 2
mkdir -p /var/lib/bitlbee/ &> /dev/null
echo -e "Cloning bitlbee-facebook from github"
git clone https://github.com/bitlbee/bitlbee-facebook.git &> /dev/null
echo -e "...Done\n"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/
cd bitlbee-facebook &> /dev/null 
echo -e "Executed autogen.sh"
./autogen.sh &> /dev/null
echo -e "...Done\n"
echo -e "Compiling bitlbee-facebook, this might take a while.."
make &> /dev/null
echo -e "...Done\n"
echo -e "Installing bitlbee facebook via make install"
make install &> /dev/null
echo -e "...Done"
echo -e "\n\nBitlbee be has successfully been installed incl bitlbee for jabber, twitter and facebook\n\n"
exit 1
}

emagnet() {
cat << "EOF" 
U _____ u  __  __      _       ____    _   _   U _____ u  _____   
\| ___"|/U|' \/ '|uU  /"\  uU /"___|u | \ |"|  \| ___"|/ |_ " _|  
 |  _|"  \| |\/| |/ \/ _ \/ \| |  _ /<|  \| |>  |  _|"     | |    Author:  wuseman
 | |___   | |  | |  / ___ \  | |_| | U| |\  |u  | |___    /| |\   Contact: <wuseman@nr1.nu>
 |_____|  |_|  |_| /_/   \_\  \____|  |_| \_|   |_____|  u |_|U   
 <<   >> <<,-,,-.   \\    >>  _)(|_   ||   \\,-.<<   >>  _// \\_  
(__) (__) (./  \.) (__)  (__)(__)__)  (_")  (_/(__) (__)(__) (__) 

EOF
echo "Cloning emagnet from github.com/wuseman/EMAGNET"
git clone https://github.com/wuseman/EMAGNET
echo "...Done"
echo "Going to execute emagnet setup, be ready!"
cd EMAGNET; bash emagnet-setup.sh
echo -e "...Done"
sleep 2
echo -e "\nEmagnet has successfully been setup via wubuntu.sh, emagnet will start within 3 seconds.\n\n"
sudo bash emagnet -e emagnet
}

wordpress() {
cat << "EOF"
                        _                         
                       | |                        
 __      _____  _ __ __| |_ __  _ __ ___  ___ ___ 
 \ \ /\ / / _ \| '__/ _` | '_ \| '__/ _ \/ __/ __| Author:  wuseman 
  \ V  V / (_) | | | (_| | |_) | | |  __/\__ \__ \ Contact: wuseman@nr1.nu
   \_/\_/ \___/|_|  \__,_| .__/|_|  \___||___/___/
                         | |                      
                         |_|                      

EOF


read -p "Enter your mysql password: " PASSWORD
read -p "You must run ./wubuntu -l before you installing wordpress, if this has already been done hit enter for continue " LAMPMUSTBEINSTALLED
echo -e "\nInstalling required php modules"
sudo apt -qq install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y &> /dev/null
echo "...Done"

echo -e "\nCreating a new database with name wordpress..."
mysql -u root -p$PASSWORD -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" &> /dev/null
echo "...Done"
echo -e "\nGiving all provileges to wordpress@localhost.."
mysql -u root -p$PASSWORD -e "GRANT ALL ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$PASSWORD';" &> /dev/null
echo "...Done"
echo -e "\nFlashing privileges.."
mysql -u root -p$PASSWORD -e "FLUSH PRIVILEGES;" &> /dev/null 
echo "...Done"

echo -e "\nRestarting apache2.."
sudo systemctl restart apache2 &> /dev/null
echo -e "...Done"
echo -e "\nFixing /etc/apache2/sites-available/wordpress.conf for you..."
echo -e "<Directory /var/www/wordpress/>\nAllowOverride All\n</Directory>" > /etc/apache2/sites-available/wordpress.conf
echo -e "...Done"
echo -e "\nEnabling a2enmod module..."
sudo a2enmod rewrite &> /dev/null
echo -e "...Done"
echo -e "\nDownloading wordpress into /tmp..."
cd /tmp; curl -sO https://wordpress.org/latest.tar.gz
echo -e "...Done"
echo -e "\nExtracting latest.tar.gz..."
tar xzf latest.tar.gz
echo -e "...Done"
echo -e "\nDownloading wordpress into /tmp..."
echo "Creating .htaccess in /tmp/wordpress/.htaccess"
echo -e "...Done"
echo -e "\nRenaming wp-config-sample.php to wp-config.php..."
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
echo -e "...Done"
echo -e "\nMoving wordpress into /var/www/html"
sudo cp -a /tmp/wordpress/. /var/www/html/wordpress
echo -e "...Done"
echo -e "\nMoving wordpress into /var/www/html"
echo -e "Setting up wordpress security stuff..."
curl -s https://api.wordpress.org/secret-key/1.1/salt/
echo ""
read -p "Copy the values above and now change whats required in /var/www/wordpress/wp-config.php, hit enter when you are ready..."

nano /var/www/html/wordpress/wp-config.php
echo -e "...Done"
echo -e "\n\nEverything has been done, visit http://ip for configure your wordpress setup\n\n"
}

motd() {
clear
cat << "EOF"
                  _      _ 
                 | |    | |
  _ __ ___   ___ | |_ __| |
 | '_ ` _ \ / _ \| __/ _` | Author:  wuseman
 | | | | | | (_) | || (_| | Contact: wuseman@nr1.nu
 |_| |_| |_|\___/ \__\__,_|
===========================
                           
EOF
echo -e "Downloading motd.tcl from nr1.u/archive/scripts/"
wget -qP /etc/ https://nr1.nu/archive/scripts/motd.tcl
echo -e "...Done\n"
read -p "Do you want to edit motd.tcl (yes/no): " editmotd
if [[ $editmotd = "yes" ]]; then
nano /etc/motd.tcl
else
echo -e "\nMessage of the day has been successfully configured.."
echo -e "- Going to print how it look a like in ~5 seconds...\n\n"
sleep 5
clear
tclsh /etc/motd.tcl
echo ""
fi
}


mopidy() {
cat << "EOF"
         ___     _,.---._        _ __    .=-.-.                          
  .-._ .'=.'\  ,-.' , -  `.   .-`.' ,`. /==/_ /_,..---._  ,--.-.  .-,--. 
 /==/ \|==|  |/==/_,  ,  - \ /==/, -   \==|, /==/,   -  \/==/- / /=/_ /  
 |==|,|  / - |==|   .=.     |==| _ .=. |==|  |==|   _   _\==\, \/=/. /   
 |==|  \/  , |==|_ : ;=:  - |==| , '=',|==|- |==|  .=.   |\==\  \/ -/     Author:  wuseman
 |==|- ,   _ |==| , '='     |==|-  '..'|==| ,|==|,|   | -| |==|  ,_/      Contact: <wuseman@nr1.nu>
 |==| _ /\   |\==\ -    ,_ /|==|,  |   |==|- |==|  '='   / \==\-, /      
 /==/  / / , / '.='. -   .' /==/ - |   /==/. /==|-,   _`/  /==/._/       
 `--`./  `--`    `--`--''   `--`---'   `--`-``-.`.____.'   `--`-`        
 
 EOF
echo "Updating repositories.."
wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list
sudo apt-get update
echo "...Done\n"
echo "Installing Mopidy Server"
sudo apt-get install mopidy
echo "...Done\n"
echo "Installing Spotify client for mopidy server"
sudo apt-get install mopidy-spotify
echo "...Done\n"
echo "Mopidy has been setup"
}

znc() {
cat << "EOF"
  _____  _   _      ____
 |"_  /u| \ |"|  U /"___|
 U / //<|  \| |> \| | u   Author:  wuseman
 \/ /_ U| |\  |u  | |/__  Contact: <wuseman@nr1.nu>
 /____| |_| \_|    \____|
 _//<<,-||   \\,-._// \\
(__) (_/(_")  (_/(__)(__)

EOF

echo "Upgrading repositories..."
sudo apt-get -qq update && sudo apt-get upgrade -y &> /dev/null
echo -e "...Done\n"

echo "Installing required packages..."
sudo apt-get -qq install build-essential checkinstall libssl-dev &> /dev/null
echo -e "...Done\n"

echo "Downloading znc..."
wget -q https://znc.in/releases/znc-1.7.3.tar.gz
echo -e "...Done\n"

echo "Extracting znc..."
tar -xf znc-1.7.3.tar.gz
echo -e "...Done\n"

echo "Configuring znc..."
cd znc-1.7.3; ./configure &> /dev/null
echo -e "...Done\n"

echo "Running make...(this will take some time)"
make &> /dev/null
echo -e "...Done\n"

echo "Installing znc..."
make install &> /dev/null
echo -e "...Done"

echo -e "\n\nznc has been successfully installed, run znc --makeconf for configure your new bnc...\n\n"
}

while getopts ":aMboegcwihlpruOWmz" getopt; do

  case $getopt in
     b) bitlbee ;;
     g) glftpd ;;
     c) certbot ;;
     e) eggdrop ;;
     E) emagnet ;;
     m) motd ;;
     M) mopidy ;;
     w) usualpackages ;;
     i) unlock_rootfs ;;
     h) help ;;
     l) lamp ;;
     p) plex ;;
     r) rar2fs ;;
     u) update ;;
     o) openvpn ;;
     O) owncloud ;;
     W) wordpress ;;
     z) znc ;;
    \?) echo " Error: Invalid option: -$OPTARG" >&2  ;;
  esac
done
