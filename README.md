# DanchuParticle

A demo application for a danchu particle effect. This is a prototype to demonstrate the effect, which means that it has no performance optimization at all.

![danchu-particle mov](https://user-images.githubusercontent.com/931655/57913365-6c299400-78c7-11e9-9691-c2908bda2fc1.gif)

## How it works

It is implemented with the very basic knowledges of physics: acceleration, velocity, gravity and friction.

1. Each time the user taps the screen, it generates a random number of views with a random acceleration.
2. On every tick, the friction affects the acceleration.
3. On every tick, the acceleration and the gravity affects the velocity.
4. On every tick, the velocity affects the frame origin.

## Author

Suyeol Jeon (https://github.com/devxoul)
