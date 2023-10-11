#include<stdio.h>
#include<stdlib.h>
#include <math.h>

#define N 8 /// order of the filter
#define NT (N+1) /// number of coeffs
#define NB 9 /// number of bits
#define SHAMT 8 /// shift amount

const int bi[NT]={8, 111, 8}; /// b array
const int ai[NT-1]={0, 0}; /// a array

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
  /// Auto regressive part
  for (i=0; i<NT-1; i++)
    y -= ((sy[i]*ai[i]) >> SHAMT) << (SHAMT-NB+1);    

  /// update the y shift register
  for (i=NT-2; i>0; i--)
    sy[i] = sy[i-1];
  sy[0] = y;
 
  return y;
}

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;
  FILE *fp_out_m;

  int x;
  int y;
  int count = 0; /// output sample
  long int somma = 0; /// output sample
  int e; /// matlab results

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }
  
  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
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
  fscanf(fp_out_m, "%d", &e);
  do{
    y = myfilter(x);
    somma += pow(y - e, 2);
    count++;

    printf("%d\n", somma);
    fscanf(fp_in, "%d", &x);
    fscanf(fp_out_m, "%d", &e);

    fprintf(fp_out,"%d\n", y);
  } while (!feof(fp_in));

  printf("somma: %d\n", sqrt(somma / count));

  fclose(fp_in);
  fclose(fp_out);
  fclose(fp_out_m);

  return 0;

}
