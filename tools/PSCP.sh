function pscp() {
    #Author Gaurav Sharma

    #Installation: add this function in .bash_profile and then source ~/.bash_profile

    #Usage:
    #Provide -f to copy from provided system to local
    #pscp -f batcave /home/brucewayne/myfile.info ~/Documents/
    #Provide -t to copy from local to provided system
    #pscp -t ~/Documents/myfile.info batcave /tmp

    proxyServer="damian@172.30.2.4"
    
    #######[Declare all the different servers reachable from proxyServer here]##########
      batcave="brucewayne@172.29.1.3"
    ####################################################################################
    
    option="$1"

    if [[ "$option" == "-t"   ]] && [[ "$3" != *"/"*  ]]
    then
        scp -oProxyJump="$proxyServer" "$2" ${!3}:"$4"
    elif [[ "$option" == "-f" ]] && [[ "$2" != *"/"* ]]
    then
        scp -oProxyJump="$proxyServer" ${!2}:"$3" "$4"
    else
         echo -e 'Usage:\n
        Provide -f to copy from provided system to local
                pscp -f payment /home/brucewayne/myfile.info ~/Documents/\n
        Provide -r to copy from local to provided system
                pscp -t ~/Documents/myfile.info uat /tmp'
    fi

}

pscp "$@"
