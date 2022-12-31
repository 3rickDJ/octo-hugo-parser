class HugoParser
  @@month = {
  "Jan" => "01",
  "Feb" => "02",
  "Mar" => "03",
  "Apr" => "04",
  "May" => "05",
  "Jun" => "06",
  "Jul" => "07",
  "Aug" => "08",
  "Sep" => "09",
  "Oct" => "10",
  "Nov" => "11",
  "Dec" => "12"
  }
  def self.split(time_format)
    time_format.split
  end

  def self.parse_date(date)
    month = date.scan(/[A-Z][a-z]{2}/).pop
    date.gsub(month,@@month[month])
  end
end
