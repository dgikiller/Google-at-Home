#Google@Home

 ***##########################################################***
 
 **ATTENTION! This project is not an official Google Project**
 
 ***##########################################################***
 
 Do you like **Google** services? Would you like to bring them at home too? So are we, so this is why we started the deployment of this 
personal project. *Android@Home* aim is to let control your home in your ownw ay that could be with android device or for example your voice, 
with the feature of an easy installation on every kind of device that have GPIO inteface and could run Linux.
 
Would be great to fuse the Google Now functions in your domotic control of the house: the goal is to speak to your home to make google 
searches, use google now capability and open doors, gates and shutter at the same time.

##Development status

Really, really prototype.

Some things works, others not, that's because it's currently in development so doesn't expect to run something useful now, code is also ugly 
and obscure in some parts.
For now you can setup some agents and a master: you speak at the microphone at an agent and the master compute the answer (currently only for 
testing purpose and mic calibration, defaults to replay what he understood with Google TTS).

##Structure
There are 2 kind of nodes: 

 * masters, 
 * agents or basics nodes. 

A  basic node can either be an agent or a master. 

The master takes the requests of agent's nodes, process them in a unique interface and send a reply back, so you will talk to the same Entity 
but you can ask things in parallel in different places on the house/infrastructure.
The Agents can be a PC or an embedded device and we plan to give also a display interface.


##Configurations
For now, we use SoX for recording on the mic so files are split up by silence (avoiding storage leaks) you have to calibrate properly those 
params.
[Coming Soon]
 
##Todo

 * <del>Making a wrapper to linux gpio functionality</del>
 * <del>Make the node communicate</del>
 * <del>Delivering functions on a master node</del>
 * <del>Master node accept and respond to requests</del>
 * <del>Speech interface thru google</del>
 * <del>SpeechToText thru google</del>
 * Auto-Calibration of mic, or an aided one
 * *Google Now* functionality interface
 * Ideas for a better database schema to collect and display informations
 * Write Display interface
 * Really, really clean the code
 * Agents offline routines
 * Video surveillance and alarm
 * Simple majordomo interface with a personality (did you remember Jarvis?:P)
 * Write an api so to open the possibility to build an Android app or a web interface

***
##Notes

We need to buy a raspberryPi but we are testing our work on a FOXG20 board. But the code is written to be portable so we don't think things 
works really different.
Another thing, this project is strictly correlated with our lifes, that's because we are making our home with that: let's consider us first 
alfa-proto-beta-testers :)

***

Suggestions, pull request or contributors, Bugs report, everything is well accepted.
Contact: mudler@dark-lab.net, skullbocks@dark-lab.net

Everything is released under GPLv3 

