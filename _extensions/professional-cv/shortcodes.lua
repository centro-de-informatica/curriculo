--[[
  Shortcodes for Professional CV & Cover Letter Quarto Extension
  FAANG-style: Clean, no visual gimmicks, ATS-friendly
  
  RESUME SHORTCODES:
  {{< entry title="..." company="..." dates="..." loc="..." >}}
  {{< skill name="..." >}}
  {{< project name="..." tech="..." >}}
  {{< language name="..." level="..." >}}
  
  COVER LETTER SHORTCODES:
  {{< recipient name="..." title="..." company="..." address="..." >}}
  {{< greeting text="..." >}}
  {{< closing text="..." >}}
  {{< subject text="..." >}}
]]--

return {
  -----------------------------------------------------------------------------
  -- RESUME SHORTCODES
  -----------------------------------------------------------------------------
  
  -- Entry shortcode: CV entry with title, company, dates, location
  ["entry"] = function(args, kwargs, meta)
    local title = pandoc.utils.stringify(kwargs["title"] or "")
    local company = pandoc.utils.stringify(kwargs["company"] or "")
    local dates = pandoc.utils.stringify(kwargs["dates"] or "")
    local loc = pandoc.utils.stringify(kwargs["loc"] or kwargs["location"] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex = string.format(
        '\\cventry{%s}{%s}{%s}{%s}',
        title, company, dates, loc
      )
      return pandoc.RawInline('latex', latex)
    else
      local html = string.format(
        '<div class="cv-entry"><strong>%s</strong> | %s <span style="float:right">%s | %s</span></div>',
        title, company, dates, loc
      )
      return pandoc.RawInline('html', html)
    end
  end,

  -- Skill shortcode: simple text, no level indicators
  ["skill"] = function(args, kwargs, meta)
    local name = pandoc.utils.stringify(kwargs["name"] or args[1] or "")
    -- Level is ignored - FAANG style doesn't use visual skill ratings
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex = string.format('\\cvskill{%s}{}', name)
      return pandoc.RawInline('latex', latex)
    else
      local html = string.format('<span>%s</span><br>', name)
      return pandoc.RawInline('html', html)
    end
  end,

  -- Project shortcode
  ["project"] = function(args, kwargs, meta)
    local name = pandoc.utils.stringify(kwargs["name"] or "")
    local tech = pandoc.utils.stringify(kwargs["tech"] or kwargs["technologies"] or "")
    local link = pandoc.utils.stringify(kwargs["link"] or kwargs["url"] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex
      if link ~= "" then
        latex = string.format('\\cvproject{\\href{%s}{%s}}{%s}', link, name, tech)
      else
        latex = string.format('\\cvproject{%s}{%s}', name, tech)
      end
      return pandoc.RawInline('latex', latex)
    else
      local html
      if link ~= "" then
        html = string.format('<div><strong><a href="%s">%s</a></strong> <em>(%s)</em></div>', link, name, tech)
      else
        html = string.format('<div><strong>%s</strong> <em>(%s)</em></div>', name, tech)
      end
      return pandoc.RawInline('html', html)
    end
  end,

  -- Language shortcode
  ["language"] = function(args, kwargs, meta)
    local name = pandoc.utils.stringify(kwargs["name"] or args[1] or "")
    local level = pandoc.utils.stringify(kwargs["level"] or args[2] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex = string.format('\\cvlanguage{%s}{%s}', name, level)
      return pandoc.RawInline('latex', latex)
    else
      local html = string.format('<span>%s: %s</span><br>', name, level)
      return pandoc.RawInline('html', html)
    end
  end,

  -- Award/Certification shortcode
  ["award"] = function(args, kwargs, meta)
    local title = pandoc.utils.stringify(kwargs["title"] or "")
    local org = pandoc.utils.stringify(kwargs["org"] or kwargs["organization"] or "")
    local year = pandoc.utils.stringify(kwargs["year"] or kwargs["date"] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex = string.format('\\noindent\\textbf{%s} | %s, %s\\\\[2pt]', title, org, year)
      return pandoc.RawInline('latex', latex)
    else
      local html = string.format('<div><strong>%s</strong> | %s, %s</div>', title, org, year)
      return pandoc.RawInline('html', html)
    end
  end,

  -- Columns layout
  ["columns"] = function(args, kwargs, meta)
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', '\\begin{minipage}[t]{0.48\\textwidth}')
    else
      return pandoc.RawInline('html', '<div style="display:flex;gap:2em;"><div style="flex:1;">')
    end
  end,

  ["column-break"] = function(args, kwargs, meta)
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', '\\end{minipage}\\hfill\\begin{minipage}[t]{0.48\\textwidth}')
    else
      return pandoc.RawInline('html', '</div><div style="flex:1;">')
    end
  end,

  ["end-columns"] = function(args, kwargs, meta)
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', '\\end{minipage}\\vspace{8pt}')
    else
      return pandoc.RawInline('html', '</div></div>')
    end
  end,

  -- Vertical space
  ["space"] = function(args, kwargs, meta)
    local size = pandoc.utils.stringify(kwargs["size"] or args[1] or "1em")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', '\\vspace{' .. size .. '}')
    else
      return pandoc.RawInline('html', '<div style="height:' .. size .. ';"></div>')
    end
  end,

  -----------------------------------------------------------------------------
  -- COVER LETTER SHORTCODES
  -----------------------------------------------------------------------------

  -- Subject line for cover letter
  ["subject"] = function(args, kwargs, meta)
    local text = pandoc.utils.stringify(kwargs["text"] or args[1] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      local latex = string.format('\\noindent\\textbf{Re: %s}\\\\[12pt]', text)
      return pandoc.RawInline('latex', latex)
    else
      local html = string.format('<p><strong>Re: %s</strong></p>', text)
      return pandoc.RawInline('html', html)
    end
  end,

  -- Paragraph with proper spacing for cover letter
  ["paragraph"] = function(args, kwargs, meta)
    local text = pandoc.utils.stringify(args[1] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', text .. '\\\\[10pt]')
    else
      return pandoc.RawInline('html', '<p>' .. text .. '</p>')
    end
  end,

  -- Highlight key achievement in cover letter
  ["highlight"] = function(args, kwargs, meta)
    local text = pandoc.utils.stringify(kwargs["text"] or args[1] or "")
    
    if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
      return pandoc.RawInline('latex', '\\textbf{' .. text .. '}')
    else
      return pandoc.RawInline('html', '<strong>' .. text .. '</strong>')
    end
  end
}
