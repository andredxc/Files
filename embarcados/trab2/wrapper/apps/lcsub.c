#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IN1_FILENAME "in1.txt"
#define IN2_FILENAME "in2.txt"

int *lcommon(char *s, char *t) {
	int strlen1 = strlen(s);
	int strlen2 = strlen(t);
	int len = (strlen1 < strlen2) ? strlen2 : strlen1;
	int i, j, k;
	int longest = 0;
	int **ptr = (int **)malloc(2 * sizeof(int *));
	static int *ret;
	/*
	 * Maximum length of the return list (considering intermediate steps).
	 * It is the maximum length of the source strings + 1 (worst-case
	 * intermediate length) + the value of the longest match + the
	 * terminator value (-1).
	 */
	ret = (int *)malloc((len + 3) * sizeof(int));
	for (i = 0; i < 2; i++)
		ptr[i] = (int *)calloc(strlen2, sizeof(int));

	ret[1] = -1;
	for (i = 0; i < strlen1; i++) {
		memcpy(ptr[0], ptr[1], strlen2 * sizeof(int));
		for (j = 0; j < strlen2; j++) {
			if (s[i] == t[j]) {
				if (i == 0 || j == 0) {
					ptr[1][j] = 1;
				} else {
					ptr[1][j] = ptr[0][j-1] + 1;
				}
				if (ptr[1][j] > longest) {
					longest = ptr[1][j];
					k = 1;
				}
				if (ptr[1][j] == longest) {
					ret[k++] = i;
					ret[k] = -1;
				}
			} else {
				ptr[1][j] = 0;
			}
		}
	}
	for (i = 0; i < 2; i++)
		free(ptr[i]);
	free(ptr);
	/* store the maximum length in ret[0] */
	ret[0] = longest;
	return ret;
}

int main(int argc, char *argv[]) {
	int i, longest, *ret;
	FILE *file1, *file2;
	char in1[1048580], in2[1048580];

	file1 = fopen(IN1_FILENAME, "r");
	file2 = fopen(IN2_FILENAME, "r");

	if (!file1){
		printf("Error opening %s\n", IN1_FILENAME);
		return -1;
	}

	if (fscanf(file1, "%s", in1) <= 0){
		printf("Error reading %s\n", IN1_FILENAME);
		return -1;
	}

	if (!file2){
		printf("Error opening %s\n", IN2_FILENAME);
		return -1;
	}

	if (fscanf(file2, "%s", in2) <= 0){
		printf("Error reading %s\n", IN2_FILENAME);
		return -1;
	}

	ret = lcommon(in1, in2);
	if ((longest = ret[0]) == 0) {
		printf("There is no common substring\n");
		exit(2);
	}

	free(ret);
	printf("Done");
	exit(0);
}