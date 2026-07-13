class AccountBlueprint < Blueprinter::Base
  identifier :id do |transfer, _options|
    transfer.id.to_s
  end

  fields :name, :direction, :balance
end
