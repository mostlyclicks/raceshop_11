module Spree::BaseHelper

  def layout_partial
    if devise_controller?
      'spree/base/devise'
    else
      'spree/base/application'
    end
  end

 #  <%#= logo img_options: { class: 'img-responsive', width: '138' } %>

	# def logo(image_path = Spree::Config[:logo], img_options: {} )
 #      link_to image_tag(image_path, img_options), spree.root_path
 #  end

 def nav_picker(taxon)
  @brand = taxon
 end

  def logo_picker(taxon)
    if taxon == 'Rossignol'
      link_to image_tag('Rossignol_Line_RED.png', class: 'img-responsive', width: '138'), '/t/rossignol'
    elsif taxon == 'Dynastar'
      link_to image_tag('LOGO_DYNASTAR_HORIZONTAL.png', class: 'img-responsive', width: '138'), '/t/dynastar'
    elsif taxon == 'Coach'
      link_to image_tag('Rossignol_Line_RED.png', class: 'img-responsive', width: '138'), '/t/coach'
    else
      link_to image_tag('Rossignol_Line_RED.png', class: 'img-responsive', width: '138'), '/'
    end
  end

  def nav_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'dropdown-menu' do
      taxons = root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
        content_tag :li, class: css_class do
         link_to(taxon.name, seo_url(taxon)) +
           taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end
      safe_join(taxons, "\n")
    end
  end

  def taxon_breadcrumbs(taxon, separator = '', breadcrumb_class = 'breadcrumb')
    return '' if current_page?('/') || taxon.nil?

    crumbs = [[t('spree.home'), spree.root_path]]

    crumbs << [t('spree.products'), products_path]
    if taxon
      crumbs += taxon.ancestors.collect { |a| [a.name, spree.nested_taxons_path(a.permalink)] } unless taxon.ancestors.empty?
      crumbs << [taxon.name, spree.nested_taxons_path(taxon.permalink)]
    end

    separator = raw(separator)

    items = crumbs.each_with_index.collect do |crumb, i|
      content_tag(:li, itemprop: 'itemListElement', itemscope: '', itemtype: 'https://schema.org/ListItem') do
        link_to(crumb.last, itemprop: 'item') do
          content_tag(:span, crumb.first, itemprop: 'name') + tag('meta', { itemprop: 'position', content: (i + 1).to_s }, false, false)
        end + (crumb == crumbs.last ? '' : separator)
      end
    end

    content_tag(:nav, content_tag(:ol, raw(items.map(&:mb_chars).join), class: breadcrumb_class, itemscope: '', itemtype: 'https://schema.org/BreadcrumbList'), id: 'breadcrumbs', class: 'sixteen columns stuff')
  end

  def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
      content_tag :ul, class: 'nav navbar-nav navbar-right taxons-list2' do
        taxons = root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
          content_tag :li, class: css_class do
           link_to(taxon.name, seo_url(taxon)) +
             taxons_tree(taxon, current_taxon, max_level - 1)
          end
        end
        safe_join(taxons, "\n")
      end
    end

end