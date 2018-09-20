## Synopsis

Simply way of patching beams on a remote system.
A backup is made of the loaded beam, and the new beam is injected on the
remote node.

## Code Example

./epatch test@rpg test $PWD/testme.beam

## Motivation

It's annoyting having to 1) scp files, 2) start remote shells 3) backup beam files 4) load beams 5) check it's the correct beam that's loaded, and repeat that over all the distributed nodes.

## Installation

```
git clone https://github.com/ruanpienaar/epatch
cd epatch
make
```

## License

Apache-2.0