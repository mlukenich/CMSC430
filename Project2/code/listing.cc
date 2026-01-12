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
static string errorBuffer = "";
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

static void displayErrors();

void firstLine()
{
    lineNumber = 1;
    printf("\n%4d  ",lineNumber);
}

void nextLine()
{
    displayErrors();
    lineNumber++;
    printf("%4d  ",lineNumber);
}

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

void displayErrors()
{
    if (errorBuffer != "")
        printf("%s\n", errorBuffer.c_str());
    errorBuffer = "";
}
