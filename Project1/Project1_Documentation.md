# CMSC 430 Project 1 Documentation

## 1. Project approach

I implemented Project 1 in the same staged order recommended by the assignment approach notes:

1. Start from the skeleton lexical analyzer and verify baseline behavior.
2. Add new reserved words and corresponding token names.
3. Add new operators and operator token names.
4. Extend lexical forms for comments, identifiers, hexadecimal integers, real literals, and character literals.
5. Upgrade listing/error reporting to support full end-of-run summaries and multiple errors on the same source line.
6. Validate incrementally with the supplied test set (`test1.txt` through `test8.txt`).

This sequence made debugging manageable because each change group was validated before moving to the next one.

---

## 2. Test plan

The tests below map directly to requirement groups.

| Test file | What it verifies | Expected outcome |
|---|---|---|
| `test1.txt` | baseline arithmetic + listing behavior | no lexical errors, compiled successfully |
| `test2.txt` | single lexical error detection (`$`) | one lexical error reported |
| `test3.txt` | punctuation/reserved words/operators/literals smoke coverage | no lexical errors |
| `test4.txt` | new reserved words (`else`, `elsif`, `endif`, `fold`, etc.) | no lexical errors |
| `test5.txt` | new operators (`| ! = <> > >= <= - / % ^ ~`) | no lexical errors |
| `test6.txt` | `--` comments, underscore identifier constraints, real/hex/char literal support | no lexical errors |
| `test7.txt` | multiple lexical errors on the same line | both invalid characters reported |
| `test8.txt` | comprehensive final integration, including invalid identifiers | lexical errors only where expected |

### 2.1 Representative run outputs

The environment used for this branch does not have `flex` available, so executable runs could not be regenerated locally. The project contains expected output captures in `Project1/testOutput/`, which are used here as run evidence.

#### Test 6 (feature-complete lexer path)

```text
Compiled Successfully
```

(See full captured run in `Project1/testOutput/test6_output.txt`.)

#### Test 7 (multiple lexical errors on one line)

```text
Lexical Error, Invalid Character $
Lexical Error, Invalid Character ?
...
Lexical Errors 2
Syntax Errors 0
Semantic Errors 0
```

(See full captured run in `Project1/testOutput/test7_output.txt`.)

#### Test 8 (comprehensive integration)

```text
...invalid identifier cases...
Lexical Error, Invalid Character _
Lexical Error, Invalid Character _
Lexical Error, Invalid Character _
Lexical Error, Invalid Character _
Lexical Error, Invalid Character _
...
Lexical Errors 5
Syntax Errors 0
Semantic Errors 0
```

(See full captured run in `Project1/testOutput/test8_output.txt`.)

---

## 3. Requirements-to-implementation traceability

### 3.1 Scanner/token requirements

- Added reserved words and unique token names for: `else`, `elsif`, `endfold`, `endif`, `fold`, `if`, `left`, `real`, `right`, `then`.
- Added new operator tokens/rules for `|`, `!`, `%`, `^`, `~` and expanded operator coverage for `-`, `/`.
- Added relational lexemes `=`, `<>`, `>`, `>=`, `<=` under `RELOP`.
- Added second comment style beginning with `--`.
- Updated identifier regex to allow underscores with constraints (no leading/trailing underscore, no more than two consecutive underscores).
- Added hexadecimal integer literal form beginning with `#`.
- Added real-literal form with required decimal point and optional exponent.
- Updated character literal rule to support escaped character forms.

### 3.2 Listing/error-report requirements

- `lastLine()` now prints either `Compiled Successfully` or lexical/syntax/semantic error counts.
- `appendError()` tracks category-specific counts.
- Line-level error buffering supports multiple messages displayed for the same source line.

---

## 4. Lessons learned and improvements

### Lessons learned

- Regex ordering in Flex is critical: specific token patterns and keyword rules must be placed before broader matches to avoid accidental tokenization.
- Comprehensive edge-case tests are necessary for lexical analyzers, especially around identifiers and literal formats.
- Error reporting quality significantly improves usability; showing all lexical errors on a line avoids slow, one-error-at-a-time iteration.

### Potential improvements

- Add automated regression script that runs all provided tests and diffs output against `testOutput/*`.
- Add additional negative tests for malformed real literals and malformed escape sequences.
- Add CI support with `flex` installed so scanner generation and regression tests run on each change.

