## Synopsis

Simply way of patching beams on a remote system.
A backup is made of the loaded beam, and the new beam is injected on the
remote node.

!NB!
the patch made with this is NOT intended for production use.

!WIP!
need to copy over the beam file. It's currently patched through injection, so a restart will incur a loss of the patch.

## Code Example

a absolute path is needed, so that the epatch escript, can load and add the path to the beam.

```

./epatch test@rpg test $PWD/testme.beam
```

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