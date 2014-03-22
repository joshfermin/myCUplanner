module UsersHelper
	def full_title(page_title)
	  base_title = "myCUplanner"
	  if page_title.empty?
	    base_title
	  else
	    "#{page_title}"
	  end
	end
end
