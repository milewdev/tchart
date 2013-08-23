# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn if fn != me }

module TChart
  module Main
    
    def self.run(argv)
      args = CommandLineParser.parse(argv)
      settings, items, errors = DataReader.read(args.data_filename)
      check_errors(errors)
      layout = Layout.new(settings, items)
      chart = ChartBuilder.build(layout, items)
      tex = chart.render
      TeXWriter.write(args.tex_filename, tex)
    rescue TChartError => e
      $stderr.puts e.message
    rescue Exception => e
      $stderr.puts e.message
      $stderr.puts e.backtrace.join("\n    ")
    end
    
  private
    
    def self.check_errors(errors)
      raise TChartError, errors.join("\n") if not errors.empty?
    end
    
  end
end
