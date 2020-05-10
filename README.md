## Etcp
Simple TCP server in Erlang

## Usage
There are several ways Erlang programs can be started:
- Interactive shell (REPL)
- [Erlang Release](https://erlang.org/doc/design_principles/release_structure.html)

> N.B. Etcp Makefile is generated via [erlang.mk](https://erlang.mk/)

### Interactive Shell
```bash
make
erl -pa ./ebin
```

Then in Erlang shell:
```erlang
> etcp_app:start(1, 2).
```

### Release
To build a release and run it:
```bash
make run
```

To build a release (without running it):
```bash
make rel
```

## License
Apace-2.0