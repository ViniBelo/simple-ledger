class TransferBlueprint < Blueprinter::Base
  identifier :id do |transfer, _options|
    transfer.id.to_s
  end

  fields :amount, :direction
end
