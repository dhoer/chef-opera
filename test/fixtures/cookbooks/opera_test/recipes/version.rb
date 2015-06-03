v = opera_version

fail("opera version returned is invalid: #{v}") unless v.match(/[\d|.]*/)

log(v)
