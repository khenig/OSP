#!/bin/bash
choice=0

while [ $choice -le 8 ]

do
	echo -e "---------------------------------"
	echo "User Name: Khen Igor Robertovich"
	echo "Student Number: 12204398"
	echo "[ MENU ]"
	echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
	echo "2. Get the data of action genre movies from 'u.item’"
	echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’"
	echo "4. Delete the ‘IMDb URL’ from ‘u.item"
	echo "5. Get the data about users from 'u.user’"
	echo "6. Modify the format of 'release date' in 'u.item’"
	echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
	echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
	echo "9. Exit"
	echo "--------------------------"
	echo "Enter your choice [ 1-9 ]"
	read choice

	case $choice in
		1*)
			echo
			echo "Please enter 'movie id' (1~1682) : "
			read mID
			echo
			cat u.item | awk -F'|' -v a=$mID 'NR==a { print }'
			;;
		2*)
			echo
			echo "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) : "
			read ans
			echo
			if [ $ans == "y" ]
			then
				cat u.item | awk -F'|' -v idx=1 '$7 == "1" && idx < 11 { print $1, $2; idx++ }'
			else
				continue
			fi
			;;
		3*)
			echo
			echo "Please enter 'movie id' (1~1682) : "
			read mID
			echo
			cat u.data | awk -v a=$mID -v total=0 -v count=0 '$2 == a { total = total + $3; count++ } END { print "average raiting of " a ": " total/count }'
			;;
		4*)
			echo
			echo "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n)"
			read ans
			echo
			if [ $ans == "y" ]
			then
				cat u.item | awk -F'|' '{ OFS = "|"; $5 = ""; print } NR==10{exit}'
			else
				continue
			fi
			;;
		5*)
			echo
			echo "Do you want to get the data about users from 'u.user'?(y/n) : "
			read ans
			echo
			if [ $ans == "y" ]
			then
				cat u.user | awk -F'|' '{ print "user " $1 " is " $2 " years old " $3 " " $4 } NR==10{exit}'
			else
				continue
			fi
			;;
		6*)
			echo
			echo "Do you want to Modify the format of 'release data' in 'u.item'?(y/n) : "
			read ans
			if [ $ans == "y" ]
			then
				tail -10 u.item | sed 's/|/\n/g' | sed -E '3s/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/\3\/2\/\1/'
			else
				continue
			fi
			;;
		7*)
			echo
			echo "Please enter the 'user id'(1~943) : "
			read uID
			echo
			cat u.data | awk -v a=$uID '$1 == a { printf $2 "|"}' | sort -n -t '|' 
			echo
			;;

	esac
done 
