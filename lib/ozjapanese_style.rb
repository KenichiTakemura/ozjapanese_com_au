# -*- coding: utf-8 -*-
module OzjapaneseStyle

  HEADINGS = Common.new_orderd_hash
  HEADINGS[:ozj_h1] = [true,OzEmployment]
  HEADINGS[:ozj_h2] = [true,nil]
  HEADINGS[:ozj_h3] = [true,nil]
  HEADINGS[:ozj_h4] = [true,nil]
  HEADINGS[:ozj_h5] = [true,nil]
  HEADINGS[:ozj_h6] = [true,nil]
  HEADINGS[:ozj_h7] = [true,nil]
  HEADINGS[:ozj_h8] = [true,nil]
  HEADINGS[:ozj_h9] = [true,nil]
  HEADINGS[:ozj_h10] = [true,nil]
  HEADINGS[:ozj_h11] = [true,nil]
  HEADINGS[:ozj_h12] = [true,nil]
  HEADINGS[:ozj_h13] = [true,nil]
  HEADINGS[:ozj_h14] = [false,nil]

  def self.headings
    h = Array.new
    HEADINGS.each do |k,v|
      h.push(k) if v[0]
    end
    h
  end

  def self.heading_controller(heading)
    heading.to_s
  end

  def self.heading_model(heading)
    HEADINGS[heading][1]
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
<p class="text-info">本サイトはオーストラリアに在住の日本人の情報交換サイトです。</p>
<p>日本人の方々の生活をサポートを目的に、オーストラリア在住の日本人が運営しています。</p>
<p>運営にあたっては一人でも多く方に利用していただけるよう、皆様の意見を日々反映し、よりよい情報交換の場として長く提供できるよう、努力します。</p>
<p class="muted"><small>本サイトは無料でご利用いただけます。</small></p>
    HTML
    html.html_safe
  end

end