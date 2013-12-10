Redmine::Plugin.register :redmine_numbering do
  name 'Redmine Numbering plugin'
  author 'to9a'
  description 'This is a plugin for Redmine to numbering'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :numbering do
    permission :manage_numbering_param, :numbering_prefixes => [:index,:new, :edit, :create, :update, :destroy, :param_index, :param_add_category, :param_add_kind, :param_add_partner],
                                        :numbering_prefixes_categories => [:new, :edit, :create, :update, :destroy],
                                        :numbering_prefixes_kinds => [:new, :edit, :create, :update, :destroy], 
                                        :numbering_prefixes_partners => [:new, :edit, :create, :update, :destroy],:require => :member

    permission :view_numbering_item, :numbering_items => [:index, :show]
    permission :manage_numbering_item,:numbering_items => [:new, :edit, :create, :update, :destroy, :preview],:require => :member
  end

  menu :project_menu, :numbering, 
      {:controller => 'numbering_items', :action => 'index'}, 
      :param => :project_id
end
