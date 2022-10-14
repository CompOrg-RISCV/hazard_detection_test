/*
 * hazard_detection_test.s
 *
 */

 // Section .crt0 is always placed from address 0
	.section .crt0, "ax"

_start:
	.global _start

//I-type Test (rs1 data hazard detection and forwarding)
     addi  x2, x0, 1                        // x2=1
     addi  x2, x2, 2                        // EXMEM data hazard, x2=3
     addi  x2, x2, 3                        // validates EXMEM over MEMWB data hazard, x2=6
     addi  x2, x2, 4                        // validates EXMEM over WB data hazard, x2=10
     nop
     nop                    // x2 = 1
     nop                    // x2 = 3
     nop                    // x2 = 6
     nop                    // x2 = 10
     addi x2, x0, 1                         // x2=1
     nop
     addi x2, x2, 2                         // MEMWB data hazard, x2=3
     addi x2, x2, 3                         // x2=6
     nop
     addi x2, x2, 4         // x2 = 1       // valdates MEMWB over WB data hazard, x2=10
     nop
     nop                    // x2 = 3
     addi x2, x2, 5         // x2 = 6       // validates WB data hazard, x2=5
     nop
     nop                    // x2 = 10
     nop
     nop
     nop                    // x2 = 15
     nop
     nop
     nop
     //halt
     nop
     nop
     nop
     nop
//R-Type Test
	 //Testing rs1 is properly forwarded
     addi x2, x0, 10
     nop
     nop
     addi x3, x0, 1		                    //x3 = 1
     add x3, x3, x2		                    //EXMEM data hazard, x3 = 1 + 10 = 11
     add x3, x3, x2		                    //EXMEM over MEMWB data hazard, x3 = 11 + 10 = 21
     add x3, x3, x2		                    //EXMEM over WB data hazard, x3 = 21 + 10 = 31
     nop
	 nop                    // x3 = 1
     nop                    // x3 = 11
     nop                    // x3 = 21
     nop                    // x3 = 31
	 nop
	 nop
	 nop
	 nop
	 //halt
	 nop
	 nop
	 nop
	 //Testing rs2 is properly forwarded
	 addi x4, x0, 1		//x4 = 1
	 add x4, x2, x4		//EXMEM data hazard, x4 = 10 + 1 = 11
	 add x4, x2, x4		//EXMEM over WB data hazard, x4 = 11 + 10 = 21
	 add x4, x2, x4		//EXMEM over WB data hazard, x4 = 21 + 10 = 31
	 nop
	 nop
	 nop
	 nop
	 nop
	 halt
	 nop
	 nop
	 nop
