# The Reformed Devs Monthly Challenge Docker

## Introduction

This container is meant to be used in conjunction with The Reformed Devs monthly challenge. The container will run the appropriate scripts to execute the tests and update the leaderboard/scores.

Each challenege will have a corresponding tag.

If you need language support for your solution and are having Docker trouble, come on over to the #monthly-challenge channel on our Slack.

## Supported Languages

This version of the container supports:

* C/C++
* Node 11
* Python 3.6
* Ruby

## Running the Container

The container expects you to mount the root directory of a challenge repo into /home/repo when running. The repo must have a run_solutions.py file.

A typical run command would look something like this (using the 2019.10 tag):

`docker run -it --rm -v $(pwd):/home/repo drewpearce/trd-challenge:2019.10`

## Challenge Archive

* [April 2019](https://github.com/plusuncold/longest-word-test)
* [May 2019](https://github.com/plusuncold/rainfall-calc-challenge)
* [June 2019](https://github.com/ReformedDevs/challenge-2019-06)
* [July 2019](https://github.com/ReformedDevs/challenge-2019-07)
* [September 2019](https://github.com/ReformedDevs/challenge-2019-09)
* [October 2019](https://github.com/ReformedDevs/challenge-2019-10)
