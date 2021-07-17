class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, length: {minimum: 250}
	validates :summary, length: {maximum: 250}
	validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
	validate :title_clickbait
	# validates :title, inclusion: {in: %w(Won't Believe Secret Top [number] Guess)}

	def title_clickbait
		clickbait = ["Won't Believe", "Secret", "Top [number]", "Guess"]
		terms = []
		clickbait.each do |term|
			if title && title.include?(term)
				terms << title
			end
		end
		
		if terms.length == 0
			errors.add(:title, "must contain clickbait words")
		end		
	end

end
