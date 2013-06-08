module ArticlesHelper
  def render_newer(pages)
    link_to_if pages.current_page > 1, "Newer", pages.current_page - 1 == 1 ? root_path : page_path(pages.current_page - 1)
  end

  def render_older(pages)
    link_to_if pages.total_pages > pages.current_page, "Older", page_path(pages.current_page + 1)
  end
end
