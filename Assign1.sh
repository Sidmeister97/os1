count=3310


while :
do
    echo "\n1.Create Address Book\n2.View Address Book\n3.Insert a record\n4.Delete a record\n5.Modify a record\n6.Search a record\n7.Exit\nEnter the choice = "
    read ch

    case $ch in
      1) echo "Enter the name for the Address Book(ex. abc.txt):- "
         read name
         file=$name    #variable containg file name

         echo "Sr.No.\t|Name\t|Address\t|Mobile Number  |" > $file
	 if [ ! -e $file ] ; then
	 echo " File does not exists "
	 elif [ ! -r $file ] ; then
	 echo " File is not readable "
	 elif [ ! -w $file ] ; then
	 echo " File is not writable "
	 else
	 echo "Address Book created successfully!!!"
	 fi
         ;;

      2) echo "Database"
	 cat $file    #For display
         ;;

      3) count=$((count+1))
         echo "Enter the Name:- "
         read name
         echo "Enter the Address:- "
         read add
	    echo "Enter mobile number:- "
	    read num
         echo $count"\t|"$name"\t|"$add"\t\t|"$num"\t|">> $file
	   `sort -n -o $file $file`         
	;;

      4) echo "Enter the id to delete from book:- "
         read name
          #command to delete specific line from file
	 	# -v selects all lines which do not contain pattern and move it to temp file
	 	#and mv moves temp file to $file

         `grep -v $name $file > temp && mv temp $file`      
         ;;

      5) echo "Enter the id to modify = "
	 read modify

	 if grep $modify $file
	 then
		 echo "Enter the parameter you want to update:-\n1.Name\n2.Address\n3.Mobile Number\n"
		 read para

		 if [ $para -eq 1 ]
		 then
			# grep finds the specific line in file and cut finds the specific word in that line

			replace=`grep $modify $file | cut -d "|" -f 2`
			echo $replace
			echo "Enter Name = "
			read name	
			#sed replaces first word by second word in file						
			`sed -i "s/$replace/$name/1" $file`
		 
		 elif [ $para -eq 2 ]
		 then
			replace=`grep $modify $file | cut -d "|" -f 3`
			echo $replace
			echo "Enter address = "
			read address							
			`sed -i "s/$replace/$address/1" $file`	
	
		 elif [ $para -eq 3 ]
		 then
			replace=`grep $modify $file | cut -d "|" -f 4`
			echo $replace
			echo "Enter mobile number = "
			read num							
			`sed -i "s/$replace/$num/" $file`	
		 fi

		 echo "The Database has been modified successfully!!!"
	 else	
		 echo "Data not found!!!"
	 fi         
	;;

      6) echo "Enter the id to serach:- "
	 read name
	 #grep finds the line containing name in the file
	 echo `grep $name $file`
	 ;;

      7) echo "Exited successfully!!!\nThank You."
         break 
         ;;
    esac
done
