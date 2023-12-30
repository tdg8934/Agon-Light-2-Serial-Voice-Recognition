   10 REM SERIAL UART EXAMPLE - GRAVITY OFFLINE VOICE RECOGNITION SENSOR
   20 REM RICHARD TURNNIDGE 2023 - Basic adaptation made by Tim Gilmore
   21 REM This version is for 16-bit basic but you could adapt
   22 REM Check if we are running in 24-bit BASIC
   24 :
   25 IF HIMEM > &FFFF PRINT "This code will only run on BBC BASIC for Z80": STOP
   30 :
   31 REM ---------------------------------------------------------
   32 REM This is the uart assembly code 
   33 REM ---------------------------------------------------------
   36 :
   38 REM allocate plenty of memory spaces for the three machine code commands, could be smaller
   39 :
   40 DIM openuart% 64
   50 DIM closeuart% 64
   60 DIM senduart% 64
   80 :
   90 REM This routine is for opening the uart
   91 :
  100 FOR I%=0 TO 3 STEP 3
  110   P%=openuart%
  120   [
  130   OPT I%
  140   :
  150   LD IX, uartstruct               ; Address of the uart struct
  160   ld a, &15
  170   RST &08                         ; mos_uopen
  180   RET
  190   .uartstruct
  200   DEFB &80                        ; LONG (3 bytes) to store baud rate (9600)
  210   DEFB &25
  220   DEFB &00
  230   DEFB 8                          ; data bits
  240   DEFB 1                          ; stop bits
  250   DEFB 0                          ; parity bits
  260   DEFB 0                          ; flow control
  270   DEFB 0                          ; interrupt bits
  280   ]
  290 NEXT
 1000 :
 1010 REM This routine is to close the uart
 1011 :
 1080 FOR I%=0 TO 3 STEP 3
 1090   P%=closeuart%
 1100   [
 1110   OPT I%
 1120   :
 1210   ld a, &16
 1220   RST &08                         ; mos_uclose
 1330   RET
 1370   ]
 1480 NEXT
 1500 :
 2000 REM This routine is to send uart data
 2001 :
 2080 FOR I%=0 TO 3 STEP 3
 2090   P%=senduart%
 2100   [
 2110   OPT I%
 2120   :
 2210   ld c, 65                        ; char to send is stored here
 2215   ld a, &18
 2220   RST &08                         ; mos_uputc
 2330   RET
 2370   ]
 2480 NEXT
 2499 :
 2999 :
 3000 REM ---------------------------------------------------------
 3001 REM This is the user Basic program - Voice Recognition
 3002 REM ---------------------------------------------------------
 3003 :
 3005 CLS : REM Just to make screen clear
 3010 PRINT "Serial uart - Gravity offline voice recognition sensor - example"
 3024 PRINT
 3025 PRINT "(https://wiki.dfrobot.com/SKU SEN0539-EN Gravity Voice Recognition Module I2C UART)"
 3027 PRINT "(https://www.dfrobot.com/product-2665.html)"
 3028 PRINT
 3030 PRINT "Hit SPACEBAR - then say 'Hello Robot' - to see Command ID"
 3033 PRINT "Say other fixed command words 'Open the door', 'Move Forward',etc."
 3035 PRINT "Hit ENTER to exit"
 3040 A = senduart% +1 : REM this is second byte into the routine, store char to send here
 3050 CALL openuart%
 3900 :
 3910 REM this routine sends key presses out the uart
 3920 :
 4000 N = GET : REM wait for a key press
 4010 PRINT CHR$(N); : REM Just so we can see on Agon screen it is doing something
 4020 IF N = 13 THEN GOTO 6000 : REM just using a CR on keyboar to exit this example
 4030 ?A = N : REM poke the char we want to send into this memory byte
 4040 CALL senduart% : REM send the data byte
 4100 IF N = 32 THEN GOTO 5000 : REM if SPACE then go to the READ section
 4110 GOTO 4000 : REM repeat
 4990 :
 5000 REM This section is to READ data from uart and print to the screen
 5001 :
 5005 A% = GET(&D5) : REM  flag for new data D5
 5010 A% = A% AND 1
 5015 IF A% = 0 THEN C% = 0 : GOTO 5030
 5020 B% = GET(&D0)
 5024 IF C% = 7 THEN PRINT B%
 5026 C% = C% + 1
 5030 K = INKEY(0)
 5040 IF K = 83 THEN GOTO 4000 : REM Not sure why yet this line must be here...
 5050 IF K = 13 THEN GOTO 6000 : REM if ENTER is pressed then exit 
 5060 :
 5200 GOTO 5000
 5999 :
 6000 CALL closeuart%
