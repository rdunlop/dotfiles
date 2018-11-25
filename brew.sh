#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Echo the commands while they are executed
set -x

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew cask upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

brew install binutils

# Install other useful binaries.
brew install ack
brew install exiv2
brew install git
brew install hub
brew install imagemagick --with-webp
brew install p7zip
brew install tree
brew install vbindiff

brew install heroku/brew/heroku

# Install tools that I use a lot
brew cask install '1password'
brew cask install 'firefox'
brew cask install 'google-chrome'
brew cask install 'slack'
brew cask install 'skype'
brew cask install 'dropbox'
brew cask install 'spectacle'
brew cask install 'sublime-text'
brew cask install 'tripmode'
brew cask install 'phantomjs'
brew cask install 'flux'

# Remove outdated versions from the cellar.
brew cleanup
