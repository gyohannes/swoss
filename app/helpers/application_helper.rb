module ApplicationHelper
  def boolean_to_text(bool)
    bool == true ? 'Yes' : 'No'
  end
end
