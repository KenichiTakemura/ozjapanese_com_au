Gretel::Crumbs.layout do
  
  # Remember to restart your application after editing this file.
  
  # Example crumbs:
  
  crumb :root do
    link "OzJapanese", root_path
  end
  
  crumb :heading do |heading|
     link I18n.t("#{heading}.title"), Ozlink.heading_link(heading,"newer")
     parent :root
  end
  
  crumb :older do |heading|
     link I18n.t("post.older"), Ozlink.heading_link(heading,"older")
     parent :heading, heading
  end

  crumb :newer do |heading|
     link I18n.t("post.newer"), Ozlink.heading_link(heading,"newer")
     parent :heading, heading
  end

  crumb :write do |heading|
    link I18n.t("post.write_new"), Ozlink.heading_link(heading,"write")
    parent :heading, heading
  end

  crumb :link_view do |post|
     link post.subject, Ozlink.heading_link(OzjapaneseStyle.heading_by_model(post.class.name),"link_view",{:d => post.id})
     parent :heading, OzjapaneseStyle.heading_by_model(post.class.name)
  end

  
  # crumb :project_issues do |project|
  #   link "Issues", project_issues_path(project)
  #   parent :project, project
  # end
  
  # crumb :issue do |issue|
  #   link issue.name, issue_path(issue)
  #   parent :project_issues, issue.project
  # end

end
