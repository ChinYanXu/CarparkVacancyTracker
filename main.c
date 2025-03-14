/**
 ******************************************************************************
 * @project        : CG/[T]EE2028 Assignment 1 Program Template
 * @file           : main.c
 * @author         : Hou Linxin, ECE, NUS
 * @brief          : Main program body
 ******************************************************************************
 *
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */
#include "stdio.h"

#define F 3
#define S 2

extern void asm_func(int* arg1, int* arg2, int* arg3, int* arg4);
extern void initialise_monitor_handles(void);






int main(void)
{
	initialise_monitor_handles();
	int i,j,k,m;
	int building[5][F][S] = {{{8,8},{8,8},{8,8}},
						{{1,2},{3,4},{5,6}},
						{{12,12},{10,5},{3,7}},
						{{12,12},{12,12},{12,12}},
						{{9,10},{7,8},{4,4}}};
	int entry[5][5] =  {{1,2,3,4,5},
					{1,1,1,1,1},
					{1,1,1,1,5},
					{0,0,0,0,0},
					{2,4,6,8,10}};
	int exit[5][F][S] = {{{1,2},{2,3},{3,4}},
					{{1,0},{0,0},{0,0}},
					{{1,2},{3,4}, {3,6}},
					{{2,2},{3,3},{4,4}},
					{{1,1},{1,1},{1,1}}};
	int result[5][F][S] = {{{0,0},{0,0},{0,0}},
						{{0,0},{0,0},{0,0}},
						{{0,0},{0,0},{0,0}},
						{{0,0},{0,0},{0,0}},
						{{0,0},{0,0},{0,0}}};

	for (k=0; k<5; k++){
		asm_func((int*)building[k], (int*)entry[k], (int*)exit[k], (int*)result[k]);
	}

	// print result[][]


	for (m=0; m<5; m++) {
		printf("TEST CASE %d RESULT:\n", m + 1);
		//printf("RESULT\n");
		for (i=0; i<F; i++)
		{
			for (j=0; j<S; j++)
			{
				//building[i][j] = result[i][j];
				//printf("%d\t", building[i][j]);
				printf("%d\t", result[m][i][j]);
			}
		printf("\n");
		}
	}


}
