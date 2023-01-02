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
      dateTime = HugoParser.parse_full_date("2011-Apr-21 19:45:03 -0500")
      expect(dateTime).to eq "2011-04-21T19:45:03-05:00"
    end
  end

  context "given a semicolon separated key-value (A->B)" do
    it "parses with a new intermediate key (A->C->B)" do
      key_value = HugoParser.parse_author_yml "author: José Juan Reyes Zuñiga"
      output = <<~EOT
      author:
        name: José Juan Reyes Zuñiga
      EOT
      expect(key_value).to eq output
    end
  end
  context "given a semicolon separated key-value (A->B)" do
    it "parses key-value with a new date format" do
      key_value = HugoParser.parse_date_yml "date: 2011-Apr-21 19:45:03 -0500"
      output = "date: 2011-04-21T19:45:03-05:00"
      expect(key_value).to eq output
    end
  end
  context "given a octopress markdown file" do
    it "extracts the frontmatter" do
      post = File.readlines('spec/post.md')
      frontmatter = HugoParser.read_frontmatter post
      output = <<~EOT
      ---
      layout: post
      title: "Podcast 0 de la temporada 0"
      date: 2011-Apr-21 19:45:03 -0500
      author: José Juan Reyes Zuñiga
      comments: true
      categories:
      ---
      EOT
      expect(frontmatter).to eq output
    end
    it "parses the date and author in the frontmatter" do
      post = File.readlines('spec/post.md')
      frontmatter = HugoParser.parse_frontmatter(post)
      output = <<~EOT
      ---
      layout: post
      title: "Podcast 0 de la temporada 0"
      date: 2011-04-21T19:45:03-0500
      author:
        name: José Juan Reyes Zuñiga
      comments: true
      categories:
      ---
      EOT
      expect(frontmatter).to eq output
    end
  end
end
