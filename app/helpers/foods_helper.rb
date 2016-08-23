module FoodsHelper

  def color_pick(food)
    if food.avg_score.to_i >= 92
      return "primary"
    elsif food.avg_score.to_i >= 86
      return "warning"
    else
      return "danger"
    end
  end
end
