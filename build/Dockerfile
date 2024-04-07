FROM arm32v7/alpine:3.19.1 

RUN \
    # Add edge/testing for: pamtester
    # echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && \
    apk add openvpn iptables bash easy-rsa && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

## needed by easyrsa
ENV OPENVPN=/etc/openvpn
ENV EASYRSA=/usr/share/easy-rsa \
    EASYRSA_REQ_COUNTRY="BR" \
    EASYRSA_REQ_PROVINCE="Goias" \
    EASYRSA_REQ_CITY="Goiania" \
    EASYRSA_REQ_ORG="Itt CopyLeft" \
    EASYRSA_REQ_EMAIL="primoitt@email.com" \
    EASYRSA_REQ_OU="Itt Company" \
    EASYRSA_KEY_SIZE=2048 \
    EASYRSA_CA_EXPIRE=3650 \
    EASYRSA_CERT_EXPIRE=3650 \
    EASYRSA_CRL_DAYS=3650 \    
    EASYRSA_PKI=$OPENVPN/pki

## Copy and run easy-rsa
COPY ${PWD}/easyrsa.sh /
RUN chmod +x /easyrsa.sh && /easyrsa.sh    

## Copy openvpn-bridge
COPY ${PWD}/openvpn-bridge /usr/local/bin/openvpn-bridge
RUN chmod 744 /usr/local/bin/openvpn-bridge

## Copy and create files
RUN mkdir -p /config
COPY ${PWD}/openvpn.conf /etc/openvpn/openvpn.conf
COPY ${PWD}/openvpn.conf /config/openvpn.conf
COPY ${PWD}/ovpn.sh /etc/openvpn/pki/ovpn.sh

## Copy entrypoint.sh
COPY ${PWD}/entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/etc/openvpn"]

EXPOSE 1194

ENTRYPOINT ["/entrypoint.sh"]