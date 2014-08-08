class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "default.jpg"
	else	
		has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, :default_url => "default.jpg", 
											:storage => :dropbox,
    									:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    									:path => ":style/:id_:filename"
  end

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates_attachment_presence :image

  belongs_to :user

  # This is to make it so that each listing can have multiple orders (if Seller has more than
  #   one of the product). Might want to get rid of this later on if there is only one item
  #   per listing (which is most likely for a video game).
  has_many :orders
end
