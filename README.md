
# Digital Function Approximator Using Taylor/Maclaurin Series (Verilog)

This project implements a digital system in Verilog for calculating mathematical functions**exp(x)**, **sin(x)**, **cos(x)**, and **ln(1+x)**using their Taylor/Maclaurin series expansions. The design is modular, testable, and suitable for FPGA or simulation environments.

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)
- [Taylor/Maclaurin Series Explanation](#taylormaclaurin-series-explanation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [How to Run](#how-to-run)
- [Simulation and Testing](#simulation-and-testing)
- [Block Diagram](#block-diagram)
- [Contributing](#contributing)
- [License](#license)



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

| **Function** | **Maclaurin Series Expansion**                          |
|--------------|----------------------------------------------------------|
| `exp(x)`     | 1 + x + x²⁄2! + x³⁄3! + x⁴⁄4! + ...                       |
| `sin(x)`     | x − x³⁄3! + x⁵⁄5! − x⁷⁄7! + ...                           |
| `cos(x)`     | 1 − x²⁄2! + x⁴⁄4! − x⁶⁄6! + ...                           |
| `ln(1 + x)`  | x − x²⁄2 + x³⁄3 − x⁴⁄4 + ... *(for −1 < x ≤ 1)*          |


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
[![Block Diagram](https://github.com/nimanaqavi/Verilog-MathFunctions/blob/main/Verilog-MathFunctions/Images/Block%20Diagram.png?raw=true)](https://github.com/nimanaqavi/Verilog-MathFunctions/blob/main/Verilog-MathFunctions/Images/Block%20Diagram.png?raw=true)



- **Controller:** Manages the sequence of operations for each function.
- **Datapath:** Performs arithmetic calculations for each term in the series.
- **Output Logic:** Assembles the final result and signals when ready.

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

---

## How to Run 

### Running the Code

1. **Clone the Repository**
   - Download or clone the repository to your local machine.

2. **Open in a Verilog Simulator**
   - Use ModelSim, Vivado, or any other Verilog-compatible simulator.
   - Add all Verilog source files and the relevant testbench (e.g., `Tb.v` or `Ln_Tb.v`) to your simulation project.

3. **Compile the Design**
   - Compile all modules in the correct order to resolve dependencies.

4. **Run Simulation**
   - Load the testbench module.
   - Start the simulation and observe the output signals (`RBUS`, `Ready`, etc.).
   - You can modify the input values in the testbench to test different scenarios.

5. **FPGA Synthesis (Optional)**
   - If targeting FPGA, use your FPGA vendor's toolchain (e.g., Xilinx Vivado, Intel Quartus).
   - Create a new project, add all Verilog files, assign top-level ports, and synthesize.
   - Generate the bitstream and program your FPGA board.


---

## License

Distributed under the MIT License.

I hope you find this Taylor/Maclaurin-based function calculator useful in your digital design projects.



