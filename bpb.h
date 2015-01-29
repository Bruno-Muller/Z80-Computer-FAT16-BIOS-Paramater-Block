#ifndef BPB_H
#define BPB_H

typedef struct {
	unsigned char BS_jmpBoot[3];
	unsigned char BS_OEMName[8];
	unsigned int BPB_BytsPerSec;
	unsigned char BPB_SecPerClus;
	unsigned int BPB_RsvSecCnt;
	unsigned char BPB_NumFATs;
	unsigned int BPB_RootEntCnt;
	unsigned int BPB_TotSec16;
	unsigned char BPB_Media;
	unsigned int BPB_FATs16;
	unsigned int BPB_SecPerTrk;
	unsigned int BPB_NumHeads;
	unsigned long BPB_HiddSec;
	unsigned long BPB_TotSec32;
	unsigned char BS_DrvNum;
	unsigned char BS_Reserved;
	unsigned char BS_BootSig;
	unsigned long BS_VolID;
	unsigned char BS_VolLab[11];
	unsigned char BS_FilSysType[8];
} BiosParameterBlock;

#endif /* BPB_H */