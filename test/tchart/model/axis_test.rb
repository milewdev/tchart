require_relative '../../test_helper'

module TChart
  describe Axis, "render" do
    it "invokes #render on all of its ticks" do
      tick1 = stub ; tick1.expects(:render)
      tick2 = stub ; tick2.expects(:render)
      ticks = [ tick1, tick2 ]
      Axis.new(ticks).render
    end
  end
end
