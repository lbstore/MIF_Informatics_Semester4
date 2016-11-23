/*
 * testMethods.c
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
#include <string.h>
#include "GuessTheNumber.h"


int main(int argc, char **argv)
{	
	  //char* str1 = "strRs1";
	 //char* str2 = "st";
	 char str[10];
	//printf("%d",strcicmp(str1,str2));
	//printf("%d",equalsIgnoreCase("strrr","strrR"));
	printf("Result %s\n",strcat(intToString(1212),"str"));
	//printf("Result %s\n",strcat("str",intToString(1212)));
	readLine(str,sizeof(str));
	printf("<%s>",str);
	
	return 0;
}

