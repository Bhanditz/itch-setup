package cl

import "github.com/itchio/itch-setup/localize"

// globals, get your globals here!

type CLI struct {
	AppName       string
	VersionString string

	Localizer *localize.Localizer

	PreferLaunch bool
	Uninstall    bool
	Relaunch     bool
	RelaunchPID  int
}