class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: {minimum: 5}, presence: true
  validates :user_id, presence: true

  after_create :send_favorite_emails

  private ###########################

  def send_favorite_emails
    post.favorites.each do |fav|

      # if fav.user_id != self.user_id && fav.user.email_favorites?
      if should_receive_update_for?(fav)
        FavoriteMailer.new_comment(fav.user,post,self).deliver
      end

    end
  end


  def should_receive_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
# the comment's creator cannot  && whoever is trying to create the favorite
# be favoriting his own post       has set 'email_favorites' to 'true'
  end


end
