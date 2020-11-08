class StudentsController < ApplicationController
    skip_before_action :require_user ,only: [:new, :create]
    before_action :set_student,only: [:show ,:edit ,:update]
    before_action :require_same_student ,only: [:edit]
    def index
     @students=Student.all
    end
    def show
        
    end
    def new
     @student=Student.new
    end
    def edit
       
    end
    def update
       
        if @student.update(student_params)
        flash[:notice]="you have sucessfully update your profile"
        redirect_to student_path(@student)
        else
         render "edit"
        end

    end 
    def create
     @student=Student.new(student_params)
     if @student.save
        session[:id]=@student.id
        flash[:notice]="you have sucessfully sign up"
        redirect_to login_path
     else
        render 'new'
     end
    end


private

def student_params
    params.require(:student).permit(:name, :email, :password ,:password_confirmation)
end
def set_student
    @student=Student.find(params[:id])
end

def require_same_student
    # in def update we retrieve the @student
    if current_user != @student
       puts current_user
       flash[:notice]="only you can edit your profile"
    redirect_to student_path(current_user)
    end
end
end