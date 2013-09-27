# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn unless fn == me }

module TChart

  #
  # Program entry point. Responsible for running the various steps
  # required to generate TikZ code that renders a chart.  Also
  # responsible for reporting errors.
  #
  def self.run(argv)
    args, errors = CommandLineParser.parse(argv)                    ; abort_if errors
    settings, items, errors = DataReader.read(args.data_filename)   ; abort_if errors
    layout, errors = LayoutBuilder.build(settings, items)           ; abort_if errors
    chart = ChartBuilder.build(layout, items)
    tex = chart.render
    TeXWriter.write(args.tex_filename, tex)
  end
  
private
  
  def self.abort_if errors
    abort(errors.join("\n")) unless errors.empty?
  end
    
end
