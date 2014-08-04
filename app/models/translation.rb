class Translation < ActiveRecord::Base
belongs_to :user
belongs_to :sentence

validates_length_of :content, minimum:1, maximum: 4096, too_short: "should not be null", too_long: "no longer than 4096 characters"end
