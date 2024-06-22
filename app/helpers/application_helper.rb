module ApplicationHelper
  def param_blank?(param)
    param.blank? || strip_space(param).empty?
  end

  def strip_space(str)
    return "" if str.nil?
    str.gsub(/[[:space:]]/, "")
  end
end
