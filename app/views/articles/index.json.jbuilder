json.array!(@articles) do |article|
  json.extract! article, :title, :description, :visible, :created_at, :last_edit, :article_type
  json.url article_url(article, format: :json)
end
