## tmp36 sensor site for particle demo

Just a small site to demo the tmp36, sinatra, heroku and ajax.

Possibly add postgres for historical data, talk about models, etc. Then reach is to add graph.js. Should be fun. IoT wubba lubba dub dub.

Super simple arduino-y code here (works for core + photon):
```cpp
int analogValue = 0;
double tempC = 0.0;

void setup() {
    Particle.variable("analogValue", analogValue);
    Particle.variable("tempC", tempC);

    pinMode(A5, INPUT);
}

void loop() {
    analogValue = analogRead(A5);
    tempC = (((analogValue * 3.3) / 4095) - 0.5) * 100;
}
```
