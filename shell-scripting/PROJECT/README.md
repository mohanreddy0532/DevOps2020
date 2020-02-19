ROBO-Shop Project Start:
------------------------------D45-2020-02-13-SESSION-20 @50Mins------------------------------
Creare a HEAD() funstion for Title: Mango DB and RabbitMQ

$1=First argument to the Function.

echo -e "\n\e[1;34m>>>>>>>>>>>>>>>>>  \e[1;4;5m $1 \e[0m  \e[1;34m<<<<<<<<<<<<<<<<<<<\e[0m"

-e=-e option of the echo command enable the parsing of the escape sequences.
\n=Next line
\e=\e[0m” sequence removes all attributes (formatting and colors). It can be a good idea to add it at the end of each colored text. ;)
1m=Bold
34m=Blue Colour
4m=Underline
5m=Blink
------------------------------D45-2020-02-13-SESSION-20 @1:17:00Mins------------------------------
Create MongoDB & RabbitMQ Functions
MongoDB_F
RabbitMQ_F
------------------------------
Print () {     echo -e "\e[1;5m====> \e[0m $1 \e[1;0m: $2 \e[0m"  }

$1=First argument to the Function.
$2=Second argument to the Function.

>>>>>>>>>>>>>>>>>   MongoDB SetUp Start   <<<<<<<<<<<<<<<<<<<
Installing MongoDB
Starting MongoDB
====>  MongoDB : Installing MongoDB 
====>  MongoDB : Starting MongoDB 
======================================================================================================================================
-------------------------------------D45-2020-02-14-SESSION-21-----@7:00Mins------------------------------------------
Installing MongoDB:

curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/mongodb/install.sh | bash & >> $LOG #Check LOG Variable for installation Logs
Get RAW installation script from Linuxautomations.
Create a LOG varibale for installation Logs.

##VARIABLES
LOG=/tmp/project.log
touch $LOG              
mv $LOG $LOG-$RANDOM  #moving old log to Random file before creating a new one.

Create a Heading in Log file under Print Function:
echo -e "\e[1;32m >>>>>>>>>>>>>>>>>>>>>>> $2 <<<<<<<<<<<<<<<<<<<<\e[0m"	#Heading in Log file /tmp/project.log
---------------------------
Create a Stat Function for checking  MongoDB installation Status
Stat() 	{						####To Check MongoDB installation Status

		case $1 in
			0)
				echo -e "\e[32m  ==> $program_name:  $2 is Succssful " 
				;;
			*)  
				echo -e "\e[32m  ==> $program_name:  $2 is FAILED" 		
				echo -e "\n\e[32m Check the LOG File errors ::: LOG-FILE = $LOG " 
				;;
		esac

		}
----------------------------------------
Start MongoDB Service;
systemctl enable mongod &>>$LOG    #Case sensitive
systemctl start mongod  &>>$LOG
Stat $?  "Starting MongoDB Service"       ####To Check MongoDB start Status called Function

-----------------
Installing RabbitMQ:

curl -s https://raw.githubusercontent.com/linuxautomations/labautomation/master/tools/rabbitmq/install.sh | bash &>>$LOG #Check LOG Variable for installation Logs
Get RAW installation script from Linuxautomations.
Create a LOG varibale for installation Logs.

Start RabbitMQ Service;
    systemctl enable rabbitmq-server &>>$LOG
    systemctl start rabbitmq-server &>>$LOG
    Stat $? "Starting $program_name Service"