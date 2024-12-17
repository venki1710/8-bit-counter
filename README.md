## Eight-Bit Counter with Seven-Segment Display on Nexys 4 DDR

This project implements an eight-bit counter using Verilog, designed for deployment on the Nexys 4 DDR FPGA board. The counter increments every second and displays its value on a seven-segment display module.

### Project Overview

The main components of this project are:

1. **Eight-Bit Counter**: The core module of the project, which increments from 0 to 255 at a 1 Hz rate. The counter automatically resets to 0 after reaching 255 or when the reset signal is active.

2. **Clock Dividers**:
   - A **1 Hz Clock Divider** that divides the input 100 MHz clock signal down to 1 Hz, which is used to control the counting frequency.
   - A **10 kHz Clock Divider** used to create a multiplexed signal for driving the seven-segment display.

3. **Binary to BCD Converter**: Converts the 8-bit binary count value into Binary-Coded Decimal (BCD) format for each digit place (ones, tens, hundreds).

4. **Seven-Segment Display Controller**: Takes the BCD output and controls the seven-segment display to show the current count value. The display cycles through the digits at a high frequency to make all digits appear simultaneously lit.

### Features

- **Real-Time Counting**: The counter increments once every second.
- **Seven-Segment Display Multiplexing**: Utilizes multiplexing to drive a four-digit seven-segment display with minimal IO pins.
- **Reset Functionality**: The counter and display can be reset using an external reset signal.
- **Efficient Clock Management**: Two different clock dividers manage the timing for the counting and display refresh rates.

### How to Use

1. **Synthesize and Implement**: Load the Verilog code onto the Nexys 4 DDR board using Vivado or any compatible FPGA toolchain.
2. **Connect the Board**: Ensure the board is properly connected to power and the seven-segment display is connected to the appropriate pins.
3. **Run the Project**: Once programmed, the board will begin counting from 0 to 255 and display the count on the seven-segment display.
4. **Reset**: Use the reset button on the board to reset the counter to zero at any time.

### Files Included

- **eight_bit_counter.v**: Main Verilog file containing the counter, clock dividers, BCD converter, and seven-segment display controller.
- **Constraints file (XDC)**: The constraints file specifying the pin assignments for the Nexys 4 DDR board.

### Future Improvements

- Add functionality to count both up and down.
- Integrate additional features such as pause/resume functionality.
- Optimize power consumption by refining clock management.

### Dependencies

- **Vivado Design Suite**: Required for synthesizing and uploading the Verilog code to the Nexys 4 DDR board.

### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

---

Feel free to adjust the description based on any additional details or features specific to your implementation!
