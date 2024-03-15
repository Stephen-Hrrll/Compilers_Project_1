// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the functions that produces the 
// compilation listing

#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{//called when a comment or new line character is encountered
	displayErrors();//display any errors that may have occurred on the previous line
	lineNumber++;
	printf("%4d  ",lineNumber);//
}

int lastLine()
{//called in scanner.l.main after repeated calls to yylex
	printf("\r");//
	displayErrors();//
	printf("     \n");//removes the line number that the last call to nexLine() created
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{//called when lexical errors occur, also used for all future compilation errors\
//labels the error with its type saves it so it can be displayed on the next call to displayErrors
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate ",
		"Semantic Error, Undeclared " };

	error = messages[errorCategory] + message;
	totalErrors++;
}

void displayErrors()
{//called at the end of each line to display any errors that may have occurred
	if (error != "")
		printf("%s\n", error.c_str());
	error = "";
}
