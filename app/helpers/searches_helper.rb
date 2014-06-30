module SearchesHelper
	def get_average_score(str)
		scores = DriveFeedback.where(:drive_id => str.to_s).sum(:score)
		counts = DriveFeedback.where(:drive_id => str.to_s).count
		if scores == 0 || counts == 0
			@average = 0
		else
			@average = (scores / counts).round(2)
		end

	end
end
