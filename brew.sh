#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Echo the commands while they are executed
set -x

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew upgrade --cask

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install `wget`
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh

brew install binutils

# Install other useful binaries.
brew install ack
brew install exiv2
brew install git
brew install hub
brew install imagemagick 
brew install p7zip
brew install tree
brew install vbindiff
brew install nvm
brew install circleci

# Kubernetes tools
brew install kubectl
brew install kubectx
brew install aws-iam-authenticator

brew install heroku/brew/heroku

# Install tools that I use a lot
brew install --cask '1password'
brew install --cask 'firefox'
brew install --cask 'google-chrome'
brew install --cask 'skype'
brew install --cask 'dropbox'
brew install --cask 'spectacle'
brew install --cask 'sublime-text'
brew install --cask 'flux'
brew install --cask 'nozbe'
brew install --cask 'docker'

# Remove outdated versions from the cellar.
brew cleanup
