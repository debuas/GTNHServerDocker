

# A unofficial repository providing automatic GTNH Server Container builds


# current versions

## Stable


`2.7.3` ,  `stable-2.7.3` , `stable-latest`

`2.7.2` ,  `stable-2.7.2` 

`2.7.1` ,  `stable-2.7.1` 

`2.7.0` ,  `stable-2.7.0` 

## Nightly

Nightly images are build every day from [DreamAssembler](https://github.com/GTNewHorizons/DreamAssemblerXXL/actions/workflows/nightly-modpack-build.yml) daily builds

Nightly verrsions are tagged under

- `nightly-latest`
- `nightly-<version>` 
- `nightly-<build-date>`
- `nightly-<build-date>-<version>`
- `nightly-<build-hash>`

to see all available builds , [look here](https://github.com/users/debuas/packages/container/gtnhserverdocker/versions)


# General Information

## Package Structure

```
/
L--app
    L-server
        |--World
        |--visualprospecting
        |--serverutilities
        |--mods
        |--config
        |--backups
        |--blueprints
        |--logs
        |--scripts
        |--eula.txt
        |--server.properties
        |--ops.json
        |--whitelist.json
        |--startserver-java9.sh
        |server-icon.png
```

## example compose file

```yml
services:
    gtnh:
        image: ghcr.io/debuas/gtnhserverdocker:<version>
        ports:
            - "25565:25565"
        restart: always
        volumes:
            - ./world:/app/server/World 
            - ./backups:/app/server/backups
            # if you want to use configs that should persist
            # mount new copy the required files over using `docker cp`
            # or use existing ones
            - ./whitelist.json:/app/server/whitelist.json
            - ./ops.json:/app/server/ops.json
            - ./server.properties/app/server/server.properties
```

to copy over already existing files before mounting use `docker cp`


# Disclaimer

This container was created for my personal use to package GTNH-Server Builds into a convenient way using Docker .
I am not affiliated with the original providers or developers of the software.

## Key Notes:

- The software contained within is subject to its original licensing terms and remains the intellectual property of its respective creators.
- Use at your own risk; I make no guarantees regarding functionality, stability, or suitability for your specific use case.
- Please verify compliance with the licensing terms of the packaged software before use.

For questions or issues related to the software itself, please contact the original maintainers or refer to their official documentation.


