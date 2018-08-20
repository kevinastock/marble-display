/*
 * Ideas:
 * Morse code message scroller
 * 
 */
int ledPins[] = {3, 9, 10, 11, 13, 6};
int inputPins[] = {0, 1, 4, 8};

/*
  5 bit CIE Lightness to 8 bit PWM conversion
  L* = 116(Y/Yn)^1/3 - 16 , Y/Yn > 0.008856
  L* = 903.3(Y/Yn), Y/Yn <= 0.008856
*/

const uint8_t CIEL8[] = {
  0, // Extra 0 for interpolation 
  0,    1,    2,    3,    4,    5,    7,    9,    12,
  15,    18,    22,    27,    32,    38,    44,    51,    58,
  67,    76,    86,    96,    108,    120,    134,    148,    163,
  180,    197,    216,    235,    255
};

uint8_t interpolate(uint8_t input) {
  uint8_t base = input / 8;
  uint8_t offset = input % 8;

  uint8_t x = CIEL8[base];
  uint8_t y = CIEL8[base+1];
  
  return (uint8_t)(x + offset * ((y-x)/8.0)); 
}

void setup() {
  // nothing happens in setup
  for (int i = 0; i < 4; i++) {
    pinMode(i, INPUT_PULLUP);
  }
}

double rad = 0;
double gap = 3.1415/7;
double rad_step = 0.01;

void loop() {
  for (int j = 0; j < 6; j++) {
    analogWrite(ledPins[j], interpolate(sin(rad+gap*j)*93 + 93 + 70));
    //analogWrite(ledPins[j], interpolate(sin(rad+gap*j)*128 + 128));
  }
  rad += rad_step;
  delay(20);

  /*
  for (int i = 50; i <= 255; i++) {
    for (int j = 0; j < 6; j++) {
      analogWrite(ledPins[j], interpolate(i));
    }
    delay(20);
  }
  for (int i = 254; i > 50; i--) {
    for (int j = 0; j < 6; j++) {
      analogWrite(ledPins[j], interpolate(i));
    }
    delay(20);
  }
  */
}
