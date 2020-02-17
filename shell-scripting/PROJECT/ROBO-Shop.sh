##ROBO-Shop Application 
##Author : Mohan 


##Functions

Heading_F() {
  
       echo -e "\n\e[1;34m>>>>>>>>>>>>>>>>>  \e[1;4m $1 \e[0m  \e[1;34m<<<<<<<<<<<<<<<<<<<\e[0m"

}


Print () {

      echo -e "\e[1;5m====> \e[0m $1 \e[1;0m: $2 \e[0m"

}

MongoDB_F() {
Heading_F "MongoDB SetUp Start"
echo Installing MongoDB
echo Starting MongoDB
program_name=MongoDB
Print $program_name "Installing MongoDB"
Print $program_name "Starting MongoDB"

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