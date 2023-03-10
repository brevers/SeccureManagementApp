
organization = Organization.find_or_create_by(name: "Tam's Company")

projects = [
  "Manhatan",
  "Artemis",
]

tasks = [
  "Research",
  "Develop",
  "QA",
  "Deploy"
]

users = [
  ["admin@example.com", User.roles[:admin]],
  ["jane@example.com", User.roles[:manager]],
  ["john@example.com", User.roles[:engineer]],
  ["grace@example.com", User.roles[:qa]],
]

projects.each do |project_name|
  Project.find_or_create_by(name: project_name) do |project|
    project.organization = organization
    project.save

    tasks.each do |task_name|
      project.tasks.create! \
        name: task_name,
        status: Task.statuses[:ready]
    end
  end
end

users.each do |email, role|
  User.find_or_create_by(email: email) do |user|
    user.role = role
    user.password = "Test1234!"
    user.password_confirmation = "Test1234!"
    user.organization = organization
  end
end
