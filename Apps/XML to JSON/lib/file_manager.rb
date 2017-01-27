require 'fileutils'

module FileManager
  APP_ROOT    = File.dirname(__FILE__)
  OUTPUT_DIR  = "output"

  def destroy_dir
    puts "destroy_dir"
    FileUtils.rm_rf( OUTPUT_DIR )
  end
  
  def create_dir
    Dir.mkdir( OUTPUT_DIR )
    #Make it platform independent
    $:.unshift( File.join(APP_ROOT, OUTPUT_DIR ) )
  end

  def create_file(file_path)
    File.join(OUTPUT_DIR, file_path)
  end
  
  def load(file)
    File.open(file)
  end
  
  def save(data, path)
    # Create a File
    output = File.new(path, "w")
    # Save data to File

    output.puts data
  end
end