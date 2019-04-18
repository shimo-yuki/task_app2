json.array!(@users) do |user|
  json.id user.id
  json.name user.name
end

# [
#   {id: 1, name: 'aaa'},
#   {id: 2, name: 'bbb'},
#   {id: 3, name: 'ccc'}
# ]
