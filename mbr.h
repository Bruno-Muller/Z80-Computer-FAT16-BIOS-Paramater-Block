#ifndef MBR_H
#define	MBR_H

#define IS_BOOTABLE		0x80
#define IS_NOT_BOOTALBE	0x00

#define MBR_SIGNATURE 0xAA55

#define PARTITION_TYPE_EMPTY	0x00
#define PARTITION_TYPE_FAT16	0x04

typedef struct {
	unsigned char bootable;
	unsigned char startingHead;
	unsigned char startingSector;
	unsigned char startingCylinder;
	unsigned char systemID;
	unsigned char endingHead;
	unsigned char endingSector;
	unsigned char endingCylinder;
	unsigned long firstPartitionSector;
	unsigned long numberOfSector;
} PartitionDescriptor;

 typedef struct {
	unsigned char bootPrgm[446];
	PartitionDescriptor partitionTable[4];
	unsigned int signature;
} MasterBootRecord;

#endif /* MBR_H */