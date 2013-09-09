# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn if fn != me }

module TChart
    
  def self.run(argv)
    args, errors = CommandLineParser.parse(argv)                    ; quit_if_errors(errors)
    settings, items, errors = DataReader.read(args.data_filename)   ; quit_if_errors(errors)
    layout, errors = LayoutBuilder.build(settings, items)           ; quit_if_errors(errors)
    chart = ChartBuilder.build(layout, items)
    tex = chart.render
    TeXWriter.write(args.tex_filename, tex)
  rescue SystemExit
    # Need to eat SystemExit in order for minitest to work.
  end
  
private
  
  def self.quit_if_errors(errors)
    return if errors.empty?
    $stderr.puts errors.join("\n")
    exit
  end
    
end
