--[[
  Styles filter for Professional CV
  Converts markdown headers to LaTeX CV sections
]]--

function Header(el)
  if quarto.doc.is_format("latex") or quarto.doc.is_format("pdf") then
    local text = pandoc.utils.stringify(el.content)
    return pandoc.RawBlock('latex', '\\cvsection{' .. text .. '}')
  end
  return el
end
