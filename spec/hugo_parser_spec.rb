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
  context "given a date in a format yyyy-Mon-dd" do
    it "parses to a format only made by numbers" do
      date = HugoParser.parse_date "2011-Apr-21"
      expect(date).to eq "2011-04-21"
    end
  end
  context "given a date format" do
    it "parses to a RFC3339 format" do
      dateTime = HugoParser.parse("2011-Apr-21 19:45:03 -0500")
      expect(dateTime).to eq "2011-04-21T19:45:03-05:00"
    end
  end
end
