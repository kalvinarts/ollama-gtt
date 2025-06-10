#!/run/current-system/sw/bin/env bash

# WARNING: This worked on Fedora42 with the the appropiate deps (which I don't remember anymore)

THREADS=12
AMDGPU_TARGETS=
CMAKE_HIP_PLATFORM=

cmake --preset 'CPU'
cmake --build --parallel $THREADS --preset 'CPU'
cmake --preset 'ROCm 6'
cmake --build --parallel $THREADS --preset 'ROCm 6'
cmake --install build  --parallel $THREADS
export CGO_ENABLED=1
export GOFLAGS="'-ldflags=-w -s'"
go build -trimpath -buildmode=pie -o dist/bin/ollama .
