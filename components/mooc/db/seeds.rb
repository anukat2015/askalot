# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Shared::Role.find_or_create_by! name: :teacher_assistant

slido = Shared::User.find_by login: :slido

Shared::ContextUser.create user: slido, context_id: 1

course = Shared::Category.find_or_create_by! name: :course, uuid: :course_uuid if Rails.env_type.test?

Shared::Category.find_or_create_by! name: :section, uuid: :section_uuid, parent_id: course.id if Rails.env_type.test?
