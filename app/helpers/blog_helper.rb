module BlogHelper
  def render_newer(pages)
    has_newer = pages.current_page > 1
    classes = has_newer ? "prev" : "prev disabled"
    tag = has_newer ? "a" : "span"
    "<#{tag} class=\"#{classes}\">Newer</#{tag}>" # TODO: Internationalize
  end

  def render_older(pages)
    has_older = pages.total_pages > pages.current_page
    classes = has_older ? "go" : "go disabled"
    tag = has_older ? "a" : "span"
    "<#{tag} class=\"#{classes}\">Older</#{tag}>" # TODO: Internationalize
  end
end
