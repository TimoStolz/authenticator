json.partial! 'api/users/user', user: resource
json.token resource.generate_jwt()
