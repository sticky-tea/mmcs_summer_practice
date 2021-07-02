#include "AES.hpp"

#include <iostream>
#include <fstream>
#include <chrono>
#include <vector>

unsigned char key[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
unsigned char iv[] = { 0xC3, 0xA7,0x80, 0x2A, 0x47, 0xE3, 0xA8, 0xFF };

int main()
{
    long size;

    std::vector<std::string> names = {"test_200kb.txt", "test_1mb.txt", "test_10mb.txt", "test_100mb.txt"};
    std::ifstream infile;
    std::ofstream outfile;

    AES aes(128);

    for(const auto& i : names)
    {
        infile.open(i, std::ifstream::binary);
        outfile.open("aes_encrypted_"+i, std::ofstream::binary);

        infile.seekg(0, std::ifstream::end);
        size=infile.tellg();
        infile.seekg(0);

        //std::cout << size << std::endl;

        char* buffer = new char[size];
        infile.read (buffer,size);

        infile.close(); 

        unsigned int plainLen = size * sizeof(char);
        unsigned int outLen = 0;

        auto begin = std::chrono::steady_clock::now();
        
        auto c = aes.EncryptCFB((unsigned char*)buffer, plainLen, key, iv, outLen);

        //auto c = aes.EncryptECB((unsigned char*)buffer, plainLen, key, outLen);

        auto end = std::chrono::steady_clock::now();

        outfile.write((char*)c, size);
        outfile.close();
    
        auto elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>(end - begin);
        std::cout << "Time elapsed for " + i + ": " << elapsed_ms.count() << " ms\n";

        delete[] buffer;
    }
}