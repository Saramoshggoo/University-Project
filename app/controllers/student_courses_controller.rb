class StudentCoursesController < ApplicationController
 def create
  course_to_add=Course.find(params[:course_id])
  unless current_user.courses.include?(course_to_add)
    StudentCourse.create(course:course_to_add,student:current_user)
    flash[:notice]="you have successfuly enrolled"
    redirect_to current_user
  else
    flash[:notice]="something was wron with enrollement"
    redirect_to root_path
  end
end

end