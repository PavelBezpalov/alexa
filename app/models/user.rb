class User < ApplicationRecord
  has_many :transactions

  def new?
    tax_group.nil?
  end
end
