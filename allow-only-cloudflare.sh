#!/bin/bash

# Устанавливаем политику по умолчанию для входящего и исходящего трафика
iptables -P INPUT DROP
ip6tables -P INPUT DROP
iptables -P FORWARD DROP
ip6tables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
ip6tables -P OUTPUT ACCEPT

# Разрешаем специфический трафик для указанных IPv4 IP-диапазонов и портов
iptables -A INPUT -s 173.245.48.0/20 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 103.21.244.0/22 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 103.22.200.0/22 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 103.31.4.0/22 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 141.101.64.0/18 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 108.162.192.0/18 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 190.93.240.0/20 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 188.114.96.0/20 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 197.234.240.0/22 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 198.41.128.0/17 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 162.158.0.0/15 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 104.16.0.0/13 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 104.24.0.0/14 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 172.64.0.0/13 -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A INPUT -s 131.0.72.0/22 -p tcp -m multiport --dports 80,443 -j ACCEPT


# Разрешаем специфический трафик для указанных IPv6 IP-диапазонов и портов
ip6tables -A INPUT -s 2400:cb00::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2606:4700::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2803:f800::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2405:b500::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2405:8100::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2a06:98c0::/29 -p tcp -m multiport --dports 80,443 -j ACCEPT
ip6tables -A INPUT -s 2c0f:f248::/32 -p tcp -m multiport --dports 80,443 -j ACCEPT

# Отбрасываем все остальные входящие соединения на портах 80 и 443 для IPv4 и IPv6
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j DROP
ip6tables -A INPUT -p tcp -m multiport --dports 80,443 -j DROP

# Записываем правила в журнал
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

echo "Правила iptables и ip6tables успешно применены."
