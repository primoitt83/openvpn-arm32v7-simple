#!/bin/bash
## Gen certs
easyrsa --batch clean-all
easyrsa --batch --req-cn=NAME build-ca nopass
easyrsa --batch build-client-full server nopass
easyrsa --batch build-client-full client nopass
easyrsa gen-dh nopass
easyrsa gen-crl
openvpn --genkey secret /etc/openvpn/pki/ta.key

# copy files
cp /etc/openvpn/pki/private/server.key /etc/openvpn/pki/server.key
cp /etc/openvpn/pki/issued/server.crt /etc/openvpn/pki/server.crt
cp /etc/openvpn/pki/private/client.key /etc/openvpn/pki/client.key
cp /etc/openvpn/pki/issued/client.crt /etc/openvpn/pki/client.crt