/*
    Fades a line down the channels, with max value and duration based on
 the voltage of analog pin 0.
 Try grounding analog 0: everything should turn off.
 Try putting +5V into analog 0: everything should turn on.
 
 See the BasicUse example for hardware setup.
 
 Alex Leone <acleone ~AT~ gmail.com>, 2009-02-03 */

#include "Tlc5940.h"
#include "tlc_fades.h"
#include "tlc_shifts.h"

uint16_t channel;

int color1 = 128;
int color2 = 128;
int color3 = 128;
int i = 0;

void setup()
{
  Tlc.init();
  randomSeed(analogRead(0));
  Serial.begin(57600);
  channel = 0;
  color1start = random(2048);
  color1stop = random(2048);
  color2start = random(2048);
  color2stop = random(2048);
  color3start = random(2048);
  color3stop = random(2048);
}
uint16_t orgChannel = 0;

void loop()
{

Serial.println (i,DEC);
for ( i;  i <= 15; i++){
  if (color1start < color1stop)
   Tlc.set(i, color1);
//  Tlc.update();
}

for (  i  ;  i > 15 && i <= 31; i++){
  
   Tlc.set(i, color2);
 // Tlc.update();
}

for (  i ;  i > 31 && i <= 47; i++){
  
   Tlc.set(i, color3);
//  Tlc.update();
}
if ( i >= 48){
  
  color1start = color1stop;
  color1stop = random(2048);
  color2start = color2stop;
  color2stop = random(2048);
  color3start = color3stop;
  color3stop = random(2048);
  i = 0;
  Tlc.update();
  delay(64);
}


  
/*channel = random(125);
  if (tlc_fadeBufferSize < TLC_FADE_BUFFER_LENGTH - 12) {
          
   
      if (!tlc_isFading(channel)) {
      uint16_t duration = (analogRead(1) * 2);
      int maxValue =  random(analogRead(0) * 2);
      int maxValue2 = random(analogRead(0) * 2);
      int maxValue3 = random(analogRead(0) * 2);
      uint32_t startMillis = millis() + 50;
      uint32_t endMillis = startMillis + duration;
      tlc_addFade(channel, 0, maxValue, startMillis, endMillis);
      tlc_addFade(channel, maxValue, 0, endMillis, endMillis + duration);
      tlc_addFade(channel + 126, 0, maxValue2, startMillis, endMillis);
      tlc_addFade(channel + 126, maxValue2, 0, endMillis, endMillis + duration);
      tlc_addFade(channel + 252, 0, maxValue3, startMillis, endMillis);
      tlc_addFade(channel + 252, maxValue3, 0, endMillis, endMillis + duration);
     }

    tlc_updateFades();
  /*  if (channel != orgChannel + 288)
    {
      channel = channel + 144;
    }
    else
    {
      channel = random(143);
      orgChannel = channel;
    }
   Serial.println (channel,DEC);
*/
    //Serial.print(channel,DEC);
    // Serial.println();
    //  if (channel++ == NUM_TLCS * 16) {
    //   channel = 0;
    //  }
  //}
  // tlc_updateFades();

  }


