#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

int main(void)
{
    double Input = 0.0;
    for (uint32_t Address = 0;
         Address < 256;
         ++Address)
    {
        printf("8'h%.02x: sine = 16'h%.04x;\n", Address, (uint16_t)(0x3fff*sin(Input)));
        Input += ((2.0*M_PI)/256.0);
    }
}
