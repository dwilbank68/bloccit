class CommentPolicy < ApplicationPolicy
  # def create?
  #   true
  # end

  def destroy?
    can_moderate?(user,record)
    # user.present? && (record.user == user || user.role == 'admin' || user.role == 'moderator' )
  end

end