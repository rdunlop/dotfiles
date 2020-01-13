# Robin's Dotfile document.

This is a personalized configuration to specify the setup that I use on my laptop.

The goal is to make it easy to re-create my development environment on new systems, if needed.

# What's in it

## Programs

* 1Password
* Skype
* Dropbox
* Spectacle
* TripMode
* SublimeText 3
* Keybase (not working yet)
* Docker (not working yet)
* Nozbe
* CircleCI commandline tool

## Command-line tools

* hub
* git
* zsh
* rvm/ruby
* nvm/node
* heroku toolchain
* chef
* aws (not working yet)

## Configurations

* SublimeText
* Spectacle App

## Reminders

* Install the ssh keys for my various needs from keybase
* Install the VPN for Table XI (ref: https://github.com/tablexi/handbook/blob/master/guides/shared_and_vpn.md)

# Before Installation:

* In System Preferences -> Security & Privacy
  - ensure that “Allow apps downloaded from ‘App Store and identified developers’” is chosen.
  - Ensure that if you leave this page, and return, the setting stays chosen.
    - if not, you may need to reinstall Mac OS
* Run `brew doctor` and resolve any issues with folders / permissions
* Run `brew install gnupg gnupg2`

# Installation

  * install git by running `git`, and having os X prompt you to install it
  * install brew from https://brew.sh
  * install 1password with `brew cask install 1password`
  * install keybase with `brew cask install keybase`
    * Login to keybase, using an existing device for authentication
    * In Keybase-Settings, enable the "Files" feature, to mount the Keybase filesystem
    * `cd /Keybase/private/robindunlop`
    * Install the ssh keys with `cd ssh_config && ./install.sh`
    * Install the ssh keys with `cd aws_config && ./install.sh`
  * download this repo
    * `cd ~/`
    * `git clone https://github.com/rdunlop/dotfiles.git`
    * `cd dotfiles`

Run one of the three installation options:

    rake install:brew            # Install homebrew packages and Mac defaults
    rake install:link_spectacles # Install Spectacles.app config
    rake install:link_sublime    # Sym-link/install SublimeText configurations
    rake install:dotfiles        # Install the dotfiles and scripts
    rake install:rvm             # Install ruby version manager
    rake install:mac_os_settings # set up some nice-to-configure mac settings
    rake install:all             # Install all of the above (recommended)

Remap the Caps-lock key to Escape:

  * https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x/40254864#40254864

## Sublime Text Troubleshooting

If the Sublime Text packages do not appear to be working, install the "Package Control" package, and then they should start working.

## Configuration

1. Set up 1Password manager by using an existing 1password app (on your phone, for example), sync passwords.
1. Set up Keybase running `keybase login`
1. run `/Keybase/private/robindunlop/ssh_config/install.sh` to install the ssh keys
1. run `/Keybase/private/robindunlop/aws_config/install.sh` to install the ssh keys

### macOS defaults

Some macOS defaults:

```bash
./.macos
```

### Install Homebrew-sourced programs

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.


