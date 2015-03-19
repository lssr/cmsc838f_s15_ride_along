const int MAG_PIN = 2;
int PREVIOUS_STATE = 1;
int MAG_VAL = 0;
int counter = 0;

void setup() {
  Serial.begin(9600);
  pinMode(MAG_PIN, INPUT);
}

void loop() {
  
  MAG_VAL = digitalRead(MAG_PIN);
  
//  Serial.println(MAG_VAL);
  
  if (MAG_VAL == 0 && PREVIOUS_STATE == 1) {
//    Serial.println(MAG_VAL);
      counter++;
      Serial.println("cycle");
//      Serial.flush();    
  }

  PREVIOUS_STATE = MAG_VAL;
  
//  delay(1);
    
}
