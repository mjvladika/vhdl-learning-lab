# VHDL Learning Lab

Documenting my journey learning VHDL and digital logic design from scratch. This portfolio tracks my progression from a simulation-first workflow using open-source tools on an ARM-based virtual machine, up to physical hardware synthesis and deployment.

## Toolchains & Environments

* **Simulation Environment:** Apple Silicon Mac → UTM Virtual Machine (Ubuntu ARM) → **GHDL** & **GTKWave**
* **Hardware Environment:** Native Linux (Ubuntu) → **Xilinx Vivado Design Suite** → **Digilent Basys 3 (Artix-7 FPGA)**

---

## Repository Structure

```text
vhdl-learning-lab/
├── .gitignore               # Excludes messy Vivado/GHDL build artifacts
├── README.md                # Project index and documentation
└── projects/
    ├── ghdl_and_gtk_wave/   # Pure simulation, ideal logic validation
    │   ├── fsm/             # Finite State Machines
    │   ├── logic/           # Combinational Logic Blocks
    │   ├── peripherals/     # Hardware Interfaces & Serial Bus Protocols
    │   └── timing/          # Clocked & Timing-Based Circuits
    │
    └── xilinx_basys3/       # Real-world hardware implementations & constraints
        ├── fsm/             # Finite State Machines
        ├── logic/           # Combinational Logic Blocks
        └── timing/          # Clocked & Timing-Based Circuits
