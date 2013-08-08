#
# SMELL: chart.calc_layout should not be exposed here.
#

# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn if fn != me }

module TChart
  module Main
    
    def self.run(argv)
      args = CommandLineParser.parse(argv)
      settings, items = DataReader.read(args.data_filename)
      items = Builder.build_frame(items)
      layout = Layout.new(settings, items)
      elements = Builder.build(layout, items)
      chart = Chart.new(elements)
      tex = chart.render
      TeXWriter.write(args.tex_filename, tex)
    rescue TChartError => e
      $stderr.puts e.message
    rescue Exception => e
      $stderr.puts e.message
      $stderr.puts e.backtrace.join("\n    ")
    end
    
  end
end
