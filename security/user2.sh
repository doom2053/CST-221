#!/bin/bash

add_users()
{
	ROOT_UID=0      #The root user has a UID of 0
	if      [ "$UID" -ne "$ROOT_UID" ]; then
        	echo "****You must be the root user to run this script!****"
        	exit
	fi
	echo
	echo Identity Verified_You are the Root
	echo 

	echo -e "\n#########################################\n"
	echo -e "Please Select the Mode!!!\n"
	echo -e "1. Add the Users Manually\n
2.Read the Users Automatically  from Text File\n"
	echo -e "###########################################"
	read add_opt
	case $add_opt in
		1)
		echo -e "Please Enter the User name:"
		read usr_name
		echo -e "Please enter the User Group"
		read usr_group
		groupadd $usr_group
       	useradd -g $usr_group -m $usr_name
    	        echo -e "Please enter the Password for User $usr_name"
 	passwd $usr_name ;;
	2)
       echo
       echo "Present working directory is: `pwd`/users.txt"
       echo
       echo -e "Do you want to use the above Default PATH? Yes=1 & No=2"
       read yn
if [ $yn == 1 ]; then
                      Path=$($pwd)users.txt
else
       echo -n "Please enter the correct path to the file (e.g. /root/folder/filename.txt): "
       read Path
fi
if [ -e $Path ]; then           #If the file user specified exists
Username=lucky
num=1
	while  [ $Username != "EOF" ]
		do
		Username=`grep "Username00$num" $Path | cut -f2 -d:`   #Extract Username from text file
num=$(($num+1))
		Password=`grep "Password" $Path | cut -f2 -d:`       #Extract Password from text file
		Group=`grep "Group" $Path |cut -f2 -d:`              #Extract Group From text file 
		
		groupadd $Group		
		
		               #Adds user to the system and gives them a password
           if [ $Username == "EOF" ]; then
                   clear
                   main
           fi
                #Adds user to the system
                useradd -g $Group -m $Username 
                #Add users password
                echo $Password | /usr/bin/passwd --stdin $Username #user Password will be assigned
	done
else  #If the user Specified file doesn't Exists
	echo -e "\n#############################################"
	echo -e "\n######CANNOT FIND or LOCATE THE FILE!!!!#####"
	echo -e "\n#############################################"
fi;;
*) echo -e "You have selected the Wrong Choice!!!"
esac
        
}
varify()
{
	echo -e "#################################"
	echo -e "Please Select the Mode!!!\n"
	echo -e "1.Varify All the Users of System\n
2.Varify All the Users of TEXT file\n"
	echo -e "#################################"
	read varify_user
case $varify_user in
		1) cat /etc/passwd |grep bash;;
		2)
 	echo
        echo "Present working directory is: `pwd`/users.txt"
        echo
        echo -e "Do you want to use the above Default PATH? Yes=1 & No=2"
        read yn
if [ $yn == 1 ]; then
                     Path=$($pwd)users.txt
else
        echo -n "Please enter the correct path to the file (e.g. /root/folder/filename.txt): "
        read Path
fi
if [ -e $Path ]; then
	Path=$($pwd)users.txt
	varify=`grep "varify" $Path |cut -f2 -d:`
	  cat  /etc/passwd | grep $varify
  echo -e "\nYou have Currently "
          cat /etc/passwd | grep $varify |wc -l
	  echo  "users added from your Text file" 
else  #If the user Specified file doesn't Exists
      echo -e "\n#############################################"
      echo -e "\n######CANNOT FIND or LOCATE THE FILE!!!!#####"
      echo -e "\n#############################################"
fi ;;
*) echo -e "Wrong Choice"
esac
					 
}

del_users()
{
#This Script will delete the Users from the HOME DIRECTORY!!!!
ROOT_UID=0      #The root user has a UID of 0
	if      [ "$UID" -ne "$ROOT_UID" ]; then
        	echo "****You must be the root user to run this script!****"
        	exit
	fi
	echo
	echo Identity Verified_You are the Root
	echo
	
	echo
	echo "Present working directory is: `pwd`/students.txt"
	echo
	
#This is the Menu to select the mode to Deletion the users, either delete selected user or to delete all the users you have in the TEXT file...???
echo -e "####################################"
echo -e "\nPlease select the Mode!!!\n
1.Delete Specific User\n
2.Delete all Users Specified in the TEXT File\n"
echo -e "####################################"
read del_opt
case $del_opt in
	1)
		echo -e "\n\nYou have currently following USERS Added to your System\n"
		 cat  /etc/passwd |grep bash
		echo -e "\n\n Type the Name of the User you wants to Delete :"
		read user_name
		userdel -r $user_name ;;
	2) 
       echo
       echo "Present working directory is: `pwd`/users.txt"
       echo
       echo -e "Do you want to use the above Default PATH? Yes=1 & No=2"
       read yn
if [ $yn == 1 ]; then
       Path=$($pwd)users.txt
else
       echo -n "Please enter the correct path to the file (e.g. /root/folder/filename.txt): "
       read Path
fi
if [ -e $Path ]; then 		#If the file user specified exists
		num=1
Username=lucky		
		while  [ $Username != "EOF" ]
		do
		Username=`grep "Username00$num" $Path | cut -f2 -d:`   #Extract Username from text file
	
		if [ $Username == "EOF" ]; then
	    		clear
			main
		fi
				                       
                userdel -r $Username
num=$(($num+1))
	done
else  #If the user Specified file doesn't Exists
	echo -e "\n#############################################"
	echo -e "\n######CANNOT FIND or LOCATE THE FILE!!!!#####"
	echo -e "\n#############################################"
fi ;;
*) echo -e "Wrong Choice" 
esac
}

main()
{
	opt=1
while [ $opt -le 4 ]
do
	clear
echo -e "			### MENU ###\n 
			1. ADD USERS\n
			2. Varify Users\n
			3. Delete Users\n
			4. EXIT\n"
read opt
case $opt in
	1) add_users ;;
	2) varify ;;
	3) del_users ;;
	4) exit 0 ;;
	*) echo -e "You have Entered the Wrong Choice!!!"
esac
echo -e "\nWant to run Script Again Yes=1 & No=4."
read opt
done
}
main
exit 0
