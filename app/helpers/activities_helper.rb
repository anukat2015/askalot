module ActivitiesHelper
  def activity_icon_tag(activity, options = {})
    data    = notification_data activity
    color   = data[:color][:action]
    type    = activity.action == :mention ? :mention : :persistence
    title   = t "notification.icon.#{type}", action: t("notification.action.#{activity.action}"), resource: t("notification.content.#{type}.#{activity.resource.class.name.downcase}")
    options = options.merge(tooltip_attributes title, placement: :bottom)

    icon_tag data[:icon][:resource], options.merge(class: color, fixed: true)
  end

  def activity_content(activity, options = {})
    resource = activity.resource

    content = case resource.class.name.downcase.to_sym
              when :comment then "notification.content.#{resource.class.name.downcase}.#{resource.commentable.class.name.downcase}.#{activity.action}"
              when :evaluation then "notification.content.#{resource.class.name.downcase}.#{resource.evaluable.class.name.downcase}.#{activity.action}"
              else "notification.content.#{resource.class.name.downcase}.#{activity.action}"
              end

    body    = t("notification.content.#{activity.action == :mention ? :mention : :persistence}.#{resource.class.name.downcase}")
    content = t(content, resource: link_to_notifiable(resource, body: body), question: link_to_notifiable(resource, length: 50)).html_safe
  end
end
