module Partial
  def partial(name, options={})
    options.merge! layout: false
    method(:slim).call name.to_sym, options
  end
end
