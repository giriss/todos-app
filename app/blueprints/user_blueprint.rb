class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :firstname, :lastname, :email
  field :token, if: ->(_field_name, _user, options) { !!options[:with_token] }
end
