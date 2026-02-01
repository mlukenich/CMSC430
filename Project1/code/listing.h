// CMSC 430 Compiler Theory and Design
// Project 1 - Lexical Analyzer
// Author: Matthew Lukenich
// Class: CMSC430
// UMGC CITE
//
// Function prototypes for the compilation listing module

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
    UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

