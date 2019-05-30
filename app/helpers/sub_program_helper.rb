module SubProgramHelper
  def track_color(name)
    colors = { :backgroundColor => "", :textColor => "" }
    
    case "#{@track[:name]}"
      when "Designer"
        colors = { :backgroundColor => "#bbdd7a", :textColor => "#616b22" }
      when "Developer"
        colors = { :backgroundColor => "#e2ca66", :textColor => "#695523" }
      when "Founder"
        colors = { :backgroundColor => "#ec833e", :textColor => "#894615" }
      when "Growth"
        colors = { :backgroundColor => "#06b4ea", :textColor => "#044968" }
      when "Maker"
        colors = { :backgroundColor => "#05d3d8", :textColor => "#035c6b" }
      when "Product"
        colors = { :backgroundColor => "#9c9cf2", :textColor => "#3c3c6d" }
      when "People"
        colors = { :backgroundColor => "#e577d0", :textColor => "#663958" }
      when "Spotlight"
        colors = { :backgroundColor => "#63e099", :textColor => "#406c50" }
      else
        colors = { :backgroundColor => "#05d3d8", :textColor => "#ffffff" }
    end
  end
end