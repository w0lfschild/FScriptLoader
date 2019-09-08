# FScriptLoader

![preview](preview.png)

# Information:

- Designed for 10.13+
- mySIMBL plugin to help explore cocoa applications on macOS
- Author: [w0lfschild](https://github.com/w0lfschild)

# Purpose
Runtime exploration of Objective-C and Objective-C++ programs through F-Script's Object Browser and Console.
Specifically, this plugin comes in handy when the program you want to explore disables debugger-attaching, or when the program has no menu bar. In these cases, use mySIMBL to load this plugin, and then use the shortcuts to control F-Script.

# Note:

- Based off code from [SIMBL-fscript](https://github.com/perfaram/SIMBL-fscript) by [perfaram](https://github.com/perfaram)
- Now has FScript bundled into the plugin and blacklist the `Dock.app` which crashes

# Installation:

1. Download [mySIMBL](https://github.com/w0lfschild/app_updates/raw/master/mySIMBL/mySIMBL_master.zip)
2. Download [FScriptLoader](https://github.com/w0lfschild/FScriptLoader/raw/master/build/FScriptLoader.bundle.zip)
3. Unzip downloads
4. Open `FScriptLoader.bundle` with `mySIMBL.app`
5. Restart any application you want to have FScriptLoader injected into

# How to use:
* Use the newly created `F-Script` item in the app's main menu (in the top menu bar).
* Shortcuts : `⌘ + ⌥ + ⇧ + C` to show console, `⌘ + ⌥ + ⇧ + O` to show Object browser.
