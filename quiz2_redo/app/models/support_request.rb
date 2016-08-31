class SupportRequest < ApplicationRecord
  paginates_per 7

  validates :name, presence: true
  validates :email, presence: true

  after_initialize :set_status_default

  def set_status_default
    self.status ||= false
  end

  def self.search(query)
    if (query)
      where(["name LIKE ? OR email LIKE ? OR department LIKE ? OR message LIKE ? ", "%#{query}", "%#{query}", "%#{query}", "%#{query}"])
    else
      all
    end
  end

end
