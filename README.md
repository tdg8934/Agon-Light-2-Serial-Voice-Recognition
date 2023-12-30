# Agon-Light-2-Serial-Voice-Recognition
DF Robot - Gravity Offline Voice Recognition Sensor (3.3vdc useage) on Agon Light 2

3.3vdc Voice Recognition communication (serial Rx/Tx) with Agon Light 2
Using Richard Turnnidge serial UART assembly/ basic code with a mini thermal receipt printer and 3.3vdc LCD, I found from DF ROBOT a Gravity Offline Voice Recognition Sensor which is powered by 3.3vdc from the Agon Light 2 (Also works with 5 VDC with libraries/ drivers for the Arduino and Raspberry Pi.).
Similarity like Alexa you speak ‘Hello Robot’ (which you can also have it learn your voice for a different wake word and commands to follow). It will then speak back through its speaker to acknowledge it heard you. It has a table of 200 + fixed commands you can speak to it which produce a command ID code - such as ‘Turn on the light’, ‘Close the window’, etc including 17 commands you can customize and have it learn. My example code reads the UART in the Agon Light 2 and displays the Command code ID. Using this ID you can write additional code and control hardware potentially (relays, etc)
It’s not quite an Alexa but it’s pretty close in many ways.  

https://www.dfrobot.com/product-2665.html
https://wiki.dfrobot.com/SKU_SEN0539-EN_Gravity_Voice...
https://github.com/tdg8934
