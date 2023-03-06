class ApplicationController < ActionController::Base

  def ensure_manager_or_above!
    return if current_user.present? && current_user.manager_or_above?

    redirect_back(fallback_location:"/", alert: "You cannot access this page")
  end

  def ensure_department!
    return if current_user&.admin? || has_access_to_current_task?

    redirect_back(fallback_location:"/", alert: "You cannot access this task")
  end

  def set_current_task(task)
    session[:current_task_id] = task&.id
  end

  private

  def has_access_to_current_task?
    current_task.present? && current_user.role == current_task.department
  end

  def current_task
    return if session[:current_task_id].nil?

    @current_task ||= Task.find(session[:current_task_id])
  end
end
