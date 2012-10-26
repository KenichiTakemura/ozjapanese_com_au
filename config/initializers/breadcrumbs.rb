Gretel::Crumbs.layout do
  
  # Remember to restart your application after editing this file.
  
  # Example crumbs:
  
  crumb :root do
    link "OzJapanese", root_path
  end
  
  crumb :heading do |heading|
     link "#{OzjapaneseStyle.heading_name(heading)}", root_path
     parent :root
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
