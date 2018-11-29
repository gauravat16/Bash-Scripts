
	#To add a new option add entry in both case statements
	#We look through the options as we can have multiple options

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
			prev_option=""	
				;;
			"-d" )
				option_array+=("$option")
				prev_option=""	
				;;
			"-g" )

				option_array_2+=("$option")			
				prev_option=""	
				;;

		esac

		case $option in
			"-t" )
				prev_option="-t"

				;;


			"-d" )
				prev_option="-d"
				;;

			"-g" )
				prev_option="-g"
				;;

		esac
	done

	}
