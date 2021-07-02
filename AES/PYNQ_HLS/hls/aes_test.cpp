#include <stdio.h>
//#include "aes.h"
#include <ap_int.h>

struct my_stream_type {
	char data[16];
	ap_uint<1> user;		// USER signal
	ap_uint<1> last; 	// TLAST signal
};
void AES_En_De( my_stream_type* in_stream, my_stream_type* out_stream, int in_char_len[3], char key[16] );
void AES_En_De_test(char bit128in_out[16], int in_char_len[3], char key[16] );

//axilite_and_16stream_main
int main(int argc, char const *argv[]) {
char plain[17] = "abcdefghijklmnop";
int len = 16;
char key[17] = "hello_world_aes_";


int in_char_len[3] = {16,0,0 };
my_stream_type output_stream, input_stream;

input_stream.user = 1;
input_stream.last = 1;

for(int i=0;i<16;i++)
	input_stream.data[i] = plain[i];

AES_En_De(&input_stream, &output_stream,in_char_len,key);

printf("%s\n",output_stream.data);
for(int i=0;i<16;i++)
	printf("%x ",(unsigned char)output_stream.data[i]);

in_char_len[1] = 1; 

for(int i=0;i<16;i++){
	input_stream.data[i] = output_stream.data[i];
	printf("%x ",(unsigned char)input_stream.data[i]);
}

AES_En_De(&input_stream, &output_stream,in_char_len,key);
printf("\n%s\n",output_stream.data);
printf("in_char_len[2]:%d\n",in_char_len[2]);

return 0;

}



int more_than16_stream_main(int argc, char const *argv[]) {

char plain[33] = "abcdefghijklmnopabcdefghijklmnop";
const int len = 32;
char key[17] = "hello_world_aes_";

int in_char_len[3] = {len,0,0 };
my_stream_type output_stream, input_stream;

printf("%s\n",plain);
input_stream.user = 1;
for(int j=0;j<len;)
{
	for(int i=0;i<16;i++)
		input_stream.data[i] = plain[j];
	j++;
	input_stream.last = 1;
}
AES_En_De(&input_stream, &output_stream,in_char_len,key);

printf("%s\n",output_stream.data);
for(int i=0;i<16;i++)
	printf("%x ",(unsigned char)output_stream.data[i]);

in_char_len[1] = 1;

for(int i=0;i<16;i++){
	input_stream.data[i] = output_stream.data[i];
	printf("%x ",(unsigned char)input_stream.data[i]);
}

AES_En_De(&input_stream, &output_stream,in_char_len,key);
printf("\n%s\n",output_stream.data);
printf("in_char_len[2]:%d\n",in_char_len[2]);

return 0;

}
