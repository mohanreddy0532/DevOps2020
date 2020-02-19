##ROBO-Shop Application 
##Author : Mohan 

##VARIABLES
LOG=/tmp/project.log
touch $LOG              
mv $LOG $LOG-$RANDOM  #moving old log to Random file before creating a new one.

##Functions
Heading_F() {
  
       echo -e "\n\e[1;34m>>>>>>>>>>>>>>>>>  \e[1;4m $1 \e[0m  \e[1;34m<<<<<<<<<<<<<<<<<<<\e[0m"

}


Print () {

	  echo -e "\e[1;35m >>>>>>>>>>>>>>>>>>>>>>> $2 <<<<<<<<<<<<<<<<<<<<\e[0m"	#Heading in Log file /tmp/project.log
      echo -e "\e[1;5;31m====>\e[0m `date` = \e[0m \e[32m $1 : \e[36m $2 \e[0m"

}

Stat() 	{						####To Check MongoDB installation Status

		case $1 in
			0)
				echo -e "\e[32m  ==> $program_name:  $2 is Succssful \e[0" 
				;;
			*)  
				echo -e "\e[32m  ==> $program_name:  $2 is FAILED  \e[0" 		
				echo -e "\n\e[32m Check the LOG File errors ::: LOG-FILE = $LOG " 
				;;
		esac

		}

MongoDB_F() {
	## All steps for MongoDB Install
	Heading_F "MongoDB SetUp Start"
	program_name=MongoDB
	Print $program_name "Installing MongoDB"  #$1 Function
	curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/mongodb/install.sh | bash &>>$LOG #Check LOG Variable for installation Logs
	Stat $? "Install of MongoDB"       ####To Check MongoDB installation Status called Function
	Print $program_name "Starting $program_name"    #$2 Function
	systemctl enable mongod &>>$LOG
	systemctl start mongod  &>>$LOG
	Stat $?  "Starting MongoDB Service"       ####To Check MongoDB start Status called Function

}

RabbitMQ_F () {
	Heading_F "RabbitMQ Setup"
    ## All steps for RabbitmQ Install
    program_name=RabbitMQ
    Print $program_name "Installing $program_name"
    curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/rabbitmq/install.sh | bash &>>$LOG #Check LOG Variable for installation Logs
    Stat $? "Installation of $program_name"
    Print $program_name "Starting $program_name"
    systemctl enable rabbitmq-server &>>$LOG
    systemctl start rabbitmq-server &>>$LOG
    Stat $? "Starting $program_name Service"    ####To Check MongoDB start Status called Function
}


#Redis
#MySQL
#Cart
#Catalogue
#Dispatch
#USer
#Web

##Main Program
MongoDB_F
RabbitMQ_F


