class UsageCollection
  def all
    @array
  end

  def push(data)
    return :unprocessable_entity unless value_valid?(data)
    @array.push(data)
    :ok
  end

private

  def initialize
    @array = []
  end

  def value_valid?(data)
    data.is_a?(Hash) && (data.keys.sort == [:cpu, :ram, :time].sort)
  end
end
