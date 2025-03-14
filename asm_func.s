/*
 * asm_func.s
 *
 *  Created on: 7/2/2025
 *      Author: Hou Linxin
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global asm_func

@ Start of executable code
.section .text

@ CG/[T]EE2028 Assignment 1, Sem 2, AY 2024/25
@ (c) ECE NUS, 2025

@ Write Student 1’s Name here: Chin Yan Xu
@ Write Student 2’s Name here: Cheong Chen Kang

@ Look-up table for registers:

@ R0 Pointer to an building array element
@ R1 Pointer to an entry array element
@ R2 Pointer to an exit array element
@ R3 Pointer to an result array element
@ R4 Reused variable commonly used to store the total number of cars entering the building for the day
@ R5 Reused variable commonly used as a counter
@ R6 Reused variable commonly used to store how many cars can be stored in the current section

@ write your program from here:

asm_func:


	.equ MAX_CARS, 12

	PUSH {R0 - R3} // save the first address of the parameters

	/*
	In this section,
	R4 will be used to store the number of cars currently in the section of the building
	R5 will be used as a counter to facilitate for looping
	*/

	MOV R4, #0
	MOV R5, #0

	InitialiseResult:

		LDR R4, [R0]
		STR R4, [R3]
		ADD R0, R0, #4
		ADD R3, R3, #4
		ADD R5, #1
		CMP R5, #6
		BNE InitialiseResult

	SUB R0, #24
	SUB R3, #24

	/*
	In this section,
	R4 will be used to store the number of cars entering the building
	R5 will be used as a counter to facilitate for looping
	R6 will be used to store the value of the current element of entry
	*/

	MOV R4, #0
	MOV R5, #0

	CountNumCarsEnteringLoop:
		LDR R6, [R1]
		ADD R4, R6
		ADD R1, R1, #4
		ADD R5, #1
		CMP R5, #5
		BNE CountNumCarsEnteringLoop

	SUB R1, #20

	/*
	In this section,
	R4 will be used to store the total number of cars entering the building
	R5 at different points of the loop will hold
	1) The number of cars in the current section of the building
	2) The number of cars in the current section of the building if all the remaining cars entering squeezed into that section
	3) The updated number of cars for the current section. If the current section cannot accomodate all the remaining cars entering
	the building, R5 will be MAX_CARS, which is the maximum number of cars that can be stored in a section. If the current section
	is able to fit in the remaining number of cars entering, R5 will store the sum of the number of cars originally in the current
	section and the remaining number of cars entering the building
	R6 will store the number of cars that can be added to the current section

	*/

	MOV R6, #0
	MOV R5, #0

	/*
	If no cars is entering go straight to determining how many cars is
	exiting from each section of the building
	*/
	CMP R4, #0
	BEQ CarsExitingLoop

	CarsEnteringLoop:
		LDR R5, [R3]
		RSB R6, R5, MAX_CARS //how many cars can be stored in the current section
		ADD R5, R5, R4
		CMP R5, MAX_CARS

		ITTTT GT
			MOVGT R5, MAX_CARS
			STRGT R5, [R3]
			ADDGT R3, R3, #4
			SUBGT R4, R4, R6

		ITT LE
			STRLE R5, [R3]
			MOVLE R4, #0

		CMP R4, #0
		BNE CarsEnteringLoop

	POP {R0 - R3}

	/**
	R4 is used to store the value of R2
	R5 is used as a regular counter to facilitate for looping
	R6 at different points of the loop will hold
	1) The value of the current element pointed to in R3
	2) The number of cars in the current section of the building when some cars have exited at the end of the day
	**/

	MOV R5, #0

	CarsExitingLoop:

		LDR R4, [R2]
		LDR R6, [R3]

		SUB R6, R6, R4
		CMP R6, #0
	    IT LT
	    MOVLT R6, #0   // Prevent negative values

		STR R6, [R3]
		ADD R3, R3, #4
		ADD R2, R2, #4
		ADD R5, #1

		CMP R5, #6
		BNE CarsExitingLoop

	SUB R3, #24
	SUB R2, #24


 	//PUSH {R14}

	//BL SUBROUTINE

 	//POP {R14}

	BX LR

SUBROUTINE:

	BX LR
