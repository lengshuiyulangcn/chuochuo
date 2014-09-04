#encoding:utf-8
class UsersController < ApplicationController
 before_filter :authenticate_user!, :except=>"show"
	def edit
		@user=User.find(params.permit(:id)[:id])
		if @user!=current_user
			redirect_to user_path(@user.id)
		end
	end
	def show
		@user=User.find(params.permit(:id)[:id])
	end
	def update
		@user=User.find(params.permit(:id)[:id])
		@user.bio=user_params[:bio]
		@user.icon=user_params[:icon]
		@user.qq=user_params[:qq]
		if @user.save
		flash[:notice]="更新个人信息成功"
		else
		flash[:error]="更新个人信息失败"
		end
		redirect_to edit_user_path(@user.id)
		
	end
	def user_params
		params.require(:user).permit(:bio,:icon,:email,:qq)
	end
end
