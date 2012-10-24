# -*- coding: utf-8 -*-
module OzjapaneseStyle

  HEADINGS = Common.new_orderd_hash
  HEADING_GROUPS = Array.new
  
  HEADINGS[:ozj_h1] = [true,OzEmployment]
  HEADINGS[:ozj_h2] = [true,OzEmployer]
  HEADINGS[:ozj_h3] = [true,OzSellGood]
  HEADINGS[:ozj_h4] = [true,OzBuyGood]
  HEADINGS[:ozj_h5] = [true,OzEstateShareRent]
  HEADINGS[:ozj_h6] = [true,OzInfoEvent]
  HEADINGS[:ozj_h7] = [true,OzPeoplePro]
  HEADINGS[:ozj_h8] = [true,OzInfoLivingSmart]
  HEADINGS[:ozj_h9] = [true,OzInfoLivingQna]
  
  HEADING_GROUPS.push([:ozj_h1,:ozj_h2])
  HEADING_GROUPS.push([:ozj_h3,:ozj_h4]) 
  HEADING_GROUPS.push([:ozj_h5,:ozj_h6])
  HEADING_GROUPS.push([:ozj_h7]) 
  HEADING_GROUPS.push([:ozj_h8,:ozj_h9]) 
    
  def self.headings
    h = Array.new
    HEADINGS.each do |k,v|
      h.push(k) if v[0]
    end
    h
  end
  
  def self.heading_groups
    HEADING_GROUPS.dup
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
<p>本サイトに投稿、またはコメントする場合は、本サイト上でログインを行う必要があります。本サイトは、FacebookおよびGoogleのアカウントでのみログインが可能です。アカウントをお持ちでない方は、アカウントを作成の上、本サイトのご利用をお願いします。本サイトにおける個人情報の取扱いに関しては、個人情報管理規約を参照ください。</p>
<p>運営にあたっては、利用者の観点から、現存するオーストラリア日本語情報サイト以上のサービスと機能を提供すること念頭に運営を行っています。</p>
<p>一人でも多く方に利用していただけるよう、皆様の意見を日々反映し、よりよい情報交換の場として長く提供できるよう、努力します。</p>
<p class="text-info">本サイトは無料でご利用いただけます。</p>
<p>2012-10-31 管理者</p>
    HTML
    html.html_safe
  end

end