module FormVisibleConcerns
  module TitleCharactersRange
    def edit_title_characters_range_check_tracker
      Setting.plugin_redmine_keywords['show_title_characters_range_tracker_ids'].include? self.try(:tracker_id).to_s
    end

    def edit_title_characters_range_visible
      User.current.admin? || edit_title_characters_range_any_role? || edit_title_characters_range_role_available
    end

    def edit_title_characters_range_role_available
      User.current.roles.any? && edit_title_characters_range_common_roles.any? && edit_title_characters_range_roles_selected?
    end

    def edit_title_characters_range_common_roles
      User.current.roles_for_project(self.try(:project)).map(&:id).to_a.map(&:to_s) & Setting.plugin_redmine_keywords['show_title_characters_range_role_ids'].to_a.map(&:to_s)
    end

    def edit_title_characters_range_any_role?
      Setting.plugin_redmine_keywords['show_title_characters_range_visible'] == '1'
    end

    def edit_title_characters_range_roles_selected?
      Setting.plugin_redmine_keywords['show_title_characters_range_visible'] == '0'
    end
  end
end
