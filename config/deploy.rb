require 'capistrano/ext/multistage'

set :stages, %w"staging production"
set :default_stage, "production"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`