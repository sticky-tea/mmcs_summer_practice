#include <string.h>
#include "magma.hpp"
#include <iostream>
#include <vector>

#include <fstream>
#include <chrono>

uint8_t Gost_Table[_GOST_TABLE_SIZE] = {
    0x04, 0x02, 0x0F, 0x05, 0x09, 0x01, 0x00, 0x08, 0x0E, 0x03, 0x0B, 0x0C, 0x0D, 0x07, 0x0A, 0x06,
    0x0C, 0x09, 0x0F, 0x0E, 0x08, 0x01, 0x03, 0x0A, 0x02, 0x07, 0x04, 0x0D, 0x06, 0x00, 0x0B, 0x05,
    0x0D, 0x08, 0x0E, 0x0C, 0x07, 0x03, 0x09, 0x0A, 0x01, 0x05, 0x02, 0x04, 0x06, 0x0F, 0x00, 0x0B,
    0x0E, 0x09, 0x0B, 0x02, 0x05, 0x0F, 0x07, 0x01, 0x00, 0x0D, 0x0C, 0x06, 0x0A, 0x04, 0x03, 0x08,
    0x03, 0x0E, 0x05, 0x09, 0x06, 0x08, 0x00, 0x0D, 0x0A, 0x0B, 0x07, 0x0C, 0x02, 0x01, 0x0F, 0x04,
    0x08, 0x0F, 0x06, 0x0B, 0x01, 0x09, 0x0C, 0x05, 0x0D, 0x03, 0x07, 0x0A, 0x00, 0x0E, 0x02, 0x04,
    0x09, 0x0B, 0x0C, 0x00, 0x03, 0x06, 0x07, 0x05, 0x04, 0x08, 0x0E, 0x0F, 0x01, 0x0A, 0x02, 0x0D,
    0x0C, 0x06, 0x05, 0x02, 0x0B, 0x00, 0x09, 0x0D, 0x03, 0x0E, 0x07, 0x0A, 0x0F, 0x04, 0x01, 0x08
};
uint8_t GOST_Key_d[_GOST_Key_Size] = {
        0x04, 0x75, 0xF6, 0xE0, 0x50, 0x38, 0xFB, 0xFA, 0xD2, 0xC7, 0xC3, 0x90, 0xED, 0xB3, 0xCA, 0x3D,
        0x15, 0x47, 0x12, 0x42, 0x91, 0xAE, 0x1E, 0x8A, 0x2F, 0x79, 0xCD, 0x9E, 0xD2, 0xBC, 0xEF, 0xBD
};
uint8_t Data_O[24] = {
    0x6A, 0xDB, 0x6E, 0xC5, 0x3E, 0xC6, 0x45, 0xA4, 0x70, 0xA8, 0x22, 0xB8, 0x94, 0xA7, 0xFE, 0x28,
    0x38, 0x48, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};
//imitta
uint8_t Imitta_Et[_GOST_Imitta_Size] ={
        0xD9, 0x8F, 0xEB, 0x04, 0x81, 0xF6, 0x2C, 0x41
};
#if _GOST_ROT_Synchro_GAMMA==1
//synchro
uint8_t Synchro_Et[_GOST_Synchro_Size] =
{
    0xC3, 0xA7,0x80, 0x2A, 0x47, 0xE3, 0xA8, 0xFF
};
#else
uint8_t Synchro_Et[_GOST_Synchro_Size] =
{
   0x47, 0xE3, 0xA8, 0xFF, 0xC3, 0xA7,0x80, 0x2A
};
#endif
//Simple replacement
uint8_t Data_C_S_Et[24] = {
    0x12, 0xA2, 0x8E, 0x60, 0x5D, 0x76, 0xBF, 0xC9, 0xAF, 0x84, 0x67, 0x8A, 0xA5, 0xE8, 0xF7, 0xE8,
    0xDE, 0x8E, 0x29, 0x16, 0x19, 0xCB, 0xD2, 0x08
};
//Gamma
unsigned char Data_C_G_Et[24] = {
    0x8B, 0x39, 0x76, 0x8B, 0x52, 0xE3, 0x94, 0x1D, 0xEA, 0x22, 0xC7, 0x24, 0x86, 0x56, 0xA2, 0xCE,
    0x11, 0x61, 0xF0, 0x07, 0x4B, 0xF8, 0xCA, 0x00
};
//Gamma with feedback
unsigned char Data_C_GF_Et[24] = {
    0x20, 0x36, 0xB4, 0x76, 0x29, 0x44, 0x36, 0xDE, 0xF1, 0x17, 0x0F, 0x02, 0x82, 0x40, 0x00, 0x05,
    0xEC, 0x04, 0x87, 0xBB, 0xF4, 0x46, 0x0A, 0xA2
};



uint8_t  Imitta[_GOST_Imitta_Size];
uint8_t  Data_E[sizeof(Data_O)];
uint8_t  Synchro[_GOST_Synchro_Size];
int main(int argc, char *argv[])
{
    long size;

    std::vector<std::string> names = {"test_200kb.txt", "test_1mb.txt", "test_10mb.txt", "test_100mb.txt"};

    std::ifstream infile;
    std::ofstream outfile;

    for(const auto& i : names)
    {
        infile.open(i, std::ifstream::binary);
        outfile.open("gost_encrypted_"+i, std::ofstream::binary);

        infile.seekg(0, std::ifstream::end);
        size=infile.tellg();
        infile.seekg(0);

        //std::cout << size << std::endl;

        char* buffer = new char[size];
        infile.read (buffer,size);

        infile.close(); 

        unsigned int plainLen = size * sizeof(char);
        unsigned int outLen = 0;

        memcpy(Synchro,Synchro_Et,sizeof(Synchro));
#if _GOST_ROT_Synchro_GAMMA==1
        GOST_Crypt_GF_Prepare_S(Synchro);
#endif

        auto begin = std::chrono::steady_clock::now();
        
        GOST_Encrypt_SR((uint8_t*)buffer, size, _GOST_Mode_Encrypt, Gost_Table, GOST_Key_d);

        auto end = std::chrono::steady_clock::now();

        outfile.write(buffer, size);
        outfile.close();
    
        auto elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>(end - begin);
        std::cout << "Time elapsed for " + i + ": " << elapsed_ms.count() << " ms\n";

        delete[] buffer;
    }
}