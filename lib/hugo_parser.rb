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
    <<~TEXTO.chomp
    author:
      name: #{name_val}
    TEXTO
  end

  def self.parse_date_yml(key_value)
    name_val = key_value.split(' ', 2)[1]
    "date: #{parse_full_date(name_val)}"
  end

  def self.read_frontmatter(text)
    a, b = text.each_with_index.find_all{|n,ind| n.include?("---")}.first(2)
    a ,b = a[1], b[1]
    text[a..b].join
  end

  def self.parse_frontmatter(frontmatter)
    frontmatter.split("\n").collect do |n|
      if n.match? "date: "
        parse_date_yml n
      elsif n.match? "author: "
        parse_author_yml n
      else
        n
      end
    end.join("\n") + "\n"
  end

  def self.parse_octo_file(octo_post)
    octo_post = File.readlines(octo_post)
    a, b = octo_post.each_with_index.find_all{|n,ind| n.include?("---")}.first(2)
    a ,b = a[1], b[1]
    frontmatter = parse_frontmatter(octo_post[a..b].join)
    body = octo_post[(b+1)..-1].join("")
    frontmatter + body
  end
end
