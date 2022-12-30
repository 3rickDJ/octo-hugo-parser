require 'hugo_parser'
describe HugoParser do
  context "given a date format" do
    it "splits into date, time, UTC difference" do
       date, time, utc = HugoParser.split("2011-Apr-21 19:45:03 -0500")
      expect(date).to eq "2011-Apr-21"
      expect(time).to eq "19:45:03"
      expect(utc).to eq "-0500"
    end
  end
end
