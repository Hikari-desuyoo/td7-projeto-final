class FavoritedWorker < ApplicationRecord
  belongs_to :hirer
  belongs_to :worker
end
