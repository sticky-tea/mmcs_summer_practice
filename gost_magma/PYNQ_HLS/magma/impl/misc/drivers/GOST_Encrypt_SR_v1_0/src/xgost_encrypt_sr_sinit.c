// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xgost_encrypt_sr.h"

extern XGost_encrypt_sr_Config XGost_encrypt_sr_ConfigTable[];

XGost_encrypt_sr_Config *XGost_encrypt_sr_LookupConfig(u16 DeviceId) {
	XGost_encrypt_sr_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XGOST_ENCRYPT_SR_NUM_INSTANCES; Index++) {
		if (XGost_encrypt_sr_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XGost_encrypt_sr_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XGost_encrypt_sr_Initialize(XGost_encrypt_sr *InstancePtr, u16 DeviceId) {
	XGost_encrypt_sr_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XGost_encrypt_sr_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XGost_encrypt_sr_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

