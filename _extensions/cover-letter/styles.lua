--[[
  Styles filter for Cover Letter
  Simple pass-through - cover letters use standard paragraphs
]]--

function Header(el)
  -- Cover letters typically don't use section headers
  -- Return as bold text if needed
  if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
    local text = pandoc.utils.stringify(el.content)
    return pandoc.RawBlock('latex', '\\noindent\\textbf{' .. text .. '}\\\\[4pt]')
  end
  return el
end
