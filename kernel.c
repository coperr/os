/* minimal freestanding kernel */
typedef unsigned int   u32;
typedef unsigned short u16;
typedef unsigned char  u8;

void kernel_main(void);

/* write a char at position pos (0..80*25-1) on VGA text-mode */
static inline void putc_at(char c, int pos) {
    volatile u8 *video = (volatile u8*)0xB8000 + pos*2;
    video[0] = (u8)c;
    video[1] = 0x07; /* attribute: light grey on black */
}

void kernel_main(void) {
    const char *msg = "its working, kappa chungus";
    for (int i = 0; msg[i]; ++i) putc_at(msg[i], i);

    /* CPU idle */
    for (;;) {
        __asm__ __volatile__("hlt");
    }
}
