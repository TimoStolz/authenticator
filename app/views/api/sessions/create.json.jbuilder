json.partial! 'api/users/user', user: resource
#json.set! token: resource.generate_jwt()
