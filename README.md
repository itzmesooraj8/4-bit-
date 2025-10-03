Counter project (4-bit synchronous counter)

Files in this folder:
- `counter.v`      : Parameterized counter module (default WIDTH = 4).
- `tb_counter.v`   : Self-checking testbench that generates `counter_waveform.vcd` and prints pass/fail.
- `run_simulation.ps1`: PowerShell helper that compiles and runs the simulation (detects iverilog).

How to run (Windows PowerShell):
1) If you already have Icarus Verilog installed (iverilog & vvp on PATH), run:

   iverilog -o my_counter_sim C:\Users\itzme\counter_project\tb_counter.v C:\Users\itzme\counter_project\counter.v
   vvp my_counter_sim

   After the run you should see `counter_waveform.vcd` in the current working directory. Open it with GTKWave:

   gtkwave counter_waveform.vcd

2) Installing Icarus Verilog on Windows:

- Recommended (Admin): Install Chocolatey (run an elevated PowerShell) and then:

  choco install iverilog -y
  choco install gtkwave -y    # optional

- Non-admin: Download a Windows build from https://bleyer.org/icarus/ (look for `iverilog-v12..._setup.exe` or older builds). Run the installer or extract a portable archive and add the folder containing `iverilog.exe` and `vvp.exe` to your user PATH.

3) Quick test using the included PowerShell helper (from this folder):

   # In PowerShell (non-elevated) at this folder
   .\run_simulation.ps1

This script will check for `iverilog` and either run the simulation or print instructions to install.

Notes / suggested improvements:
- You can change the counter width by editing the `WIDTH` parameter in `tb_counter.v` and `counter.v` (they are set to 4 by default).
- The testbench is self-checking; it will print `TEST PASSED` when the counter increments correctly.

If you'd like, I can try to automatically install a portable Icarus Verilog into your user directory (non-admin) and run the simulation — tell me to proceed with "non-admin" or run the provided script yourself.