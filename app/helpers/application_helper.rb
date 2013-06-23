module ApplicationHelper
  # Construct the page title.
  def page_title(title)
    base_title = "Segmentation Fault"
    if title.empty?
      base_title
    else
      "#{base_title} : #{title}"
    end
  end

  # Construct the page's html class for page specific styles.
  def page_class(p)
    if p.empty?
      ''
    else
      " class=\"p-#{p}\""
    end
  end

  def static_markdown(content)
    @@md ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true,
                                     :fenced_code_blocks => true,
                                     :no_intra_emphasis => true,
                                     :tables => true)
    @@md.render(content)
  end
end
