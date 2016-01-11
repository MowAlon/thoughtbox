class Link < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, url: {:no_local => true}

  before_validation :insert_http_prefix

  private

    def insert_http_prefix
      self.url = 'http://' + self.url if self.url.first(7) != 'http://'
    end

end