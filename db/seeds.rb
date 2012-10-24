# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

TopFeedList.category_feed(OzEmployment.name).destroy_all
OzEmployment.destroy_all

# Sample Data
# Not for Production
flyer = Flyer.first

expiry = Common.current_time + 60.days
subject = "法相・滝氏、午後に認証式＝拉致相は官房長官兼務"
html = <<-HTML
　藤村修官房長官は２４日午前の記者会見で、暴力団関係者との交際や外国人献金問題などで辞任した田中慶秋法相兼拉致問題担当相の後任に滝実前法相（７４）を再起用すると発表した。同日午後の皇居での認証式を経て正式に就任する。拉致担当相は藤村氏が兼務する。

【写真で振り返る】辞任、更迭…志半ばで大臣の座を去った政治家たち

　滝氏は今月１日の内閣改造に際し、高齢を理由に退任を希望した経緯があるが、藤村氏は「辞めたいというわけではなかったと聞いている」と述べ、再起用に支障はないとの見解を示した。滝氏は２４日午前、国会内で記者団に「老骨にもう一度むちを入れ直す」と意欲を語った。

　また、藤村氏は自身の拉致担当相兼務について「（政府の）拉致問題対策本部副本部長として、この１年、裏方にも携わってきた」と述べ、同担当相が目まぐるしく交代するこに対する批判に配慮した。【小山由宇】
HTML

59.downto(0) { |x|
  post = OzEmployment.new(:subject => "#{x} #{subject}", :valid_until => expiry);
  post.created_at = Common.current_time - x.days
  content = post.build_content(:body => html)
  post.save
  post.set_user(flyer)
  content.save
}
