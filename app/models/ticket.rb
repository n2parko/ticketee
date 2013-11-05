class Ticket < ActiveRecord::Base
    belongs_to :projects, :dependent => :delete
    validates_presence_of :title
    validates :description, :presence => true, :length => { :minimum => 10 }

end
