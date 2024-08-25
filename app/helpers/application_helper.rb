module ApplicationHelper
  BASE_TITLE = "Holohato"

  def param_blank?(param)
    param.blank? || strip_space(param).empty?
  end

  def strip_space(str)
    return "" if str.nil?
    str.gsub(/[[:space:]]/, "")
  end

  def page_title(page_title = "")
    page_title.empty? ? BASE_TITLE : page_title + ' - ' + BASE_TITLE
  end
end
