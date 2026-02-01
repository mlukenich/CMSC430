// CMSC 430 Compiler Theory and Design
// Project 1 - Lexical Analyzer
// Author: Matthew Lukenich
// Class: CMSC430
// UMGC CITE
//
// Token definitions for the lexical analyzer

enum Tokens {
    ADDOP = 256, MULOP, ANDOP, RELOP, ARROW, 
    BEGIN_, CASE, CHARACTER, END, ENDSWITCH, 
    FUNCTION, INTEGER, IS, LIST, OF, OTHERS, 
    RETURNS, SWITCH, WHEN, 
    // New Reserved Words
    ELSE, ELSIF, ENDFOLD, ENDIF, FOLD, 
    IF, LEFT, REAL, RIGHT, THEN,
    // New Operators
    OROP, NOTOP, REMOP, EXPOP, NEGOP,
    // Literals
    IDENTIFIER, INT_LITERAL, REAL_LITERAL, CHAR_LITERAL
};
