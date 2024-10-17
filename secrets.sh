cmd=$1

case "$cmd" in
encrypt)
    tar -cvO ./secrets | openssl enc -aes-256-cbc -pbkdf2 -salt -out secrets.tar.enc
    ;;
decrypt)
    openssl enc -d -aes-256-cbc -pbkdf2 -in secrets.tar.enc | tar xv
    ;;
*)
    echo "Usage: $0 encrypt | decrypt"
    ;;
esac
