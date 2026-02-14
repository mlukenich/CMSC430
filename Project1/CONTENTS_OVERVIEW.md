# Project1 comprehension notes

This document summarizes the **skeleton code**, **test data**, **requirements**, and **recommended approach** for CMSC 430 Project 1.

## 1) Skeleton code understanding (`Project1-skeleton-code/`)

The starter implementation is a baseline lexical analyzer with minimal token coverage.

### Core files and responsibilities
- `scanner.l`
  - Defines basic lexeme classes: whitespace, `//` comments, identifiers (`[A-Za-z][A-Za-z0-9]*`), decimal integers, character literals (`'.'`), and punctuation (`() , : ;`).
  - Supports a small operator/keyword set (`+`, `*`, `&`, `<`, `=>`, `begin`, `case`, `character`, `end`, `endswitch`, `function`, `integer`, `is`, `list`, `of`, `others`, `returns`, `switch`, `when`).
  - Reports unmatched characters with `appendError(LEXICAL, yytext)`.
  - Writes token/lexeme pairs to `lexemes.txt` while echoing source lines.
- `tokens.h`
  - Declares the initial `enum Tokens` used by scanner rules.
- `listing.h` / `listing.cc`
  - Provide listing support (`firstLine`, `nextLine`, `lastLine`, `appendError`).
  - Skeleton behavior tracks only a single cumulative `totalErrors`, and only one buffered error string at a time.
- `makefile`
  - Uses `flex` to generate `scanner.c`, compiles objects with `g++`, links executable `compile`.

### What the skeleton does *not* yet cover
Compared with project requirements, the skeleton lacks:
- many reserved words,
- new logical/arithmetic operators,
- expanded relational operators,
- `--` comments,
- underscore-aware identifier constraints,
- hex and real literals,
- escape-aware character literal updates,
- per-category error counters and multi-error-per-line display behavior.

## 2) Project requirements understanding (`Project 1 Requirements (1).pdf`)

The requirements ask for extending lexer behavior and listing/error reporting in two groups.

### A. Required lexer/token changes (`scanner.l` + `tokens.h`)
1. Add reserved words/tokens: `else`, `elsif`, `endfold`, `endif`, `fold`, `if`, `left`, `real`, `right`, `then`.
2. Add logical operators: `| -> OROP`, `! -> NOTOP`.
3. Add relational lexemes (all map to `RELOP`): `=`, `<>`, `>`, `>=`, `<=`.
4. Add subtraction `-` under `ADDOP`.
5. Add division `/` under `MULOP`.
6. Add remainder operator `% -> REMOP`.
7. Add exponent operator `^ -> EXPOP`.
8. Add unary negation operator `~ -> NEGOP`.
9. Add comment form `--` to end-of-line (ignored token-wise, but line-counted).
10. Update identifier rule to allow underscores with constraints:
   - no leading underscore,
   - no trailing underscore,
   - no more than two consecutive underscores.
11. Add hexadecimal integer literal form beginning with `#` followed by hex digits.
12. Add real literal form with decimal point and optional exponent (`e|E`, optional sign, digits).
13. Update character literal to allow escape-character forms (including `\b`, `\t`, `\n`, `\r`, `\f` among allowed escaped forms).

### B. Required listing generator changes (`listing.cc`)
1. `lastLine` must report either:
   - `Compiled Successfully` when no errors, or
   - counts for lexical/syntax/semantic errors when errors exist.
2. `appendError` must:
   - increment category counters,
   - queue all messages occurring on a line (not just one).
3. `displayErrors` must print all queued messages for previous line and clear queue.

### Deliverables required by assignment
- Source `.zip` including `.l`, `.cc`, `.h`, and a working `makefile`.
- Documentation file discussing:
  - implementation approach,
  - test plan and screenshots,
  - lessons learned/improvements.

## 3) Recommended approach understanding (`Project 1 Approach (1).pdf`)

The provided approach recommends this implementation sequence:

1. Build and run the skeleton first (using `test1.txt` to `test3.txt`) and inspect `lexemes.txt`.
2. Add new reserved words + token enum entries; validate with `test4.txt`.
3. Add new operators + token enum entries; validate with `test5.txt`.
4. Add remaining lexical features (new comment style, identifier/char literal updates, real + hex literals); validate with `test6.txt`.
5. Update listing functions for full error accounting/message queuing; validate multi-error behavior using `test7.txt`.
6. Run comprehensive coverage test (`test8.txt`) and verify both:
   - lexical error behavior,
   - token mapping in `lexemes.txt` (allowing token-number ordering differences).

This staged order mirrors increasing complexity and makes debugging easier by isolating each requirement group.

## 4) Test data understanding (`project1-test-data/` + `testOutput/`)

The supplied tests intentionally map to requirement groups:

- `test1.txt`: simple arithmetic function expected to compile with no lexical errors.
- `test2.txt`: single illegal character (`$`) to confirm lexical error reporting.
- `test3.txt`: baseline punctuation/operator/keyword/identifier/literal smoke test.
- `test4.txt`: reserved-word-heavy program including newly added control-flow words.
- `test5.txt`: operator coverage (`| ! = <> > >= <= - / % ^ ~`) in realistic expressions.
- `test6.txt`: new comment style, underscore identifier variants, real literals, hex literals, escaped char literals.
- `test7.txt`: two invalid characters on one line to verify multi-error-per-line output.
- `test8.txt`: broad final integration test with valid/invalid identifiers and full token-family coverage.

The corresponding `testOutput/*.txt` files represent expected listing/error behavior and are best used as regression or comparison outputs after each milestone.

## 5) Current implemented solution (`code/`) in relation to requirements

The implemented `code/` scanner/listing appears aligned with the requirements and staged approach:
- Added reserved words/tokens and new operators,
- added `--` comments,
- expanded identifier, numeric, and character literal regexes,
- upgraded listing to separate lexical/syntax/semantic counters and buffered multi-error line output,
- includes tests and expected outputs matching staged validation strategy.

In short, `Project1` contains both:
- the pedagogical starter (`Project1-skeleton-code`), and
- an evolved solution (`code`) that follows the assignment’s required feature expansion path.
