# Based on https://github.com/ryanb/dotfiles/

require "erb"
require "fileutils"
require "pstore"
require "rake"
require "shellwords"

# list of files to sym-link into the ~/ directory
DOTFILES = %w(
  aliases
  gemrc
  gitconfig
  gitignore
  hushlogin
  rspec
  zshenv
  zshrc
  zsh
)

task default: "install:all"

desc "Warn if git origin is newer"
task :check do
  next unless system("git fetch origin")
  next if `git diff HEAD origin/master`.strip.empty?
  log(:yellow, "warning Working copy is out of date; consider `git pull`")
end

namespace :install do

  desc "install everything"
  task all: %i[rvm dotfiles]

  desc "install brew packages"
  task brew: %i[check] do
    `./brew.sh`
  end

  desc "Install dotfiles into user’s home directory"
  task dotfiles: %i[check] do
    always_replace = false

    Dotfile.each do |dotfile|
      case dotfile.status
      when :identical
        log(:green, "identical #{dotfile}")
      when :missing
        dotfile.link!
      when :different
        if always_replace
          dotfile.replace!
        elsif (answer = ask(:red, "overwrite? #{dotfile}"))
          always_replace = true if answer == :always
          dotfile.replace!
        else
          log(:gray, "skipping #{dotfile}")
        end
      end
    end
  end

  desc "Install rvm"
  task :rvm do
    `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
    `\curl -sSL https://get.rvm.io | bash -s stable`
  end

  desc "Install spectacle configuration"
  task :link_spectacles do
    log(:blue, "linking spectacle config")
    FileUtils.ln_s("init/spectacle.json", "~/Library/Application\ Support/Spectacle/Shortcuts.json")
  end

  desc "Symlink the Sublime Packages/User directory"
  task :link_sublime do
    source_sublime = File.join(File.dirname(__FILE__), "sublime")
    dot_sublime = File.expand_path("~/.sublime")
    if !File.exist?(dot_sublime)
      FileUtils.ln_s(source_sublime, dot_sublime)
    end
    user_packages = File.expand_path("~/Library/Application Support/Sublime Text 3/Packages/User")
    if !File.exist?(user_packages)
      log(:magenta, "mkdir Library/Application Support/Sublime Text 3/Packages/User")
      FileUtils.mkdir_p(user_packages)
    end
    if File.directory?(user_packages) && ! File.symlink?(user_packages)
      log(:magenta, "Unable to sym-link existing sublime directory. Please compare #{user_packages} with #{source_sublime}")
      if (answer = ask(:red, "overwrite sublime settings with this-repo?"))
        if answer
          log(:magenta, "rm    Library/Application Support/Sublime Text 3/Packages/User")
          FileUtils.rm_rf(user_packages)
          log(:magenta, "link Library/Application Support/Sublime Text 3/Packages/User")
          FileUtils.ln_s(dot_sublime, user_packages)
        end
      end
    end
  end
end

def log(color, message, options={})
  begin
    require "highline"
  rescue LoadError
  end

  first, rest = message.split(" ", 2)
  first = first.ljust(10)

  if defined?(HighLine::String)
    first = HighLine::String.new(first).public_send(color)
  end

  line = [first, rest].join(" ")

  if line.end_with?(" ")
    print(line)
  else
    puts(line)
  end
end

def ask(color, question)
  log(color, "#{question} [yNaq]? ")

  case $stdin.gets.chomp
  when "a"
    :always
  when "y"
    true
  when "q"
    exit
  else
    false
  end
end

class Dotfile
  def self.each(directory=nil, &block)
    DOTFILES.each do |file_name|
      yield(new(file_name))
    end
  end

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def erb?
    file =~ /\.erb\z/i
  end

  def name
    ".#{file.sub(/\.erb\z/i, "")}"
  end
  alias :to_s :name

  def target
    File.expand_path("~/#{name}")
  end

  def status
    if File.identical?(file, target)
      :identical
    elsif File.exist?(target) || File.symlink?(target)
      :different
    else
      :missing
    end
  end

  def link!(delete_first: false)
    ensure_target_directory

    if erb?
      log(:yellow, "generating #{self}")
      contents = ERB.new(File.read(file)).result(binding)

      log(:blue, "writing #{self}")
      FileUtils.rm_rf(target) if delete_first
      File.open(target, "w") do |out|
        out << contents
      end
    else
      log(:blue, "linking #{self}")
      FileUtils.rm_rf(target) if delete_first
      FileUtils.ln_s(File.absolute_path(file), target)
    end
  end

  def replace!
    link!(delete_first: true)
  end

  def ensure_target_directory
    directory = File.dirname(target)
    return if File.directory?(directory)

    log(:magenta, "mkdir #{File.dirname(name)}")
    FileUtils.mkdir_p(directory)
  end

  def prompt(label)
    default = pstore.transaction { pstore[label] }
    print default ? "#{label} (#{default}): " : "#{label}: "
    $stdout.flush

    entry = $stdin.gets.chomp
    result = entry.empty? && default ? default : entry

    pstore.transaction { pstore[label] = result }
    result
  end

  def pstore
    @_pstore ||= PStore.new(pstore_path)
  end

  def pstore_path
    File.join(__dir__, ".db")
  end
end
