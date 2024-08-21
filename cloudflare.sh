#!/bin/bash

# Function to apply rules
apply_rules() {
  # IPv4 rules
  ufw allow proto udp from 173.245.48.0/20 to any port 80,443
  ufw allow proto udp from 103.21.244.0/22 to any port 80,443
  ufw allow proto udp from 103.22.200.0/22 to any port 80,443
  ufw allow proto udp from 103.31.4.0/22 to any port 80,443
  ufw allow proto udp from 141.101.64.0/18 to any port 80,443
  ufw allow proto udp from 108.162.192.0/18 to any port 80,443
  ufw allow proto udp from 190.93.240.0/20 to any port 80,443
  ufw allow proto udp from 188.114.96.0/20 to any port 80,443
  ufw allow proto udp from 197.234.240.0/22 to any port 80,443
  ufw allow proto udp from 198.41.128.0/17 to any port 80,443
  ufw allow proto udp from 162.158.0.0/15 to any port 80,443
  ufw allow proto udp from 104.16.0.0/13 to any port 80,443
  ufw allow proto udp from 104.24.0.0/14 to any port 80,443
  ufw allow proto udp from 172.64.0.0/13 to any port 80,443
  ufw allow proto udp from 131.0.72.0/22 to any port 80,443

  ufw allow proto tcp from 173.245.48.0/20 to any port 80,443
  ufw allow proto tcp from 103.21.244.0/22 to any port 80,443
  ufw allow proto tcp from 103.22.200.0/22 to any port 80,443
  ufw allow proto tcp from 103.31.4.0/22 to any port 80,443
  ufw allow proto tcp from 141.101.64.0/18 to any port 80,443
  ufw allow proto tcp from 108.162.192.0/18 to any port 80,443
  ufw allow proto tcp from 190.93.240.0/20 to any port 80,443
  ufw allow proto tcp from 188.114.96.0/20 to any port 80,443
  ufw allow proto tcp from 197.234.240.0/22 to any port 80,443
  ufw allow proto tcp from 198.41.128.0/17 to any port 80,443
  ufw allow proto tcp from 162.158.0.0/15 to any port 80,443
  ufw allow proto tcp from 104.16.0.0/13 to any port 80,443
  ufw allow proto tcp from 104.24.0.0/14 to any port 80,443
  ufw allow proto tcp from 172.64.0.0/13 to any port 80,443
  ufw allow proto tcp from 131.0.72.0/22 to any port 80,443

  # Deny any other traffic on ports 80 and 443
  ufw deny proto tcp to any port 80,443

  # Allow traffic on port 80
  ufw allow 80
  ufw allow 80/tcp
  ufw allow 80/udp

  # Allow traffic on port 443
  ufw allow 443
  ufw allow 443/tcp
  ufw allow 443/udp

  # Allow traffic on port 25 and 465 from specific IP
  ufw allow from 217.69.139.160 to any port 25,465

  # IPv6 rules
  ufw allow proto udp from 2400:cb00::/32 to any port 80,443
  ufw allow proto udp from 2606:4700::/32 to any port 80,443
  ufw allow proto udp from 2803:f800::/32 to any port 80,443
  ufw allow proto udp from 2405:b500::/32 to any port 80,443
  ufw allow proto udp from 2405:8100::/32 to any port 80,443
  ufw allow proto udp from 2a06:98c0::/29 to any port 80,443
  ufw allow proto udp from 2c0f:f248::/32 to any port 80,443

  ufw allow proto tcp from 2400:cb00::/32 to any port 80,443
  ufw allow proto tcp from 2606:4700::/32 to any port 80,443
  ufw allow proto tcp from 2803:f800::/32 to any port 80,443
  ufw allow proto tcp from 2405:b500::/32 to any port 80,443
  ufw allow proto tcp from 2405:8100::/32 to any port 80,443
  ufw allow proto tcp from 2a06:98c0::/29 to any port 80,443
  ufw allow proto tcp from 2c0f:f248::/32 to any port 80,443

  # Deny any other traffic on ports 80 and 443 for IPv6
  ufw deny proto tcp to any port 80,443

  # Allow traffic on port 80 for IPv6
  ufw allow 80/tcp
  ufw allow 80/udp

  # Allow traffic on port 443 for IPv6
  ufw allow 443/tcp
  ufw allow 443/udp

  # Allow outgoing traffic on ports 25 and 465 on eth0
  ufw allow out on eth0 proto tcp to any port 25,465
}

# User prompt for IP address
read -p "Enter your static IP address for SSH access (leave blank for dynamic IP): " user_ip

if [ -n "$user_ip" ]; then
  ufw allow from $user_ip to any port 22
  echo "SSH access allowed from IP $user_ip on port 22."
else
  echo "You did not enter a static IP address."
  echo "Warning: Dynamic IP addresses may change, affecting SSH access."
  echo "Check with your ISP for a static IP address."

  # Blocking port 22 for all if no static IP is provided
  ufw deny 22
  echo "Port 22 blocked for all incoming traffic. Enabling protection mode."
fi

# Apply the firewall rules
apply_rules

# Enable UFW
ufw enable

echo "Firewall configuration complete."
