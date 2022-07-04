# Script variables. ################################################################################
FTP_USER="freebox"
FTP_DIR="/Nemesis/bibliography/"
FTP_HOST="jvanhare.freeboxos.fr"
FTP_PORT="5273"

# Upload the bibliography to the ftp server. #######################################################
upload_bibliography() {
    read -rs 'PASSWORD?Enter the host password: '
    echo ""
    for FILE in $PWD/pdf/*.pdf; do
        F=$(basename "$FILE")
        echo "Uploading $FILE to $FTP_DIR$F"
        curl -S -s -T $FILE -u $FTP_USER:$PASSWORD ftp://$FTP_HOST:$FTP_PORT$FTP_DIR$F --ftp-ssl
    done
}
# Download the bibliography from the ftp server. ###################################################
download_bibliography() {
    read -rs 'PASSWORD?Enter the host password: '
    echo ""
    for FILE in $(curl -s -l -u $FTP_USER:$PASSWORD ftp://$FTP_HOST:$FTP_PORT$FTP_DIR --ftp-ssl); do
        if [[ $FILE == *.pdf ]] then
            echo "Downloading $FTP_DIR$FILE to pdf/$FILE"
            curl -S -s -u $FTP_USER:$PASSWORD ftp://$FTP_HOST:$FTP_PORT$FTP_DIR$FILE -o pdf/$FILE --ftp-ssl
        fi
    done
}
