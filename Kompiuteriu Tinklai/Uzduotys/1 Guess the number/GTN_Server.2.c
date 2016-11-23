
#include <stdio.h>
#include <string.h>    
#include <stdlib.h>    


#include <sys/types.h> 
#include <sys/socket.h>
#include <arpa/inet.h> //inet_addr
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>    //write
#include <pthread.h> //for threading , link with lpthread

#include "GuessTheNumber.h"
 
//the thread function
void *connectionHandler(void *);

int endServer = 0; 
int main(int argc , char *argv[])
{
    int socket_desc , client_sock;
    //struct sockaddr_in server, client;
    struct sockaddr_storage clientAddr;
    socklen_t clientAddrSize;
    int yes = 1;
    struct addrinfo hints;
    struct addrinfo *res;  
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_UNSPEC;  // use IPv4 or IPv6, whichever
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_flags = AI_PASSIVE;     // fill in my IP for me
	
	getaddrinfo(NULL,"22222",&hints,&res);
	
	/* 
    
    socket_desc = socket(AF_INET , SOCK_STREAM , 0);
    if (socket_desc == -1){
        printf("Could not create socket");
    }
    */
    //Create socket
    socket_desc = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    
    puts("Socket created");
     
    //Prepare the sockaddr_in structure
    /*
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons( PortNumber );
     
    //Bind
    if( bind(socket_desc,(struct sockaddr *)&server , sizeof(server)) < 0)
    */
    if (setsockopt(socket_desc, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) == -1) {
            perror("setsockopt");
            exit(1);
        }
    if(bind(socket_desc,res->ai_addr,res->ai_addrlen)<0)
    {
        //print the error message
        perror("bind failed. Error");
        exit(1);
    }
    puts("bind done");
     
    //Listen
    listen(socket_desc , 10);
     /*
    puts("Waiting for incoming connections...");
    c = sizeof(struct sockaddr_in);
     */
     
    //Accept and incoming connection
    puts("Waiting for incoming connections...");
	pthread_t thread_id;
	//int threadCount = 0;	
		//while( (client_sock = accept(socket_desc, (struct sockaddr *)&client, (socklen_t*)&c)) )
		while(endServer ==0){
			if(endServer == 1){
				puts("BREAK");
				usleep(3000000);
				break;
				
			}else{
				//client_sock = accept(socket_desc, (struct sockaddr *)&client, (socklen_t*)&c);
				client_sock = accept(socket_desc, (struct sockaddr *)&clientAddr, &clientAddrSize);
					
				
				puts("Connection accepted");
				pthread_create( &thread_id , NULL ,  connectionHandler , (void*) &client_sock);
				pthread_detach(thread_id);
				puts("Handler assigned");
				/*
				if( pthread_create( &thread_id , NULL ,  connectionHandler , (void*) &client_sock) < 0)
				//if( pthread_create( &thread_id[threadCount] , NULL ,  connectionHandler( (void*) &client_sock,threadCount),(void*) &client_sock) < 0)
				{
					
					perror("could not create thread");
					return 1;
				}else{
					pthread_detach(thread_id);
				}
				*/
			}
			
		}
		
	close(client_sock);
    if(endServer == 1){
		puts("Server end");
	} 
    if (client_sock < 0)
    {
        perror("accept failed");
        return 1;
    }
     
    return 0;
}
 
/*
 * This will handle connection for each client
 * */
void *connectionHandler(void *socketDesc){
    //Get the socket descriptor
    int sock = *(int*)socketDesc;
    int readSize;
    char *message , messageBuffer[100];
     
    message = "Guess the number game\n";
    write(sock, message, strlen(message));
    
    gameValues game = getNewGame(defaultMaxValue);
    readSize = 1;
    //Receive a message from client
	//while( (read_size = recv(sock , client_message , 2000 , 0)) > 0 ){
	
	do{	
        bzero(messageBuffer,100);
        readSize = recv(sock,messageBuffer,100,0);
        printf("At Recieved: %s\n",messageBuffer);
        if(equalsIgnoreCase(messageBuffer,"endserver\n")==1){
			endServer = 1;
			parseInput(&game,"end\n");
		}else{
			parseInput(&game,messageBuffer);
		}
        write(sock,messageBuffer,strlen(messageBuffer));
    }while(((game.endConnection == 0) && readSize >0)&& endServer == 0);
     
    if(readSize == 0){
        puts("Client disconnected");
        fflush(stdout);
    } else if(readSize == -1) {
        perror("recv failed");
    }
    if(game.endConnection == 1){
		puts("Client disconnected by command");
	}
	shutdown(sock, SHUT_WR);
	close(sock);
    return NULL;
} 
