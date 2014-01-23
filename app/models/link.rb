class Link < ActiveRecord::Base
	belongs_to :shibe
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: { maximum: 50}
	validates :address, presence: true
	validates :shibe_id, presence: true

  def strip_quotes
    gsub(/\A['"]+|['"]+\Z/, "")
  end

  def add_quotes
     %Q/"#{strip_quotes}"/ 
  end
  
end
