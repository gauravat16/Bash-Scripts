#Example
OPTION_1=""
option_array[0]="1"
option_array[1]="2"

options="$@"


set_options(){
    prev_option=""
    
    for option in $options;
    do
        case $prev_option in
            "-t" )
                OPTION_1=$option
            ;;
            "-d" )
                option_array+=("$option")
            ;;
            "-g" )
                
                option_array_2+=("$option")
            ;;
            
        esac
        
        prev_option="$option"
        
    done
    
}

function test()
{
	set_options

	echo $OPTION_1
	echo ${option_array[*]}
	echo ${option_array_2[*]}
	
}


test