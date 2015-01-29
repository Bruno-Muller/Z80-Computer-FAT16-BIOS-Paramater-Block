#include "bpb.h"
#include "mbr.h"

__sfr __at (0x00) USART_PORT;
__sfr __at (0x02) SDCARD_PORT;

volatile __at (0x50) unsigned int IO_PARAM1;
volatile __at (0x52) unsigned long IO_PARAM2;

#define SDCARD_READ		0x00

#define SECTOR_SIZE		0x200

#define MBR_ADDRESS		0x1100
#define BPB_ADRESS 		0x1300
#define BOOTSTRAP_ADDRESS 0x1500

#define MBR_PTR			(void*) MBR_ADDRESS
#define BPB_PTR			(void*) BPB_ADRESS
#define BOOTSTRAP_PTR	(void*) BOOTSTRAP_ADDRESS

void print(const char* string) {
	do {
		USART_PORT = *string;
		string++;
	} while (*string != 0);
}

void load_sector_into_memory(void* memory, unsigned long sector_address) {
	IO_PARAM1 = (unsigned int) memory;
	IO_PARAM2 = sector_address;
	SDCARD_PORT = SDCARD_READ;
}

void main() {
	const MasterBootRecord* const mbr = MBR_PTR; // MBR was previously loaded by the BIOS
	const PartitionDescriptor* const partition = &mbr->partitionTable[0]; // We are in the first partition
	const BiosParameterBlock* const bpb = BPB_PTR; // PBP was previously loaded by the MBR
	char* bootstrap = BOOTSTRAP_PTR;
	unsigned int bootstrap_abs_first_sector, bootstrap_abs_final_sector, sector;
	
	
	print("\r\nBOOTSTRAP");
	
	bootstrap_abs_first_sector = partition->firstPartitionSector + 1;
	bootstrap_abs_final_sector = partition->firstPartitionSector + bpb->BPB_RsvSecCnt;
	
	for (sector = bootstrap_abs_first_sector; sector < bootstrap_abs_final_sector; sector++, bootstrap+=512) {
		load_sector_into_memory(bootstrap, sector);
	}
	
	// crt0.s will jump to BOOTSTRAP_PTR
}