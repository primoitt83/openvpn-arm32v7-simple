#!/bin/sh
#
# Generates profile.ovpn file
# Customizado para o Openwrt 18.06 por primoitt

help(){
    	cat >&2 <<EOF
Generates a profile.ovpn

Usage:

$0 client-name [server-address:port]

EOF
    	exit 1
}

CLIENT=${1:?$(help)}
SERVER_ADDR=${2:?$(help)}
EASY_DIR=$(pwd)

for F in ${CLIENT}.crt ${CLIENT}.key ca.crt; do
    	if ! [ -f "$EASY_DIR/$F" ]; then
            	echo "File '$EASY_DIR/$F' does not exist"
            	exit 1
    	fi
done

cat <<EOF
client
dev tun
proto udp
sndbuf 0
rcvbuf 0
remote-cert-tls server
remote $(echo "$SERVER_ADDR"| cut -d: -f1) $(echo "$SERVER_ADDR" | cut -d: -f2)
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
tls-auth ta.key 1
auth SHA256
cipher AES-256-CBC
setenv opt block-outside-dns
key-direction 1
verb 3
<ca>
$(cat "$EASY_DIR/ca.crt")
</ca>
<cert>
$(cat "$EASY_DIR/${CLIENT}.crt")
</cert>
<key>
$(cat "$EASY_DIR/${CLIENT}.key")
</key>
<tls-auth>
$(cat "$EASY_DIR/ta.key")
</tls-auth>
EOF