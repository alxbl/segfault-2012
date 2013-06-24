class Language < ActiveRecord::Base
  attr_accessible :code, :name, :name_en
  validates :name, presence: true
  validates :name_en, presence: true
  validates :code, presence: true, length: { minimum: 2, maximum: 2 }

  def to_param
    code
  end
end
