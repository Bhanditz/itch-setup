UPX ?= echo
UPX_LEVEL ?= -1
RACE ?= 0
_GO_BUILD_FLAGS ?= -v

ifeq ($(RACE),1)
_GO_BUILD_FLAGS := $(_GO_BUILD_FLAGS) -race
endif

ifeq ($(OS),Windows_NT)
SETUP_OS:=windows
  ifeq (GOOS,386)
GOBIN:=${GOPATH}/bin/windows_386
  else
GOBIN:=${GOPATH}/bin
  endif
else
UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Linux)
SETUP_OS:=linux
GOBIN:=${GOPATH}/bin
  else
  ifeq ($(UNAME_S),Darwin)
SETUP_OS:=darwin
GOBIN:=${GOPATH}/bin
  else
SETUP_OS:=unknown
  endif
endif
endif

all:
	@make $(SETUP_OS)

linux:
	go get ${_GO_BUILD_FLAGS} -tags gtk_3_18
	${UPX} ${UPX_LEVEL} ${GOBIN}/itch-setup
	cp -f ${GOBIN}/itch-setup ${GOBIN}/kitch-setup

windows:
	windres -o itch-setup.syso itch-setup.rc
	go get ${_GO_BUILD_FLAGS} -ldflags="-H windowsgui"
	${UPX} ${UPX_LEVEL} ${GOBIN}/itch-setup.exe
	cp -f ${GOBIN}/itch-setup.exe ${GOBIN}/kitch-setup.exe

darwin:
	go get ${_GO_BUILD_FLAGS}
	${UPX} ${UPX_LEVEL} ${GOBIN}/itch-setup
	cp -f ${GOBIN}/itch-setup ${GOBIN}/kitch-setup

