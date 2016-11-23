/*
 * GuessTheNumber.c
 * 
 * Copyright 2016 Lemmin <lemmin@Acer-Kubuntu>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */

 
#include <unistd.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

#include <time.h>
#include <string.h>
#include <math.h>
#include <tgmath.h>
#ifndef GuessTheNumberGuard
#define GuessTheNumberGuard 
#define PortNumber 22222
#define defaultMaxValue 50
	int max(int a, int b){
		return ((a>b) ? a : b);
	}
	typedef struct{
		 char* endConnection;
		 char* newGame;
		 char* getAnswer;
		 char* getHelp;
	}commands;
	typedef struct {
		int numberToGuess;
		int numberOfTries;
		int lastGuessRelative;
		int endConnection;
		int maxValue;
	}gameValues;
	commands getCommands(){
		commands com;
		com.endConnection = "end\n";
		com.newGame = "newgame\n";
		com.getAnswer = "answer\n";
		com.getHelp = "help\n";
		return com;
	}
	int getRandomNumber(int maxValue){
		srand(time(NULL));
		int randomNum = rand() % maxValue +1;
		return randomNum;
	}
	gameValues getNewGame(int maxValue){
		gameValues newGame;
		newGame.numberOfTries = 0;
		newGame.lastGuessRelative = 1;
		newGame.numberToGuess = getRandomNumber(maxValue);
		newGame.endConnection = 0;
		newGame.maxValue = maxValue;
		return newGame;
	}
	
	gameValues tryGuess(gameValues game, int guess){
		
		if(guess < game.numberToGuess){
			game.numberOfTries++;
			game.lastGuessRelative = -1;
		}else if(guess >game.numberToGuess){
			game.numberOfTries++;
			game.lastGuessRelative = 1;
		}else{
			game.numberOfTries++;
			game.lastGuessRelative = 0;
		}
		return game;
	}

	
	

	
	char* intToString(int n){
		
		int length = log10(n)+1;
		char* buffer;
		buffer = (char *) malloc(length+1);
		snprintf(buffer,length+1,"%d",n);
		//printf("%s\n",buffer);
		return buffer;
		
		
		
	}
	int equalsIgnoreCase(char *a, char *b){
		for (int i=0;i<max(strlen(a),strlen(b));) {
			
			int d = tolower(*a) - tolower(*b);
			if (d != 0){
				return 0;
			}
			a++;
			b++;
		}
		return 1;
	}
	void readLine(char str[],int size){
		
		read(STDIN_FILENO, str, size);
		int len = strlen(str);
		printf("%d %d\n",len,size);
		if(len ==3){
			str[1] = '\0';
		}else if(len<size-1){
			str[len-1] ='\0';
			//str[len-1] ='\n';
		}else{
			str[size-1] = '\0';
			//str[size-1] = '\n';
		}
		
		//printf("%s",str);
		if(len>size){
			getchar();
		}
		
	}
	void parseInput(gameValues *game,char* str){
				commands com = getCommands();
				if(equalsIgnoreCase(str,com.endConnection)){
					sprintf(str,"Connection close\n");
					game->endConnection = 1;
				}else if(equalsIgnoreCase(str,com.getAnswer)){
					sprintf(str,"Answer was:%d\n to start a new game type %s\n",game->numberToGuess,com.newGame);
					game->lastGuessRelative = 0;	
				}else if(equalsIgnoreCase(str,com.getHelp)){
					sprintf(str,"Commands: \n End Connection: %s New Game: %s Get Answer: %s Get Help: %s\n",com.endConnection,com.newGame,com.getAnswer,com.getHelp);
				}else if(equalsIgnoreCase(str,com.newGame)){
					sprintf(str,"New Game Started! \n");
					*game = getNewGame(game->maxValue);
				}else{
					if(game->lastGuessRelative == 0){
						sprintf(str,"Game is over, to start a new game type %s",com.newGame); 
					}else{
						int guess = atoi(str);	
						if(guess<=0||guess>game->maxValue){
							sprintf(str,"Parsing error, make sure to type number in range [1,%d]\nTo see all commands type:%s",game->maxValue,com.getHelp);
						}else{
							*game = tryGuess(*game,atoi(str));
							switch(game->lastGuessRelative){
								case(0):
									sprintf(str,"YOU WON!\nYou made %d tries\n",game->numberOfTries);
									break;
								case(1):
									sprintf(str,"Too High! \n");
									break;
								case(-1):
									sprintf(str,"Too Low! \n");
									break;
							}
						}
					}
				}
			}
	
	

#endif


