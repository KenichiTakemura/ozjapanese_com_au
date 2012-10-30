# -*- coding: utf-8 -*-
module OzjapaneseStyle
  
  HEADINGS = Common.new_orderd_hash
  
  HEADINGS[:ozj_all] = [false,nil,nil]  
  HEADINGS[:ozj_h1] = [true,OzEmployment,0]
  HEADINGS[:ozj_h2] = [true,OzEmployer,0]
  HEADINGS[:ozj_h3] = [true,OzSellGood,1]
  HEADINGS[:ozj_h4] = [true,OzBuyGood,1]
  HEADINGS[:ozj_h5] = [true,OzEstateShareRent,2]
  HEADINGS[:ozj_h6] = [true,OzInfoEvent,2]
  HEADINGS[:ozj_h8] = [true,OzInfoLivingSmart,3]
  HEADINGS[:ozj_h9] = [true,OzInfoLivingQna,3]
  
  HEADINGS[:ozj_h7] = [false,OzPeoplePro,nil]
  #HEADINGS[:ozj_h11] = [false,nil,nil]
  
  def self.all_headings
    HEADINGS.collect { |k,v| k }
  end
  
  def self.headings
    h = Array.new
    HEADINGS.each do |k,v|
      h.push(k) if v[0]
    end
    h
  end
  
  def self.heading_by_model(model)
    HEADINGS.each do |k,v|
      return k if v[1].to_s.eql?(model)
    end
  end
  
  def self.heading_groups
    h = Array.new
    headings.each do |k|
      i = HEADINGS[k][2]
      h[i] = Array.new if h[i].nil?
      h[i].insert(-1,k)
    end
    h
  end
  
  def self.group_id(heading)
    HEADINGS[heading][2]
  end

  def self.heading_controller(heading)
    heading.to_s
  end

  def self.heading_model(heading)
    HEADINGS[heading][1]
  end

  def self.heading_model_name(heading)
    HEADINGS[heading][1].to_s
  end
  
  def self.heading_name(heading, locale=nil)
    if locale.present?
      return I18n.t("#{heading}.title", :locale => locale)
    else
      return I18n.t("#{heading}.title")
    end
  end

  def self.hello_description
    html = <<-HTML
<p>本サイトはオーストラリアに在住の日本人の情報交換サイトです。</p>
<p>ワーホリ、移住、ビジネス、親子ステイ、リタイア・・すべての方のご利用を歓迎します。</p>
	  HTML
    html.html_safe
  end

  def self.about_site
    html = <<-HTML
<p class="text-success">OzJapaneseのご利用、誠にありがとうございます。</p>
<p class="text-info">本サイトはオーストラリアに在住の日本人の情報交換サイトです。</p>
<p>現時点は、ブリスベンを対象にサービスを提供しています。</p>
<p>日本人の方々の生活をサポートを目的に、オーストラリア在住の日本人が運営しています。</p>
<p>本サイトは、皆様からの投稿により成り立つサイトです。皆様からの投稿を心よりお待ちしております。</p>
<p>本サイトに投稿、またはコメントする場合は、本サイト上でログインを行う必要があります。本サイトは、FacebookおよびGoogleのアカウントでのみログインが可能です。アカウントをお持ちでない方は、FacebookおよびGoogleのアカウントを作成の上、本サイトのご利用をお願いします。本サイトにおける個人情報の取扱いに関しては、個人情報管理規約を参照ください。</p>
<p>運営にあたっては、利用者一人一人の声を聞き、利用者の観点から、現存するオーストラリア日本語情報サイト以上のサービスと機能を提供すること念頭に運営を行っています。</p>
<p>一人でも多く方に利用していただけるよう、皆様の意見を日々反映し、よりよい情報交換の場として長く提供できるよう、努力します。</p>
<p class="text-info">本サイトは無料でご利用いただけます。</p>
<strong><p class="text-success">ミッションステートメント</p></strong>
<ul>
<li>オーストラリア日本語サイトで、最も支持されるサイトを目指します。</li>
<li>利用者全員の声、やりたいを反映し、最も見たいサイトを目指します。</li>
<li>欲しかった情報が見つかるサイトを目指します。</li>
<li>利用者が書き込みやすい、簡単に使えるサイトを目指します。</li>
</ul>

<p>2012-10-31 管理者</p>
    HTML
    html.html_safe
  end
  
end