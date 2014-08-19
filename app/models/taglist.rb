class Taglist < ActiveRecord::Base
belongs_to :passage
belongs_to :tag
end
