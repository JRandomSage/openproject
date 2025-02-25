class Notification < ApplicationRecord
  REASONS = {
    mentioned: 0,
    assigned: 1,
    watched: 2,
    subscribed: 3,
    commented: 4,
    created: 5,
    processed: 6,
    prioritized: 7,
    scheduled: 8,
    responsible: 9,
    date_alert_start_date: 10,
    date_alert_due_date: 11
  }.freeze

  enum reason: REASONS,
       _prefix: true

  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :project
  belongs_to :journal
  belongs_to :resource, polymorphic: true

  include Scopes::Scoped
  scopes :unsent_reminders_before,
         :mail_reminder_unsent,
         :mail_alert_unsent,
         :recipient,
         :visible

  def date_alert?
    reason.in?(["date_alert_start_date", "date_alert_due_date"])
  end
end
