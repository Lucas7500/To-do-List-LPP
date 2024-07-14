class Task
  attr_accessor :id, :description, :completed

  def initialize(id, description)
    @id = id
    @description = description
    @completed = false
  end
end
