class LayoutTestController < ApplicationController
	def test_page
		@var = "afsafasf"
		render layout: "layouts/brain_writing_layout"
	end
end
