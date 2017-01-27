# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##
# Config
#
require 'fileutils'
require 'singleton'

class Config
  
  include Singleton

  # Directories
  attr_reader :input_dir, :output_dir
  # File Paths
	attr_reader :r_path, :csv_path, :out_path
  def initialize
    @input_dir  = File.join(APP_ROOT, 'src')
    @output_dir = File.join(APP_ROOT, 'bin')
    
    @r_path     = File.join(@input_dir, "analysis", "monte_carlo.R")
    
    @csv_path   = File.join(@output_dir, "simulation.csv")
    @out_path   = File.join(@output_dir, "simulation.out")
  end
end
