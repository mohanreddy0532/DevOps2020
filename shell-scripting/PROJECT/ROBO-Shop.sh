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

	  echo -e "\e[1;32m >>>>>>>>>>>>>>>>>>>>>>> $2 <<<<<<<<<<<<<<<<<<<<\e[0m"	#Heading in Log file /tmp/project.log
      echo -e "\e[1;5;31m====>`date` = \e[0m \e[32m $1 : \e[36m $2 \e[0m"

}

MongoDB_F() {
Heading_F "MongoDB SetUp Start"
echo Installing MongoDB
echo Starting MongoDB
program_name=MongoDB
Print $program_name "Installing MongoDB"  #$1 Function
curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/mongodb/install.sh | bash &>>$LOG #Check LOG Variable for installation Logs
Print $program_name "Starting MongoDB"    #$2 Function

}

RabbitMQ_F () {
Heading_F "RabbitMQ SetUp Start"
echo Installing RabbitMQ
echo Starting RabbitMQ
program_name=RabbitMQ
Print $program_name "Installing RabbitMQ"
Print $program_name "Starting RabbitMQ"

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


