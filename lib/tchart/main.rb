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
      settings, y_items = DataReader.read(args.data_filename)
      y_items = Builder.build_frame(y_items)
      layout = Layout.new(settings, y_items)
      x_items = Builder.build_x_items(layout)
      chart = Chart.new(layout, x_items, y_items)
      chart.build
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
