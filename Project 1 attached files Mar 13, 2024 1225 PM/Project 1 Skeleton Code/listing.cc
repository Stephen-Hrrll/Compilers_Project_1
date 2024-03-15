// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the functions that produces the 
// compilation listing

#include <cstdio>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "listing.h"


static string error = "";
static int totalErrors = 0;
static int lineNumber;
static map<ErrorCategories, int> errorCounts; // Tracks counts of different error types
static vector<string> lineErrors; // Stores error messages for the current line

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

int lastLine() {
    displayErrors(); // Ensure remaining errors are displayed before the summary

    if (totalErrors > 0) {
        printf("Lexical Errors %d\n", errorCounts[LEXICAL]);
        printf("Syntax Errors %d\n", errorCounts[SYNTAX]);
        printf("Semantic Errors %d\n", errorCounts[GENERAL_SEMANTIC] + errorCounts[DUPLICATE_IDENTIFIER] + errorCounts[UNDECLARED]);
    } else {
        printf("Compiled Successfully\n");
    }
    
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
	lineErrors.push_back(messages[errorCategory] + message); // Add to line errors
    errorCounts[errorCategory]++; // Increment error count
}

void displayErrors() {
    for (const string& msg : lineErrors) {
        printf("%s\n", msg.c_str());
    }
    lineErrors.clear(); // Clear errors for the next line
}

