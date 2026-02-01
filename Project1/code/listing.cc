// CMSC 430 Compiler Theory and Design
// Project 1 - Lexical Analyzer
// Author: Matthew Lukenich
// Class: CMSC430
// UMGC CITE
//
// This file contains the bodies of the functions that produce the 
// compilation listing with line numbers and error reporting.

#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"

static int lineNumber;
static string errorBuffer = "";
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

static void displayErrors();

// Initializes the listing by printing the first line number
void firstLine()
{
    lineNumber = 1;
    printf("\n%4d  ",lineNumber);
}

// Displays any errors for the current line and advances to the next line
void nextLine()
{
    displayErrors();
    lineNumber++;
    printf("%4d  ",lineNumber);
}

// Finalizes the listing and prints error summary or success message
int lastLine()
{
    printf("\r");
    displayErrors();
    printf("     \n");

    int totalErrors = lexicalErrors + syntaxErrors + semanticErrors;

    if (totalErrors == 0)
    {
        printf("Compiled Successfully\n");
    }
    else
    {
        printf("Lexical Errors %d\n", lexicalErrors);
        printf("Syntax Errors %d\n", syntaxErrors);
        printf("Semantic Errors %d\n", semanticErrors);
    }
    
    return totalErrors;
}
    
// Appends an error message to the buffer and increments the appropriate counter
void appendError(ErrorCategories errorCategory, string message)
{
    string messages[] = { "Lexical Error, Invalid Character ", "",
        "Semantic Error, ", "Semantic Error, Duplicate ",
        "Semantic Error, Undeclared " };

    // Append newline if buffer is not empty so multiple errors appear on separate lines
    if (errorBuffer != "") {
        errorBuffer += "\n";
    }

    errorBuffer += messages[errorCategory] + message;

    // Increment specific error counters
    if (errorCategory == LEXICAL) {
        lexicalErrors++;
    } else if (errorCategory == SYNTAX) {
        syntaxErrors++;
    } else {
        semanticErrors++;
    }
}

// Outputs buffered errors and clears the buffer
void displayErrors()
{
    if (errorBuffer != "")
        printf("%s\n", errorBuffer.c_str());
    errorBuffer = "";
}