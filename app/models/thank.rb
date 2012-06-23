class Thank < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  attr_accessor :content_type
end
