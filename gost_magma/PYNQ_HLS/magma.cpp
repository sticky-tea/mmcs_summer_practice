#include <stdlib.h>
#include <String.h>
#include "magma.hpp"

#define _SWAPW32(W) ((W>>24) | (W<<24) | ((W>>8)&0xFF00) | ((W<<8)&0xFF0000))

#define _Min(x,y) (x>y?y:x)

#define _GOST_C0 (uint32_t)(0x1010101)

#define _GOST_C1 (uint32_t)(0x1010104)

#define _GOST_ADC32(x,y,c) c=(uint32_t)(x+y); c+=( ( c<x ) | ( c<y ) )

uint8_t GOST_Table[_GOST_TABLE_SIZE] = {
    0x04, 0x02, 0x0F, 0x05, 0x09, 0x01, 0x00, 0x08, 0x0E, 0x03, 0x0B, 0x0C, 0x0D, 0x07, 0x0A, 0x06,
    0x0C, 0x09, 0x0F, 0x0E, 0x08, 0x01, 0x03, 0x0A, 0x02, 0x07, 0x04, 0x0D, 0x06, 0x00, 0x0B, 0x05,
    0x0D, 0x08, 0x0E, 0x0C, 0x07, 0x03, 0x09, 0x0A, 0x01, 0x05, 0x02, 0x04, 0x06, 0x0F, 0x00, 0x0B,
    0x0E, 0x09, 0x0B, 0x02, 0x05, 0x0F, 0x07, 0x01, 0x00, 0x0D, 0x0C, 0x06, 0x0A, 0x04, 0x03, 0x08,
    0x03, 0x0E, 0x05, 0x09, 0x06, 0x08, 0x00, 0x0D, 0x0A, 0x0B, 0x07, 0x0C, 0x02, 0x01, 0x0F, 0x04,
    0x08, 0x0F, 0x06, 0x0B, 0x01, 0x09, 0x0C, 0x05, 0x0D, 0x03, 0x07, 0x0A, 0x00, 0x0E, 0x02, 0x04,
    0x09, 0x0B, 0x0C, 0x00, 0x03, 0x06, 0x07, 0x05, 0x04, 0x08, 0x0E, 0x0F, 0x01, 0x0A, 0x02, 0x0D,
    0x0C, 0x06, 0x05, 0x02, 0x0B, 0x00, 0x09, 0x0D, 0x03, 0x0E, 0x07, 0x0A, 0x0F, 0x04, 0x01, 0x08
};
uint8_t GOST_Key[_GOST_Key_Size] = {
        0x04, 0x75, 0xF6, 0xE0, 0x50, 0x38, 0xFB, 0xFA, 0xD2, 0xC7, 0xC3, 0x90, 0xED, 0xB3, 0xCA, 0x3D,
        0x15, 0x47, 0x12, 0x42, 0x91, 0xAE, 0x1E, 0x8A, 0x2F, 0x79, 0xCD, 0x9E, 0xD2, 0xBC, 0xEF, 0xBD
};

inline uint32_t _lrotl32 ( uint32_t x, uint8_t r )
{
  return (x << r) | (x >> (32 - r));
}

//GOST basic Simple Step
void GOST_Crypt_Step(GOST_Data_Part *DATA, uint8_t *GOST_Table, uint32_t GOST_Key, bool Last )
{
#pragma pack(0)
    typedef union
    {
        uint32_t full;
        uint8_t parts[_GOST_TABLE_NODES/2];
    } GOST_Data_Part_sum;
    GOST_Data_Part_sum S;
    uint8_t m;
    uint8_t tmp;
    //N1=Lo(DATA); N2=Hi(DATA)

    S.full = (uint32_t)((*DATA).half[_GOST_Data_Part_N1_Half]+GOST_Key) ;//S=(N1+X)mod2^32

    for(m=0; m<(_GOST_TABLE_NODES/2); m++)
    {
        //S(m)=H(m,S)
        tmp=S.parts[m];
        S.parts[m] = *(GOST_Table+(tmp&0x0F));//Low value
        GOST_Table+= _GOST_TABLE_MAX_NODE_VALUE;//next line in table
        S.parts[m] |= (*(GOST_Table+((tmp&0xF0)>>4)))<<4;//High value
        GOST_Table+= _GOST_TABLE_MAX_NODE_VALUE;//next line in table

    }
    S.full = (*DATA).half[_GOST_Data_Part_N2_Half]^_lrotl32(S.full,11);//S=Rl(11,S); rol S,11 //S XOR N2
    if (Last)
    {
        (*DATA).half[_GOST_Data_Part_N2_Half] = S.full; //N2=S
    }else
    {
        (*DATA).half[_GOST_Data_Part_N2_Half] = (*DATA).half[_GOST_Data_Part_N1_Half];//N2=N1
        (*DATA).half[_GOST_Data_Part_N1_Half] = S.full;//N1=S
    }
}


void GOST_Crypt_32_E_Cicle(GOST_Data_Part *DATA, uint8_t *GOST_Table, uint32_t *GOST_Key)
{
    uint8_t k,j;
    uint32_t *GOST_Key_tmp=GOST_Key;
//Key rotation:
//K0,K1,K2,K3,K4,K5,K6,K7, K0,K1,K2,K3,K4,K5,K6,K7, K0,K1,K2,K3,K4,K5,K6,K7, K7,K6,K5,K4,K3,K2,K1,K0

    for(k=0;k<3;k++)
    {
        for (j=0;j<8;j++)
        {
            GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Next_Step ) ;
            GOST_Key++;
        }
        GOST_Key=GOST_Key_tmp;
    }

    GOST_Key+=7;//K7

    for (j=0;j<7;j++)
    {
        GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Next_Step ) ;
        GOST_Key--;
    }
    GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Last_Step ) ;
}


//Basic 32-P decryption algorithm of GOST, usefull only in SR mode
void GOST_Crypt_32_D_Cicle(GOST_Data_Part *DATA, uint8_t *GOST_Table, uint32_t *GOST_Key)
{
    uint8_t k,j;
//Key rotation:
//K0,K1,K2,K3,K4,K5,K6,K7, K7,K6,K5,K4,K3,K2,K1,K0, K7,K6,K5,K4,K3,K2,K1,K0, K7,K6,K5,K4,K3,K2,K1,K0
    for (j=0;j<8;j++)
    {
        GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Next_Step ) ;
        GOST_Key++;
    }
//GOST_Key offset =  GOST_Key + _GOST_32_3P_CICLE_ITERS_J
    for(k=0;k<2;k++)
    {
        for (j=0;j<8;j++)
        {
            GOST_Key--;
            GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Next_Step ) ;
        }
        GOST_Key+=8;
    }
    for (j=0;j<7;j++)
    {
        GOST_Key--;
        GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Next_Step ) ;
    }
    GOST_Key--;
    GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key,_GOST_Last_Step ) ;

}

//Imitta
void GOST_Imitta_16_E_Cicle(GOST_Data_Part *DATA, uint8_t *GOST_Table, uint32_t *GOST_Key)
{
//Key rotation:
//K0,K1,K2,K3,K4,K5,K6,K7, K0,K1,K2,K3,K4,K5,K6,K7.
    uint8_t k,j;
    uint32_t *GOST_Key_Beg=GOST_Key;
    for(k=0;k<2;k++)
    {
        for (j=0;j<8;j++)
        {
            GOST_Crypt_Step(DATA, GOST_Table, *GOST_Key, _GOST_Next_Step) ;
            GOST_Key++;
        }
        GOST_Key=GOST_Key_Beg;
    }


}

void GOST_Imitta(uint8_t *Open_Data,  uint8_t *Imitta, uint32_t Size, uint8_t *GOST_Table, uint8_t *GOST_Key )
{

    uint8_t Cur_Part_Size;
    GOST_Data_Part *Imitta_Prep=(GOST_Data_Part *) Imitta;
    GOST_Data_Part Open_Data_Prep;
    while(Size!=0)
    {
        Cur_Part_Size=_Min(_GOST_Part_Size,Size);
        Open_Data_Prep.half[_GOST_Data_Part_N2_Half]=0;
        Open_Data_Prep.half[_GOST_Data_Part_N1_Half]=0;
        memcpy(&Open_Data_Prep,Open_Data,Cur_Part_Size);
        (*Imitta_Prep).half[_GOST_Data_Part_N1_Half]^=Open_Data_Prep.half[_GOST_Data_Part_N1_Half];
        (*Imitta_Prep).half[_GOST_Data_Part_N2_Half]^=Open_Data_Prep.half[_GOST_Data_Part_N2_Half];
        Size-=Cur_Part_Size;
        Open_Data+=Cur_Part_Size;
        GOST_Imitta_16_E_Cicle(Imitta_Prep,GOST_Table,(uint32_t *)GOST_Key);
    }
#if _GOST_ROT==1
    (*Imitta_Prep).half[_GOST_Data_Part_N1_Half]=_SWAPW32((*Imitta_Prep).half[_GOST_Data_Part_N1_Half]);
    (*Imitta_Prep).half[_GOST_Data_Part_N2_Half]=_SWAPW32((*Imitta_Prep).half[_GOST_Data_Part_N2_Half]);
#endif
}

void GOST_Encrypt_SR(uint8_t *Data, uint32_t Size, bool Mode, uint8_t* Data_out)
{
#pragma HLS INTERFACE s_axilite port=Size
#pragma HLS PIPELINE enable_flush
#pragma HLS INTERFACE s_axilite port=return
    uint8_t Cur_Part_Size;
    GOST_Data_Part Data_prep;
    uint32_t *GOST_Key_pt=(uint32_t *) GOST_Key;
    uint32_t sz = Size;

    while (Size!=0)
    {
        Cur_Part_Size=_Min(_GOST_Part_Size,Size);
        memset(&Data_prep,_GOST_Def_Byte, 8);
        memcpy(&Data_prep,Data,Cur_Part_Size); //
#if _GOST_ROT==1
        Data_prep.half[_GOST_Data_Part_N2_Half]=_SWAPW32(Data_prep.half[_GOST_Data_Part_N2_Half]);
        Data_prep.half[_GOST_Data_Part_N1_Half]=_SWAPW32(Data_prep.half[_GOST_Data_Part_N1_Half]);
#endif
        if (Mode==_GOST_Mode_Encrypt)
        {
            GOST_Crypt_32_E_Cicle(&Data_prep,GOST_Table,GOST_Key_pt);
        } else
        {
            GOST_Crypt_32_D_Cicle(&Data_prep,GOST_Table,GOST_Key_pt);
        }
#if _GOST_ROT==1
        Data_prep.half[_GOST_Data_Part_N2_Half]=_SWAPW32(Data_prep.half[_GOST_Data_Part_N2_Half]);
        Data_prep.half[_GOST_Data_Part_N1_Half]=_SWAPW32(Data_prep.half[_GOST_Data_Part_N1_Half]);
#endif
        memcpy(Data,&Data_prep, Cur_Part_Size); //
        Data+=Cur_Part_Size;
        Size-=Cur_Part_Size;
   }
    Data -= sz;

    memcpy(Data_out, Data, sz);

    for(int i = 0; i < 24; i++)
    	printf("%hhx ", Data[i]);
}

void GOST_Encrypt_SR_AXI(aes_byte Data[16], aes_byte Data_out[16])
{
#pragma HLS inline region

#pragma HLS INTERFACE axis port=Data
#pragma HLS INTERFACE axis port=Data_out
#pragma HLS INTERFACe s_axilite port=return bundle = CONTROL_BUS

#pragma HLS pipeline

	const uint8_t Size = 16;
	unsigned char data_in[Size];
	unsigned char data_out[Size];

	for (unsigned char i = 0; i < Size; i++) {
		data_in[i] = Data[i].text_byte;
	}

	bool Mode = _GOST_Mode_Encrypt;

	GOST_Encrypt_SR(data_in, Size, Mode, data_out);

	for (unsigned char i = 0; i < Size; i++) {
		Data_out[i].text_byte = data_out[i];
		if (i != (Size - 1))
			Data_out[i].TLAST = false;
		else
			Data_out[i].TLAST = true;
	}
}

#if _GOST_ROT_Synchro_GAMMA==1
void GOST_Crypt_G_PS(uint8_t *Synchro, uint8_t *GOST_Table, uint8_t *GOST_Key)
{
   uint32_t Tmp;
   GOST_Data_Part *GOST_Synchro_prep= (GOST_Data_Part *) Synchro;
   Tmp=(*GOST_Synchro_prep).half[_GOST_Data_Part_N2_Half];
   (*GOST_Synchro_prep).half[_GOST_Data_Part_N2_Half]=(*GOST_Synchro_prep).half[_GOST_Data_Part_N1_Half];
   (*GOST_Synchro_prep).half[_GOST_Data_Part_N1_Half]=Tmp;

   GOST_Crypt_32_E_Cicle(GOST_Synchro_prep, GOST_Table, (uint32_t *) GOST_Key);
}
#endif


void GOST_Crypt_G_Data(uint8_t *Data, uint32_t Size, uint8_t *Synchro, uint8_t *GOST_Table, uint8_t *GOST_Key )
{

    GOST_Data_Part *S=(GOST_Data_Part *)Synchro;
    GOST_Data_Part Tmp;
    uint8_t i;
    while(Size!=0)
    {
        (*S).half[_GOST_Data_Part_N1_Half]+=_GOST_C0;
        _GOST_ADC32((*S).half[_GOST_Data_Part_N2_Half],_GOST_C1,(*S).half[_GOST_Data_Part_N2_Half]);//_GOST_Data_Part_HiHalf

        Tmp=*S;
        GOST_Crypt_32_E_Cicle(&Tmp,GOST_Table,(uint32_t *)GOST_Key);
#if _GOST_ROT==1
        Tmp.half[_GOST_Data_Part_N2_Half]=_SWAPW32(Tmp.half[_GOST_Data_Part_N2_Half]);
        Tmp.half[_GOST_Data_Part_N1_Half]=_SWAPW32(Tmp.half[_GOST_Data_Part_N1_Half]);
#endif
        for (i=0;i<_Min(_GOST_Part_Size,Size);i++)
        {
            *Data^=Tmp.parts[i];
            Data++;
        }
        Size-=i;
    }
}

#if _GOST_ROT_Synchro_GAMMA==1

void GOST_Crypt_GF_Prepare_S(uint8_t *Synchro)
{
    GOST_Data_Part *S=(GOST_Data_Part *)Synchro;
    uint32_t Tmp=(*S).half[_GOST_Data_Part_N1_Half];
    (*S).half[_GOST_Data_Part_N1_Half]=(*S).half[_GOST_Data_Part_N2_Half];
    (*S).half[_GOST_Data_Part_N2_Half]=Tmp;
}
#endif


void GOST_Crypt_GF_Data(uint8_t *Data, uint32_t Size, uint8_t *Synchro, bool Mode, uint8_t *GOST_Table, uint8_t *GOST_Key )
{
    GOST_Data_Part *S=(GOST_Data_Part *)Synchro;
    uint8_t i,Tmp;
    while(Size!=0)
    {

        GOST_Crypt_32_E_Cicle(S,GOST_Table,(uint32_t *)GOST_Key);//C32(S)
#if _GOST_ROT==1
        (*S).half[_GOST_Data_Part_N2_Half]=_SWAPW32((*S).half[_GOST_Data_Part_N2_Half]);
        (*S).half[_GOST_Data_Part_N1_Half]=_SWAPW32((*S).half[_GOST_Data_Part_N1_Half]);
#endif
        for (i=0;i<_Min(_GOST_Part_Size,Size);i++)//Data XOR S; S=Data;
        {
            if (Mode==_GOST_Mode_Encrypt)
            {
                *Data^=(*S).parts[i];
                (*S).parts[i]=*Data;
            } else
            {
                Tmp=*Data;
                *Data^=(*S).parts[i];
                (*S).parts[i]=Tmp;
            }
            Data++;
        }
#if _GOST_ROT==1
        (*S).half[_GOST_Data_Part_N2_Half]=_SWAPW32((*S).half[_GOST_Data_Part_N2_Half]);
        (*S).half[_GOST_Data_Part_N1_Half]=_SWAPW32((*S).half[_GOST_Data_Part_N1_Half]);
#endif
        Size-=i;
    }

}
