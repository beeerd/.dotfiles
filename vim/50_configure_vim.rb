#! /usr/bin/env ruby

puts "Cloning the vim config into ~/.vim"

vim_folder = "#{HOME}/.vim"
git_config = vim_folder + "/.git/config"

def run_clone
  `git clone --recursive https://github.com/beeerd/Vim-Configuration #{HOME}/.vim`
end

if File.exist?(git_config) && File.read(git_config).scan(/beeerd\/Vim-Configuration/)
  Dir.chdir(vim_folder) do
    `git pull`
  end
elsif Dir.exist?(vim_folder)
  backup(vim_folder)
  run_clone
else
  run_clone
end

make_link_where_appropriate("#{vim_folder}/.vimrc", "#{HOME}/.vimrc")

puts "Installing vim bundles with Vundle, this will take a moment"
Dir.chdir(vim_folder) do
  # Install all Vundle plugins
  %x[vim +PluginInstall +qall]
end
