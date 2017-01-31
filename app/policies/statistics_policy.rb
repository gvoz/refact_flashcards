class StatisticsPolicy < Struct.new(:user, :statistics)
  def index?
    if user
      user.admin?
    else
      false
    end
  end
end
