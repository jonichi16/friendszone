module UsersHelper
  def format_date(date)
    date.strftime("%B %Y")
  end

  def friends_count(user)
    pluralize(Friend.followed_by(user).size, "person")
  end

  def get_location(user)
    user.location.titlecase
  end
end
