require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Starting wiki_projects_plugin for Redmine'

Redmine::Plugin.register :redmine_wiki_projects do

  name 'Redmine Wiki Projects plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  Redmine::WikiFormatting::Macros.register do
desc <<-EOHELP
    ..Display recent news. Examples:

    !{{projects}}
    ...A list showing all direct subprojects user is allowed to access

EOHELP
    macro :projects do |obj, args|
      projects = Project.visible.find(:all)
      html = '<ul>'
      projects.each do |project|
          if project.parent_id != obj.project.id
            next
          end
          html << '<li>'
          html << link_to_project(project, {}, :class => "project")
          html << '</li>'

      end
      html << '</ul>'
    end
  end
end
