# README

A simple ROR app that has two models
1) Givers
2) Takers

Both are exactly same. 
They communicate with each other using Wisper gem which provides a pubsub based domain communication
method.

Givers publish the location of food and TakerListener will listen to that and notify the nearby taker.
Only one taker should be notified to avoid conflict. 