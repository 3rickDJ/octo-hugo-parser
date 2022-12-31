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

  def self.parse_full_date(full_date)
    date, time, utc = split(full_date)
    date = parse_date(date)
    time = 'T'+time
    utc.insert 3, ':'
    date+time+utc
  end

  def self.parse_author_yml(key_value)
    name_val = key_value.split(' ', 2)[1]
    <<~TEXTO
    author:
      name: #{name_val}
    TEXTO
  end
end
