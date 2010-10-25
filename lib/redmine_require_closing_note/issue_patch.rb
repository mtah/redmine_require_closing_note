module RedmineRequireClosingNote
  module IssuePatch

    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
        before_save :require_closing_note
      end
    end

    module InstanceMethods

      private
      def require_closing_note
        if closing? && @current_journal.notes.blank?
          errors.add(:base, "A note is required when closing an issue")
          return false
        end
      end
    end
  end
end
