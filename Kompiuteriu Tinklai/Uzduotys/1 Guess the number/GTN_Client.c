#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h> 

#include "GuessTheNumber.h" 
int main(int argc,char **argv)
{
	printf("Client init\n");
	
    const int sendBuffSize = 15;
    const int readBuffSize = 100;
    char sendLine[sendBuffSize];
    char recvLine[readBuffSize];
    
    
    
    char* connectTo = "127.0.0.1";//localHost
	//connectTo = "192.168.1.67";		//ip namuose
	//connectTo = "172.24.1.31"; // dabartinis ip
	
    int sockfd;
    struct sockaddr_in servaddr;
	
    sockfd=socket(AF_INET,SOCK_STREAM,0);
    bzero(&servaddr,sizeof servaddr);
    
  // getaddrinfo
    servaddr.sin_family=AF_INET;
    servaddr.sin_port=htons(PortNumber);
    inet_pton(AF_INET,connectTo,&(servaddr.sin_addr)); 
    int connectionResponse;
	do{
		//convert IPv4 and IPv6 addresses from text to binary form
		printf("Connecting\n");
		connectionResponse = connect(sockfd,(struct sockaddr *)&servaddr,sizeof(servaddr)); //initiate a connection on a socket
		
		printf("Getting response...\n");
		
		//bzero(recvLine,readBuffSize);
		
		usleep(1500000);
		
	}while(connectionResponse<0);

		printf("Connected!\n");
		read(sockfd,recvLine,readBuffSize);
		printf("%s",recvLine);
		int bytes = 0;
		int serverClosed = 0;
    do{
        bzero( sendLine, sendBuffSize);
        bzero( recvLine, readBuffSize);
		fgets(sendLine,sendBuffSize,stdin);
        bytes = write(sockfd,sendLine,strlen(sendLine)+1); 	//send to server
        bytes = read(sockfd,recvLine,readBuffSize);	//get response	
        if(bytes ==0){
			serverClosed = 1;
		}	
        printf("%s",recvLine);
        
        if(equalsIgnoreCase(recvLine,"Connection close\n")||bytes ==0){
			serverClosed = 1;
		}
		
    }while(1!=serverClosed);
    shutdown(sockfd, SHUT_WR);
    close(sockfd);
    return 0;
}
 
