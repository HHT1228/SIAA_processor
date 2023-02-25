# Assembly File Format
- Always use `tab`
- No `tab` before a line
- No comments in a line with instruction / branch definition
- No instruction in the line defining a branch
- Binary number format: 0bxxxx_xxxx

## Example
```
seti  0
LOOP:
seti  0
LOOP2:
seti  0b0000_0001
halt
```
