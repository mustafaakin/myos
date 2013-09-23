void putc(unsigned int pos, char c){
	char* video = (char*)0xB8000;
	video[2 * pos ] = c;
	video[2 * pos + 1] = 0x3F;
}

void puts(int place, char* str){
	while(*str){		
		putc(place++, *(str++));
	}
}

void welcome(){
	char* video = (char*)0xB8000;
	
	int i,j, pos;
	for(i = 0; i < 80; i++){
		for(j=0; j < 25; j++){
			pos = i + j * 80;
			video[2 * pos ] = ' ';
			video[2 * pos + 1] = 0x3F;			
		}
	}

	puts(80*10 + 30, "Welcome to my OS");

}

void printNo(int place, int a){		
	puts(place, "Memory:");
	puts(place + 18, "bytes");
	int count = 0;	
	while(a > 0){
		char c = (char)(a % 10) + 48;
		putc(place + 16, c);
		place--;
		a = a / 10;
		count--;		
		if ( count % 3 == 0){
			place--;
		}
	}
}

int main (void)
{
	welcome();

	int *i;
	for(i = 0x01000000; i < 0xFFFFFFFF ; i++){
		printNo(80*5, (int) i);	
		*i = 0x0BAD0DAD;
		if ( *i != 0x0BAD0DAD){ // test if the write was succesful, tests above 16M
			break;
		}
	}

	puts(80*12 + 32, "Mustafa Akin");

    while(1) {}
    return 0;
}
