#include<stdio.h>
#include<stdlib.h>
#include <math.h>

#define N 8 /// order of the filter
#define NT (N+1) /// number of coeffs
#define NB 9 /// number of bits
#define SHAMT 9 /// shift amount

int bi[NT]; /// b array
int ai[NT-1]; /// a array

/// Perform fixed point filtering assming direct form I
///\param x is the new input sample
///\return the new output sample
int myfilter(int x)
{
  static int sx[NT]; /// x shift register
  static int sy[NT-1]; /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i; /// index
  int y; /// output sample

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i=0; i<NT; i++)
      sx[i] = 0;
    for (i=0; i<NT-1; i++)
      sy[i] = 0;
  }

  /// shift and insert new sample in x shift register
  for (i=NT-1; i>0; i--)
    sx[i] = sx[i-1];
  sx[0] = x;

  /// make the convolution
  /// Moving average part
  y = 0;
  for (i=0; i<NT; i++)
    y += ((sx[i]*bi[i]) >> SHAMT) << (SHAMT-NB+1);

  /// update the y shift register
  for (i=NT-2; i>0; i--)
    sy[i] = sy[i-1];
  sy[0] = y;

  return y;
}

const char bi_file_name[7] = "bi.txt";

int main (int argc, char **argv)
{
  FILE *fp_in = NULL;
  FILE *fp_bi = NULL;
  FILE *fp_out = NULL;
  FILE *fp_out_m = NULL;

  int x;
  int y;
  int count = 0; /// output sample
  double somma = 0; /// output sample
  int expected; /// matlab results

  // Initialize bi with values written in bi.txt
  int iter_bi = 0; // index for bi

  fp_bi = fopen(bi_file_name, "r");
  if (fp_bi == NULL) {
    printf("Error: cannot open %s\n", bi_file_name);
    exit(2);
  }

  while (iter_bi <= NT && (fscanf(fp_bi, "%d", &bi[iter_bi++]) == 1));

  if (--iter_bi != NT) {
    printf("Error: mismatch number of elements\n");
    printf("Expected: %d\t\tRead: %d\n", NT, iter_bi);
    exit(1);
  }

  fclose(fp_bi);

  // initialize ai vector with zeros
  /* for (int i = 0; i < NT; ai[i++] = 0); */

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL) {
    printf("Error: cannot open %s\n");
    exit(2);
  }

  fp_out = fopen(argv[2], "w");
  fp_out_m = fopen("./resultsm.txt", "r");

  /// check shift amount
  if (SHAMT < ((NB)-1))
  {
    printf("Error shift amount must be at least nbit-1\n");
    exit(3);
  }

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  fscanf(fp_out_m, "%d", &expected);
  do{
    y = myfilter(x);
    somma += pow(y - expected, 2);
    count++;

    fscanf(fp_in, "%d", &x);
    fscanf(fp_out_m, "%d", &expected);

    fprintf(fp_out,"%d\n", y);
  } while (!feof(fp_in));

  printf("fixed-point vs pseudo-fixed-point\nrmsd: %f\n", sqrt(somma / count));

  fclose(fp_in);
  fclose(fp_out);
  fclose(fp_out_m);

  return 0;

}
