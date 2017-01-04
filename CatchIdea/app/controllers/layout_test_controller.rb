class LayoutTestController < ApplicationController
	def test_idea
		render layout: "layouts/main_layout"
	end
	def test_friend
		render layout: "layouts/main_layout"
	end 
	def test_profile
		render layout: "layouts/main_layout"
	end
	def test_discrition
		render layout: "layouts/main_layout"
	end
	def test_sign_in
		render layout: "layouts/sign_in_layout"
	end
	def test_sign_up
		render layout: "layouts/main_layout"
	end
end
