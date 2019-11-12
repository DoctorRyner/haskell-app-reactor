# haskell-app-reactor

## Prerequisites

First of all you need to install haskell build tool https://docs.haskellstack.org/en/stable/install_and_upgrade/

Then I suggest you to install ghcid, it allows you to use hot reloading and rerun your code automatically
```haskell
stack install ghcid
```

## Running

There are two scripts in Equations.yaml

1. gui-dev – runs frontend in developer mode
2. api-dev – runs backend in developer mode

You might want to install https://github.com/DoctorRyner/sae or translate it to Makefile

But you always just can copy and paste `cd gui && ghcid -c "stack ghci gui shared" -r=debugApp` manually

## Go get some food

For HTTP requests I had to create this library https://github.com/DoctorRyner/miso-http

And it uses some of the hugest dependencies in all Haskell so it will take some time to build it, be patient
