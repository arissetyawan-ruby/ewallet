module ApplicationHelper

	def you(a, b)
		"(you)" if a==b
	end

	def error_messages_for(obj)
		res= "<ul>"
		obj.errors.each do |k, v|
			res+= "<li>" + k.to_s.humanize + ", " + v.humanize + "</li>"
		end
		res += "</ul>"
		raw(res)
	end
end
