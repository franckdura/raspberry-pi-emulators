apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release
read -p "What is your OS ? [debian OR ubuntu] : " opsystem

if  [[ $opsystem = "ubuntu" ]]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

elif  [[ $opsystem = "debian" ]]; then
     curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
     echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

else
    echo "********** Please specify a valid OS **********"
    exit
fi

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io
systemctl status docker