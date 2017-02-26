module ApplicationHelper
	def find_name(user_id)
		if check_friend(user_id)
			return Friend.find_by(current_id: user_id, user_id: session[:id]).name
		else
			return User.find_by(id: user_id).name
		end
	end
	def check_friend(user_id)
		if (Friend.where(current_id: user_id, user_id: session[:id]).exists?)
			return true
		else 
			return false
		end
	end
	def caret_submit_tag(name)
		out = ''
		out.concat('<button type = "submit" class = "caret_submit">')
			out.concat(name)
			out.concat('<span class = "dropdown"><span class = "caret"></span></span>')
		out.html_safe
	end
end
