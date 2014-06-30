module SearchesHelper
	def get_average_score(str)
		scores = DriveFeedback.where(:drive_id => str).sum(:score)
		counts = DriveFeedback.where(:drive_id => str).count
		if scores == 0 || counts == 0
			@average = "nan"
		else
			@average = (scores / counts).round(2)
		end

	end
end
