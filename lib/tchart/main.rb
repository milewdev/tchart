require 'stringio'

# 'require' all files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn if fn != me }

module TChart
  module Main
    def self.run(argv)
      args = CommandLineParser.parse(argv)
      settings, items = DataReader.read(args.data_filename)
      chart = Chart.new(settings, items)
      chart.calc_layout
      tex = TeXGenerator.generate(chart)
      TeXWriter.write(args.tex_filename, tex)
    rescue TChartError => e
      $stderr.puts e.message
    rescue Exception => e
      $stderr.puts e.message
      $stderr.puts e.backtrace.join("\n    ")
    end
  end
end
