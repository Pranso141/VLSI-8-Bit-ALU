# 🔧 VLSI 8-Bit ALU Verilog (Finished Project)

A fully functional **8-bit Arithmetic Logic Unit** implemented in Verilog, built as a hands-on exercise to practice core digital design and HDL concepts.

## 📌 Overview

This project implements an 8-bit ALU capable of performing arithmetic, bitwise, and shift operations. The carry logic is built using a **Carry Lookahead Adder (CLA)** architecture for fast, parallel carry computation rather than the slower ripple-carry approach.

## ⚙️ Supported Operations

### ➕ Arithmetic
| Opcode | Operation                        |
|--------|----------------------------------|
| `0000` | 8-bit CLA Addition               |
| `0001` | 8-bit CLA Addition with Carry    |
| `0010` | 8-bit Subtraction                |
| `0011` | 8-bit Subtraction with Borrow    |
| `0100` | 2's Complement                   |
| `0101` | Increment                        |
| `0110` | Decrement                        |

### 🔣 Bitwise
| Opcode | Operation |
|--------|-----------|
| `0111` | AND       |
| `1000` | OR        |
| `1001` | XOR       |

### 🔀 Shift & Rotate
| Opcode | Operation               |
|--------|-------------------------|
| `1010` | Logical Shift           |
| `1011` | Rotate                  |
| `1100` | Rotate Through Carry    |

---

## 🧪 Running Simulations

You can simulate this project using any standard Verilog simulator.
## 📖 Concepts Practiced

- Structural and dataflow Verilog modeling
- `generate`/`endgenerate` for iterative instantiation
- Carry Lookahead logic (Generate & Propagate signals)
- Operator precedence in Verilog expressions
- Parameterized and modular design
- Writing self-checking testbenches with `task`

---

## 🗒️ Notes

- Subtraction is implemented using **2's complement addition** (`in1 + (~in2) + 1`)
- Flag outputs (Zero, Negative, Overflow, Carry) are planned for the top-level ALU
- Must Specify the direction of the shift (1 for right shift and 0 for left shift)

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

## Limitations 🏮
- Currently can only work on unsigned numbers, will work on improving the project to work with signed numbers (in an unforseeable future).
