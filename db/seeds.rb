
organization = Organization.find_or_create_by(name: "Tam's Company")

projects = [
  "Manhatan",
  "Artemis",
]

tasks = [
  ["Research", User.roles[:engineer]],
  ["Develop", User.roles[:engineer]],
  ["QA", User.roles[:qa]],
  ["Deploy", User.roles[:manager]]
]

projects.each do |project_name|
  Project.find_or_create_by(name: project_name) do |project|
    project.organization = organization
    project.save

    tasks.each do |task_name, department|
      project.tasks.create! \
        name: task_name,
        status: Task.statuses[:ready],
        department: department
    end
  end
end


if Rails.env.development?
  users = [
    ["admin@example.com", User.roles[:admin]],
    ["jane@example.com", User.roles[:manager]],
    ["john@example.com", User.roles[:engineer]],
    ["grace@example.com", User.roles[:qa]],
  ]

  users.each do |email, role|
    User.find_or_create_by(email: email) do |user|
      user.role = role
      user.password = "Test1234!"
      user.password_confirmation = "Test1234!"
      user.otp_secret = User.generate_otp_secret
      user.otp_required_for_login = false
      user.organization = organization
    end
  end
end
