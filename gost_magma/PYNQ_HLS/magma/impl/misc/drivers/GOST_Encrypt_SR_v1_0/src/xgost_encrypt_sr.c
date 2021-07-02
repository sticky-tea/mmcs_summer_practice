// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xgost_encrypt_sr.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XGost_encrypt_sr_CfgInitialize(XGost_encrypt_sr *InstancePtr, XGost_encrypt_sr_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XGost_encrypt_sr_Start(XGost_encrypt_sr *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL) & 0x80;
    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XGost_encrypt_sr_IsDone(XGost_encrypt_sr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XGost_encrypt_sr_IsIdle(XGost_encrypt_sr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XGost_encrypt_sr_IsReady(XGost_encrypt_sr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XGost_encrypt_sr_EnableAutoRestart(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XGost_encrypt_sr_DisableAutoRestart(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_AP_CTRL, 0);
}

void XGost_encrypt_sr_Set_Size(XGost_encrypt_sr *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_SIZE_DATA, Data);
}

u32 XGost_encrypt_sr_Get_Size(XGost_encrypt_sr *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_SIZE_DATA);
    return Data;
}

void XGost_encrypt_sr_InterruptGlobalEnable(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_GIE, 1);
}

void XGost_encrypt_sr_InterruptGlobalDisable(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_GIE, 0);
}

void XGost_encrypt_sr_InterruptEnable(XGost_encrypt_sr *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_IER);
    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_IER, Register | Mask);
}

void XGost_encrypt_sr_InterruptDisable(XGost_encrypt_sr *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_IER);
    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_IER, Register & (~Mask));
}

void XGost_encrypt_sr_InterruptClear(XGost_encrypt_sr *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XGost_encrypt_sr_WriteReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_ISR, Mask);
}

u32 XGost_encrypt_sr_InterruptGetEnabled(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_IER);
}

u32 XGost_encrypt_sr_InterruptGetStatus(XGost_encrypt_sr *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XGost_encrypt_sr_ReadReg(InstancePtr->Control_BaseAddress, XGOST_ENCRYPT_SR_CONTROL_ADDR_ISR);
}

