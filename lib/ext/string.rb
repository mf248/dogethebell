class String
  def strip_quotes
    gsub(/\A['"]+|['"]+\Z/, "")
  end
end

class String
  def add_quotes
     %Q/"#{strip_quotes}"/ 
  end
end