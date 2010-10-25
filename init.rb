require 'redmine'
require 'dispatcher'

Redmine::Plugin.register :redmine_require_closing_note do
  name 'Redmine Require Closing Note plugin'
  author 'Adam Walters'
  description 'Plugin to add validation on Issue which prevents closing of an issue without providing a note'
  version '0.0.1'
end

# This was required for plugin to be included in development environment
Dispatcher.to_prepare do
  require_dependency 'issue'
  unless Issue.included_modules.include? RedmineRequireClosingNote::IssuePatch
    Issue.send(:include, RedmineRequireClosingNote::IssuePatch)
  end
end
