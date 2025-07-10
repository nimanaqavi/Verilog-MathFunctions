
# Digital Function Approximator Using Taylor/Maclaurin Series (Verilog)

This project implements a digital system in Verilog for calculating mathematical functions—**exp(x)**, **sin(x)**, **cos(x)**, and **ln(1+x)**—using their Taylor/Maclaurin series expansions. The design is modular, testable, and suitable for FPGA or simulation environments.

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Taylor/Maclaurin Series Explanation](#taylormaclaurin-series-explanation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Simulation and Testing](#simulation-and-testing)
- [Block Diagram](#block-diagram)
- [Contributing](#contributing)
- [License](#license)
- [How to Run and Release](#how-to-run-and-release)

## Overview

This digital system evaluates four mathematical functions using hardware-friendly Taylor/Maclaurin series approximations. The design is structured for clarity, modularity, and ease of simulation.

## How It Works

- **Input:**  
  - 16-bit input value (`Xbus`)
  - 2-bit function selector (`Func`/`MOD`):  
    - `00`: exp(x)
    - `01`: sin(x)
    - `10`: cos(x)
    - `11`: ln(1+x)

- **Output:**  
  - 18-bit result (`RBUS`)
  - Ready/Done signals

- **Operation:**  
  - On `start`, the system computes the selected function using the Taylor/Maclaurin series expansion up to a fixed number of terms for efficiency and accuracy.
  - The calculation is performed using a combination of a datapath (arithmetic operations) and a controller (state machine).

## Taylor/Maclaurin Series Explanation

The Taylor/Maclaurin series approximates functions as a sum of polynomial terms. For this project, the following expansions are used:

| Function      | Series Expansion (Maclaurin)                                         |
|---------------|---------------------------------------------------------------------|
| exp(x)        | \( 1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \dots \)               |
| sin(x)        | \( x - \frac{x^3}{3!} + \frac{x^5}{5!} - \dots \)                   |
| cos(x)        | \( 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - \dots \)                   |
| ln(1+x)       | \( x - \frac{x^2}{2} + \frac{x^3}{3} - \dots \)                     |

**Key Points:**
- Only a limited number of terms are used for each function to balance accuracy and hardware resource usage.
- Each term is calculated using multipliers, adders, and subtractors, controlled by a finite state machine.

## Project Structure

| File            | Description                                      |
|-----------------|--------------------------------------------------|
| `part1TOP.v`    | Term generator for Taylor series                 |
| `part1Dp.v`     | Datapath for term calculation                    |
| `part1CO.v`     | Controller for term calculation                  |
| `part2DP.v`     | Main datapath for exp, sin, cos                  |
| `part2CO.v`     | Controller for exp, sin, cos                     |
| `Ln_TOP.v`      | Top module for ln(1+x)                           |
| `Ln_DP.v`       | Datapath for ln(1+x)                             |
| `Ln_CO.v`       | Controller for ln(1+x)                           |
| `Part2TOP.v`    | System top module for all functions              |
| `Tb.v`          | Testbench for term generator                     |
| `Ln_Tb.v`       | Testbench for ln(1+x)                            |

## Usage

1. **Simulation:**
   - Use ModelSim or any Verilog simulator.
   - Run the provided testbenches to verify functionality.

2. **FPGA Implementation:**
   - Synthesize the design using your preferred FPGA toolchain.
   - Connect inputs and outputs as described above.

## Simulation and Testing

- Each module includes a dedicated testbench.
- Testbenches apply different input values to verify the correctness of each function’s calculation.
- Example input values: 0, 1/2, 1/4, etc.

## Block Diagram

