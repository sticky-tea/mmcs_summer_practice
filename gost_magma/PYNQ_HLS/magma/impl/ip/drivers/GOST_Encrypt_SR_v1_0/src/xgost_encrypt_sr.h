// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XGOST_ENCRYPT_SR_H
#define XGOST_ENCRYPT_SR_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xgost_encrypt_sr_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XGost_encrypt_sr_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XGost_encrypt_sr;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XGost_encrypt_sr_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XGost_encrypt_sr_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XGost_encrypt_sr_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XGost_encrypt_sr_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XGost_encrypt_sr_Initialize(XGost_encrypt_sr *InstancePtr, u16 DeviceId);
XGost_encrypt_sr_Config* XGost_encrypt_sr_LookupConfig(u16 DeviceId);
int XGost_encrypt_sr_CfgInitialize(XGost_encrypt_sr *InstancePtr, XGost_encrypt_sr_Config *ConfigPtr);
#else
int XGost_encrypt_sr_Initialize(XGost_encrypt_sr *InstancePtr, const char* InstanceName);
int XGost_encrypt_sr_Release(XGost_encrypt_sr *InstancePtr);
#endif

void XGost_encrypt_sr_Start(XGost_encrypt_sr *InstancePtr);
u32 XGost_encrypt_sr_IsDone(XGost_encrypt_sr *InstancePtr);
u32 XGost_encrypt_sr_IsIdle(XGost_encrypt_sr *InstancePtr);
u32 XGost_encrypt_sr_IsReady(XGost_encrypt_sr *InstancePtr);
void XGost_encrypt_sr_EnableAutoRestart(XGost_encrypt_sr *InstancePtr);
void XGost_encrypt_sr_DisableAutoRestart(XGost_encrypt_sr *InstancePtr);

void XGost_encrypt_sr_Set_Size(XGost_encrypt_sr *InstancePtr, u32 Data);
u32 XGost_encrypt_sr_Get_Size(XGost_encrypt_sr *InstancePtr);

void XGost_encrypt_sr_InterruptGlobalEnable(XGost_encrypt_sr *InstancePtr);
void XGost_encrypt_sr_InterruptGlobalDisable(XGost_encrypt_sr *InstancePtr);
void XGost_encrypt_sr_InterruptEnable(XGost_encrypt_sr *InstancePtr, u32 Mask);
void XGost_encrypt_sr_InterruptDisable(XGost_encrypt_sr *InstancePtr, u32 Mask);
void XGost_encrypt_sr_InterruptClear(XGost_encrypt_sr *InstancePtr, u32 Mask);
u32 XGost_encrypt_sr_InterruptGetEnabled(XGost_encrypt_sr *InstancePtr);
u32 XGost_encrypt_sr_InterruptGetStatus(XGost_encrypt_sr *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
